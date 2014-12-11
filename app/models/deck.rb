class Deck < ActiveRecord::Base

  # relatonships

  belongs_to :user
  has_many :cards

  # validations

  validates :name, presence: true
  validates :user, presence: true

  # accept nested attributes

  accepts_nested_attributes_for :cards,  reject_if: :all_blank, allow_destroy: true

  # set defaults

  after_initialize :defaults

  def defaults
    self.name ||= 'Untitled Deck'
  end

  # methods

  def comprehension_level

    if !self.cards.any?
      0
    else
      comprehension_total = 0
      self.cards.each do |card|
        if !card.comprehension_state.nil?
          comprehension_total += card.comprehension_state
        end
      end
      comprehension_total.to_f / ( self.cards.count * 5 ).to_f
    end

  end

  def cards_to_study

    cards = []

    if self.cards.any?
      self.cards.each do |card|

        chance = rand(0..6)

        if( card.comprehension_state.nil? || card.comprehension_state <= chance )
          cards << card
        end

      end
    end

    unless cards.any?
      # if no cards, take a selection of half the deck ordered by least-known material
      cards = self.cards.order(comprehension_state: :asc).take( (self.cards.count.to_f / 2).round )
    end

    Card.where(id: cards.map(&:id))

  end

end
