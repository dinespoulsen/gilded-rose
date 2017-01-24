require "spec_helper"
require "item"

describe Item do

  context "when initialized" do
    it "comes with a name" do
      cheese = Item.new("Cheese", 10, 10)
      expect(cheese.name).to eq("Cheese")
    end
  end
end
