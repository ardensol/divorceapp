require 'csv'

namespace :import do
    desc "Will out put CSV's for Subscribers"
    task :lawyers => :environment do
        
        
        CSV.foreach("#{Rails.root}/public/lawyers.csv", :encoding => 'windows-1251:utf-8') do |row|

            des = row[5].rstrip.lstrip == "Javascript is required to view this map." ? "" : row[5].rstrip.lstrip
            address_line_1 = row[6] == nil ? "" : row[6].rstrip.lstrip
            zip = row[8] == nil ? "" : row[8].rstrip.lstrip 
            p row[3]
            if Profile.find_by_scrape_url(row[3]) == nil
                Profile.create({name: row[0].lstrip.rstrip,
                                city: row[1].rstrip.lstrip,
                                state: row[2].strip,
                                phone_number: row[7].rstrip.lstrip,
                                description: des,
                                blurb: des,
                                scrape_url: row[3],
                                zip_code: zip,
                                address_line_1: address_line_1
                                })
            end

            
        end
    end
end