module FileMethods
  extend ActiveSupport::Concern

  # def i(word, at_line=0)
  def i(args = {})
    puts "i called"
    word = args[:word1] + "\n" if args[:word1]
    at_line = args[:at_line]

    tempfile=File.open("file.tmp", 'w')
    f=File.new(args[:file_path])

    f.each_with_index do |line, index|

      if (index+1 == at_line)
        tempfile << word
        tempfile<<line
      else
        tempfile<<line
      end
    end
    tempfile << word if at_line == nil

    f.close
    tempfile.close

    FileUtils.mv("file.tmp", args[:file_path])
  end

  # def r(word1, word2, at_line=0)
  def r(args = {})
    puts "r called"
    word1 = args[:word1]
    word2 = args[:word2]
    at_line = args[:at_line]

    tempfile = File.open("file.tmp", 'w')
    f=File.new(args[:file_path])

    if at_line == 0 && word1 && word2
      f.each { |line| tempfile << line.gsub(/#{word1}/i, word2) }
    else
      f.each.with_index do |line, index|
        index+1 == at_line ? tempfile << line.gsub(/#{word1}/i, word2) : tempfile << line
      end
    end

    f.close
    tempfile.close

    FileUtils.mv("file.tmp", args[:file_path])
  end

  # def rev(at_line=0)
  def rev(args = {})
    puts "rev called"
    at_line = args[:at_line]

    tempfile=File.open("file.tmp", 'w')
    f=File.new(args[:file_path])

    f.each_with_index do |line, index|
      if (index+1 == at_line)
        tempfile << line.reverse.gsub(/\n/,"") + "\n" # Remove the new line and and it to the end
      else
        tempfile << line
      end
    end

    f.close
    tempfile.close

    FileUtils.mv("file.tmp", args[:file_path])
  end

  def s(args)
    puts "Inside S"
  end

  def del(args)
    at_line = args[:at_line]

    tempfile=File.open("file.tmp", 'w')
    f=File.new(args[:file_path])

    f.each_with_index do |line, index|
      tempfile << line unless index+1 == at_line
    end

    f.close
    tempfile.close

    FileUtils.mv("file.tmp", args[:file_path])
  end

end