---
title: "postgresql"
date: 2016-07-13 18:18
---

# postgresql

+   ``createdb``,Normally, the database user who executes this command becomes the owner of the new database. However, a different owner can be specified via the ``-O`` option, if the executing user has appropriate privileges.
+   ``dropdb``,`dropdb` destroys an existing PostgreSQL database. The user who executes this command must be a database superuser or the owner of the database.
+   ``pg_dump``,`pg_dump` is a utility for backing up a PostgreSQL database. It makes consistent backups even if the database is being used concurrently.`pg_dump` does not block other users accessing the database (readers or writers).``pg_dump --inserts --clean sql_book > dump.sql``
+   ``psql -d sql_book < dump.sql``,restoring a database with psql.The -d option specifies which database to connect to. The use of `<` reads the contents of the file dump.sql into the `psql` command. This will allow use to restore the data of our database if it has been lost or altered after using `pg_dump`.
+   ``psql \c library``,change database
+   ``psql \dt``,displays all tables for the current database
+   ``psql \l``,``psql \list``,display all databases
+   ``psql \d users``,describe the table
+   ``create table users (id serial, username char(25) not null, enabled boolean default true, primary key (id));``
+   ``insert into users (id, username, enabled) values (20, 'john snow', false);``
+   ``insert into users (username) values ('aya starke');``
+   ``insert into users (username, enabled) values ('little finger', false);``
+   ``select * from users``,``select username from users``,``select id,username from users``
+   ``select username from users where enabled = true;``
+   ``select id,username from users order by username;``
+   ``select id,username from users order by id desc;``,``select id,username from users order by id asc``
+   ``delete from users;``
+   ``update users set enabled = true where id = 4;``
+   ``update users set enabled = false where rtrim(username) like '% II';``
+   ``delete from users where username = 'John Smith';``
+   ``alter table users add column last_login timestamp not null default NOW();``
+   ``alter table users rename column username to full_name;``
+   ``alter table users alter column full_name type varchar(25);``
+   ``alter table users drop column enabled;``
+   ``alter table users rename to all_users;``
+   ``DML,Data Manipulation Statements``,``CRUD``,``insert,select,update,delete``
+   ``DDL``,``Data Definition Statements``,``createdb``,``create table``,``\d table_name``,``psql table_name``,``drop database``,``alter table``,``drop table``
+   ERD,An entity relationship diagram is a graphical representation of entities and their relationships to each other. An entity is a piece of data.
+   ``create table users(id serial, username varchar(25) not null, enabled boolean default true, last_login timestamp not null default now(), primary key (id));`` The ``NOT NULL`` constraint prevents a column from allowing a null value
+   ``create table addresses(user_id int not null, street varchar(30) not null, city varchar(30) not null, state varchar(30) not null, primary key (user_id),constraint fk_user_id foreign key (user_id) references users);``
+   ``create table books (id serial, title varchar(100) not null, author varchar(100) not null, published_date timestamp not null, isbn int, primary key (id), unique(isbn));``The Unique constraint disallows duplicate entry into the books table for the column value of isbn.
+   ``create table reviews (id serial, book_id int not null, user_id int not null, review_content varchar(255), rating int, published_date timestamp default now(), primary key (id), foreign key (book_id) references books(id) on delete cascade, foreign key (user_id) references users(id) on delete cascade);``The ``ON DELETE CASCADE`` clause indicates that if a book/user is deleted all reviews associated with that book/user are also deleted.
+   ``create table user_books(user_id int not null, book_id int not null, checkout_date timestamp, return_date timestamp, primary key (user_id, book_id), foreign key (user_id) references users(id) on update cascade, foreign key (book_id) references books(id) on update cascade);``When a primary_key consists of a unique pair ``PRIMARY KEY (user_id, book_id)``, it is known as a composite key. It usually occurs in many-to-many relationships, and we need to add an extra table to store this relationship data. The composite key ensures that the data in the table will be unique for the relation between the user and book.
+   A **Primary Key** is a unique identifier for a row of data.
+   **Foreign key** columns are used to reference another row of data, perhaps in another table. In order to reference another row, the database needs a unique identifier for that row. Therefore, foreign key columns contain the value of the referenced row's primary key.Foreign keys are how RDBMS sets up relationships between rows of data, either in the same table or across tables.
+   PostgreSQL allows relationships between both the schema and data of different tables through the use of **FOREIGN KEYS** and an operation called a `JOIN`. 
+   JOINs are clauses in SQL statements that link two tables based on one or more fields. With JOINs, relational databases can reduce redundancy.
+   An `INNER JOIN` returns a result set that contains the common elements of the tables, i.e the intersection where they match on the joined column. ``select users.*,addresses.* from users inner join addresses on users.id = addresses.user_id;``
+   A LEFT JOIN or a LEFT OUTER JOIN takes all the rows from one table, defined as the `LEFT` table, and `JOIN`s it with a second table. The JOIN is based on the conditions supplied in the parentheses. A `LEFT JOIN` will always include the rows from the `LEFT` table, even if there are no matching rows in the table it is JOINed with.What's being said in SQL is "give me all the matching rows from the left table along with any matching data from the RIGHT table based on the ON clause".
+   A CROSS JOIN, also known as a Cartesian JOIN, returns all rows from one table crossed with every row from the second table. This JOIN does not have an ON clause.``SELECT * FROM users CROSS JOIN addresses;``
+   A `RIGHT JOIN` is similar to a `LEFT JOIN` except that all the data on the second table is included.
+   ``pg_dump --inserts --no-acl --clean library > library.sql``,``psql -d library < library.sql``
+   ``copy (select u.username, b.title from users u inner join users_books ub on (ub.user_id = u.id) inner join books b on (b.id = ub.book_id)) to '/tmp/users_books.csv' with cvs;``
+   ``copy (select u.username, b.title from users u inner join users_books ub on (ub.user_id = u.id) inner join books on (b.id = ub.book_id)) to '/tmp/users_books.csv' with csv header;``
+   PostgreSQL使用C/S架构模型，客户端psql终端输入的命令必须传送给server来进行执行处理，``copy``命令必须使用绝对路径，服务端不知道客户端所在的路径。``\copy``可以使用相对路径。
+   ``\copy books (title, author, published_date) FROM './gutenberg_books.csv' DELIMITER ','  CSV;``
+   ``SELECT CONCAT(title,' by ', author) AS "Books By" FROM books;``,format data
+   ``SELECT COUNT(id) AS enabled_count FROM users WHERE enabled = true;``,aliasing
+   ``SELECT DISTINCT u.username FROM users LEFT JOIN  users_books ub ON (ub.user_id = u.id);``
+   ``SELECT title, author FROM books LIMIT 5;``
+   ``SELECT u.username FROM users WHERE u.id NOT IN (SELECT ub.user_id FROM users_books ub);``
+   [using explain](https://www.postgresql.org/docs/current/static/using-explain.html)
+   ​