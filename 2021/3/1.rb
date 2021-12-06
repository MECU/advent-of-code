require 'csv'

def calculate_gamma(output)
    output.to_i(2)
end

def calculate_epsilon(output)
    output.split('').map {|x| x == '0' ? '1' : '0'}.join.to_i(2)
end

def calculate(diag)
    count = diag.count
    diag_legth = diag[0].length - 1
    output = ''
    for i in 0..diag_legth
        col = diag.map {|r| r[i] }

        zeros = col.count('0')
        if zeros > (count - zeros)
            output += '0' 
        else
            output += '1'
        end
    end
    output
end

def main
    diag = []
    
    CSV.foreach('input.csv') do |row|
        diag << row[0].split('')
    end

    output = calculate(diag)
    puts calculate_epsilon(output) * calculate_gamma(output)
end

main
