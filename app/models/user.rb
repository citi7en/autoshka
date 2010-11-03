require 'digest'

class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation

	EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates_presence_of :name, 
												:message => "^Необходимо ввести имя."
	validates_presence_of :email,
												:message => 'должен быть введён.'
	validates_length_of		:name, :maximum => 20,
												:message => 'должно не больше 20 символов'
	validates_format_of		:email, :with => EmailRegex,
												:message => 'имеет неправильный формат.'

	validates_uniqueness_of	:name, :case_sensitive => false,
													:message => 'уже использовано.'
	validates_uniqueness_of :email, :case_sensitive => false,
													:message => 'уже использован.'
	# Automatically create the virtual attribute 'password_confirmation'.
	validates_confirmation_of	:password,
							:message => 'должен совпадать с полем для подтверждения.'

	# Password validations.
	validates_presence_of :password,
												:message => 'должен быть введён.'
	validates_length_of		:password, :within => 6..40,
												:message => 'должен быть от 6 до 40 символов.'
=begin
	HUMAN_ATTRIBUTES = {
			:name => "Имя пользователя",
			:email => "Адрес электронной почты",
			:password => "Пароль"
		}

	def self.human_attribute_name(attr)
		HUMAN_ATTRIBUTES[attr.to_sym] || super
	end
=end

	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	def remember_me!
		self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
		save_without_validation
	end

	def self.authenticate(email, submitted_password)
	  user = find_by_email(email)
	  return nil  if user.nil?
	  return user if user.has_password?(submitted_password)
	end


  private

    def encrypt_password
			unless password.nil?
				self.salt = make_salt
				self.encrypted_password = encrypt(password)
			end
    end

    def encrypt(string)
			secure_hash("#{salt}#{string}")
    end

		def make_salt
			secure_hash("#{Time.now.utc}#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end

end
