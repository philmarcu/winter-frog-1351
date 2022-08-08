require 'rails_helper'

RSpec.describe 'plots index page' do
  context 'user story 1' do
    it 'shows all the plot numbers' do
      garden = Garden.create!(name: 'Sloan`s Lake Community Garden', organic: true)

      plot_1 = garden.plots.create!(number: 1, size: 'Smedium', direction: 'Weast')
      plot_2 = garden.plots.create!(number: 2, size: 'Large', direction: 'East')
      plot_3 = garden.plots.create!(number: 3, size: 'XXXXL', direction: 'South West')

      visit plots_path

      within "#plot-#{plot_1.id}" do
        expect(page).to have_content("Plot # 1")
        expect(page).to have_content("Plot Size - Smedium")
        expect(page).to have_content("Cardinal Direction - Weast")
        expect(page).to_not have_content("Plot # 2")
        expect(page).to_not have_content("Cardinal Direction - South West")
      end

      within "#plot-#{plot_2.id}" do
        expect(page).to have_content("Plot # 2")
        expect(page).to have_content("Plot Size - Large")
        expect(page).to have_content("Cardinal Direction - East")
        expect(page).to_not have_content("Plot # 3")
        expect(page).to_not have_content("Plot Size - XXXXL")
      end

      within "#plot-#{plot_3.id}" do
        expect(page).to have_content("Plot # 3")
        expect(page).to have_content("Plot Size - XXXXL")
        expect(page).to have_content("Cardinal Direction - South West")
        expect(page).to_not have_content("Plot # 1")
        expect(page).to_not have_content("Cardinal Direction - Weast")
      end
    end

    it 'shows all the plants a plot has' do
      garden = Garden.create!(name: 'Sloan`s Lake Community Garden', organic: true)

      plot_1 = garden.plots.create!(number: 1, size: 'Smedium', direction: 'Weast')
      plot_2 = garden.plots.create!(number: 2, size: 'Large', direction: 'East')
      plot_3 = garden.plots.create!(number: 3, size: 'XXXXL', direction: 'South West')

      plant_1 = plot_1.plants.create!(name: "Purple Beauty Sweet Bell Pepper", descrpt: "Prefers rich, well draining soil.", harvest_days: 40)
      plant_2 = plot_1.plants.create!(name: "Rudder Red Bell Pepper", descrpt: "Prefers rich soil and shady environments.", harvest_days: 70)
      plant_3 = plot_1.plants.create!(name: "Carolina Reaper Pepper", descrpt: "Prefers hellish conditions.", harvest_days: 66)

      plant_4 = plot_2.plants.create!(name: "Cabbages", descrpt: "The Avatar likes to visit this garden.", harvest_days: 43)
      plant_5 = plot_2.plants.create!(name: "Red Tomatoes", descrpt: "Needs solid amount of daily sunshine to maximize growth.", harvest_days: 52)
      
      plant_6 = plot_3.plants.create!(name: "Potatoes", descrpt: "Stick em, boil em, mash em in a stew", harvest_days: 38)

      visit plots_path

      within "#plot-#{plot_1.id}" do
        expect(page).to have_content("Purple Beauty Sweet Bell Pepper")
        expect(page).to have_content("Rudder Red Bell Pepper")
        expect(page).to have_content("Carolina Reaper Pepper")
        expect(page).to_not have_content("Cabbages")
        expect(page).to_not have_content("Red Tomatoes")
      end

      within "#plot-#{plot_2.id}" do
        expect(page).to have_content("Cabbages")
        expect(page).to have_content("Red Tomatoes")
        expect(page).to_not have_content("Carolina Reaper Pepper")
        expect(page).to_not have_content("Potatoes")
      end

      within "#plot-#{plot_3.id}" do
        expect(page).to have_content("Potatoes")
        expect(page).to_not have_content("Cabbages")
        expect(page).to_not have_content("Red Tomatoes")
        expect(page).to_not have_content("Carolina Reaper Pepper")
      end
    end

    it 'has a button that deletes a specific plant from a specific plot' do
      turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)

      plot_1 = turing_garden.plots.create!(number: 1, size: 'Smedium', direction: 'Weast')
      plot_2 = turing_garden.plots.create!(number: 2, size: 'Regular', direction: 'West')

      plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", descrpt: "Prefers rich, well draining soil.", harvest_days: 40)
      plant_2 = Plant.create!(name: "Rudder Red Bell Pepper", descrpt: "Prefers rich soil and shady environments.", harvest_days: 70)
      plant_3 = Plant.create!(name: "Carolina Reaper Pepper", descrpt: "Prefers hellish conditions.", harvest_days: 66)

      plot_pl1 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
      plot_pl2 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
      plot_pl3 = PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_3.id)

      plot_pl5 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_2.id)
      plot_pl6 = PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_3.id)

      visit plots_path

      within "#plot-#{plot_1.id}" do
        expect(page).to have_selector(:link_or_button, "Delete Carolina Reaper Pepper")
        expect(page).to have_selector(:link_or_button, "Delete Rudder Red Bell Pepper")
        expect(page).to have_selector(:link_or_button, "Purple Beauty Sweet Bell Pepper")
      end

      within "#plot-#{plot_1.id}" do
        click_on "Delete Carolina Reaper Pepper"
        click_on "Delete Rudder Red Bell Pepper"

        expect(page).to_not have_content("Carolina Reaper Pepper")
        expect(page).to_not have_content("Rudder Red Bell Pepper")
        expect(page).to have_content("Purple Beauty Sweet Bell Pepper")
      end

      within "#plot-#{plot_2.id}" do
        expect(page).to have_content("Carolina Reaper Pepper")
        expect(page).to have_content("Rudder Red Bell Pepper")
      end

      save_and_open_page
    end
  end
end