class ConsoleController < ApplicationController
  def show
    @items = Item.all
  end
end
