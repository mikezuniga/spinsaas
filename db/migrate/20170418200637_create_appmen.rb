class CreateAppmen < ActiveRecord::Migration[5.0]
  def change
    create_table :appmen do |t|
      t.string :name
      t.text :stackmetadata
      t.string :stackid
      t.string :uuid
      t.text :details
      t.belongs_to :user
      t.timestamps
    end
  end
end
