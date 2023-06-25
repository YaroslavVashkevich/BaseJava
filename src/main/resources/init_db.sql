CREATE DATABASE resume_database;

CREATE TABLE resume
(
    uuid      VARCHAR(36) PRIMARY KEY,
    full_name TEXT NOT NULL
);

CREATE TABLE contact
(
    id          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    resume_uuid VARCHAR(36) NOT NULL REFERENCES resume (uuid) ON DELETE CASCADE,
    type        TEXT        NOT NULL,
    value       TEXT        NOT NULL
);

CREATE UNIQUE INDEX contact_uuid_type_index ON contact (resume_uuid, type);

CREATE TABLE section
(
    id          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    resume_uuid VARCHAR(36) NOT NULL REFERENCES resume (uuid) ON DELETE CASCADE,
    type        TEXT        NOT NULL,
    content     TEXT        NOT NULL
);

CREATE UNIQUE INDEX section_idx ON section (resume_uuid, type);
