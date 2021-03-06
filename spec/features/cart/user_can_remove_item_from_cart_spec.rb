require 'rails_helper'

describe "a visitor can remove an item from the cart", type: :feature do
    before(:each) do
      @slammers = Category.create!(title: "Slammers")
      @item_1 = @slammers.items.create!(title: "Lion Holographic Slammer",
                                      price: 3.0,
                                      description: "1/4 thick brass, saw-shaped slammer with holographic lion",
                                      image_path: "http://www.the90swereawesome.com/wp-content/uploads/2014/08/intricate.jpg"
                                      )
    end

      scenario "when a visitor removes an item from the cart" do
      # Background: My cart has an item in it
        visit items_path

        click_button "Add to Cart"

        expect(page).to have_content("You now have 1 Lion Holographic Slammer.")

        click_on 'My Cart'

        visit cart_path


        expect(page).to have_content(1)

      # And I click link "remove"
        click_on("Remove")

      # Then my current page should be "/cart"
        expect(current_path).to eq(cart_path)

      # And I should see a message styled in green
      # And the message should say "Successfully removed SOME_ITEM from your cart."
        expect(page).to have_content("You've successfully removed")

      # And the title "SOME_ITEM" should be a link to that item in case the user wants to add it back
        # expect(page).to have_link(category_item_path(@slammers, @item_1))

      # And I should not see the item listed in cart
        expect(page).to_not have_content("1/4 thick brass, saw-shaped slammer with holographic lion")
     end
  end
