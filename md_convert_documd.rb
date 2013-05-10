def convert_line (line)
    code_token = "```"

    if not line.include?(code_token); return line; end

    line = line.strip
    if line == code_token
       "</code><markdown>"
    else
        _, lang = line.split(code_token)
        "</markdown><code #{lang}>"
    end
end

def convert_md_to_documd (input_fname, output_fname)
    infos = []

    File.open(input_fname, 'r').each_line do |line|
        infos << convert_line(line)
    end

    File.open(output_fname, 'w') { |file|
        file.puts('<markdown>')
        infos.each { |info| file.puts(info) }
        file.puts('</markdown>')
    }
end

# ==============================================================================
# MAIN
# ==============================================================================
if __FILE__ == $0
    if not ARGV.length == 2
        puts "usage: ruby #{__FILE__} input.md output.documd"
        exit
    end
    input_fname, output_fname = ARGV
    convert_md_to_documd(input_fname, output_fname)
end
