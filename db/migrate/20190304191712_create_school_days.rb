class CreateSchoolDays < ActiveRecord::Migration[5.0]
  def change
    create_table :school_days do |t|
      t.date :date
    end
  end
end
