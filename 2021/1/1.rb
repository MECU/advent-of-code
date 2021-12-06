require 'csv'

count = 0
value = nil
CSV.foreach('1-input.csv') do |row|
    puts row
    next if row.nil?

    row_value = row[0].to_i
    
    if value.nil?
        value = row_value
        next
    end

    puts "#{row_value}|#{value}=#{row_value > value}"   
    if row_value > value
        count += 1
    end

    value = row_value
end

puts count
