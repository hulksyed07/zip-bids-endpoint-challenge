# frozen_string_literal: true

class Bid < ApplicationRecord
  before_save :assign_priority

  private
  def assign_priority
    self.priority = case
      when country != '*' && category != '*' && channel != '*'
        1
      when country != '*' && category != '*' && channel = '*'
        2
      when country != '*' && category = '*' && channel != '*'
        3
      when country != '*' && category = '*' && channel = '*'
        4
      when country = '*' && category != '*' && channel != '*'
        5
      when country = '*' && category != '*' && channel = '*'
        6
      when country = '*' && category = '*' && channel != '*'
        7
      else
        8
      end
  end
end
