CREATE TABLE user_records%SUFFIX% (
    id serial NOT NULL,
    aggregate_id uuid NOT NULL,
    email character varying not null,
    encrypted_password character varying not null,
    created_at TIMESTAMP not null,
    updated_at TIMESTAMP,
    CONSTRAINT user_records_pkey%SUFFIX% PRIMARY KEY (id)
);
CREATE UNIQUE INDEX user_records_keys%SUFFIX% ON user_records%SUFFIX% USING btree (aggregate_id);