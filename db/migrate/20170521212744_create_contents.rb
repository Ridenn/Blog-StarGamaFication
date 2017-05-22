class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|

      t.string :featured_image
      t.string :lead
      t.text :content
      t.integer :site_area, default: 0

      t.timestamps
    end
  end
end
