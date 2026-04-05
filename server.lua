local Core = exports['qb-core']:GetCoreObject()
local MySQL = exports.oxmysql -- This line fixes the "nil value" error

-- Helper: Get Citizen ID
local function getPlayerCID(src)
    local Player = Core.Functions.GetPlayer(src)
    return Player and Player.PlayerData.citizenid
end

-- Callback: Fetch Player Job Data for the UI
lib.callback.register('multijob:getPlayerData', function(source)
    local cid = getPlayerCID(source)
    local Player = Core.Functions.GetPlayer(source)
    if not cid then return nil end

    -- Fetch all jobs owned by this player from the database
    local jobs = MySQL.query.await('SELECT * FROM player_multijobs WHERE identifier = ?', {cid})
    
    return {
        jobs = jobs,
        activeJob = Player.PlayerData.job.name,
        xpConfig = { base = Config.XPPerLevel, mult = Config.XPMultiplier }
    }
end)

-- Event: Change Active Job & Save Location
RegisterNetEvent('multijob:server:changeJob', function(jobName, jobGrade)
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if not Player then return end
    
    local cid = Player.PlayerData.citizenid
    local currentJob = Player.PlayerData.job.name

    -- 1. Save current location before switching so they can "return" later
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    MySQL.update('UPDATE player_multijobs SET last_location = ? WHERE identifier = ? AND job_name = ?', {
        json.encode({x = coords.x, y = coords.y, z = coords.z}), cid, currentJob
    })

    -- 2. Verify they actually own the job and switch them
    local target = MySQL.prepare.await('SELECT * FROM player_multijobs WHERE identifier = ? AND job_name = ?', {cid, jobName})
    
    if target then
        Player.Functions.SetJob(jobName, jobGrade)
        
        -- 3. Teleport back to where they last worked that job (if enabled)
        if Config.SaveLastLocation and target.last_location then
            local pos = json.decode(target.last_location)
            SetEntityCoords(ped, pos.x, pos.y, pos.z)
        end
        
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Job Switched', 
            description = 'Clocked into: ' .. target.job_label, 
            type = 'success'
        })
    end
end)

-- Export: Add Job Experience (Use this in other scripts!)
exports('AddJobXP', function(source, amount)
    local cid = getPlayerCID(source)
    local Player = Core.Functions.GetPlayer(source)
    if not Player then return end
    local job = Player.PlayerData.job.name

    local d = MySQL.prepare.await('SELECT job_xp, job_level FROM player_multijobs WHERE identifier = ? AND job_name = ?', {cid, job})
    if d then
        local nextXP = math.floor(Config.XPPerLevel * (Config.XPMultiplier ^ (d.job_level - 1)))
        
        if (d.job_xp + amount) >= nextXP then
            -- Level Up Logic
            MySQL.update('UPDATE player_multijobs SET job_xp = 0, job_level = job_level + 1 WHERE identifier = ? AND job_name = ?', {cid, job})
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Level Up!', 
                description = 'You reached Level '..(d.job_level + 1) .. ' in ' .. job, 
                type = 'success'
            })
        else
            -- Add XP Logic
            MySQL.update('UPDATE player_multijobs SET job_xp = job_xp + ? WHERE identifier = ? AND job_name = ?', {amount, cid, job})
        end
    end
end)

-- Command: Admin Add Whitelisted Job (/addjob ID JOB GRADE)
RegisterCommand('addjob', function(source, args)
    local src = source
    local targetId = tonumber(args[1])
    local jobName = args[2]
    local jobGrade = tonumber(args[3]) or 0

    local Player = Core.Functions.GetPlayer(src)
    if not Player or not Config.AdminGroups[Player.PlayerData.permission] then 
        return TriggerClientEvent('ox_lib:notify', src, {title = 'Error', description = 'No Permissions', type = 'error'}) 
    end

    local targetPlayer = Core.Functions.GetPlayer(targetId)
    if not targetPlayer then return end

    local jobInfo = Core.Shared.Jobs[jobName]
    if jobInfo then
        local gradeLabel = jobInfo.grades[tostring(jobGrade)] and jobInfo.grades[tostring(jobGrade)].name or "Employee"
        
        -- Insert into DB or update if they already have it
        MySQL.prepare('INSERT INTO player_multijobs (identifier, job_name, job_grade, job_label, grade_label) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE job_grade = ?, grade_label = ?', {
            targetPlayer.PlayerData.citizenid, jobName, jobGrade, jobInfo.label, gradeLabel, jobGrade, gradeLabel
        })
        
        TriggerClientEvent('ox_lib:notify', targetId, {title = 'New Career', description = 'Access granted to: ' .. jobInfo.label, type = 'inform'})
    end
end)