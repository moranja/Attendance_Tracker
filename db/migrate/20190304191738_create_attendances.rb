class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.belongs_to :student
      t.belongs_to :school_day
      t.datetime :arrival_time
      t.boolean :manually_changed
      t.integer :minutes_early
    end
  end
end
