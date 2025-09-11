module Api
  module V1
    class BooksController < ApplicationController
      # applies the rescue to every method in this controller
      # rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

      MAX_PAGINATION_LIMIT = 100
      
      def index
        # books = Book.all

        # to make pagination work
        # const pageLimit = req.query.limit || 10;
        # const currentPage = req.query.page || 1;
        # const skipIndex = (currentPage - 1) * pageLimit; # offset


        # books = Book.limit(params[:limit]).offset(params[:offset])
        books = Book.limit(limit).offset(params[:offset])

        # render json: Book.all
        render json: BooksRepresenter.new(books).as_json
      end
      
      # def show
      #   render json: { id: book.id, title: book.title, author: book.author }
      # end

      def create
        # binding.irb # breakpoint
        # some logic
        # Book.create(title: 'Harry Potter 1', author: 'JK Rowling')
        # book = Book.new(title: 'Harry Potter 1', author: 'JK Rowling')
        # book = Book.new(title: params[:title], author: params[:author])
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))

        UpdateSkuJob.perform_later(book_params[:title])

        # Book.new(book_params).valid? # to check if valid without saving

        if book.save
          # render json: book, status: 201
          # render json: book, status: :created
          render json: BookRepresenter.new(book).as_json, status: :created
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

      def limit # set a limit of max 100 i.e. <= 100
        [
          params.fetch(:limit).to_i,
          MAX_PAGINATION_LIMIT
      ].min
      end

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        # params.require(:book).permit(:title, :author)
        params.require(:book).permit(:title)
      end

      # def not_destroyed
      #   render json: {}, status: :unprocessible_entity
    end
  end
end