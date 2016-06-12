module API
  class ItemsController < ApplicationController
    before_action :authenticate_user!

    def_param_group :authentication_headers do
      header 'access-token', 'Access authentication token' ,:required => true
      header 'uid', 'user email', :required => true
    end

    #GET "/items"
    api :GET, "/items", "Show all items"
    error :code => 401, :desc => "Unauthorized"
    param_group :authentication_headers
    description "Obtain all items"
    formats ['json']
    example '
    {
      "data": [
        {
          "id": "1",
          "type": "one item",
          "attributes": {
            "name": "hey",
            "quantity": 20
          }
        },
        {
          "id": "2",
          "type": "items",
          "attributes": {
            "name": "another item",
            "quantity": 30
          }
        }
      ]
    }
    '
    def index
      items = Item.all
      render json: items , status: 200
    end

    #GET "/items/:id"
    api :GET, "/items/:id", "Show item"
    error :code => 401, :desc => "Unauthorized"
    error :code => 404, :desc => "Item not found"
    param_group :authentication_headers
    description "Obtain one item by id"
    formats ['json']
    example '
    {
      "data": {
        "id": "1",
        "type": "items",
        "attributes": {
          "name": "hey",
          "quantity": 20
        }
      }
    }'
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
     
     #PATCH "/items/:id"
     def update
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: item, status: 200
      else
        render json: item.errors, status: 422
      end
     end

     #DELETE "/items/:id"
     def destroy
      item = Item.find(params[:id])
      item.destroy
      head 204
     end

     private
      def item_params 
        params.require(:item).permit(:name,:quantity)
      end
  end
end