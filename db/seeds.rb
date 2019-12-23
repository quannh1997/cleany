# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin::Admin.create(email: 'quannh220497@gmail.com', 
                     password_digest: BCrypt::Password.create('123456'))

i = 1
@password = '123456'
until i > 8 #Until we've gone over 5
	User.create!(name: "user#{i}",
             email: "quannh#{i}@gmail.com",
             password: @password,
             password_confirmation: @password,
             phone: "090999999#{i}",
             address: "Hanoi, Vietnam",
             activated: true,
             activated_at: Time.zone.now)
             
	Partner.create!(name: "partner#{i}",
         email: "quannh#{i+10}@gmail.com",
         password: @password,
         password_confirmation: @password,
         phone: "090999999#{i+10}",
         district: i + 1,
         city: "01",
         worktime_start: 5 + i,
         worktime_end: 8 + i,
         activated: true,
         activated_at: Time.zone.now,
         description: Faker::Lorem.paragraph,
         cost: 500*i)
    i = i+1
end #End the loop

WorkingLog.create!(
    user_id: 1,
    partner_id: 1,
    worktime_start: 7,
    worktime_end: 8,
    address: "Thanh Xuan, Ha Noi",
    cost: 500,
    working_date: DateTime.now.to_date,
    status: 1,
    note: 'Please call me!'
)

WorkingLog.create!(
    user_id: 3,
    partner_id: 1,
    worktime_start: 7,
    worktime_end: 8,
    address: "Thanh Xuan, Ha Noi",
    cost: 500,
    working_date: DateTime.now.next_day(1).to_date,
    status: 1,
    note: 'Hello! Help me clean my room'
)

WorkingLog.create!(
    user_id: 2,
    partner_id: 1,
    worktime_start: 7,
    worktime_end: 8,
    address: "Thanh Xuan, Ha Noi",
    cost: 500,
    working_date: DateTime.now.next_day(2).to_date,
    status: 1,
    note: 'Hello! Help me clean my room'
)

WorkingLog.create!(
    user_id: 4,
    partner_id: 2,
    worktime_start: 7,
    worktime_end: 8,
    address: "Thanh Xuan, Ha Noi",
    cost: 1000,
    working_date: DateTime.now.next_day(1).to_date,
    status: 1,
    note: 'Hello! Help me clean my room'
)

100.times do
    Comment.create!(
        user_id: rand(1..8),
        partner_id: rand(1..8),
        content: Faker::Lorem.paragraph
    )
end


100.times do
    begin
        user_id = rand(4..6)
        partner_id = rand(1..6)
        worktime_start = rand(7..9)
        worktime_end = worktime_start + rand(1..3)
        cost= rand(300..1000)
        working_date = Time.at(rand(DateTime.now.days_ago(15).to_f..DateTime.now.days_ago(2).to_f)).to_date

        if WorkingLog.where(:partner => partner_id).where(:working_date => working_date).where("worktime_end > ?", worktime_start).empty?
            WorkingLog.create!(
                user_id: user_id,
                partner_id: partner_id,
                worktime_start: worktime_start,
                worktime_end: worktime_end,
                address: "Thanh Xuan, Ha Noi",
                cost: cost,
                working_date: working_date,
                status: 1,
                note: Faker::Lorem.paragraph
            )
        end
    rescue Exception => e 
        print "="
    end
end