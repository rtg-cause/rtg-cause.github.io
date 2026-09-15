# rtg-cause.github.io

### Calendar

The calendar is generated automatically during the Jekyll build from the markdown
files in `_calendar/`. Each event is a file with the metadata in the front matter.
Here's an example:

```yaml
---
title: CAUSE Hybrid Meeting
start_date: 2025-11-21 09:00
end_date: 2025-11-21 10:00
location: Online - https://tuhh.zoom.us/j/1234
description: Monthly hybrid meeting
---

* Administrative stuff
* Scientific discussion
```

Generation is done by the plugin `_plugins/calendar_generator.rb`, which reads all
events from the collection and produces the ICS file at `/assets/CAUSE_calendar.ics`.
