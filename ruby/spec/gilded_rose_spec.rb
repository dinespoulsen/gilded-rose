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

    it "should return true when checking when sulfuras should change in quality" do
      expect(rose.not_change?(sulfuras)).to be(true)
    end

    it "should return false when checking whether cheese should decrease in quality" do
      expect(rose.decrease_quality?(cheese)).to be(false)
    end

    it "should return true when checking if cheese should increase in quality" do
      expect(rose.increase_quality?(cheese)).to be(true)
    end

    it "should return false when checking whether backstage passes should decrease in quality" do
      expect(rose.decrease_quality?(backstage)).to be(false)
    end

    it "should return false when checking whether backstage passes should decrease in quality" do
      expect(rose.increase_quality?(backstage)).to be(true)
    end

    it "should return true when quality is higher than 0" do
      test_item = Item.new("test", 10, 1)
      expect(rose.valid_quality?(test_item)).to be(true)
    end

    it "should return true when quality is lower than 50" do
      test_item = Item.new("test", 10, 49)
      expect(rose.valid_quality?(test_item)).to be(true)
    end

    it "should return false when quality is 50 or higher" do
      test_item = Item.new("test", 10, 50)
      expect(rose.valid_quality?(test_item)).to be(false)
    end

    it "should return false when quality is 0 or lower" do
      test_item = Item.new("test", 10, 0)
      expect(rose.valid_quality?(test_item)).to be(false)
    end

    context "when updating quality and sell in date has passed" do

      it "should decrease the quality of a random item twice as fast" do
        test_item = Item.new("test", 0, 10)
        rose.add(test_item)
        expect{rose.update_quality}.to change{test_item.quality}.from(10).to(8)
      end

      it "should never let the quality of an item be negative" do
        test_item = Item.new("test", 0, 1)
        rose.add(test_item)
        expect{rose.update_quality}.to change{test_item.quality}.from(1).to(0)
      end
    end

    context "When increasing quality" do

      it "should be able to hanlde aging brie" do
        brie = Item.new("Aged Brie", 10, 10)
        expect{rose.increase_quality(brie)}.to change{brie.quality}.from(10).to(11)
      end

      it "should be able to hanlde backstage pass when sell in value is less than 11" do
        backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)
        expect{rose.increase_quality(backstage)}.to change{backstage.quality}.from(10).to(12)
      end

      it "should be able to hanlde backstage pass when sell in value is less than 6" do
        backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)
        expect{rose.increase_quality(backstage)}.to change{backstage.quality}.from(10).to(13)
      end
    end

    context "When decreasing quality" do
      it "should decrease by one" do
        test = Item.new("test", 10, 10)
        expect{rose.decrease_quality(test)}.to change{test.quality}.from(10).to(9)
      end
    end

    context "When decreaseing sell_in date" do
      it "should return true if sell in date has passed" do
        test = Item.new("test", -1, 10)
        expect(rose.passed_sell_date?(test)).to be(true)
      end

      it "should return false if sell in date has passed" do
        test = Item.new("test", 1, 10)
        expect(rose.passed_sell_date?(test)).to be(false)
      end

      it "should decrease handle a standard item" do
        test = Item.new("test", 10, 10)
        expect{rose.decrease_sell_in(test)}.to change{test.sell_in}.from(10).to(9)
      end

      it "should handle backstage pass when sell in date has passed" do
        backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 10)
        expect{rose.increase_quality(backstage)}.to change{backstage.quality}.from(10).to(0)
      end

      it "should handle aged brie when sell in date has passed" do
        brie = Item.new("Aged Brie", -1, 10)
        expect{rose.increase_quality(brie)}.to change{brie.quality}.from(10).to(12)
      end
    end

    context "when handling Conjured item" do
      it "should decrease quality by two when sell in has not passed" do
        conjured = Item.new("Conjured", 10, 10)
        expect{rose.decrease_quality(conjured)}.to change{conjured.quality}.from(10).to(8)
      end

      it "should decrease quality by 4 when sell in has passed" do
        conjured = Item.new("Conjured", -1, 10)
        expect{rose.decrease_quality(conjured)}.to change{conjured.quality}.from(10).to(6)
      end
    end
  end

  describe "when testing the case spacifications" do

    it "should decrease the quality of a random item" do
      test_item = Item.new("test", 10, 10)
      rose.add(test_item)
      expect{rose.update_quality}.to change{test_item.quality}.from(10).to(9)
    end

    it "should increase the quality of the aged brie" do
      brie = Item.new("Aged Brie", 10, 10)
      rose.add(brie)
      expect{rose.update_quality}.to change{brie.quality}.from(10).to(11)
    end

    it "should increase the quality of the aged brie by two when sell in date has passed" do
      brie = Item.new("Aged Brie", 0, 10)
      rose.add(brie)
      expect{rose.update_quality}.to change{brie.quality}.from(10).to(12)
    end

    it "should increase the quality of a backstage pass with 1 when sell in is more than 10" do
      backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)
      rose.add(backstage)
      expect{rose.update_quality}.to change{backstage.quality}.from(10).to(11)
    end

    it "should increase the quality of a backstage pass with 2 when sell in 10 or less" do
      backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)
      rose.add(backstage)
      expect{rose.update_quality}.to change{backstage.quality}.from(10).to(12)
    end

    it "should increase the quality of a backstage pass with 3 when sell in is 5 or less" do
      backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)
      rose.add(backstage)
      expect{rose.update_quality}.to change{backstage.quality}.from(10).to(13)
    end

    it "should be zero quality for backstage pass when sell in is zero" do
      backstage = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)
      rose.add(backstage)
      expect{rose.update_quality}.to change{backstage.quality}.from(10).to(0)
    end

    it "should not change the quality of a sulfuras" do
      sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 5, 10)
      rose.add(sulfuras)
      expect{rose.update_quality}.not_to change{sulfuras.quality}
    end

    it "should never let the quality of an item be negative" do
      test = Item.new("test", 10, 0)
      rose.add(test)
      expect{rose.update_quality}.not_to change{test.quality}
    end

    it "should never let the quality of an item be more than 50" do
      brie = Item.new("Aged Brie", 10, 50)
      rose.add(brie)
      expect{rose.update_quality}.not_to change{brie.quality}
    end
  end

end
