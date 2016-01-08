SET echo off
SET heading off
SET feedback off
SET verify off

/*
Calvin Tran
IS 380
Project [Return Authorization]

AGING.SQL
*/


--Banner
PROMPT
PROMPT ****** Initializing Aging Return Authorization Report ******
PROMPT

--Shows Today Date
SELECT 'Today''s Date: ', sysdate
	FROM dual;

ACCEPT vAging PROMPT 'Please Enter Number of Days to Query: ';

SET heading on
COLUMN RANum HEADING 'RA | Number' FORMAT 9999
COLUMN Status HEADING 'RA | Status' FORMAT a6
COLUMN RAOpenDate HEADING 'Date | Open' FORMAT Date
COLUMN PNum HEADING 'Product | Number' FORMAT a8
COLUMN PDescription HEADING 'Product | Description' FORMAT a15
COLUMN ReturnQty HEADING 'Request | Quantity' FORMAT 999
COLUMN ReturnPrice HEADING 'Unit | Price' FORMAT $999
COLUMN ReturnTotal HEADING 'Request | Amount' FORMAT $999
COLUMN DaysOpen HEADING 'Days | Open' FORMAT 999

SELECT RANum, Status, RAOpenDate, returnauth.PNum, PDescription, ReturnQty, ReturnPrice, ReturnTotal, TRUNC(sysdate)-TRUNC(RAOpenDate) DaysOpen
	FROM returnauth, product
	WHERE returnauth.PNum = product.PNum
		AND Status = 'Open'
		AND (TRUNC(sysdate)-TRUNC(RAOpenDate)) >= '&vAging'
		ORDER BY DaysOpen DESC;
