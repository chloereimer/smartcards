class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :deck, index: true
      t.string :front
      t.string :back
    end
  end
end
