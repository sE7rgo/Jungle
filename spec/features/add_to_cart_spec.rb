require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "a user visits the home page, clicks add on a product and the cart is updated to (1)" do
    visit root_path

    # commented out b/c it's for debugging only
    
    first('article.product').find_button('Add').click

    expect(page).to have_text('My Cart (1)')

    save_screenshot
  end
end