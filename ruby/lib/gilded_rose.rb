class GildedRose
  attr_reader :items
  MAX_QUALITY = 50
  NAME_AGED_BRIE = "Aged Brie"
  NAME_CONJURED = "Conjured"
  NAME_BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  NAME_SULFURAS = "Sulfuras, Hand of Ragnaros"
  INCREASE_QUALITY = [NAME_AGED_BRIE, NAME_BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"]

  def initialize(items = [])
    @items = items
  end

  def add(item)
    self.items << item
  end

  def not_change?(item)
    return true if item.name == NAME_SULFURAS
  end

  def increase_quality?(item)
    return true if INCREASE_QUALITY.include?(item.name)
  end

  def decrease_quality?(item)
    return false if INCREASE_QUALITY.include?(item.name)
    return true
  end

  def valid_quality?(item)
    return true if item.quality > 0 && item.quality < 50
    return false
  end

  def increase_quality(item)
    if valid_quality?(item)
      return item.quality -= item.quality if item.name == NAME_BACKSTAGE_PASS && passed_sell_date?(item)
      return item.quality += 3 if item.name == NAME_BACKSTAGE_PASS && item.sell_in < 6
      return item.quality += 2 if item.name == NAME_BACKSTAGE_PASS && item.sell_in < 11
      return item.quality += 2 if passed_sell_date?(item)
      return item.quality += 1
    else
      return item
    end
  end

  def decrease_quality(item)
    if valid_quality?(item)
      return item.quality -= 4 if item.name == NAME_CONJURED && passed_sell_date?(item)
      return item.quality -= 2 if item.name == NAME_CONJURED
      return item.quality -= 2 if passed_sell_date?(item) && item.quality > 1
      item.quality -= 1
    else
      return item
    end
  end

  def passed_sell_date?(item)
    item.sell_in < 0
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end


  def update_quality
    @items.each do |item|
    item.sell_in = item.sell_in - 1
      if not_change?(item)
        return item
      else
        if decrease_quality?(item)
          decrease_quality(item)
        else
          increase_quality(item)
        end
      end
    end
  end

end
