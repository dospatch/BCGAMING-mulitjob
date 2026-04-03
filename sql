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