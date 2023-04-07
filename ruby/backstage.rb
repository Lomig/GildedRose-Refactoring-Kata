# frozen_string_literal: true

require_relative('common_item')

class Backstage < CommonItem
  def update
    ages_one_day
    item.quality = 0 and return self if expired?

    increase_quality_up_to_fifty
    increase_quality_up_to_fifty_again if item.sell_in < 10
    increase_quality_up_to_fifty_again if item.sell_in < 5

    self
  end
end
