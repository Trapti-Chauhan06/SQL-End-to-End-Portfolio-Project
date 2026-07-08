create database OnlineBookStore;
use OnlineBookStore;
create table Books(Book_Id serial primary key, Title varchar(255), Author varchar (255), Genre varchar(100), Published_Year int, Price numeric (10,2), stock int);
create table customers( Customer_Id serial primary key, Name varchar(100), Email varchar(100), Phone varchar(15), City varchar(100), Country VARCHAR (100));
create table orders ( Order_Id serial primary key, Customer_Id int References Customers (Customer_id),Book_Id int References Books(Book_Id), Order_Date Date, Quantity int, Total_Amount numeric (10,2));
show tables;
Select * from OnlineBookstore.Books;
select * from onlinebookstore.customers;
select * from onlinebookstore.orders;
# Retrieve all books in the "Fiction" Genre
Select * from OnlineBookstore.Books where genre="Fiction";
# Find books published after the year 1950
Select * from books where published_year > 1950;
# List all customers from the canada
Select * from customers where country ="Canada";
# Show orders placed in November 2023
Select * from orders where order_date between '2023-11-01' and '2023-11-30';
# Retrieve the total stock of books available
select sum(stock) from books;
# Most Expensive Book
Select * from books 
order by price desc
limit 1;
# Show all customers who ordered more than 1 quantity of a book
select * from orders where quantity >1;
# Retrieve all orders where total amount exceeds $20
select * from orders where total_amount> 20;
# List all genres available in books table
select distinct genre from books;
# Find the book with the lowest stock
select * from books 
order by stock asc
limit 1;
# Calculate the total revenue generated from all orders
select sum(total_amount) from orders;
# Retrieve the total number of books sold for each genre
select b.genre, sum(o.Quantity) as Total_Books_sold
from orders o
join books b on o.Book_id = b.Book_id
group by b.genre;
# Find the avearge price of books in the "Fantasy" genre
select avg(price) as Avg_Price from books where genre = "Fantasy";
# List customers who have placed atleast 2 orders
select customer_id, count(order_id) as order_count from orders 
group by customer_id 
having count(order_id) >=2;
# Find the most frequently ordered book
select o.book_id ,b.title, count(o.order_id) as order_count from orders o
join books b on o.book_id = b.book_id
group by o.book_id , b.title
order by order_count desc limit 1;
# Show the top 3 most expensive books of "Fantasy" genre
select * from books where genre ="fantasy"
order by price desc limit 3;
# Retrieve the total quantity of books sold by each author
select b.author, sum(o.quantity) as Total_quantity from orders o join books b on o.book_id = b.book_id
group by b.author ;
# List the cities where customers who spent over 30 are located
select distinct c.city, total_amount from orders o 
join customers c on o.customer_id = c.customer_id
where o.total_amount > 30;
# Find the customer who spent the most on orders
select c.customer_id, c.name, sum(o.total_amount) as Total_Spent
from orders o
join customers c on o.customer_id = c.customer_id
group by c.customer_id , c.name
order by Total_spent desc limit 1;
# Calculate the stock remaining after fulfilling all orders
select b.book_id, b.title, b.stock, coalesce(sum(o.quantity),0) as Order_quantity,
b.stock- coalesce(sum(o.quantity),0) as Remaining_Quantity 
from books b 
left join orders o on  b.book_id = o.book_id
group by b.book_id
order by b.book_id;



 