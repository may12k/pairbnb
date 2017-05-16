class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
    	t.date :start_date
    	t.date :end_date
    	t.belongs_to :user, index: true, foreign_key: true
    	t.belongs_to :listing, index: true, foreign_key: true
    	t.integer :number_of_guests
    	t.timestamps
    end
  end
end
