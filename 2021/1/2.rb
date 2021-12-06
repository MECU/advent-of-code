require 'csv'

values = []
CSV.foreach('1-input.csv') do |row|
    next if row.nil?
    values << row[0].to_i
end

rows = values.count
count = 0

(3..(rows-2)).each do |row|
    old_sum = values[(row-3)..(row-1)].sum
    new_sum = values[(row-2)..row].sum
    
    puts "#{old_sum}|#{new_sum}"
    count += 1 if old_sum < new_sum
end

puts count
