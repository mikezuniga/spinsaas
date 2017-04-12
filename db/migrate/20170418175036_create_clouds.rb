class CreateClouds < ActiveRecord::Migration[5.0]
  def change
    create_table :clouds do |t|
      t.string :name
      t.string :provider
      t.string :apikey
      t.string :secretkey
      t.string :endpoint
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
