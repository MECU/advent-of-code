# MAP.keys.map do |k|
    # p k.to_s.split('').sort.join
# end

require 'csv'

def load
    data = []
    CSV.foreach('input.csv') do |row|
        data << row[0].split(' | ').map { |r| r.split(' ') }
    end
    data
end

def remove_letters(one, two)
    (one.split('') - two.split('')).join
end

def display_map(input)
    # each of the 7 slots can have 7 letters
    possible = (0..6).to_a.map { |x| 'abcdefg' }

    #  0000
    # 3    1
    # 3    1
    #  4444
    # 5    2
    # 5    2
    #  6666

    # the two segments means 1 and 2 can only be those values
    possible[1] = input[0]
    possible[2] = input[0]

    # 3 segments - 2 segments mean 0 is the remaining letter
    possible[0] = remove_letters(input[1], input[0])

    # 4 segments - 2 segments means 3,4 are those 2 letters
    possible[3] = remove_letters(input[2], input[0])
    possible[4] = possible[3]

    # remove known possibles from 5,6
    possible[5] = remove_letters(possible[5], possible[0])
    possible[5] = remove_letters(possible[5], possible[1])
    possible[5] = remove_letters(possible[5], possible[3])
    possible[6] = possible[5]
    
    # the 5 and 6 segments all use segment 6, so whatever they all have in common is 6, minus known 0
    possible[6] = ((input[3].split('') & input[4].split('') & input[5].split('') & input[6].split('') & input[7].split('') & input[8].split('')) - [possible[0]]).join
    possible[5] = remove_letters(possible[5], possible[6])

    # # all the 5 segments have 4 in common, so 3 is minus that value
    possible[3] = remove_letters(possible[3], (input[3].split('') & input[4].split('') & input[5].split('')).join)
    possible[4] = remove_letters(possible[4], possible[3])

    # # all the 6 segments have 2 in common, so 1 is minus that value
    possible[1] = remove_letters(possible[1], (input[6].split('') & input[7].split('') & input[8].split('')).join)
    possible[2] = remove_letters(possible[2], possible[1])

    # number re-creation
    zero = (possible[0]+possible[1]+possible[2]+possible[3]+possible[5]+possible[6]).split('').sort.join
    two = (possible[0]+possible[1]+possible[4]+possible[5]+possible[6]).split('').sort.join
    three = (possible[0]+possible[1]+possible[4]+possible[2]+possible[6]).split('').sort.join
    five = (possible[0]+possible[2]+possible[3]+possible[4]+possible[6]).split('').sort.join
    six = (possible[0]+possible[2]+possible[3]+possible[4]+possible[5]+possible[6]).split('').sort.join
    nine = (possible[0]+possible[2]+possible[3]+possible[4]+possible[1]+possible[6]).split('').sort.join
    
    {
        input[9] => 8,
        five => 5,
        two => 2,
        three => 3,
        input[1] => 7,
        nine => 9,
        six => 6,
        input[2] => 4,
        zero => 0,
        input[0] => 1,
    }
end

def main
    data = load

    two = 0
    data.each do |signal|

        input = signal[0].sort_by(&:length).map { |s| s.split('').sort.join }

        digits = display_map(input)

        value = signal[1].map do |s|
            digits[s.to_s.split('').sort.join]
        end
        two += value.map(&:to_s).join.to_i
    end

    p "two: #{two}"
end

main
