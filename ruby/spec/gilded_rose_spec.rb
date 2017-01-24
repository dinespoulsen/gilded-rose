require "spec_helper"
require "gilded_rose"

describe GildedRose do

  subject(:rose) {described_class.new}
  let(:cheese) {double(:cheese, :name => "Aged Brie", :quality => 10, :sell_in => 10)}
  let(:sulfuras) {double(:sulfuras, :name => "Sulfuras, Hand of Ragnaros", :quality => 10, :sell_in => 10)}
  let(:backstage) {double(:backstage, :name => "Backstage passes to a TAFKAL80ETC concert", :quality => 10, :sell_in => 10)}

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

    it "should return false when checking whether sulfuras should decrease in quality" do
      expect(rose.decrease_quality?(sulfuras)).to be(false)
    end

    it "should return false when checking whether backstage passes should decrease in quality" do
      expect(rose.decrease_quality?(backstage)).to be(false)
    end

    it "should return false when checking whether backstage passes should decrease in quality" do
      expect(rose.increase_quality?(backstage)).to be(true)
    end

    context "when updating quality" do
      it "should increase the quality of the aged brie" do
        brie = Item.new("Aged Brie", 10, 10)
        rose.add(brie)
        expect{rose.update_quality}.to change{brie.quality}.from(10).to(11)
      end

      it "should decrease the quality of a random item" do
        brie = Item.new("test", 10, 10)
        rose.add(brie)
        expect{rose.update_quality}.to change{brie.quality}.from(10).to(9)
      end
    end
  end

end
