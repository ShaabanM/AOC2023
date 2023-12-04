module Utils

export read_file_strings, read_file_as_string, is_number

nums = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

# Read the input file
function read_file_strings(filename::String)
    f = open(filename)
    lines = readlines(f)
    close(f)
    return lines
end

# Read input file as one string
function read_file_as_string(filename::String)
    f = open(filename)
    string = read(f, String)
    close(f)
    return string
end

# determines if a character is a number
function is_number(c::Char)
    global nums
    return c in nums
end

end