require 'rails_helper'

  describe "a visitor can adjusts the quantity in a cart", type: :feature do
    before(:each) do
      @category = Category.create!(title: "Slammers")
      @item_1 = @category.items.create!(title: "Lion Holographic Slammer",
                                      price: 3.0,
                                      description: "1/4 thick brass, saw-shaped slammer with holographic lion",
                                      image_path: "http://www.the90swereawesome.com/wp-content/uploads/2014/08/intricate.jpg"
                                      )
    end

      scenario "when a visitor adjusts the quantity in the cart" do
        visit items_path
        click_button "Add to Cart"

        expect(page).to have_content("You now have 1 Lion Holographic Slammer.")

        click_on 'My Cart'
        visit cart_path
    #Then I should see my item with a quantity of 1
          within(".cart_item:nth-child(1)") do
            expect(page).to have_content(1)
          end

    #And when I increase the quantity
        within(".cart_item:nth-child(1)") do
          fill_in('quantity', :with => 2)
        end

        expect(current_path).to eq(cart_path)

    #And that item's quantity should reflect the increase
        within(".cart_item:nth-child(1)") do
          expect(page).to have_content(1)
        end

    #And the subtotal for that item should increase
        within(".cart_item:nth-child(1)") do
          expect(sub_total).to equal(2)
        end

    #And the total for the cart should match that increase
        expect(page).to have_content("total")

    #And when I decrease the quantity
       within(".cart_item div:nth-child(1)") do
          fill_in('quantity', :with => 3)
        end

    #Then my current page should be '/cart'
        expect(current_path).to eq(cart_path)

    #And that item's quantity should reflect the decrease
        within(".cart_item div:nth-child(1)") do
          expect("Sub-total").to equal(2)
        end
     end
  end
