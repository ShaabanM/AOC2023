#!/usr/bin/env julia
# This script provides a solution to the first day of AOC 2023

# Read the input file
function read_file(filename::String)
    f = open(filename)
    lines = readlines(f)
    close(f)
    return lines
end

# determines if a character is a number
function is_number(c::Char)
    return c in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
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

lines = read_file("input")
numbers = []
acc = 0
for line in lines
    global acc # need to declare that in this scope I want to inherit the global var
    digits = get_digits(line)
    acc += (str_to_int(combine_digits(digits)))
end

print("The answer to part 1 is: ", acc)