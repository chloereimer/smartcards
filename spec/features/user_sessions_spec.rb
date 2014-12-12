describe "User sessions", type: :feature do

  let(:user) { create(:user) }

  it "is found at /login" do
    visit '/login'
    expect(current_path).to eq(new_user_session_path)
  end

  it "has a field for an email address" do
    visit '/login'
    expect(page).to have_selector('#user_email')
  end

  it "has a field for a password" do
    visit '/login'
    expect(page).to have_selector('#user_password')
  end

  context "given a valid email address and password" do

    it "logs the user in" do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Log in'
      expect(page).to have_content("Logged in as #{user.email}")
    end

    it "brings the user to the decks index" do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Log in'
      expect(current_path).to eq(decks_path)
    end

    it "produces a message informing the user that they have been logged in" do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end

  end

  context "given an invalid email" do

    it "does not log the user in" do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: 'invalid_email@email.com'
      end
      click_button 'Log in'
      expect(current_path).to eq(new_user_session_path)
    end

    it "produces an error informing the user that the email or password is invalid." do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: 'invalid_email@email.com'
      end
      click_button 'Log in'
      expect(page).to have_content("Invalid email address or password.")
    end

  end

  context "given a valid email but invalid password" do

    it "does not log the user in" do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'invalid password'
      end
      click_button 'Log in'
      expect(current_path).to eq(new_user_session_path)
    end

    it "produces an error informing the user that the email or password is invalid." do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'invalid password'
      end
      click_button 'Log in'
      expect(page).to have_content("Invalid email or password.")
    end

  end

  context "a logged-in user attempting to logout" do

    it "should log the user out" do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Log in'
      click_link 'Logout'
      visit '/decks'
      expect(current_path).to eq(new_user_session_path)
    end

    it "should bring the user back to the login screen" do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Log in'
      click_link 'Logout'
      expect(current_path).to eq(new_user_session_path)
    end

    it "should produce a message informing the user that they have been logged out" do
      visit '/login'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Log in'
      click_link 'Logout'
      expect(page).to have_content('Signed out successfully.')
    end

  end

end
