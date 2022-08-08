require 'rails_helper'

RSpec.describe 'garden show page' do
  context 'user story 3' do
    it 'goes to a specific garden and shows its info' do
      garden = Garden.create!(name: 'Sloan`s Lake Community Garden', organic: true)

      plot_1 = garden.plots.create!(number: 1, size: 'Smedium', direction: 'Weast')
      plot_2 = garden.plots.create!(number: 2, size: 'Large', direction: 'East')
      plot_3 = garden.plots.create!(number: 3, size: 'XXXXL', direction: 'South West')

      plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", descrpt: "Prefers rich, well draining soil.", harvest_days: 40)
      plant_2 = Plant.create!(name: "Rudder Red Hot Pepper", descrpt: "Prefers rich soil and shady environments.", harvest_days: 70)
      plant_3 = Plant.create!(name: "Carolina Reaper Pepper", descrpt: "Prefers hellish conditions.", harvest_days: 66)

      plant_4 = Plant.create!(name: "Super Cabbages", descrpt: "The Avatar likes to visit this garden.", harvest_days: 103)
      plant_5 = Plant.create!(name: "Super Red Tomatoes", descrpt: "Needs solid amount of daily sunshine to maximize growth.", harvest_days: 102)
      plant_6 = Plant.create!(name: "Super Potatoes", descrpt: "Stick em, boil em, mash em in a stew", harvest_days: 108)

      plo_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
      plo_pl2 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
      plo_pl3 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_3.id)

      plo_pl3 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_4.id)
      plo_pl3 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_5.id)
      plo_pl3 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_6.id)

      plo_pl3 = PlotPlant.create!(plot_id: plot_3.id, plant_id: plant_1.id)
      plo_pl3 = PlotPlant.create!(plot_id: plot_3.id, plant_id: plant_2.id)
      plo_pl3 = PlotPlant.create!(plot_id: plot_3.id, plant_id: plant_3.id)

      visit garden_path(garden.id)

      expect(page).to have_content("Sloan`s Lake Community Garden")

      within "#unqiue-plants-under-100" do
        expect(page).to have_content("Purple Beauty Sweet Bell Pepper", count: 1)
        expect(page).to have_content("Rudder Red Hot Pepper", count: 1)
        expect(page).to have_content("Carolina Reaper Pepper", count: 1)

        expect(page).to_not have_content("Super Cabbages")
        expect(page).to_not have_content("Super Red Tomatoes")
        expect(page).to_not have_content("Super Potatoes")
      end
    end
  end
end