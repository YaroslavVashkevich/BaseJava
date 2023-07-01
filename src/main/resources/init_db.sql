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

INSERT INTO resume (uuid, full_name)
VALUES ('1f22b9d3-3090-4f79-bd4d-307ae72d6029', 'name1'),
       ('45a676cb-0401-4e14-abdd-32724b46e274', 'name2'),
       ('982cbb91-32b1-4344-beba-c9b7f7647e89', 'name3'),
       ('4d2835de-893d-4c22-b28f-8d67d9528431', 'name4');

