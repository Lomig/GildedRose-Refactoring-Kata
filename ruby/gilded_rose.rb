require_relative("item")
require_relative("common_item")
require_relative("aged_brie")
require_relative("backstage")
require_relative("sulfuras")

class GildedRose
  ITEM_CLASSES = {
    "Aged Brie"                                 => AgedBrie,
    "Sulfuras, Hand of Ragnaros"                => Sulfuras,
    "Backstage passes to a TAFKAL80ETC concert" => Backstage
  }

  def initialize(items)
    @items = items.map { |item| class_from(name: item.name).new(item) }
  end

  def update_quality
    @items.each { |item| item.update }
    self
  end

  private
  
  def class_from(name:)
    ITEM_CLASSES[name] || CommonItem
  end
end
