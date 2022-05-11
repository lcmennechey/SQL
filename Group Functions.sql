REM Lisbeth Mennechey
REM Chapter 11

REM HANDS-ON #1

/* Determine how many books are in the Cooking categoy */
SELECT COUNT (category) "Cooking Books"
FROM books
WHERE category='COOKING';



REM HANDS-ON #3

/* Display most recent publication date of all books sold */
SELECT MAX (pubdate) "Newest Book"
FROM books;



REM HANDS-ON #5

/* List the retail price of least expensive book in Computer category */
SELECT MIN (retail) "Least Expensive Computer Book"
FROM books
WHERE category = 'COMPUTER';



REM HANDS-ON #7

/* Determine how many orders have been placed by each customer. Do
not include in the results any customer who hasn't recently placed
an order */ 
SELECT customer#, COUNT (DISTINCT order#) "Num of Orders"
FROM orders
GROUP BY Customer#
ORDER BY Customer#;



REM HANDS-ON #9

/* List the customers living in Georgia and Florida who have 
placed an order totaling more than $80 */
SELECT customer#, order#, SUM (paideach) "Amount"
FROM orders join orderitems USING (order#)
WHERE shipstate = 'FL' OR shipstate = 'GA'
GROUP BY customer#, order#
HAVING sum(paideach) > 80;




REM ADVANCED CHALLENGE

/* Determine which books generate less than a 55% profit and how many
copies of these books have been sold */
SELECT title, COUNT (quantity) "Times Ordered" --times ordered
FROM books join orderitems USING (isbn)
WHERE (retail-cost)/cost < .55
GROUP BY title
ORDER BY title;
