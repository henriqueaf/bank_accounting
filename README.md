[![CircleCI](https://circleci.com/gh/henriqueaf/bank_accounting/tree/master.svg?style=svg)](https://circleci.com/gh/henriqueaf/bank_accounting/tree/master)

# Bank Accounting
## About
This is a fake Bank Account system that allow registered users to simulate money(Brazilian BRL) transferences with each other. It's an implementation of specs described [here](https://gist.github.com/bezelga/f4f6c065a454665122b875b1566d5178).

Basically this system allow any person to sign up and start to transfer money to other people. To make a transference the user only need to select other user account and value of the transference. Of course, there are some rules:
* Source account need to have enough money
* Both accounts (source and destination) need to be a valid one
* Credit and debit transactions must stay together (if one fail, the other one is canceled)

It uses a Ruby on Rails framework and PostgreSQL as database.

## Demo
Enjoy a running example here: https://bank-accounting.herokuapp.com/

PS: Play with it at your own risk! I'm not responsible for whatever you do with your FAKE VIRTUAL MONEY! =D

## Dependencies
To get started with this project you will need to install:
* Ruby: https://rvm.io/ (version 2.5.1)
* PostgresSQL: https://www.postgresql.org/download/
* Npm: https://www.npmjs.com/get-npm

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

Install npm packages:
```
$ npm install
```

When you play with the code, remember to run the tests to make sure it's not broken: (you should run tests before play with code, just saying...)
```
$ bundle exec rspec
```

After that, just run the server...
```
$ rails server
```

... and access the URL on your browser
```
http://localhost:3000
```

## Console Usage
You can try it by Rails console. First, enter on project folder and start the rails console:
```
$ rails console
```
Then create an user to be the "source": (by default, when you create an user, the system also creates an account with R$ 5.000,00)
```
> source_user = FactoryBot.create(:user)
```
Now create other user to receive the money:
```
> destination_user = FactoryBot.create(:user)
```
And here we can transfer money using the module created for that:
```
> Core.transfer_money?(source_user.account.id, destination_user.account.id, 1000)
# => true

> Core.get_balance(source_user.account.id).to_d
# => 4000.0

> Core.transfer_money?(source_user.account.id, destination_user.account.id, 100000)
# => false
```
