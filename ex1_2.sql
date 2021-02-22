CREATE INDEX name ON customer USING btree(name);
CREATE INDEX address ON customer USING hash(address);
