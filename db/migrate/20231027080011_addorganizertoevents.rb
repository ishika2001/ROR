class Addorganizertoevents < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :organizer, null: false, foreign_key: {to_table: :users}
  end
end
