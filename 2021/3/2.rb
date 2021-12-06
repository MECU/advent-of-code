require 'csv'

def calculate(diag, param = 'O2')
    local_diag = diag.dup
    diag_legth = local_diag[0].length - 1
    
    for i in 0..diag_legth
        count = local_diag.count
        col = local_diag.map { |r| r[i] }
        
        zeros = col.count('0')
        if param == 'O2'
            p "O2: #{zeros} > #{count-zeros}"
            if zeros > (count - zeros)
                local_diag.select! { |r| r[i] == '0' }
            else
                local_diag.select! { |r| r[i] == '1' }
            end
        else
            p "CO2: #{zeros} <= #{count-zeros}"
            if zeros <= (count - zeros)
                local_diag.select! { |r| r[i] == '0' }
            else
                local_diag.select! { |r| r[i] == '1' }
            end
        end

        break if local_diag.count == 1
    end

    local_diag[0].join.to_i(2)
end

def main
    diag = []
    
    CSV.foreach('input.csv') do |row|
        diag << row[0].split('')
    end

    puts calculate(diag) * calculate(diag, 'CO2')
end

main

# 4177936 lower
# 4188156 lower
# 2829354