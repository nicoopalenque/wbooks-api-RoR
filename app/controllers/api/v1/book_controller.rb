module Api
  module V1
    class BookController < ApplicationController
      before_action :authenticate_user!

      def index
        @books = Book.all
        render_paginated @books, each_serializer: Api::V1::Serializer::BookSerializer
      end

      def show
        render json: Api::V1::Serializer::BookSerializer.new.serialize_to_json(find_book)
      end

      private

      def find_book
        @find_book ||= Book.find(params[:id])
      end
    end
  end
end