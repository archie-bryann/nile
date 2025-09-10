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

All status symbols: https://guides.rubyonrails.org/layouts_and_rendering.html?utm_source=chatgpt.com#the-status-option

# To require certail fields for a route (ChatGPT)

1. Model-level validation (like Mongoose `required: true`)

```rb
class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
end

```

2. Controller-level requirement (like request validation middleware in Express)

```rb
def create
  book = Book.new(book_params)

  if book.save
    render json: book, status: :created
  else
    render json: book.errors, status: :unprocessable_entity
  end
end

private

def book_params
  # Require :book, and also require that :title and :author are present inside
  params.require(:book).require([:title, :author]).permit(:title, :author)
end
```

3. Why both? This way, even if a request sneaks around the controller (say, a background job or a different API endpoint), the model still enforces the rules.
