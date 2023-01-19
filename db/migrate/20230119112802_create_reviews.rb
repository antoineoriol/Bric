class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating
      t.references :products, null: true, foreign_key: true

      t.timestamps
    end
  end
end
