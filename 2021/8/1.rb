require 'csv'

def load
    data = []
    CSV.foreach('input.csv') do |row|
        data << row[0].split(' | ').map { |r| r.split(' ') }
    end
    data
end

def main
    data = load

    one = 0
    data.each do |signal|
        signal[1].each do |s|
            one += 1 if [2,3,4,7].include?(s.length)
        end
    end

    p "one: #{one}"
end

main