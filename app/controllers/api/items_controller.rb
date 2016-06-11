module API
  class ItemsController < ApplicationController
    def index
      items = Item.all
      render json: items , status: 200
    end
    def show
      item = Item.find(params[:id])
      render json: item , status: 200
    end
  end
end