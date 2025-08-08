class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :price_cents, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
