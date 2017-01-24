require "spec_helper"
require "item"

describe Item do

  context "when initialized" do
    it "comes with a name" do
      cheese = Item.new("Cheese", 10, 10)
      expect(cheese.name).to eq("Cheese")
    end

    it "comes with a sell in property" do
      cheese = Item.new("Cheese", 10, 10)
      expect(cheese.sell_in).to eq(10)
    end

    it "comes with a quality property" do
      cheese = Item.new("Cheese", 10, 10)
      expect(cheese.quality).to eq(10)
    end
  end
end
