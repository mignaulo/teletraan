-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ALWAYS BACKUP YOUR DATA BEFORE EXECUTING THIS SCRIPT   
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# This script upgrade DB schema from version 0 to version 1

DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS asg_alarms;
DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS health_checks;
DROP TABLE IF EXISTS healthcheck_errors;
DROP TABLE IF EXISTS new_instances_reports;

CREATE TABLE IF NOT EXISTS schedules (
    id                  VARCHAR(22)     NOT NULL,
    total_sessions      INT             NOT NULL DEFAULT 0,
    cooldown_times      VARCHAR(32)     NOT NULL,
    host_numbers        VARCHAR(32)     NOT NULL,
    current_session     INT             NOT NULL DEFAULT 0,
    state               VARCHAR(32)     NOT NULL DEFAULT "NOT_STARTED",
    state_start_time    BIGINT          NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE environs ADD COLUMN override_policy VARCHAR(32) NOT NULL DEFAULT "OVERRIDE";
ALTER TABLE environs ADD COLUMN schedule_id VARCHAR(22);

-- make sure to update the schema version to 1
UPDATE schema_versions SET version=1;
