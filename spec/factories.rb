Factory.define :user do |user|
	user.name										"Example User"
	user.email									"example@user.net"
	user.password								"foobar"
	user.password_confirmation	"foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :name do |n|
  "user-#{n}s"
end

Factory.define :article do |article|
  article.title       "Типовой заголовок"
  article.rubric      "Новости городка"
  article.autor       "Никита Литвинков"
  article.release     "204"
  article.date        "2010.12.07"
  article.content     "Привет как дела?"
end
