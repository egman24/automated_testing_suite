## Use rake to trigger these and other ruby scripts to automate processes
## Abstract out the output coloring and timestamps for clean tests
## Abstract out the title and intro
## Distributed/forked watir?
## HTML output for screenshots

require 'erb'
require 'watir'
load 'lib/colorize.rb'

Watir.driver = :webdriver

instance_list = {"cardiovillage"                        => 'cardiovillage.com',
                 "prenatal nutrition training"          => 'prenatalnutritiontraining.com',
                 "montpelier"                           => 'learn.montpelier.org',
                 "hsfc"                                 => 'onlinehsfc.org',
                 "grandrounds"                          => 'uvagrandrounds.com'}

puts "                                            "
puts "--------------------------------------------"
puts " ______  _______________  ______ ______  2.0"
puts "/ |     | |    | || | \ \| |    | |  | |    "
puts "'------.| |    | || |  | | |----| |__| |    "
puts " ____|_/|_|____|_||_|_/_/|_|____|_|  |_|    "
puts "                                            "
puts "--------------------------------------------"
puts "                                            "

directory = File.expand_path("./screenshots")
session = "#{directory}/#{Time.now.strftime('%Y-%m-%d_%H%M%S')}"

puts "Test Session: " + yellow(session)
puts "                        "

Dir::mkdir("screenshots") if not File.directory?("screenshots")
Dir::mkdir(session) if not File.directory?(session)
puts "\t ==> Created session directory for screenshots..."

puts "\t ==> Beginning test suite..."
puts "                            "
instance_list.each_pair do |name, url|

  starts = Time.now
  puts title(name) + " starts @ " + yellow(starts.to_s)
  sub_session = "#{session}/#{name}"
  Dir::mkdir(sub_session) if not File.directory?(sub_session)
  puts "\t ==> Created #{name} screenshot sub-directory..."

  screenshot = "#{sub_session}/#{name.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')}_"

  puts "\t ==> Running #{name} tests..."
	# t_string = "<%= #{name} %>"
	# browser = ERB.new t_string
	browser = Watir::Browser.new
	browser.goto "http://#{url}"
  browser.screenshot.save screenshot + "homepage.png"
  if browser.text.include? "Sign"
    browser.link(:href => /.*users\/sign_up/).click
    browser.h1(:text => /Registration/).when_present { browser.screenshot.save screenshot + "registration.png" }
    ## embed to an html report based on types of tests, sections, etc...
    # embed screenshot, 'image/png'
  end
	browser.close

  ends = Time.now
  puts title(name) + " ends @ " + yellow(ends.to_s)
  puts '--------------------------------------------------------------------'
  elapsed_time = ends - starts
  puts "Time Elapsed: #{elapsed_time.round} seconds"
  puts " "
end


##
## Final output and embedding
##

`cp report.rhtml #{session}/report.rhtml`
`cp main.css #{session}/main.css`

raw_report  = "#{session}/report.rhtml"
html_report = "#{session}/report.html"

`cd #{session} && ruby #{raw_report} >> #{html_report}`

puts "==> Visit report.html @ cd #{session}/"

output = Watir::Browser.new
output.goto "file://#{html_report}"



