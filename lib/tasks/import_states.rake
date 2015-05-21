require 'csv'

namespace :import do
    desc "Will out put CSV's for Subscribers"
    task :states => :environment do
        
        
        CSV.foreach("#{Rails.root}/public/divorce_stats.csv") do |row|
            
            divorce_cost = row[1] == nil ? "" : row[1]
            divorce_rate = row[2] == nil ? "" : row[2]
            total_divorce = row[3] == nil ? "" : row[3]
            distribution_type = row[4] == nil ? "" : row[4]
            divorce_law_description = row[5] == nil ? "" : row[5]


            if State.find_by_name(row[0]) == nil
                State.create({name: row[0],
                                divorce_cost: divorce_cost,
                                divorce_rate: divorce_rate,
                                total_divorce: total_divorce,
                                distribution_type: distribution_type,
                                divorce_law_description: divorce_law_description
                                })
            else
                @state = State.find_by_name(row[0])
                @state.update({ divorce_cost: divorce_cost,
                                divorce_rate: divorce_rate,
                                total_divorce: total_divorce,
                                distribution_type: distribution_type,
                                divorce_law_description: divorce_law_description
                                })
            end

            
        end
    end
end