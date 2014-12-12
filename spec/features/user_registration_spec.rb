describe "User registration", type: :feature do

  let(:user) { build(:user) }

  it "is found at /register" do
    visit '/register'
    expect(current_path).to eq(new_user_registration_path)
  end

  it "has a field for an email address" do
    visit '/register'
    expect(page).to have_selector('#user_email')
  end

  it "has a field for a password" do
    visit '/register'
    expect(page).to have_selector('#user_password')
  end

  it "has a field for a password confirmation" do
    visit '/register'
    expect(page).to have_selector('#user_password_confirmation')
  end

  context "given a valid email address, password, and password confirmation" do

    it "registers the user" do
      visit '/register'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
      end
      expect( User.find_by_email( user.email ) ).to be_nil
      click_button 'Sign up'
      expect( User.find_by_email( user.email ) ).to_not be_nil
    end

    it "brings the user to the decks index" do
      visit '/register'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
      end
      click_button 'Sign up'
      expect(current_path).to eq(decks_path)
    end

  end

  context "given a blank email address, password, and password confirmation" do

    it "produces an error informing the user the email address can't be blank" do
      visit '/register'
      click_button 'Sign up'
      expect(page).to have_content('Email can\'t be blank')
    end

    it "produces an error informing the user the password can't be blank" do
      visit '/register'
      click_button 'Sign up'
      expect(page).to have_content('Password can\'t be blank')
    end

  end

  context "given a valid email address, but a password and password confirmation that do not match" do

    it "produces an error informing the user the password confirmation does not match the password" do
      visit '/register'
      within('#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'not the password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end

  end

  context "given an email address that has already been taken" do

    it "produces an error informing the user that the email address has been taken" do
      existing_user = create(:user)
      visit '/register'
      within('#new_user') do
        fill_in 'Email', with: existing_user.email
      end
      click_button 'Sign up'
      expect(page).to have_content('Email has already been taken')
    end

  end

end
