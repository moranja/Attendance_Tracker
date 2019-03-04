class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :school_day_id
      t.datetime :arrival_time
      t.boolean :manually_changed
    end
  end
end
