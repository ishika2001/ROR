class Addstatustoticket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :status, :string, default:"not-booked"
  end
end
