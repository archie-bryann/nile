module Api
  module V1
    class BooksController < ApplicationController
      # applies the rescue to every method in this controller
      # rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

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
        # `!` returns true if successful & an exception we can handle if not.
        Book.find(params[:id]).destroy!

        head :no_content # 204
      # rescue ActiveRecord::RecordNotDestroyed
      #   render json: {}, status: :unprocessable_entity
      end


      private

      def book_params
        params.require(:book).permit(:title, :author)
      end

      # def not_destroyed
      #   render json: {}, status: :unprocessible_entity
    end
  end
end