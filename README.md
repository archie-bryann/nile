# README

# Create a Rails API-only Application

Run below in the terminal:

```
rails new nile --api
```

# Generate controller with rails scaffolding

```
rails g controller BooksController index
```

# Generate a model

1. Create model:

```
rails g model Book title:string author:string
```

2. Run the migrations

```
rails db:migrate
```

# Populate the model with data

1. Run below to start a IRB session within the context of the rails application:

```
rails c
```

2. Run:

```
Book.create!(author: 'tom', title: 'Rails API')
```

# Search for a specific terms in routes

```
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
