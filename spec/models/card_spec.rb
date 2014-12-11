describe Card do

  let( :card ) { create :card }

  it "has a valid factory" do
    expect( card ).to be_valid
  end

  it "is invalid without a deck" do
    card.deck = nil
    expect( card ).to_not be_valid
  end

  it "is invalid without a front" do
    card.front = nil
    expect( card ).to_not be_valid
  end

  it "is invalid without a back" do
    card.back = nil
    expect( card ).to_not be_valid
  end

end
