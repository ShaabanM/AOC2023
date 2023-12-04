include("../utils.jl")

total_red = 12
total_greem = 13
total_blue = 14

struct CubeSet
    red::Int
    green::Int
    blue::Int

    function count_colour(set_string, colour)
        cubes = split(set_string, ",")
        count = 0
        for cube in cubes
            if occursin(colour, cube)
                num = split(cube, " ")[2]
                count += parse(Int, num)

            end
        end
        return count
    end

    function CubeSet(set_string)
        red = count_colour(set_string, "red")
        green = count_colour(set_string, "green")
        blue = count_colour(set_string, "blue")
        new(red, green, blue)
    end
end

struct Game
    game_id::Int
    n_turns::Int
    cube_sets::Array{CubeSet}
    min_red::Int
    min_green::Int
    min_blue::Int

    function Game(game_string)
        # Get the game name and the turns string
        game_string = split(game_string, ":")
        game = parse(Int, split(game_string[1], " ")[2])

        # Split out the turns 
        turns = split(game_string[2], ";")
        n_turns = length(turns)

        # create a cube set for every turn
        cube_sets = []
        min_red = 0
        min_green = 0
        min_blue = 0
        for turn in turns
            set = CubeSet(turn)
            push!(cube_sets, set)
            if set.red > min_red
                min_red = set.red
            end
            if set.green > min_green
                min_green = set.green
            end
            if set.blue > min_blue
                min_blue = set.blue
            end
        end
        new(game, n_turns, cube_sets, min_red, min_green, min_blue)
    end

end

# Function to determine whether or not a game is possible
function is_possible(red, green, blue)
    return red <= total_red && green <= total_greem && blue <= total_blue
end


function part_1()
    lines = Utils.read_file_strings("input")
    id_sum = 0
    for line in lines
        game = Game(line)
        id_sum += game.game_id
        for cube_set in game.cube_sets
            if !is_possible(cube_set.red, cube_set.green, cube_set.blue)
                id_sum -= game.game_id
                break
            end
        end
    end

    println("Part 1 solution is ", id_sum)
end


function part_2()
    lines = Utils.read_file_strings("input")
    sum = 0
    for line in lines
        game = Game(line)
        sum += (game.min_blue * game.min_green * game.min_red)
    end

    println("Part 2 solution is ", sum)
end

part_1()
part_2()
