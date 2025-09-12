# README

# Create a Rails API-only Application

Run below in the terminal:

```bash
rails new nile --api
```

# Generate controller with rails scaffolding

```bash
rails g controller BooksController index
```

# Generate a model

1. Create model:

```bash
rails g model Book title:string author:string
```

2. Run the migrations

```bash
rails db:migrate
```

# Populate the model with data

1. Run below to start a IRB session within the context of the rails application:

```bash
rails c
```

2. Run:

```bash
Book.create!(author: 'tom', title: 'Rails API')
```

# Search for a specific terms in routes

```bash
rails routes | grep book
```

# The :status Option in Rails

```rb
render json: book, status: :created
```

All status symbols:

Official: https://guides.rubyonrails.org/layouts_and_rendering.html?utm_source=chatgpt.com#the-status-option

Unofficial: http://www.railsstatuscodes.com/

# Adding Validations

In order for `books.errors` from the controller method to work as seen below:

```rb
render json: book.errors, status: :unprocessible_entity
```

Validations have to put in the model.

Docs: https://guides.rubyonrails.org/active_record_validations.html

# rescue_from

https://apidock.com/rails/ActiveSupport/Rescuable/ClassMethods/rescue_from

# Rspec to run tests

Guide:

https://www.youtube.com/watch?v=-aO0TlPTHhA&list=PLbTv9eGiI03u1-JFkFpPGsR_hMre6WX3e&index=9

https://www.youtube.com/watch?v=u7TglqnXbDw&list=PLbTv9eGiI03u1-JFkFpPGsR_hMre6WX3e&index=10

To run test

```bash
rspec
```

```bash
bundle exec rspec spec/requests/books_spec.rb
```

# For model associations

1. Create a `author` model

```bash
rails g model Author first_name:string last_name:string age:integer
```

Then run migrations:

```bash
rails db:migrate
```

We need a foreign key id which references the other model:

```bash
rails g migration add_author_to_books author:references
```

This sets up that has_many...belongs_to references

Then remove below from that migration file:

```rb
# # , null: false, foreign_key: true
```

Now, remove the previous author string field

```bash
rails g migration remove_author_from_books author:string
```

# Controller Representers

Controllers representers are used for populating and pre-processing json response

# Active Job for background jobs

Generate a job:

```bash
rails g job update_sku
```

Call the job in the controller

```rb
UpdateSkuJob.perform_later(book_params[:title])
```

# Generate a user model

```bash
rails g model User username:string
```

# Adding `password_digest` to the user model

```bash
rails g migration add_password_digest_to_user password_digest:string
```

Then add below in the user model:

```ruby
has_secure_password
```

# Create a user in rails console

```bash
rails c
```

```ruby
User.create(username: 'BookSeller99')
user = User.first
user.password = 'Password1'
user.save!
```

# HTTP Token Authentication
