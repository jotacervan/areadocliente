class SystemMailer < ApplicationMailer
	default from: "contato@mobile2you.com.br"

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Bem-vindo ao Painel da Mobile')
	end
end