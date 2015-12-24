# homamiii-db
Use MySQL 5.7 with this project. Here's is pretty straightforward way of getting it on a Windows machine. If you're using Linux, I'm pretty sure you know what you're doing, and this step should be a breeze for you. 

*NOTE: The tutorial suggests installing many MySQL components, but I recommend just installing the 'MySQL Server' componentas the rest is just unnecessary for this project.*

[Install MySQL on Windows Using MySQL Installer](http://www.mysqltutorial.org/install-mysql/)

Next, you'll want to download GitHub Desktop, which can be found here: [GitHub Desktop](https://desktop.github.com/)

Here's a link to setting up GitHub Desktop: [Installing GitHub Desktop](https://help.github.com/desktop/guides/getting-started/installing-github-desktop/)

Again, if you're on Linux, just get the git commandline program, and get hub from here: [hub commandline tool](https://github.com/github/hub)

I recommend creating an alias for `hub` using the `git` command.

If you're on Windows, but you still want to use the commandline, I recommend Git Bash: [Git for Windows](https://git-for-windows.github.io/)

Once you've got yourself set up to clone a Git repository, clone this one. To do this in GitHub Desktop, check out the following tutorial: [Adding and cloning repositories in GitHub Desktop](https://help.github.com/desktop/guides/contributing/adding-and-cloning-repositories/)

Once you've got it cloned onto your local system, I suggest modifying lines 4 and 5 of `homamiii.sql`. Right now, it's set to a local user of mine that I use when logging into MySQL, but you should change it to your own user. Note that these lines will create your user for you; you don't need to explicitly issue a `CREATE USER` command from the MySQL commandline after the fact.

Now, open up a terminal or command prompt, change directory to where the `homamiii.sql` script is located on your filesystem, and log into your local mysql server with your root account's password that you set during your MySQL installation:

`mysql -u root -p`

and type the following:

`source homamiii.sql;`

This script will create the database, its tables, and load up all the data from the CSVs into the database. 

As a test to make sure everything worked, query the database:

`SELECT name from creature;`

This should return 146 rows of creatures' names.

Now, log out of MySQL, then log in to the `homamiii` database as your new user.

`mysql -u <username> -p homamiii`

And that's it! Happy querying!

###External references:

- [Heroes of Might and Magic III Wiki](http://heroes.thelazy.net/wiki/Main_Page)

##TODO:
- Create table for [spells](http://heroes.thelazy.net/wiki/Spells)
- Create table for [heroes' secondary skills](http://heroes.thelazy.net/wiki/Category:Secondary_skills)
- Create table for [heroes](http://heroes.thelazy.net/wiki/List_of_heroes)

##DONE:
- Create table for [artifacts](http://heroes.thelazy.net/wiki/Artifacts)
