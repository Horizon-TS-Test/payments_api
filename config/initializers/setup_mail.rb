ActionMailer::Base.smtp_settings = {
	address: "smtp.gmail.com",
	port: 587,
	domain: "gmail.com",
	user_name:"patyaleja24@gmail.com",
	password: "EMELEC1526",
	authentication: :login, 
	enable_starttls_auto: true #ttls

}