class BootstrapFormBuilder < ActionView::Helpers::FormBuilder 
	delegate :content_tag, to: :@template
	[:text_field, :text_area, :url_field, :email_field, :number_field].each do |metodo|  
		define_method metodo do |name, *args|

		options = args.extract_options! # convertir campos en hash
		#puts "\n#{options}\n"
		aditional_classes = "form-control floating-label"
		if options.has_key?(:class) #true si el objeto pertenesca a una clase
			options[:class] += aditional_classes
		else
			options[:class] = aditional_classes
		end
		options[:placeholder] = name.capitalize
		content_tag :div, class:"form-group" do
			super(name, options)
		end
	end
	end
	
	def errors
		if object.errors.any? #true si al menos ayun elemento
			content_tag :div, class:"red large-padding white-text" do
				content_tag(:h2, "Errores") +
				content_tag(:ul) do
					lis = ""
					object.errors.full_messages.each do |err|
						lis += content_tag :li, err
					end
					lis.html_safe
				end	
			end
		end
	end

	

	def submit (*args)
		content_tag :div do
			super(*args, class:"btn btn-success")
		end
	end
end