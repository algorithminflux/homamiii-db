# homamiii-db
Use mysql 5.7 with this project. You can download it here: 

[MySQL 5.7](https://dev.mysql.com/downloads/mysql/)

To get started, open up a terminal or command prompt, change directory to where `homamiii.sql` is located on your filesystem, and log into your local mysql server with your root account's password that you set during your MySQL installation:

`mysql -u root -p`

and type the following:

`source homamiii.sql;`

This script will create the database, its tables, and load up all the data from the CSVs into the database.

##TODO:
- Create table for [spells](http://heroes.thelazy.net/wiki/Spells)
- Create table for [heroes' secondary skills](http://heroes.thelazy.net/wiki/Category:Secondary_skills)
- Create table for [heroes](http://heroes.thelazy.net/wiki/List_of_heroes)

##DONE:
- Create table for [artifacts](http://heroes.thelazy.net/wiki/Artifacts)
