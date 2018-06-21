class DeleteFkAttachmentProduct < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:attachments, :products)
      remove_foreign_key :attachments, :products
    end
  end
end
