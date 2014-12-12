include Warden::Test::Helpers # include warden test helpers to stub out sessions

describe "Decks management" do

  Warden.test_mode!

  let(:user) { create(:user) }

  context "while the user is logged out" do

    it "should redirect the user from the decks index to the login screen" do
      visit '/decks'
      expect(current_path).to eq(new_user_session_path)
    end

    it "should redirect the user from a deck page to the login screen" do
      deck = create(:deck)
      visit "/decks/#{deck.id}"
      expect(current_path).to eq(new_user_session_path)
    end

  end

  context "while the user is logged in" do

    it "allows the user to view the decks index" do
      login_as(user, scope: :user)
      visit '/decks'
      expect(current_path).to eq(decks_path)
    end

    context "the decks index" do

      it "is found at /decks" do
        login_as(user, scope: :user)
        visit "/decks"
        expect(current_path).to eq(decks_path)
      end

      it "shows a message indicating there are no decks if this is the case" do
        login_as(user, scope: :user)
        visit '/decks'
        expect(page).to have_content('No decks found.')
      end

      it "has a link that, when clicked, will create a new deck" do
        login_as(user, scope: :user)
        visit '/decks'
        old_deck_count = user.decks.count
        click_link 'Why not create one?'
        expect(user.decks.count).to eq(old_deck_count + 1)
      end

      it "shows all of the user's decks" do
        decks = create_list( :deck, 5, user: user )
        login_as(user, scope: :user)
        visit '/decks'
        decks.each do |deck|
          expect(page).to have_content(deck.name)
        end
      end

      it "does not show any other user's decks" do
        other_user = create( :user )
        decks = create_list( :deck, 5, user: other_user )
        login_as(user, scope: :user)
        visit '/decks'
        decks.each do |deck|
          expect(page).to_not have_content(deck.name)
        end
      end

      it "allows the user to click on a deck to view it" do
        deck = create( :deck, user: user )
        login_as(user, scope: :user)
        visit '/decks'
        click_link( deck.name )
        expect(current_path).to eq(deck_path(deck))
        expect(page).to have_selector("#edit_deck_#{deck.id}")
      end

    end

    context "a deck page", js: true do

      let(:deck) { create(:deck, user: user ) }

      it "is found at /decks/:id" do
        login_as(user, scope: :user)
        visit "/decks/#{deck.id}"
        expect(current_path).to eq(deck_path(deck))
      end

      it "has a field for the deck's name" do
        login_as(user, scope: :user)
        visit "/decks/#{deck.id}"
        expect(page).to have_selector('#deck_name')
      end

      it "has a button that, when clicked, will save changes to the deck's name" do
        login_as(user, scope: :user)
        visit "/decks/#{deck.id}"
        within("#edit_deck_#{deck.id}") do
          fill_in 'deck_name', with: 'New Deck Name'
        end
        click_button 'Save Deck', match: :first
        deck.reload
        expect(deck.name).to eq('New Deck Name')
      end

      it "has a button that, when clicked, will update the database to reflect newly added cards" do
        old_card_count = deck.cards.count
        login_as(user, scope: :user)
        visit "/decks/#{deck.id}"
        click_link 'Add Card', match: :first
        find('.front').set('front text')
        find('.back').set('back text')
        click_button 'Save Deck', match: :first
        deck.reload
        expect(deck.cards.count).to eq(old_card_count + 1)
        expect(deck.cards.last.front).to eq('front text')
        expect(deck.cards.last.back).to eq('back text')
      end

      it "has a button that, when clicked, will update the database to reflect updated cards" do
        card = create( :card, deck: deck )
        login_as(user, scope: :user)
        visit "/decks/#{deck.id}"
        find('.front').set('front text')
        find('.back').set('back text')
        click_button 'Save Deck', match: :first
        card.reload
        expect(card.front).to eq('front text')
        expect(card.back).to eq('back text')
      end

      it "has a button that, when clicked, will update the database to reflect deleted cards" do
        card = create( :card, deck: deck )
        old_card_count = deck.cards.count
        login_as(user, scope: :user)
        visit "/decks/#{deck.id}"
        click_link 'Remove Card', match: :first
        click_button 'Save Deck', match: :first
        deck.reload
        expect(deck.cards.count).to eq(old_card_count - 1)
      end

      it "has a link that, when clicked, will add a card to the screen" do
        login_as(user, scope: :user)
        visit "/decks/#{deck.id}"
        expect(page).to_not have_selector('.card')
        click_link 'Add Card', match: :first
        expect(page).to have_selector('.card')
      end

      context "a card on said deck page" do

        it "has a field for the card's front" do
          login_as(user, scope: :user)
          visit "/decks/#{deck.id}"
          click_link 'Add Card', match: :first
          expect(page).to have_selector('.front')
        end

        it "has a field for the card's back" do
          login_as(user, scope: :user)
          visit "/decks/#{deck.id}"
          click_link 'Add Card', match: :first
          expect(page).to have_selector('.back')
        end

        it "has an indicator for the card's comprehension level" do
          login_as(user, scope: :user)
          visit "/decks/#{deck.id}"
          click_link 'Add Card', match: :first
          expect(page).to have_selector('.comprehension-level')
        end

        it "has a link that, when clicked, removes the card from the screen" do
          login_as(user, scope: :user)
          visit "/decks/#{deck.id}"
          click_link 'Add Card', match: :first
          click_link 'Remove Card'
          expect(page).to_not have_selector('.card')
        end

        context "that has been pulled from the database" do

          it "reflects the card's front accurately" do
            card = create( :card, deck: deck, back: 'front text' )
            login_as(user, scope: :user)
            visit "/decks/#{deck.id}"
            expect(page).to have_selector('input[value="front text"]')
          end

          it "reflects the card's back accurately" do
            card = create( :card, deck: deck, back: 'back text' )
            login_as(user, scope: :user)
            visit "/decks/#{deck.id}"
            expect(page).to have_selector('input[value="back text"]')
          end

          it "reflects the card's comprehension level accurately" do
            card = create( :card, deck: deck, comprehension_state: 4 )
            login_as(user, scope: :user)
            visit "/decks/#{deck.id}"
            expect(page).to have_content('★ ★ ★ ★')
          end

        end

      end

    end

  end
  
end
