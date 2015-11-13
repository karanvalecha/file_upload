module UtilityFileMethods
  def read_file(file_path = nil)
    File.open(file_path, "r") do |file|
      begin
        @file_contents = []
        file.read.gsub(/\r\n?/, "\n").each_line {|line| @file_contents << line.html_safe }
      ensure
        file.close
      end
    end
    return @file_contents
  end

  def write_file(file_path = nil, content=nil)
    # Open a new stream and write to the file.
      File.open(file_path, "w") do |file|
        begin
          file.write(content)
        ensure
          file.close
        end
      end
  end


  def update_actions(cmd = nil)
    words = cmd.scan(/['|"][\w?\s*]+['|"]/) # grab the words for swapping
    @word1 = words[0][/(\w\s*)+/] if words[0]
    @word2 = words[1][/(\w\s*)+/] if words[1]
    cmd.gsub!(/['|"][\w?\s*]+['|"]/,"")

    @at_line = cmd.scan(/\d{1,}/)[0].to_i || 0 # grab the line number
    cmd.gsub!(/\d{1,}/, "")
    cmd.gsub!(/_/, "")

    cmd = cmd.downcase.split(/\s+/)
    cmd.each do |method|
      self.send("#{method}",
      {file_path: @file_path, at_line: @at_line, word1: @word1, word2: @word2})
    end
  end
end