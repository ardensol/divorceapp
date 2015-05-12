require 'csv'

namespace :import do
    desc "Will out put CSV's for Subscribers"
    task :lawyers => :environment do
        
        
        CSV.foreach("#{Rails.root}/public/lawyers.csv") do |row|
            
            des = row[5].rstrip.lstrip == "Javascript is required to view this map." ? "" : row[5].rstrip.lstrip

            Profile.create({name: row[0].lstrip.rstrip,
                            city: row[1].rstrip.lstrip,
                            state: row[2].strip,
                            phone_number: row[7].rstrip.lstrip,
                            description: des,
                            blurb: des
                            })

            
        end
    end
end