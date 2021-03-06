REM LISBETH MENNECHEY
REM Chapter 12

REM HANDS-ON #1

/* List book title and retail price for books with a retail
price lower than the average retail price of all books sold */
SELECT title, retail
from books
WHERE retail < (select avg(retail)
from books);



REM HANDS-ON #2

/* Determine which books cost less than the average cost 
of other books in the same category */
SELECT b.title, a.category, b.cost
FROM books b, 
  (SELECT category, avg(cost) average
  FROM books
  Group by Category) a
WHERE b.category = a.category
AND  b.cost < a.average
Order by category;



REM HANDS-ON #7

/* List the shipping city and state for the order that had the longest shipping delay */
SELECT shipcity "Ship City", shipstate "Ship State"
FROM orders
WHERE NVL(shipdate,SYSDATE)-orderdate = (select MAX(NVL (shipdate,SYSDATE)-orderdate)
from orders);



REM HANDS-ON #8

/* Determine which customers placed orders for the least expensive book */
Select c.customer#, c.lastname, c.firstname
From customers c, orders o, orderitems oi, books b
WHERE  c.customer# = o.customer#
  AND o.order# = oi.order#
  AND oi.isbn = b.isbn
  AND b.retail = (Select min(retail)
                  from books)
ORDER BY c.lastname;


                  
REM HANDS-ON #9

/* Determine the number of different customers who placed an order
for books written or cowritten by James Austin */
SELECT COUNT (DISTINCT customer#) "Customer Count"
FROM orders
WHERE order# IN (SELECT order#
                FROM orderitems
                WHERE isbn IN (SELECT isbn
                              FROM bookauthor
                              WHERE authorid = (SELECT authorid
                                                FROM author
                                                WHERE lname='AUSTIN' AND fname = 'JAMES')));



REM HANDS-ON #10

/* Determine which books were published by the publisher of The Wok Way to Cook */
SELECT title
FROM books
WHERE pubid IN (SELECT pubid
        FROM books 
        WHERE title = 'THE WOK WAY TO COOK')
AND title NOT IN (SELECT title
                  FROM books
                  WHERE title = 'THE WOK WAY TO COOK')
ORDER BY title;




REM ADVANCED CHALLENGE#1

/* Determine how much the surcharge would be for all recently placed orders
if payment was made by a credit card */
SELECT sum(quantity*paideach)*.015 AS "SURCHARGE"
from orderitems;



REM ADVANCED CHALLENGE #2

/* Determine total amount that can be expected to be written off as uncollectible based
on recently placed orders with an invoice total more than the average of all recently 
placed orders */
SELECT *
from orders
order by order#;

SELECT *
FROM ORDERITEMS;

SELECT SUM(quantity*paideach)*.04 uncollectible
 FROM orderitems 
 WHERE order# IN
       (SELECT order#
        FROM orderitems
        GROUP BY order#
        HAVING SUM(quantity*paideach) > 
                                     (SELECT   AVG(SUM(quantity*paideach))
                                      FROM orderitems
                                      GROUP BY order#) );