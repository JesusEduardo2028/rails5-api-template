require "rails_helper"

RSpec.describe "Items API", :type => :request do

  before { host! "api.rails-5-template.com" }

  context "/items" do
    before do
      @items = FactoryGirl.create_list(:item, 10 )
    end
    it "return all items" do
      get "/items"
      response_data = json(response.body)[:data]
      expect(response.status).to be(200)
      expect(response_data.count).to be @items.count
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
      expect(response_data[:id].to_i).to be(@item.id)
      expect(response_data[:attributes]).to eq item_attributes
    end
  end
end