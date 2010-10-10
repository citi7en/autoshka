Factory.define :user do |user|
	user.name										"Обычный Пользователь"
	user.email									"example@user.net"
	user.password								"foobar"
	user.password_confirmation	"foobar"
end
