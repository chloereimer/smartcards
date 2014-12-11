class DecksController < ApplicationController

  respond_to :json, :html

  def index
    @decks = policy_scope(Deck)
    respond_with @decks
  end
  
  def show
    @deck = Deck.find(params[:id])
    authorize @deck
    respond_with @deck
  end
  
  def create
    @deck = Deck.new()
    @deck.user ||= current_user
    authorize @deck
    @deck.save
    respond_with @deck
  end

  def edit
    @deck = Deck.find(params[:id])
    authorize @deck
    respond_with @deck
  end
  
  def update
    @deck = Deck.find(params[:id])
    authorize @deck
    @deck.update(deck_params)
    respond_with @deck
  end
  
  def destroy
    @deck = Deck.find(params[:id])
    authorize @deck
    @deck.destroy
    respond_with @deck
  end

  def study
    @deck = Deck.find(params[:deck_id])
    authorize @deck
    @cards_to_study = @deck.cards_to_study
    respond_with @deck
  end

  def update_comprehension

    @deck = Deck.find(params[:deck_id])
    authorize @deck

    old_comprehension = @deck.comprehension_level

    cards_attributes = params[:deck][:cards_attributes]
    cards_attributes.each do |card_attributes|

      card = Card.find( card_attributes[1][:id] )
      correct = card_attributes[1][:is_correct]
      tested = card_attributes[1][:is_tested]

      if( tested )

        if( !card.comprehension_state.nil? )

          if( correct.to_i > 0 && card.comprehension_state < 5 )
            # correct and not yet max
            card.comprehension_state += 1
            card.save
          elsif( correct.to_i <= 0 && card.comprehension_state > 0 )
            # wrong and not yet min
            card.comprehension_state -= 1
            card.save
          else
            # stay the same
          end

        else

          if( correct.to_i > 0 )
            card.comprehension_state = 1
            card.save
          else
            card.comprehension_state = 0
            card.save
          end

        end

      end

    end

    @deck.update(update_comprehension_params)
    @deck.reload

    if( old_comprehension > @deck.comprehension_level )
      flash[:comprehension_up] = "<h1>You'll do better next time.</h1><div>Your comprehension level went down from <strong>#{ActionController::Base.helpers.number_to_percentage( old_comprehension * 100, precision: 2 )}</strong> to <strong>#{ActionController::Base.helpers.number_to_percentage( @deck.comprehension_level * 100, precision: 2 )}</strong>.</div>"
    elsif( old_comprehension < @deck.comprehension_level )
      flash[:comprehension_down] = "<h1>Great work!</h1><div>Your comprehension level went up from <strong>#{ActionController::Base.helpers.number_to_percentage( old_comprehension * 100, precision: 2 )}</strong> to <strong>#{ActionController::Base.helpers.number_to_percentage( @deck.comprehension_level * 100, precision: 2 )}</strong>!</div>"
    else
      flash[:comprehension_same] = "<h1>Not bad...</h1><div>Your comprehension level stayed the same at <strong>#{ActionController::Base.helpers.number_to_percentage( @deck.comprehension_level * 100, precision: 2 )}</strong></div>"
    end

    respond_with @deck
  end

  private

  def deck_params
    params.require(:deck).permit(:user_id, :name, cards_attributes: [ :id, :front, :back, :_destroy ])
  end

  def update_comprehension_params
    params.require(:deck).permit( cards_attributes: [ :id, :comprehension_state ])
  end

end
