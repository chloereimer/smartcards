describe User do

  let( :user ) { create :user }

  it "has a valid factory" do
    expect( user ).to be_valid
  end

  it "is invalid without an email address" do
    user.email = nil
    expect( user ).to_not be_valid
  end

end
