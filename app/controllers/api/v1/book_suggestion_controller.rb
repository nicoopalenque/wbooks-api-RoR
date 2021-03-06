module Api
  module V1
    class BookSuggestionController < ApplicationController
      def index
        render json: BookSuggestion.all
      end

      def create
        @book = BookSuggestion.new(book_params)
        if @book.save
          render json: @book, status: :created
        else
          render json: creation_failed, status: :bad_request
        end
      end

      private

      def book_params
        params.require(:book_suggestion).permit(
          :synopsis,
          :price,
          :author,
          :title,
          :link,
          :editor,
          :year,
          :user_id
        )
      end

      def creation_failed
        { error: 'The book could not be created' }
      end
    end
  end
end
