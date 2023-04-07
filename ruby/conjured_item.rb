# frozen_string_literal: true

require_relative('common_item')

class ConjuredItem < CommonItem
  def update
    ages_one_day
    decrease_quality_down_to_zero(time: 2)
    decrease_quality_down_to_zero_again(time: 2) if expired?

    self
  end
end
