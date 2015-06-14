require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'csv'
require 'mechanize'

namespace :export do
    desc "Will out put CSV's for Subscribers"
    task :lawyers => :environment do
        
        agent = Mechanize.new
        state_array = ['alaska', 'arizona', 'alabama', 'arkansas', 'california', 'colorado', 'connecticut', 'delaware', 'florida', 'georgia', 'hawaii', 'idaho', 'illinois', 'indiana', 'iowa', 'kansas', 'kentucky', 'louisiana', 'maine', 'maryland','massachusetts', 'michigan', 'minnesota', 'mississippi', 'missouri', 'montana', 'Nebraska', 'nevada', 'new-hampshire', 'new-jersey', 'new-mexico', 'new-york', 'north-carolina', 'north-dakota', 'ohio', 'oklahoma', 'oregon', 'pennsylvania', 'rhode-island', 'south-carolina', 'south-dakota', 'tennessee', 'texas', 'utah', 'vermont', 'virginia', 'washington', 'west-virginia', 'wisconsin', 'wyoming']
        state_array.each do |state|
            mech_page = agent.get("http://www.aaml.org/members/#{state}")

            i = 0

            CSV.open("#{Rails.root}/public/lawyers.csv", "a") do |csv|
                csv << ["name", "city", "state", "url", "blurb", "legal_orgs", "street_address", "phone", "zip code","website"]
                page = mech_page.parser
                
                    page.css('tbody tr').each do |scrape|
                    
                        begin
                            name = scrape.css('.views-field-field-profile-fname-value-1').text
                            city = scrape.css('.views-field-city').text
                            state = scrape.css('.views-field-field-state-value').text
                            links = scrape.css('a')
                            urls = links.map { |link| link['href']}
                            url = urls.first

                            profile_page = mech_page.links_with(text: "View Profile")[i].click

                            profile_page_parsed = profile_page.parser

                            blurb = profile_page_parsed.css('.details')[0].text
                            legal_orgs = profile_page_parsed.css('.details')[1].text
                            presentations = profile_page_parsed.css('.details')[2].text if profile_page_parsed.css('.details')[2].text

                            street_address = profile_page_parsed.css('.extended-address').text if profile_page_parsed.css('.extended-address').text

                            zip_code = profile_page_parsed.css('.postal-code').text if profile_page_parsed.css('.postal-code').text

                            phone = profile_page_parsed.css('.tel .value')[0].text if profile_page_parsed.css('.tel .value')[0].text

                            website = profile_page_parsed.css('.website-btn').map { |link| link['href']}.first

                            i += 1

                            p website

                            csv << [name, city, state, url, blurb, legal_orgs, street_address, phone, zip_code, website]
                        rescue
                            i += 1
                            next
                        end
                    end
            end
        end
    end

    task :pictures => :environment do
        agent = Mechanize.new
        profiles = Profile.all

        profiles.each do |profile|
            begin
                url = profile.scrape_url
                html = agent.get(url)
                pic = agent.get(html.parser.at('.imagecache-member_profile_photo')['src']).save
                sourceImage = Image.read(pic)
                
                profile.avatar = sourceImage
                profile.save
            rescue => e
                puts e 
                puts pic
                next
            end
        end
    end
end