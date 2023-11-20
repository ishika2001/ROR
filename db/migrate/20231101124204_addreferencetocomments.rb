class Addreferencetocomments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :event, null: false, foreign_key: true
    add_reference :comments, :attender, null: false, foreign_key: {to_table: :users}
  end
end
