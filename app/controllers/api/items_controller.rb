module API
  class ItemsController < ApplicationController
    protect_from_forgery with: :null_session
    
    #GET "/items"
    def index
      items = Item.all
      render json: items , status: 200
    end

     #GET "/items/:id"
    def show
      item = Item.find(params[:id])
      render json: item , status: 200
    end

     #POST "/items"
     def create
      item = Item.new(item_params)
      if item.save
        render json: item, status: 201
      else
        render json: item.errors, status: 422
      end
     end
     
     private
      def item_params 
        params.require(:item).permit(:name,:quantity)
      end
  end
end