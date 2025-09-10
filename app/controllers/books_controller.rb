class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def create
    # some logic
    # Book.create(title: 'Harry Potter 1', author: 'JK Rowling')
    # book = Book.new(title: 'Harry Potter 1', author: 'JK Rowling')
    # book = Book.new(title: params[:title], author: params[:author])
    book = Book.new(book_params)

    if book.save
      # render json: book, status: 201
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Book.find(params[:id]).destroy!

    head :no_content # 204
  end


  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
