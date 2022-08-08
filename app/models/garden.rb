class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants


  def unique_plants
    plants.select('plants.*')
    .where('plants.harvest_days < ?', '100')
    .distinct
  end

  def most_plants
    plants.select('plants.*')
    .group(:id, 'plants.name')
    .count('plants.name')
    binding.pry
  end
end
