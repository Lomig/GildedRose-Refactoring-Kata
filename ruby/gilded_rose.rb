class GildedRose

  def initialize(items)
    @items = items
  end

  def aged_brie_update(item)
    item.sell_in -= 1

    item.quality +=1
    item.quality +=1 if item.sell_in < 0
    item.quality = 50 if item.quality > 50
  end

  def backstage_update(item)
    item.sell_in -= 1
    return item.quality = 0 if item.sell_in < 0

    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
    item.quality = 50 if item.quality > 50
  end

  def sulfuras_update(item)
  end

  def common_update(item)
    item.sell_in -= 1

    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
    item.quality = 0 if item.quality < 0
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Aged Brie"
        aged_brie_update(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        backstage_update(item)
      when "Sulfuras, Hand of Ragnaros"
        sulfuras_update(item)
      else
        common_update(item)
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
