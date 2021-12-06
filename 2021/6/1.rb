FISH_SEED = '3,5,2,5,4,3,2,2,3,5,2,3,2,2,2,2,3,5,3,5,5,2,2,3,4,2,3,5,5,3,3,5,2,4,5,4,3,5,3,2,5,4,1,1,1,5,1,4,1,4,3,5,2,3,2,2,2,5,2,1,2,2,2,2,3,4,5,2,5,4,1,3,1,5,5,5,3,5,3,1,5,4,2,5,3,3,5,5,5,3,2,2,1,1,3,2,1,2,2,4,3,4,1,3,4,1,2,2,4,1,3,1,4,3,3,1,2,3,1,3,4,1,1,2,5,1,2,1,2,4,1,3,2,1,1,2,4,3,5,1,3,2,1,3,2,3,4,5,5,4,1,3,4,1,2,3,5,2,3,5,2,1,1,5,5,4,4,4,5,3,3,2,5,4,4,1,5,1,5,5,5,2,2,1,2,4,5,1,2,1,4,5,4,2,4,3,2,5,2,2,1,4,3,5,4,2,1,1,5,1,4,5,1,2,5,5,1,4,1,1,4,5,2,5,3,1,4,5,2,1,3,1,3,3,5,5,1,4,1,3,2,2,3,5,4,3,2,5,1,1,1,2,2,5,3,4,2,1,3,2,5,3,2,2,3,5,2,1,4,5,4,4,5,5,3,3,5,4,5,5,4,3,5,3,5,3,1,3,2,2,1,4,4,5,2,2,4,2,1,4'

def main(days)
    fish = FISH_SEED.split(',').map(&:to_i).tally
    
    days.times do
        new_fish = Hash[8, fish[0]]
        new_fish = Hash.new if fish[0].nil?

        # subtract 1  from days
        fish.each_pair do |k, v| 
            new_fish.merge!({k-1 => v})
        end

        if fish[0]
            #merge -1 day into 6, if exists
            if new_fish.has_key?(6)
                new_fish[6] += new_fish[-1]
            else
                new_fish[6] = new_fish[-1]
            end

            # drop -1 day
            new_fish.delete(-1)
        end

        p new_fish
        fish = new_fish
    end
p fish

    p fish.values.sum
end

# main(4)
# exit
# part 1, 80 days = 343441
main(80)
# part 2, 256 days = 
main(256)