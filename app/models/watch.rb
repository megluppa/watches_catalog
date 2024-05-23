class Watch < ApplicationRecord
  CATEGORIES = [['Standard', 'standard'], ['Premium', 'premium'], ['Premium+', 'premium+']]

  validates_inclusion_of :category, :in => CATEGORIES
end
