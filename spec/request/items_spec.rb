require "rails_helper"

RSpec.describe "Items API", :type => :request do

  before { host! "api.rails-5-template.com" }

  context "GET methods" do
    context "/items" do
      before(:all) do
        @items = FactoryGirl.create_list(:item, 10 )
      end
      it "return all items" do
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
      it "returns the correct item" do
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
      it "it creates a new item" do
        item_hash =  {name: "Item name", quantity: 200} 
        post '/items', params: {item: item_hash }
        new_item = json(response.body)[:data]
        expect(response.status).to be(201)
        expect(Item.count).to eq 1
        expect(new_item[:id]).to_not be_nil
      end
    end

  end
end