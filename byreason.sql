SET echo off
SET heading on
SET feedback off
SET verify off

/*
Calvin Tran
IS 380
Project [Return Authorization]

BYREASON.SQL
*/

--Banner
PROMPT
PROMPT ****** Initializing By Reason Return Authorization Report ******
PROMPT

COLUMN PNum HEADING 'Product | Number' FORMAT a8
COLUMN PDescription HEADING 'Product | Description' FORMAT a15 
COLUMN RCode HEADING 'Reason | Code' FORMAT a6
COLUMN Reason HEADING 'Reason | Description' FORMAT a15 
COLUMN NumReturn HEADING 'Number of | Returns' FORMAT 999
COLUMN TotalQty HEADING 'Total | Quantity' FORMAT 99,999
COLUMN TotalAmt HEADING 'Total | Amount' FORMAT $99,999 


SELECT returnauth.PNum, PDescription, returnauth.RCode, Reason, count(returnauth.PNum) NumReturn, sum(ReturnQty) TotalQty, sum(ReturnTotal) TotalAmt
	FROM product, returncode, returnauth
	WHERE returnauth.PNum = product.PNum
		AND returnauth.RCode = returncode.RCode
	GROUP BY returnauth.PNum, PDescription, returnauth.RCode, Reason
	ORDER BY returnauth.PNum;
