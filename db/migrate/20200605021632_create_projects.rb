class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.text :description
      t.text :title
      t.text :video
      t.text :image
      t.text :frontend
      t.text :backend
      t.timestamps
    end
  end
end
