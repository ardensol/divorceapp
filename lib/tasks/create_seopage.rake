namespace :create do
    desc "Will out put CSV's for Subscribers"
    task :seopage => :environment do
        
        cities = Profile.uniq.pluck(:city)

         cities.each do |city|
            if SeoPage.find_by_city(city) == nil
                c = Profile.find_by_city(city)
                s = c.state

                 SeoPage.create({city: city,
                                 state: s,
                                 name: "best divorce lawyers in #{city} #{s}",
                                 image_tag: city.downcase,
                                 og_description: "Best Divorce Lawyers in #{city}, #{s}" 
                                })
            end
        end
    end
end