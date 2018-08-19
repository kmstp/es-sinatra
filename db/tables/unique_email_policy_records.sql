CREATE TABLE unique_email_policy_records%SUFFIX% (
    id serial NOT NULL,
    email character varying not null,
    CONSTRAINT unique_email_policy_records_pkey%SUFFIX% PRIMARY KEY (id)
);

CREATE UNIQUE INDEX unique_email_policy_records_keys%SUFFIX% ON unique_email_policy_records%SUFFIX% USING btree (email);
