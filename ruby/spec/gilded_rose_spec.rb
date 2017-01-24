require "spec_helper"
require "gilded_rose"

describe GildedRose do

  subject(:rose) {described_class.new}
  let(:cheese) {double(:cheese)}


  describe "The Gilded Rose" do
    it "should be able to add an item" do
      rose.add(cheese)
      expect(rose.items).to include(cheese)
    end
  end

end
