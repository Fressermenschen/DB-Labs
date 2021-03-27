CREATE TABLE public.ledger
(
    id serial NOT NULL,
    from_id integer NOT NULL,
    to_id integer NOT NULL,
    fee integer,
    amount integer,
    transaction_date_time timestamp without time zone,
    PRIMARY KEY (id)
);

ALTER TABLE public.ledger
    OWNER to postgres;

BEGIN;
SAVEPOINT START;

UPDATE accounts SET credit = credit - 500
    WHERE id = 1;
UPDATE accounts SET credit = credit + 500
    WHERE id = 3;
INSERT INTO ledger (id, from_id, to_id, fee, amount, transaction_date_time) VALUES (1, 1, 3, 0, 500, '{2020-12-22 16:13:10-07}');
SAVEPOINT TR_1;

UPDATE accounts SET credit = credit - 730
    WHERE id = 2;
UPDATE accounts SET credit = credit + 30
    WHERE id = 4;
UPDATE accounts SET credit = credit + 700
    WHERE id = 1;
INSERT INTO ledger (id, from_id, to_id, fee, amount, transaction_date_time) VALUES (2, 2, 1, 30, 700, '{2021-08-24 21:15:25-07}');
SAVEPOINT TR_2;

UPDATE accounts SET credit = credit - 130
    WHERE id = 2;
UPDATE accounts SET credit = credit + 30
    WHERE id = 4;
UPDATE accounts SET credit = credit + 100
    WHERE id = 3;
INSERT INTO ledger (id, from_id, to_id, fee, amount, transaction_date_time) VALUES (3, 2, 3, 30, 100, '{2000-03-21 17:45:29-07}');
SAVEPOINT TR_3;

SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO TR_3;
SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO TR_2;
SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO TR_1;
SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO START;
SELECT * FROM accounts;
SELECT * FROM ledger;

COMMIT;
