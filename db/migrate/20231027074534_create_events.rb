class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.time :time
      t.string :venue
      t.string :description
      t.timestamps
    end
  end
end
