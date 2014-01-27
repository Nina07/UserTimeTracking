class CreateUsers < ActiveRecord::Migration
  # def change
  #   create_table :users do |t|
  #     t.string :name
  #     t.string :role

  #     t.timestamps
  #   end
  # end

  def up
  	create_table :users do |t|
  		t.string :name
  		t.boolean :role
  		t.timestamps
  	end
  end

  def down
  	drop_table :users
  end
end
