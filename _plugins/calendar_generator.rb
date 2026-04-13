#
# Generates /assets/CAUSE_calendar.ics during Jekyll build.
# Input is the data in _calendar
#

require 'icalendar'
require 'icalendar/tzinfo'
require 'date'
require 'time'

module Jekyll
    class CalendarGenerator < Generator
        safe true # Safe to run in restricted environments
        priority :low # Run after most generators

        TIMEZONE = 'Europe/Berlin'
        SITE_URL = 'https://rtg-cause.github.io'

        def generate(site)
            cal = Icalendar::Calendar.new
            cal.prodid = '-//YourSiteName//Calendar//EN'
            cal.calscale = 'GREGORIAN'
            cal.publish # Adds METHOD:PUBLISH

            # Add the timezone block
            tz = TZInfo::Timezone.get(TIMEZONE)
            cal.add_timezone tz.ical_timezone(Time.now)

            events = site.collections['calendar'].docs
            events.each do |doc|
                event = doc.data
                cal.event do |e|
                    e.uid = "#{SITE_URL}#{doc.url}"
                    e.dtstamp = Icalendar::Values::DateTime.new(Time.now.utc, 'tzid' => 'UTC')

                    e.dtstart = ical_datetime(event['start_date'])
                    e.dtend = ical_datetime(event['end_date'])

                    e.summary = event['title']
                    e.description = event['description']
                    e.location = event['location']

                    e.url = event['eventurl'] if event['eventurl']
                end
            end

            # Write the calendar file
            page = PageWithoutAFile.new(site, site.source, 'assets', 'CAUSE_calendar.ics')
            page.content = cal.to_ical
            page.data['layout'] = nil
            site.pages << page
        end

        def ical_datetime(value)
            dt = case value
                when DateTime then value
                when Date then value.to_datetime
                when Time then value.to_datetime
                else DateTime.parse(value.to_s)
                end

            Icalendar::Values::DateTime.new(dt, 'tzid' => TIMEZONE)
        end
    end
end
