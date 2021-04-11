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