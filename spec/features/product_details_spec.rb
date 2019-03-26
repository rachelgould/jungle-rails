require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

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

  scenario "They can click Details button from homepage to get to that product's details" do
    # ACT
    visit root_path
    find_link('Details »', href: product_path(Product.first.id)).click

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_text(Product.first.name).and have_text "User Reviews:"
  end

  scenario "They can click the product's image or name to get to that product's details" do
    # ACT
    visit root_path
    find_link(Product.first.name, href: product_path(Product.first.id)).click

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_text(Product.first.name).and have_text "User Reviews:"
  end
end
