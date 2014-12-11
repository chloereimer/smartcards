describe DeckPolicy do

  subject { described_class }
  let(:user) { create(:user) }

  context "deck belongs to user" do

    let(:deck) { create(:deck, user: user) }

    permissions :show? do
      it "allows access" do
        expect( subject ).to permit( user, deck )
      end
    end

    permissions :create? do
      it "allows access" do
        expect( subject ).to permit( user, deck )
      end
    end

    permissions :edit? do
      it "allows access" do
        expect( subject ).to permit( user, deck )
      end
    end

    permissions :update? do
      it "allows access" do
        expect( subject ).to permit( user, deck )
      end
    end

    permissions :destroy? do
      it "allows access" do
        expect( subject ).to permit( user, deck )
      end
    end

    permissions :study? do
      it "allows access" do
        expect( subject ).to permit( user, deck )
      end
    end

    permissions :update_comprehension? do
      it "allows access" do
        expect( subject ).to permit( user, deck )
      end
    end

  end

  context "deck does not belong to user" do

    let(:deck) { create(:deck, user: User.new ) }

    permissions :show? do
      it "denies access" do
        expect( subject ).to_not permit( user, deck )
      end
    end

    permissions :create? do
      it "denies access" do
        expect( subject ).to_not permit( user, deck )
      end
    end

    permissions :edit? do
      it "denies access" do
        expect( subject ).to_not permit( user, deck )
      end
    end

    permissions :update? do
      it "denies access" do
        expect( subject ).to_not permit( user, deck )
      end
    end

    permissions :destroy? do
      it "denies access" do
        expect( subject ).to_not permit( user, deck )
      end
    end

    permissions :study? do
      it "denies access" do
        expect( subject ).to_not permit( user, deck )
      end
    end

    permissions :update_comprehension? do
      it "denies access" do
        expect( subject ).to_not permit( user, deck )
      end
    end

  end

end
