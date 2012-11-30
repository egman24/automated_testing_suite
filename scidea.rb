## Use rake to trigger these and other ruby scripts to automate processes
## Abstract out the output coloring and timestamps for clean tests
## Abstract out the title and intro
## Distributed/forked watir?
## HTML output for screenshots

require 'watir'
load 'lib/colorize.rb'
load 'lib/ui.rb'

###############
## Bootstrap ##
###############

Ui.title_logo

directory = File.expand_path("./screenshots")
session = "#{directory}/#{Time.now.strftime('%Y-%m-%d_%H%M%S')}"

puts "Test Session: " + blue_background(session)
puts "                                         "

Dir::mkdir("screenshots") if not File.directory?("screenshots")
Dir::mkdir(session) if not File.directory?(session)
puts "\t ==> Created session directory for screenshots..."

puts "\t ==> Beginning test suite..."
puts "                              "

################
## Test suite ##
################

Watir.driver = :webdriver

puts "Are you on a Linux machine(y/n)?: "
linux_machine = gets.chomp

if linux_machine == 'y'
  browser_type_list = [:chrome, :firefox]
else
  browser_type_list  = [:chrome, :ie, :firefox]
end

puts "                                        "

instance_list = {"cardiovillage"                 => {:url => 'cardiovillage.com', :color => :black_blue},
                 "prenatal nutrition training"   => {:url => 'prenatalnutritiontraining.com', :color => :black_purple},
                 "montpelier"                    => {:url => 'learn.montpelier.org', :color => :black_gold },
                 "hsfc"                          => {:url => 'onlinehsfc.org', :color => :black_red},
                 "grandrounds"                   => {:url => 'uvagrandrounds.com', :color => :black_teal} }

browser_type_list.each { |browser_type|

  puts "\t ==> #{browser_type} is loading..."
  puts "                                    "

  b = Watir::Browser.new browser_type

  instance_list.each_pair do |instance, info|



    starts = Time.now
    puts title(instance, info[:color]) + " in " + browser(browser_type.to_s) + " starts @ " + time(starts.to_s)
    sub_session = "#{session}/#{instance}"
    Dir::mkdir(sub_session) if not File.directory?(sub_session)
    puts "\t ==> Created #{instance} screenshot sub-directory..."

    screenshot = "#{sub_session}/#{instance.gsub(' ','_').gsub(/[^0-9A-Za-z_]/,'')}_#{browser_type}_"

    puts "\t ==> Running #{instance} tests in #{browser_type}..."

    Dir[File.dirname(__FILE__) + '/flows/*.rb'].each {|file| load file }
    t = Thread.new{tests(b, info, screenshot)}
    t.join

    ends = Time.now
    puts title(instance, info[:color]) + " in " + browser(browser_type) + " ends @ " + time(ends.to_s)
    elapsed_time = ends - starts

    puts "                                                                                                     "
    puts "-----------------------------Time Elapsed: #{elapsed_time.round} seconds-----------------------------"
    puts "                                                                                                     "

  end

  b.close
}

################################
## Final output and embedding ##
################################

`cp report.rhtml #{session}/report.rhtml`
`cp main.css #{session}/main.css`

raw_report  = "#{session}/report.rhtml"
html_report = "#{session}/report.html"

`cd #{session} && ruby #{raw_report} >> #{html_report}`

puts "==> Visit report.html @ cd #{session}/"

puts "                                                "
puts "A browser should bring up the report shortly... "
puts "                                                "

output = Watir::Browser.new
output.goto "file://#{html_report}"

puts "*Gameloss*"




