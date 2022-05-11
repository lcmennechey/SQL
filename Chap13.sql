REM LISBETH MENNECHEY
REM CHAPTER 13

REM HANDS-ON #1: 

/* Create a view that lists the name and phone number 
of the contact person at each person at each publisher. Don't 
include publisher's ID in the view. Name the view contact */
CREATE VIEW contact
  AS SELECT name, contact, phone
    FROM publisher;
    
SELECT *
FROM contact;



REM HANDS-ON #2:

/* Change the Contact view so that no users can accidentally 
perform DML operations on the view */
CREATE OR REPLACE VIEW contact
  AS SELECT name, contact, phone
    FROM publisher
  WITH READ ONLY;
  
DROP VIEW contact;



REM HANDS-ON #5:

/* Create a view that lists the ISBN and title for each book in
inventory along with the name and phone number of the person to
contact. Name view reorderinfo. */
CREATE VIEW reorderinfo
  AS SELECT title, isbn, contact, phone
    FROM books JOIN publisher USING (pubid);
    
SELECT *
FROM reorderinfo;



REM HANDS-ON #10

/* Delete the reorderinfo view */
DROP VIEW reorderinfo;




REM ADVANCED CHALLENGE

/* Identify the five most frequently purchased books and the percentage 
of profit each book generates. */
SELECT title, qty "QTY", ROUND(profit,0)  "PROFIT %"
  FROM 
     (SELECT title, SUM(quantity) qty, ((retail-cost)/cost*100) profit      
         FROM books JOIN orderitems USING(isbn)      
         GROUP BY title,((retail-cost)/cost*100)      
         ORDER BY qty DESC)
   WHERE ROWNUM <=5;