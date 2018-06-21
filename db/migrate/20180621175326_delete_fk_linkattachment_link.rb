class DeleteFkLinkattachmentLink < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:link_attachments, :links)
      remove_foreign_key :link_attachments, :links
    end
  end
end
