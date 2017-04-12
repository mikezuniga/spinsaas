class AppmanCloud < ActiveRecord::Migration[5.0]
  def change
    create_table :appmans_clouds, id: false do |t|
      t.belongs_to :appman, index: true
      t.belongs_to :cloud, index: true
    end
  end
end
