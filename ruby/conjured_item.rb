require_relative("common_item")

class ConjuredItem < CommonItem
  def update
    item.sell_in -= 1

    item.quality -= 2
    item.quality -= 2 if item.sell_in < 0
    
    limit_quality
    self
  end
end