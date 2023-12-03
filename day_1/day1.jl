#!/usr/bin/env julia
# This script provides a solution to the first day of AOC 2023

nums = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
num_names = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
const number_map = Dict(
    "one" => "o1e",
    "two" => "t20",
    "three" => "t3e",
    "four" => "f4r",
    "five" => "f5e",
    "six" => "s6x",
    "seven" => "s7n",
    "eight" => "e8t",
    "nine" => "n9e",
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
    global num_names
    global number_map
    for num_name in num_names
        string = replace(string, num_name => number_map[num_name])
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