#!/usr/bin/env julia
# This script provides a solution to the first day of AOC 2023

nums = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
num_names = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
const number_map = Dict(
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9",
)

# Read the input file
function read_file(filename::String)
    f = open(filename)
    lines = readlines(f)
    close(f)
    return lines
end

# determines if a character is a number
function is_number(c::Char)
    global nums
    return c in nums
end

# converts a string to an integer
function str_to_int(s::String)
    n = 0
    for c in s
        if is_number(c)
            n = n * 10 + parse(Int, c)
        end
    end
    return n
end

# given a string get a list of the digits in the string
function get_digits(string::String)
    digits = []
    for c in string
        if is_number(c)
            push!(digits, c)
        end
    end
    return digits
end

# given a list of characters combine them into a string using the puzzles logic
function combine_digits(chars)
    if length(chars) > 1
        return string(chars[1], chars[end])
    elseif length(chars) == 1
        return string(chars[1], chars[1])
    else
        return "00"
    end
end

#replace any number names with their number in a string going left to right on the 
function replace_num_names(string::String)
    # Find all occurrences
    global number_map
    occurrences = []
    occurrences_last = []
    for (name, num) in number_map
        index = findfirst(name, string)
        index_last = findlast(name, string)
        if !isnothing(index)
            push!(occurrences, (first(index), name, number_map[name]))
            push!(occurrences_last, (first(index_last), name, number_map[name]))
        end
    end

    # Sort by index positions
    sort!(occurrences, by=x -> x[1])
    sort!(occurrences_last, by=x -> x[1])

    if length(occurrences) >= 1
        # Perform replacement on the first count of the first occuring instance
        (_, name, num) = occurrences[1]
        string = replace(string, name => num; count=1)
    end

    if length(occurrences_last) >= 1
        # repeat for last occuring digit but now do it for all occurances
        (_, name, num) = occurrences_last[end]
        string = replace(string, name => num)
    end

    return string
end

# Function that solves part 1 of the puzzle
function part_1()
    lines = read_file("input")
    acc = 0
    for line in lines
        # global acc # need to declare that in this scope I want to inherit the global var if used out of function
        digits = get_digits(line)
        acc += (str_to_int(combine_digits(digits)))
    end
    println("The answer to part 1 is: ", acc)
end

function part_2()
    lines = read_file("input")
    acc = 0
    for line in lines
        # global acc # need to declare that in this scope I want to inherit the global var if used out of function
        line = replace_num_names(line)
        digits = get_digits(line)
        acc += (str_to_int(combine_digits(digits)))
    end
    println("The answer to part 2 is: ", acc)
end



# Script 
part_1()
part_2()
