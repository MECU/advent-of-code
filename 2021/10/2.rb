require 'csv'

PAIRS = {'(' => ')', '[' => ']', '{' => '}', '<' => '>'}
POINTS = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4,
}

def line_score(line)
    score = 0

    while line.count > 0
        x = line.pop

        score *= 5
        score += POINTS[PAIRS[x]]
    end

    score
end

score = 0
chunks = []

CSV.foreach('input.csv') do |row|
    data = row[0].split('')

    chunk = []
    incomplete = false

    data.each do |i|
        if PAIRS.keys.include?(i)
            chunk << i
            next
        end

        last = chunk.pop

        if PAIRS[last] == i
            next
        end
        
        incomplete = true
        break
    end

    chunks << chunk unless incomplete
end

# p chunks
scores = chunks.map { |x| line_score(x) }.sort

p scores[((scores.count - 1)/2)]

# 241904613 low
# 3636718673 low
# 4147363484 high
# 3646451424