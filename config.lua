Config = {}

Config.Framework = 'qb' -- Support for 'qb' (standard)
Config.OpenKey = 'F10'
Config.MaxJobsPerPlayer = 5

-- XP & Leveling Logic
Config.XPPerLevel = 1000 
Config.XPMultiplier = 1.15 -- 15% more XP required per level

-- Gameplay Features
Config.SaveLastLocation = true 
Config.ShowLeaderboard = true

-- Job UI Customization (FontAwesome Icons)
Config.WhitelistedJobs = {
    ['police'] = { icon = 'fas fa-shield-alt', color = '#3498db' },
    ['ambulance'] = { icon = 'fas fa-heartbeat', color = '#e74c3c' },
    ['mechanic'] = { icon = 'fas fa-wrench', color = '#f1c40f' },
    ['taxi'] = { icon = 'fas fa-taxi', color = '#f39c12' },
    ['realestate'] = { icon = 'fas fa-city', color = '#2ecc71' },
}

-- Admin Permissions
Config.AdminGroups = {
    ['admin'] = true,
    ['god'] = true,
    ['superadmin'] = true
}