class EmailsController < ApplicationController
  def create
  	@email= MyEmail.new(email:params[:email]) # elultimo donde esta param[:email] debe ser el mismo nombre q esta en unregistered.haml email_field_tag
  		if @email.save
  			render json: @email
  		else
  			render json: @email.errors, status: :unprocessable_entity
  		end
  end
end
