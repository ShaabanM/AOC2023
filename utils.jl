module Utils

export read_file_strings

# Read the input file
function read_file_strings(filename::String)
    f = open(filename)
    lines = readlines(f)
    close(f)
    return lines
end

end