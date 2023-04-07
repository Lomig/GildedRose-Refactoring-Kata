# frozen_string_literal: true

require_relative('common_item')

class AgedBrie < CommonItem
  def update
    ages_one_day
    increase_quality_up_to_fifty
    increase_quality_up_to_fifty_again if expired?

    self
  end
end
