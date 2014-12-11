class DeckPolicy

  attr_reader :user, :deck

  def initialize(user, deck)
    @user = user
    @deck = deck
  end

  def show?
    @user == @deck.user
  end

  def create?
    @user == @deck.user
  end

  def edit?
    @user == @deck.user
  end

  def update?
    @user == @deck.user
  end

  def destroy?
    @user == @deck.user
  end

  def study?
    @user == @deck.user
  end

  def update_comprehension?
    @user == @deck.user
  end

  class Scope

    attr_reader :user, :deck

    def initialize(user, deck)
      @user = user
      @deck = deck
    end

    def resolve
      @deck.where( user_id: @user.id )
    end

  end    

end
