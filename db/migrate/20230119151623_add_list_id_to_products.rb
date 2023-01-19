class AddListIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :list, null: true, foreign_key: true
  end
end
