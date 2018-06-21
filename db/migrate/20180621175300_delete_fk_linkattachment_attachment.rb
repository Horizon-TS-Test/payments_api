class DeleteFkLinkattachmentAttachment < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:link_attachments, :attachments)
      remove_foreign_key :link_attachments, :attachments
    end
  end
end
