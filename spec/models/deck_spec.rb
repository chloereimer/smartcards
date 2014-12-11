describe Deck do

  let( :deck ) { create :deck }

  it "has a valid factory" do
    expect( deck ).to be_valid
  end

  it "is invalid without a user" do
    deck.user = nil
    expect( deck ).to_not be_valid
  end

  it "is invalid without a name" do
    deck.name = nil
    expect( deck ).to_not be_valid
  end

end
