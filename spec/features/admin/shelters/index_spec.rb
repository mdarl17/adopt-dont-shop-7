require 'spec_helper'

RSpec.describe "The Admin Shelter Index Page" do
  it "displays a section for Shelters with pending applications" do

    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
    shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 9)
    shelter_3 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)

    application_2 = Application.create!(name: 'John', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love animals', application_status: 'Pending')
    application_3 = Application.create!(name: 'Jane', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love animals', application_status: 'Pending')
    
    bella = shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) 
    rigby = shelter_2.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) 

    application_2.pets << bella
    application_3.pets << rigby
    
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    visit '/admin/shelters'
    # Then I see a section for "Shelters with Pending Applications"
    expect(page).to have_content("Shelters with pending applications")
    # And in this section I see the name of every shelter that has a pending application
    within(".shelters_with_pending_applications") do
      expect(page).to have_content("Aurora shelter")
      expect(page).to have_content("Denver shelter")
      expect(page).to_not have_content("Boulder shelter")
    end
  end
end