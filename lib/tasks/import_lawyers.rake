require 'csv'

namespace :import do
    desc "Will out put CSV's for Subscribers"
    task :lawyers => :environment do
        
        
        CSV.foreach("#{Rails.root}/public/lawyers.csv") do |row|
            
            des = row[5].rstrip.lstrip == "Javascript is required to view this map." ? "" : row[5].rstrip.lstrip

            if Profile.find_by_name(row[0].lstrip.rstrip) == nil
                Profile.create({name: row[0].lstrip.rstrip,
                                city: row[1].rstrip.lstrip,
                                state: row[2].strip,
                                phone_number: row[7].rstrip.lstrip,
                                description: des,
                                blurb: des,
                                scrape_url: row[3],
                                zip_code: row[8].strip,
                                address_line_1: row[6].rstrip.lstrip
                                })
            end

            
        end
    end
end