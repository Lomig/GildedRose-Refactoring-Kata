require_relative("common_item")

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