class GildedRose
  attr_reader :items
  MAX_QUALITY = 50

  def initialize(items = [])
    @items = items
  end

  def add(item)
    self.items << item
  end

  def not_change?(item)
    return true if item.name == "Sulfuras, Hand of Ragnaros"
  end

  def increase_quality?(item)
    return true if item.name == "Aged Brie"
    return true if item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def decrease_quality?(item)
    return false if item.name == "Aged Brie"
    # return false if item.name == "Sulfuras, Hand of Ragnaros"
    return false if item.name == "Backstage passes to a TAFKAL80ETC concert"
    return true
  end

  def valid_quality?(item)
    return true if item.quality > 0 && item.quality < 50
    return false
  end

  def increase_quality(item)
    return item.quality += 3 if item.name == "Backstage passes to a TAFKAL80ETC concert" && item.sell_in < 6
    return item.quality += 2 if item.name == "Backstage passes to a TAFKAL80ETC concert" && item.sell_in < 11
    return item.quality += 1
  end

  def decrease_quality(item)
    item.quality -= 1
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end


  def update_quality
    @items.each do |item|
    if not_change?(item)
      return item
    else
      if decrease_quality?(item)
        if valid_quality?(item)
            decrease_quality(item)
        end
      else
        if valid_quality?(item)
          increase_quality(item)
        end
      end
    end

    item.sell_in = item.sell_in - 1
    #to handle when sell_in goes below 0
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
                item.quality = item.quality - 1
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < MAX_QUALITY
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end



# class Item
#   attr_accessor :name, :sell_in, :quality
#
#   def initialize(name, sell_in, quality)
#     @name = name
#     @sell_in = sell_in
#     @quality = quality
#   end
#
#   def to_s()
#     "#{@name}, #{@sell_in}, #{@quality}"
#   end
# end
