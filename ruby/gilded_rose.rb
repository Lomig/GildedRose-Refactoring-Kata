class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when "Aged Brie"
        AgedBrie.new(item).update
      when "Backstage passes to a TAFKAL80ETC concert"
        Backstage.new(item).update
      when "Sulfuras, Hand of Ragnaros"
        Sulfuras.new(item).update
      else
        CommonItem.new(item).update
      end
    end
  end

  class CommonItem
    attr_reader :item

    def initialize(item)
      @item = item
    end


    def update
      item.sell_in -= 1

      item.quality -= 1
      item.quality -= 1 if item.sell_in < 0
      
      limit_quality
      self
    end

    private

    def limit_quality
      return item.quality = 0 if item.quality < 0

      item.quality = 50 if item.quality > 50
    end
  end

  class AgedBrie < CommonItem
    def update
      item.sell_in -= 1

      item.quality +=1
      item.quality +=1 if item.sell_in < 0

      limit_quality
      self
    end
  end

  class Backstage < CommonItem
    def update
      item.sell_in -= 1
      item.quality = 0 and return self if item.sell_in < 0

      item.quality += 1
      item.quality += 1 if item.sell_in < 10
      item.quality += 1 if item.sell_in < 5

      limit_quality
      self
    end
  end

  class Sulfuras < CommonItem
    def update
      self
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
