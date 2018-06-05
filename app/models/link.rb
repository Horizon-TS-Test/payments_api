# == Schema Information
#
# Table name: links
#
#  id              :integer          not null, primary key
#  product_id      :integer
#  expiration_date :datetime
#  downloads       :integer
#  downloads_limit :integer
#  custom_id       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :string
#

require 'digest/md5' #md5 permite creaar una hash a partir de una cdena
class Link < ActiveRecord::Base
	before_create :set_defaults
	after_create :send_email #despues que se cree el link llama a este metodo
  belongs_to :product
  has_many :link_attachments

  	def is_invalid?
      (DateTime.now > self.expiration_date || self.downloads >= 20) #self.downloads_limit)    end
    end

    def update_downloads
      puts " 2 ingreso a update_downloads"
      self.update(downloads: self.downloads+1) 
    end

    def create_attachment_links
      puts "4 ingreso a create attachment link"
      product.attachments.each do |attachment|
        puts "5 creo un link x archivo link.rb"
        self.link_attachments.create(attachment:attachment)

      end
    end

    def links
      link_attachments.limit(product.attachments.count)
    end

    private
  		def set_defaults
  			self.custom_id = Digest::MD5.hexdigest("#{DateTime.now}#{self.id}#{self.product_id}")
  			self.downloads ||= 0 #asignale 0 en el caso de q downloads sea nil o ste vacio
  		end

  		def send_email
        puts "antes de q se abra en el navegador"
  			LinkMailer.download_link(self).deliver_now
  		end

  		
end
