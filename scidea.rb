## Use rake to trigger these and other ruby scripts to automate processes
## Abstract out the output coloring and timestamps for clean tests
## Abstract out the title and intro
## Distributed/forked watir?
## HTML output for screenshots

require 'erb'
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

browser_type_list  = [:chrome, :ie, :firefox]

instance_list = {"cardiovillage"                 => {:url => 'cardiovillage.com', :color => :black_blue},
                 "prenatal nutrition training"   => {:url => 'prenatalnutritiontraining.com', :color => :black_purple},
                 "montpelier"                    => {:url => 'learn.montpelier.org', :color => :black_gold },
                 "hsfc"                          => {:url => 'onlinehsfc.org', :color => :black_red},
                 "grandrounds"                   => {:url => 'uvagrandrounds.com', :color => :black_teal} }

instance_list.each_pair do |instance, info|

  browser_type_list.each { |browser_type|

    starts = Time.now
    puts title(instance, instance[info][:color]) + " in " + browser(browser_type) + " starts @ " + time(starts.to_s)
    sub_session = "#{session}/#{instance}"
    Dir::mkdir(sub_session) if not File.directory?(sub_session)
    puts "\t ==> Created #{instance} screenshot sub-directory..."

    screenshot = "#{sub_session}/#{instance.gsub(' ','_').gsub(/[^0-9A-Za-z_]/,'')}_#{browser_type}_"

    puts "\t ==> Running #{instance} tests in #{browser_type}..."


    # t_string = "<%= #{name} %>"
    # browser = ERB.new t_string
    browser = Watir::Browser.new
    browser.goto "http://#{instance[info][:url]}"
    browser.screenshot.save screenshot + "homepage.png"
    if browser.text.include? "Sign"
      browser.link(:href => /.*users\/sign_up/).click
      browser.h1(:text => /Registration/).when_present { browser.screenshot.save screenshot + "registration.png" }
      ## embed to an html report based on types of tests, sections, etc...
      # embed screenshot, 'image/png'
    end
    browser.close

    ends = Time.now
    puts title(instance, info[instance][:color]) + " in " + browser(browser_type) + " ends @ " + time(ends.to_s)
    puts '--------------------------------------------------------------------'
    elapsed_time = ends - starts
    puts "Time Elapsed: #{elapsed_time.round} seconds"
    puts " "
  }

end

################################
## Final output and embedding ##
################################

`cp report.rhtml #{session}/report.rhtml`
`cp main.css #{session}/main.css`

raw_report  = "#{session}/report.rhtml"
html_report = "#{session}/report.html"

`cd #{session} && ruby #{raw_report} >> #{html_report}`

puts "==> Visit report.html @ cd #{session}/"

output = Watir::Browser.new
output.goto "file://#{html_report}"



