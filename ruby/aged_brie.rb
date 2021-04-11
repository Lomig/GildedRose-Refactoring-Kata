require_relative("common_item")

class AgedBrie < CommonItem
  def update
    item.sell_in -= 1

    item.quality +=1
    item.quality +=1 if item.sell_in < 0

    limit_quality
    self
  end
end