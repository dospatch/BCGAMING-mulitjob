# BCGAMING-mulitjob 

📁 Multi-Job Script - README
📌 Overview

The Multi-Job Script allows players to hold and switch between multiple jobs without losing progress. This is perfect for roleplay servers where players want to work in different departments (Police, EMS, Mechanic, etc.).

⚙️ Features
✅ Hold multiple jobs at once
🔄 Switch jobs with command/menu
💾 Saves job data automatically
🧑‍💼 Supports grades/ranks per job
🔒 Job restrictions (optional)
📊 Compatible with QBCore / ESX
📦 Requirements

Make sure you have:

QBCore or ESX Framework
ox_lib (recommended for UI)
oxmysql (or mysql-async)
📥 Installation
Download or place the script into your resources folder:
resources/[scripts]/multijob
Add to your server.cfg:
ensure multijob
Import the SQL file into your database:
multijob.sql
🗃️ Database Setup

Example table:

CREATE TABLE `multijobs` (
  `identifier` VARCHAR(50),
  `job` VARCHAR(50),
  `grade` INT,
  PRIMARY KEY (`identifier`, `job`)
);
🎮 Commands
Command	Description
/jobs	View your jobs
/setjob	Switch to a saved job
/addjob	Add a job (Admin only)
/removejob	Remove a job (Admin only)
🧠 How It Works
When a player gets a new job, it is saved in the database.
Players can switch between jobs without losing rank.
Each job keeps its own grade/level.
The active job is synced with the framework (QBCore/ESX).
🔧 Configuration

Edit config.lua:

Config = {}

-- Max jobs per player
Config.MaxJobs = 3

-- Command names
Config.Commands = {
    OpenMenu = "jobs",
    SwitchJob = "setjob"
}

-- Use menu (ox_lib)
Config.UseMenu = true
🔐 Permissions

Example:

Config.AdminGroups = {
    "admin",
    "god"
}
🖥️ UI (Optional)
Uses ox_lib context menu
Clean job selection interface
Easy switching
🐞 Known Issues
Make sure jobs exist in your framework
Ensure database is properly imported
Restart server after installing
💡 Future Updates (Optional Ideas)
Job cooldown system
Duty toggle per job
Paycheck per job
Job XP system
👨‍💻 Credits
Script by: BCGaming Development
Framework: QBCore / ESX
UI: ox_lib
📞 Support

If you need help:

Join your server Discord
Contact server staff/dev team
