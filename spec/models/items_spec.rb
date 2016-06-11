require 'rails_helper'

describe Item do
  before { @item = FactoryGirl.build(:item) }

  subject { @item }

  it { should respond_to(:name) }
  it { should respond_to(:quantity) }

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:quantity)}
end