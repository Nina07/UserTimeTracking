class CreateUserTimes < ActiveRecord::Migration
  def change
    create_table :user_times do |t|
      t.datetime :arrival_time
      t.references :user, index: true

      t.timestamps
    end
  end
end
