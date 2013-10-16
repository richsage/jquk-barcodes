require 'csv'

namespace :jquk do

  desc "Process any outstanding jobs"
  task :process => :environment do
    @jobs = Job.all
    @jobs.each_with_index do |job, i|
      i += 1
      puts "Processing job #{i}"
    end
  end

  desc "Import delegate database"
  task :import_delegates => :environment do
    @delegate_file = ENV['file']
    unless !@delegate_file.nil?
      $stderr.puts "Error: please supply a CSV file to import"
      exit!
    end

    puts "Using '#{@delegate_file}' for import\n"

    puts "Clearing delegate database"

    # Wipe existing delegate details
    Delegate.delete_all

    # Import from CSV
    begin
      rows = CSV.read(@delegate_file)
      rows.each do |row|
        next if row.length == 0

        @delegate = Delegate.new
        @delegate.delegate_id = row[0]
        @delegate.first_name = row[1]
        @delegate.last_name = row[2]
        @delegate.email_address = row[3]
        @delegate.company = row[4]

        @delegate.save

        puts "Added: #{@delegate.full_name}\n"
      end
    rescue Exception => e
      $stderr.puts "Error: Couldn't read CSV file"
      $stderr.puts e.message
    end

    puts "Total delegates: " << Delegate.count.to_s
  end

end
