# encoding: utf-8
namespace :dev do

  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", :setup ]

  desc "Setup system data"
  task :setup => :environment do
      # puts "Create system user"
      # u = User.new({name: '陳均均', email: 'quietmes@gmail.com', fb_id: '100000062614743', token: 'CAAHGlsmfwRABAAZAtJlhAEtoBhwpD3M71Q1oPPkgjHZCAAZC9IYCiluulsZC4DtdprYSZAZBon3S8gQZAoVWse3gOQXM8OudMf0FwrJmXzAzpmIa7WYKh4hyZCTU6uqBEs7bYbWt3ZAZA6px8TaVWWW7v7D12Gb5nSkqlIPZA2KUkT301J1qKlEQSOb'})
      # u.save!


      # puts "Create sample task - 薄多義"
      # r = Restaurant.new({name: '板橋│薄多義 BITE 2 EAT‧Q感手工披薩【誠品板橋店】', address: '新北市板橋區中山路一段46號', telephone: '02-29540410'})
      # r.save
      # t = Task.new({name: r.name, status: 'N', restaurant: r, user_id: 1, url: 'http://doll1027.pixnet.net/blog/post/171945207-%E6%9D%BF%E6%A9%8B%E2%94%82%E8%96%84%E5%A4%9A%E7%BE%A9-bite-2-eat%E2%80%A7q%E6%84%9F%E6%89%8B%E5%B7%A5%E6%8A%AB%E8%96%A9%E3%80%90%E8%AA%A0%E5%93%81%E6%9D%BF'})
      # t.save!

      # puts "Create system task - 武藏武骨"
      # r = Restaurant.new({name: '左營‧神社風麵屋武藏武骨黑雷拉麵', address: '高雄市左營區站前北路1號', telephone: '07-5811112'})
      # r.save
      # t = Task.new({name: r.name, status: 'N', restaurant: r, user_id: 1, url: 'http://rmlove30.pixnet.net/blog/post/54112066-%E5%B7%A6%E7%87%9F%E2%80%A7%E7%A5%9E%E7%A4%BE%E9%A2%A8%E9%BA%B5%E5%B1%8B%E6%AD%A6%E8%97%8F%E6%AD%A6%E9%AA%A8%E9%BB%91%E9%9B%B7%E6%8B%89%E9%BA%B5'})
      # t.save!


      # puts "Create sample task - 薄多義(finish)"
      # r = Restaurant.find(1)
      # t = Task.new({name: r.name, status: 'Y', restaurant: r, user_id: 1, url: 'http://doll1027.pixnet.net/blog/post/171945207-%E6%9D%BF%E6%A9%8B%E2%94%82%E8%96%84%E5%A4%9A%E7%BE%A9-bite-2-eat%E2%80%A7q%E6%84%9F%E6%89%8B%E5%B7%A5%E6%8A%AB%E8%96%A9%E3%80%90%E8%AA%A0%E5%93%81%E6%9D%BF'})
      # t.save!

      # puts "Create system task - 武藏武骨(finis)"
      # r = Restaurant.find(2)
      # t = Task.new({name: r.name, status: 'Y', restaurant: r, user_id: 1, url: 'http://rmlove30.pixnet.net/blog/post/54112066-%E5%B7%A6%E7%87%9F%E2%80%A7%E7%A5%9E%E7%A4%BE%E9%A2%A8%E9%BA%B5%E5%B1%8B%E6%AD%A6%E8%97%8F%E6%AD%A6%E9%AA%A8%E9%BB%91%E9%9B%B7%E6%8B%89%E9%BA%B5'})
      # t.save!
  end
end