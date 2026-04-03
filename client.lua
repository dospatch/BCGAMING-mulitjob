local menuOpen = false

-- Function to handle opening the NUI
local function toggleMultiJob()
    if menuOpen then return end
    
    lib.callback('multijob:getPlayerData', false, function(data)
        if not data or #data.jobs == 0 then
            lib.notify({
                title = 'Career Center', 
                description = 'You have no registered job slots.', 
                type = 'error'
            })
            return
        end

        menuOpen = true
        SetNuiFocus(true, true)
        
        -- Merge Icons from Config
        for i=1, #data.jobs do
            local jobRef = Config.WhitelistedJobs[data.jobs[i].job_name]
            data.jobs[i].icon = jobRef and jobRef.icon or 'fas fa-briefcase'
        end

        SendNUIMessage({
            action = "open",
            jobs = data.jobs,
            activeJob = data.activeJob,
            xpConfig = data.xpConfig,
            maxJobs = Config.MaxJobsPerPlayer
        })
    end)
end

-- NUI Callbacks
RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    menuOpen = false
    cb('ok')
end)

RegisterNUICallback('confirmSwitch', function(data, cb)
    TriggerServerEvent('multijob:server:changeJob', data.job, data.grade)
    cb('ok')
end)

-- Keybind Mapping
RegisterKeyMapping('multijob', 'Open Multi-Job Menu', 'keyboard', Config.OpenKey)

RegisterCommand('multijob', function()
    toggleMultiJob()
end)