SET echo off
SET heading off
SET feedback off
SET verify off


/*
Calvin Tran
IS 380
Project [Return Authorization]

QUERYRA.SQL
*/

--Banner
PROMPT
PROMPT ****** Return Authorization Viewer ******
PROMPT


ACCEPT vRANum PROMPT 'Please Enter an RA Number: ';


--Display RA Number and Status
SELECT 'RA Number:', RTRIM(RANum)
	FROM returnauth
	WHERE RANum = '&vRANum';
SELECT 'RA Status:', Status
	FROM returnauth
	WHERE RANum = '&vRANum';


--Display Customer Information
SELECT 'Customer Number:', CNum
	FROM returnauth
	WHERE RANum = '&vRANum';
SELECT '    Customer Name:', FirstName||' '|| LastName
	FROM returnauth, customer
	WHERE RANum = '&vRANum'
		AND customer.CNum = returnauth.Cnum;
SELECT '    Shipping Address:', Address
	FROM returnauth, customer
	WHERE RANum = '&vRANum'
		AND customer.CNum = returnauth.Cnum;
SELECT '    City, State Zip:', City||', '|| State||' '|| Zip
	FROM returnauth, customer
	WHERE RANum = '&vRANum'
		AND customer.CNum = returnauth.Cnum;
SELECT '    Phone:', '('||SUBSTR(PhoneNumber,1,3)||') '||SUBSTR(PhoneNumber,4,3)||'-'||SUBSTR(PhoneNumber,7,4)
	FROM returnauth, customer
	WHERE RANum = '&vRANum'
		AND customer.CNum = returnauth.Cnum;


--Display Product Information
SELECT 'Product Number:', PNum
	FROM returnauth
	WHERE RANum = '&vRANum';
SELECT '    Product Description:', PDescription
	FROM returnauth, product
	WHERE RANum = '&vRANum'
		AND product.PNum = returnauth.PNum;
SELECT '    Unit Price:', RTRIM(UnitPrice)
	FROM returnauth, product
	WHERE RANum = '&vRANum'
		AND product.PNum = returnauth.PNum;


--Display Return Code Information
SELECT 'Return Code:', RCode
	FROM returnauth
	WHERE RANum = '&vRANum';
SELECT 'Reason Description:', Reason
	FROM returnauth, returncode
	WHERE RANum = '&vRANum'
		AND returncode.RCode = returnauth.RCode;


--Display RA Open and Close Date
SELECT 'RA Open Date:', RAOpenDate
	FROM returnauth
	WHERE RANum = '&vRANum';
SELECT 'RA Close Date:', RACloseDate
	FROM returnauth
	WHERE RANum = '&vRANum';


--Display Quantity Returned with Amount Debit
SELECT 'Quantity Requested for Return:', RTRIM(ReturnQty)
	FROM returnauth
	WHERE RANum = '&vRANum';
SELECT 'Item Price: $'||''|| RTRIM(ReturnPrice)
	FROM returnauth
	WHERE RANum = '&vRANum';
SELECT 'Amount Requested for Return: $'||''|| RTRIM(ReturnTotal)
	FROM returnauth
	WHERE RANum = '&vRANum';


--Display Quantity Received with Amount Credit
SELECT 'Quantity Received:', RTRIM(ActualReturnQty)
	FROM returnauth
	WHERE RANum = '&vRANum';
SELECT 'Amount Credited: $'||''|| RTRIM(ActualReturnTotal)
	FROM returnauth
	WHERE RANum = '&vRANum';
