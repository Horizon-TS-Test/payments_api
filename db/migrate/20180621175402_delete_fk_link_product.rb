class DeleteFkLinkProduct < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:links, :products)
      remove_foreign_key :links, :products
    end
  end
end
