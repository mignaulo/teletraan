-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ALWAYS BACKUP YOUR DATA BEFORE EXECUTING THIS SCRIPT   
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- add missing commits from https://github.com/pinterest/teletraan/pull/491/files#diff-380d85d61edaf8019bd4a4cd16a48c36

CREATE TABLE IF NOT EXISTS host_tags (
    host_id        VARCHAR(64)         NOT NULL,
    env_id         VARCHAR(22)         NOT NULL,
    tag_name       VARCHAR(64)         NOT NULL,
    tag_value      VARCHAR(256),
    create_date     BIGINT              NOT NULL,
    PRIMARY KEY    (host_id, env_id, tag_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX host_tags_env_idx ON host_tags (env_id);
CREATE INDEX host_tags_env_host_idx ON host_tags (env_id, host_id);

CREATE TABLE IF NOT EXISTS deploy_constraints (
  constraint_id     VARCHAR(22)         NOT NULL,
  constraint_key    VARCHAR(64)         NOT NULL,
  max_parallel      BIGINT              NOT NULL,
  state             VARCHAR(32)         NOT NULL,
  start_date        BIGINT              NOT NULL,
  last_update       BIGINT,
  PRIMARY KEY   (constraint_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE environs ADD COLUMN deploy_constraint_id VARCHAR(22);


CREATE INDEX agent_first_deploy_state_idx ON agents (env_id,first_deploy, deploy_stage ,state);

-- make sure to update the schema version to 1
UPDATE schema_versions SET version=2;
