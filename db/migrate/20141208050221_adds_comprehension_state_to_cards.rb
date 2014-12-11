class AddsComprehensionStateToCards < ActiveRecord::Migration

  def change
    add_column :cards, :comprehension_state, :integer
  end

end
