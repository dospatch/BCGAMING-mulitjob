#BCGAMING

🏢 Advanced Career Center & Multi-Job System

A professional, high-performance career management system for FiveM. This resource allows players to hold multiple authorized job roles, progress through a custom experience (XP) system, and maintains immersion by saving work locations.

✨ Key Features

Authorized Career Slots: Players only see jobs manually assigned to them by administrators.

XP & Leveling System: Independent level tracking for every job role.

Smart Location Sync: Remembers where a player was when they clocked out and returns them there upon clock-in.

Modern Dashboard: A sleek, dark-themed NUI accessible via a customizable keybind.

Optimized Logic: Built with ox_lib and oxmysql for a lag-free experience.

🛠️ Installation & Setup

1. Database Configuration

You must run this SQL query in your database manager (HeidiSQL, phpMyAdmin, etc.) to create the required table structure. This prevents the "nil value" errors by providing a place for data to save.

CREATE TABLE IF NOT EXISTS `player_multijobs` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `identifier` VARCHAR(60) NOT NULL,
  `job_name` VARCHAR(50) NOT NULL,
  `job_grade` INT DEFAULT 0,
  `job_label` VARCHAR(50) DEFAULT 'Job',
  `grade_label` VARCHAR(50) DEFAULT 'Grade',
  `last_location` LONGTEXT DEFAULT NULL,
  `job_xp` INT DEFAULT 0,
  `job_level` INT DEFAULT 1,
  UNIQUE KEY `unique_job` (`identifier`, `job_name`)
);


2. Dependency Check

Ensure the following resources are started before this script in your server.cfg:

ensure qb-core

ensure ox_lib

ensure oxmysql

3. Folder Naming

Ensure your resource folder is named exactly as defined in your manifest. If you experience "nil" errors, ensure there are no spaces or special characters in the folder name.

🎮 Usage & Commands

Administrator: Granting a Career

Since this is an authorized system, players cannot "self-add" jobs. An admin must use:
/addjob [Player_ID] [Job_Name] [Grade]

Example: /addjob 1 police 0

Developer: Rewarding Experience (XP)

To reward players for completing community tasks or successful work shifts, use this server-side export in your other scripts:

-- Syntax: exports['BCGAMING-mulitjob-main']:AddJobXP(source, amount)
exports['BCGAMING-mulitjob-main']:AddJobXP(source, 100) 


⚙️ Configuration

Open config.lua to customize your experience:

Max Careers: Limit how many jobs one person can hold (Default: 5).

XP Scaling: Adjust the Multiplier to change how much harder each level becomes.

UI Icons: Update the job list with FontAwesome icons to match your specific server roles.

⌨️ Controls

F10 (Default): Open the Career Dashboard.

ESC: Close the menu.

Click: Selecting a job will automatically switch your duty status and handle your location sync.

Created with a focus on clean, professional, and community-friendly gameplay.