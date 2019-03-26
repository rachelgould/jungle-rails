require 'rails_helper'

RSpec.feature "Visit adds items to cart from the homepage", type: :feature, js:true do
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

  scenario "User adds first product to cart, and nav cart item counter increments by 1" do
    # ACT
    visit root_path
    # Click the first "add to cart" button
    page.first('form.button_to').find_button('Add').click

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end
end
