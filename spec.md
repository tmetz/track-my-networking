# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app

#### App is built with Sinatra


- [x] Use ActiveRecord for storing information in a database

* Migrations have been created and run


- [x] Include more than one model class (e.g. User, Post, Category)
Modes: User, Person (meaning professional connection), Interaction

- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
User has_many interactions, and has_many persons through interactions

- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
Interaction belongs_to User and Person

- [x] Include user accounts with unique login attribute (username or email)
User accounts use unique email

- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
Interaction has all CRUD routes

- [x] Ensure that users can't modify content created by other users
Before being sent to an edit page or allowed to delete, user is verified as being the owner of the content

- [x] Include user input validations
Validates on a variety of things, including whether there is a password and whether the email address is unique

- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
Uses flash messages to display errors

- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
README has been created

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message