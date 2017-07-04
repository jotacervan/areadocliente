class SystemMailer < ApplicationMailer
	default from: "contato@mobile2you.com.br"

	def welcome_email(user,password)
		@user = user
		@pass = password
		email_with_name = %("#{@user.name}" <#{@user.email}>)
		mail(from: "Equipe Mobile2you <contato@mobile2you.com.br>", to: email_with_name, subject: 'Bem-vindo à sua nova Área do Cliente!')
	end
end