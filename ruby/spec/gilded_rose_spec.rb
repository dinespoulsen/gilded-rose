require "spec_helper"
require "gilded_rose"

describe GildedRose do

  subject(:rose) {described_class.new}
  let(:cheese) {double(:cheese, :name => "cheese", :quality => 10, :sell_in => 10)}
  let(:sulfuras) {double(:sulfuras, :name => "sulfuras", :quality => 10, :sell_in => 10)}

  describe "The Gilded Rose" do
    it "should be able to add an item" do
      rose.add(cheese)
      expect(rose.items).to include(cheese)
    end

    it "should return false when checking whether cheese should decrease in quality" do
      expect(rose.decrease_quality?(cheese)).to be(false)
    end

    it "should return true when checking if cheese should increase in quality" do
      expect(rose.increase_quality?(cheese)).to be(true)
    end

    it "should return false when checking whether sulfuras should decrease in quality" do
      expect(rose.decrease_quality?(sulfuras)).to be(false)
    end
  end

end
