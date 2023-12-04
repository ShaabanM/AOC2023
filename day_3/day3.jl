include("../utils.jl")

mutable struct Number
    value::Int64
    lox::Array{Int64}
    loy::Array{Int64}
    symbol_adjacent::Bool
end

function update_number(number::Number, array)
    for i in 1:length(number.lox)
        x = number.lox[i]
        y = number.loy[i]
        if neighbour_logic(array, y, x)
            number.symbol_adjacent = true
            return
        end
    end
end

# construct a 2D array of symbols from input string where each new line is a new row
function construct_array(string)
    return hcat([split(line, "") for line in split(string, "\n")]...)
end

# get the type of symbol where 0 is a dot, 1 is a number, and 2 is a anything else
function get_symbol_type(char)
    if char == "."
        return 0
    elseif Utils.is_number(char[1])
        return 1
    else
        return 2
    end
end

# check each neighbour of a given index including diagonals none of the neighbours are "." or a number return true
function neighbour_logic(array, x, y)
    dims = size(array)
    for i in -1:1
        for j in -1:1
            if x + j > 0 && x + j <= dims[2] && y + i > 0 && y + i <= dims[1]
                if get_symbol_type(array[x+j, y+i]) == 2
                    return true
                end
            end
        end
    end
    return false
end

function part_1()
    input = Utils.read_file_as_string("input")
    array = construct_array(input)
    dims = size(array)
    println(dims)
    numbers = []
    for i in 1:dims[2]
        digits = ""
        lox = []
        loy = []
        for j in 1:dims[1]
            c = array[j, i]
            # make sure c is a char 
            if typeof(c) != Char
                c = c[1]
            end
            if Utils.is_number(c)
                digits = digits * c
                push!(lox, i)
                push!(loy, j)
            elseif digits != ""
                number = Number(parse(Int64, digits), lox, loy, false)
                push!(numbers, number)
                digits = ""
                lox = []
                loy = []
            end
            # if last char is number
        end
        if digits != ""
            number = Number(parse(Int64, digits), lox, loy, false)
            push!(numbers, number)
        end
    end
    acc = 0
    for number in numbers
        update_number(number, array)
        if number.symbol_adjacent
            acc += number.value
        end
    end
    println("Part 1 soln is ", acc)
end

part_1()