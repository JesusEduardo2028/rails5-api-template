require "rails_helper"

RSpec.describe "Items API", :type => :request do

  before { host! "api.rails-5-template.com" }

  context "GET methods" do
    context "/items" do
      before(:all) do
        @items = FactoryGirl.create_list(:item, 10 )
      end
      it "should return all items" do
        get "/items"
        response_data = json(response.body)[:data]
        expect(response.status).to be(200)
        expect(response_data.count).to be @items.count
        expect(response.content_type).to eq Mime[:json]
      end
    end
    context "/items/:id" do
      before do
        @item = FactoryGirl.create(:item)
      end
      it "should return the correct item" do
        get "/items/#{@item.id}"
        response_data = json(response.body)[:data]
        item_attributes = {
          name: @item.name,
          quantity: @item.quantity
        }

        expect(response.status).to be(200)
        expect(response_data[:id].to_i).to eq(@item.id)
        expect(response_data[:attributes]).to eq item_attributes
      end
    end
  end

  context "POST methods" do
    context "/items" do
      it "should creates a new item" do
        item_hash =  {name: "Item name", quantity: 200} 
        post '/items', params: {item: item_hash }
        new_item = json(response.body)[:data]
        expect(response.status).to be(201)
        expect(Item.count).to eq 1
        expect(new_item[:id]).to_not be_nil
      end
    end

    context "invalid /items post request" do
      it "should respond with a 422 error and total error messages" do
        item_hash =  {name: nil, quantity: nil} 
        post '/items', params: {item: item_hash }
        error_message = json(response.body)
        expect(response.status).to be(422)
        expect(error_message.count).to be 2
      end
    end
  end

  context "PATCH methods" do
    context "/items/:id" do
      before do
        @item = FactoryGirl.create(:item)
      end
      it "should update an item with new data" do
        new_item_name = "THE ITEM"
        patch "/items/#{@item.id}",{params: {item: { name: new_item_name } }}
        expect(response.status).to be(200)
        expect(@item.reload.name).to eq new_item_name
      end
    end

    context "invalid /items/:id patch request" do
      before do
        @item = FactoryGirl.create(:item)
      end
      it "should respond with a 422 error and total error messages" do
        new_item_name = ""
        patch "/items/#{@item.id}",{params: {item: { name: new_item_name } }}
        error_message = json(response.body)
        expect(response.status).to be(422)
        expect(error_message.count).to be 1
      end
    end
  end

  context "DELETE methods" do
    before do
      @item = FactoryGirl.create(:item)
    end
    context "items/:id " do
      it "should delete the item" do
        delete "/items/#{@item.id}"
        expect(response.status).to be(204)
        expect(Item.count).to eq(0)
      end
    end
  end

end