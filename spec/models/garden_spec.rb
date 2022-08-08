require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots)}
    it { should have_many(:plants).through(:plot_plants)}
  end

  describe '#instance methods' do
    describe '#unique_plants' do
      it 'gets all the unique plants < 100 harvest days' do
        turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
        
        plot_1 = turing_garden.plots.create!(number: 1, size: 'Smedium', direction: 'Weast')
        plot_2 = turing_garden.plots.create!(number: 2, size: 'Large', direction: 'East')
        
        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", descrpt: "Prefers rich, well draining soil.", harvest_days: 40)
        plant_2 = Plant.create!(name: "Rudder Red Bell Pepper", descrpt: "Prefers rich soil and shady environments.", harvest_days: 130)
        plant_3 = Plant.create!(name: "Cabbages", descrpt: "The Avatar likes to visit this garden.", harvest_days: 43)
        plant_4 = Plant.create!(name: "Carolina Reaper Pepper", descrpt: "Prefers hellish conditions.", harvest_days: 66)
        plant_5 = Plant.create!(name: "Super Pumpkin", descrpt: "Yay onions", harvest_days: 104)
        plant_6 = Plant.create!(name: "Dragonfruit", descrpt: "Needs solid amount of daily sunshine to maximize growth.", harvest_days: 121)
        
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_3.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_4.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_5.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_6.id)

        plo_pl1 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_2.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_5.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_6.id)

        expect(turing_garden.unique_plants).to match_array([plant_4, plant_1, plant_3])
      end
    end

    describe '#most_plants' do
      it 'sorts plants by highest count in plots' do
        turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
        
        plot_1 = turing_garden.plots.create!(number: 1, size: 'Smedium', direction: 'Weast')
        plot_2 = turing_garden.plots.create!(number: 2, size: 'Large', direction: 'East')
        plot_3 = turing_garden.plots.create!(number: 3, size: 'Extra Medium', direction: 'South')
        plot_4 = turing_garden.plots.create!(number: 4, size: 'Small', direction: 'North East')

        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", descrpt: "Prefers rich, well draining soil.", harvest_days: 40)
        plant_2 = Plant.create!(name: "Rudder Red Bell Pepper", descrpt: "Prefers rich soil and shady environments.", harvest_days: 130)
        plant_3 = Plant.create!(name: "Cabbages", descrpt: "The Avatar likes to visit this garden.", harvest_days: 43)
        plant_4 = Plant.create!(name: "Carolina Reaper Pepper", descrpt: "Prefers hellish conditions.", harvest_days: 66)
        plant_5 = Plant.create!(name: "Super Pumpkin", descrpt: "Yay onions", harvest_days: 104)
        plant_6 = Plant.create!(name: "Dragonfruit", descrpt: "Needs solid amount of daily sunshine to maximize growth.", harvest_days: 121)

        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_3.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_4.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_5.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_6.id)

        plo_pl1 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_2.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_5.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_6.id)

        plo_pl1 = PlotPlant.create!(plot_id: plot_3.id, plant_id: plant_2.id)
        plo_pl1 = PlotPlant.create!(plot_id: plot_3.id, plant_id: plant_6.id)

        plo_pl1 = PlotPlant.create!(plot_id: plot_4.id, plant_id: plant_6.id)

        expect(turing_garden.most_plants).to match_array([plant_6, plant_2, plant_5])
      end
    end
  end
end
