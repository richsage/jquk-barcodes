namespace :jquk do

  desc "Process any outstanding jobs"
  task :process => :environment do
    @jobs = Job.all
    @jobs.each_with_index do |job, i|
      i += 1
      puts "Processing job #{i}"
    end
  end

end
