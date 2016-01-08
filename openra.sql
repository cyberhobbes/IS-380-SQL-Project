SET echo off
SET heading off
SET feedback off
SET verify off

/*
Calvin Tran
IS 380
Project [Return Authorization]

OPENRA.SQL
*/

--Banner
PROMPT
PROMPT ****** Initializing New Return Authorization ******
PROMPT 

--Shows Today Date
SELECT 'Today''s Date: ', sysdate
	FROM dual;

PROMPT

--Accept Customer Number and Display Information
ACCEPT vCNum PROMPT 'Enter Customer Number: ';
SELECT '    Customer Name:', FirstName||' '|| LastName
	FROM customer
	WHERE CNum = '&vCNum';
SELECT '    Shipping Address:', Address
	FROM customer
	WHERE CNum = '&vCNum';
SELECT '    City, State Zip:', City||', '|| State||' '|| Zip
	FROM customer
	WHERE CNum = '&vCNum';
SELECT '    Phone:', '('||SUBSTR(PhoneNumber,1,3)||') '||SUBSTR(PhoneNumber,4,3)||'-'||SUBSTR(PhoneNumber,7,4)
	FROM customer
	WHERE CNum = '&vCNum';

PROMPT

--Accept Product Number and Display Information
ACCEPT vPNum PROMPT 'Enter Product Number: ';
SELECT '    Product Number:', PNum
	FROM product
	WHERE PNum = '&vPNum';
SELECT '    Product Description:', PDescription
	FROM product
	WHERE PNum = '&vPNum';
SELECT '    Unit Price: $'||''|| RTRIM(UnitPrice)
	FROM product
	WHERE PNum = '&vPNum';

PROMPT

--Accept Return Quantity and Display Return Amount
ACCEPT vRQty PROMPT 'Enter the Return Quantity: ';
SELECT '    Amount Returned: $'||''|| RTRIM('&vRQty'*UnitPrice)
	FROM product
	WHERE PNum = '&vPNum';

PROMPT

--Display Return Code and Accept Return Code
SET heading on
PROMPT Pick a reason for your return:
COLUMN RCode HEADING 'Reason | Code' FORMAT a6
COLUMN Reason HEADING 'Reason' FORMAT a15
SELECT * FROM returncode;

PROMPT

--Accept Return Code
ACCEPT vCode PROMPT 'Enter The Reason Code: ';

--Creating a Return Authorization Record
INSERT into returnauth (RANum, RAOpenDate, RACloseDate, Status, CNum, PNum, RCode, ReturnQty, ReturnPrice, ReturnTotal, ActualReturnQty, ActualReturnTotal) 
	SELECT MAXNUM, sysdate, null, 'Open', '&vCNum', '&vPnum', '&vCode', '&vRQty', UnitPrice, UnitPrice*'&vRQty', null, null
	FROM counter, product
	WHERE PNum = '&vPNum';

SET heading off
SELECT '****** Return Authorization:'||' '|| RTRIM(RANum)||' '||'has been created.'
	FROM returnauth, counter
	WHERE RANum = MAXNUM;

SELECT 'Return Authorization Number:', RTRIM(RANum)
	FROM returnauth, counter
	WHERE RANum = MAXNUM;

PROMPT
PROMPT Mail to: 
PROMPT -Specialty Java Inc. 
PROMPT -208 Industrial Blvd. 
PROMPT -Waconia, MN 55387
PROMPT

--Update the Counter for each New Record
UPDATE counter SET MAXNUM = MAXNUM+1;

COMMIT;
