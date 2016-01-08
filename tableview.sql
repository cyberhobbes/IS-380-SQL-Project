SET echo off
SET heading on
SET feedback off
SET verify off


/*
Calvin Tran
IS 380
Project [Return Authorization]

TABLEVIEW.SQL
*/

spool d:tableview.txt

--Display Table Types & Columns
DESCRIBE customer;
DESCRIBE product;
DESCRIBE returncode;
DESCRIBE returnauth;


--Display Table Records
SELECT * from customer;
SELECT * from product;
SELECT * from returncode;
SELECT * from returnauth;

spool off;
