class AddStatusToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :status, :boolean, default: "available"
  end
end
