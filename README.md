[![CircleCI](https://circleci.com/gh/henriqueaf/bank_accounting/tree/master.svg?style=svg)](https://circleci.com/gh/henriqueaf/bank_accounting/tree/master)

# README
## About
This is a fake Bank Account system that allow registered users to simulate money(Brazilian BRL) transferences with each other. It's an implementation of specs described [here](https://gist.github.com/bezelga/f4f6c065a454665122b875b1566d5178).

Basically this system allow any person to sign up and start to transfer money to other people. To make a transference the user only need to select other user account and value of the transference. Of course, there are some rules:
* Source account need to have enough money
* Both accounts (source and destination) need to be a valid one

It uses a Ruby on Rails framework and PostgreSQL as database.

## Demo
Enjoy a running example here: https://bank-accounting.herokuapp.com/

## Dependencies
To get started with this project you will need to install:
* Ruby: https://rvm.io/ (version 2.5.1)
* PostgresSQL: https://www.postgresql.org/download/

## Getting started
Clone this project:
```
$ git clone git@github.com:henriqueaf/bank_accounting.git
```

Enter on project directory and install gems:
```
$ bundle install
```

Copy and change(as you wish) the database configuration file:
```
$ cp config/database.yml.example config/database.yml
```

Create and migrate database:
```
$ rake db:setup
```

When you play with the code, remember to run the tests to make sure it's not broken: (you should run tests before play with code, just saying...)
```
$ bundle exec rspec
```

PS: Play with it at your own risk! I'm not responsible for whatever you do with your FAKE VIRTUAL MONEY! =D
