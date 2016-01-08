SET echo off
SET heading off
SET feedback off
SET verify off

/*
Calvin Tran
IS 380
Project [Return Authorization]

SETUP.SQL
*/

--Drop all tables for testing purposes
DROP TABLE returnauth;
DROP TABLE customer;
DROP TABLE product;
DROP TABLE returncode;
DROP TABLE counter;

--Creating Tables
CREATE TABLE customer
	(
	CNum varchar2(3),
	FirstName varchar2(10),
	LastName varchar2(10),
	Address varchar2(20),
	City varchar2(15),
	State varchar2(2),
	Zip varchar2(5),
	PhoneNumber varchar2(10),
	PRIMARY KEY (CNum)
	);

CREATE TABLE product
	(
	PNum varchar2(3),
	PDescription varchar2(20),
	UnitPrice number(6),
	PRIMARY KEY(PNum)
	);

CREATE TABLE returncode
	(
	RCode varchar2(1),
	Reason varchar2(20),
	PRIMARY KEY(RCode)
	);

CREATE TABLE returnauth
	(
	RANum number(5),
	RAOpenDate date,
	RACloseDate date,
	Status varchar2(6),
	CNum varchar2(3),
	PNum varchar2(3),
	RCode varchar2(1),
	ReturnQty number(3),
	ReturnPrice number(5),
	ReturnTotal number(7),
	ActualReturnQty number(3),
	ActualReturnTotal number(7),	
	PRIMARY KEY(RANum),
	CONSTRAINT fk_returnAuth_cnum FOREIGN KEY (CNum) REFERENCES customer(CNum),
	CONSTRAINT fk_returnAuth_pnum FOREIGN KEY (PNum) REFERENCES product(PNum),
	CONSTRAINT fk_returnAuth_rcode FOREIGN KEY (RCode) REFERENCES returnCode(RCode)
	);

CREATE TABLE counter
	(
	MAXNUM number(5)
	);

--Inserting records into the tables
INSERT INTO customer VALUES ('101','James','Freeman','300 Webster Street','Oakland','CA','94607','5106533394');
INSERT INTO customer VALUES ('102','Justin','Morrison','270 7th Street','San Francisco','CA','94103','4158611313');
INSERT INTO customer VALUES ('103','Jeremy','Tooker','375 Valencia Street','San Francisco','CA','94103','4152520800');
INSERT INTO customer VALUES ('104','Eileen','Rinaldi','1026 Valencia Street','San Francisco','CA','94110','4156411024');
INSERT INTO customer VALUES ('105','Phil','Jaber','3101 24th Street','San Francisco','CA','94110','4158759370');

INSERT INTO product VALUES ('201','Blonde',7);
INSERT INTO product VALUES ('202','Kona',12);
INSERT INTO product VALUES ('203','Vienna',8);
INSERT INTO product VALUES ('204','French',11);
INSERT INTO product VALUES ('205','New Orleans',13);

INSERT INTO returncode VALUES ('1','Bad Quality');
INSERT INTO returncode VALUES ('2','Wrong Order');
INSERT INTO returncode VALUES ('3','Defective');
INSERT INTO returncode VALUES ('4','Late Shipment');
INSERT INTO returncode VALUES ('5','Missing Items');

INSERT INTO returnauth VALUES (1,'10-FEB-14','23-NOV-14','Closed','101','203','1',10,8,80,5,40);
INSERT INTO returnauth VALUES (2,'15-MAR-14','4-MAY-14','Closed','103','201','4',7,7,49,5,35);
INSERT INTO returnauth VALUES (3,'29-JAN-14',null,'Open','104','202','2',15,12,180,null,null);
INSERT INTO returnauth VALUES (4,'11-APR-14',null,'Open','102','204','2',23,11,253,null,null);
INSERT INTO returnauth VALUES (5,'6-MAY-14',null,'Open','105','204','2',10,11,110,null,null);
INSERT INTO returnauth VALUES (6,'12-JUN-14',null,'Open','102','202','3',5,12,60,null,null);
INSERT INTO returnauth VALUES (7,'18-JUL-14',null,'Open','103','203','2',9,8,72,null,null);

INSERT INTO counter VALUES (00008);

COMMIT;


