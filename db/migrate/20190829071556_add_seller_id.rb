class AddSellerId < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :seller, foreign_key: {to_table: :users}
  end
end
