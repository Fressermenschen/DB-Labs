CREATE INDEX review_index on customer using GIN(to_tsvector('english', review));
CREATE INDEX review_index on customer using GIST(to_tsvector('english', review));
