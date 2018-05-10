---
title: "Conversion"
description: "Conversion of Moments"
layout: "guide"
icon: "flash"
weight: 1
---

###### {$page.description}

<article id="1">

## Moment Constructors

Moment.apex has various constructors to build an instance in any situation.

| Constructor | Description |
| ----------- | ----------- |
| Moment() | Create a Moment based on now |
| Moment(Datetime) | Create a Moment based on the Datetime |
| Moment(Date) | Create a Moment based on the Date, with time fields set to 0 |
| Moment(Time) | Create a Moment based on the Time, with the date as today |
| Moment(Long) | Create a Moment based on the time in milliseconds |
| Moment(String) | Create a Moment by parsing the string according to the locale |
| Moment(String, String) | Create a Moment by parsing the string according to the pattern |
| Moment(String, List&lt;String&gt;) | Create a Moment by parsing the string according to a list of patterns |
| Moment(String, Moment.Format) | Create a Moment by parsing the string according to the predefined Moment.Format |
| Moment(Date, Time) | Create a Moment by combining the Date and Time |
| Moment(Integer, Integer, Integer) | Create a Moment with the year, month, and day |
| Moment(Integer, Integer, Integer, Integer, Integer, Integer) | Create a Moment with the year, month, day, hour, minute, and second |
| Moment(Integer, Integer, Integer, Integer, Integer, Integer, Integer) | Create a Moment with the year, month, day, hour, minute, second and millisecond |
| Moment(Map&lt;String, Integer&gt;) | Create a Moment with a map of the fields(year, month, day, hour, minute, second, and millisecond) |
| Moment(List&lt;Integer&gt;) | Create a Moment with a list of the fields(year, month, day, hour, minute, second, and millisecond) |
| Moment(Moment) | Create a Moment with an existing Moment |
| Moment(Moment.DatetimeInfo) | Create a Moment with the DatetimeInfo |

Date/Time parsing accepts the same patterns as Date/Time formatting. Below is the table of rules supported.

| Character | Description |
| --------- | ----------- |
| y | Year |
| Y | Week year |
| M | Month in year |
| d | Day in month |
| a | Am/pm marker |
| H | Hour in day (0-23) |
| k | Hour in day (1-24) |
| K | Hour in am/pm (0-11) |
| h | Hour in am/pm (1-12) |
| m | Minute in hour |
| s | Second in minute |
| S | Millisecond |
| w | Week in year |
| E | Day name in week |
| u | Day number of week (1 = Monday, ..., 7 = Sunday) |
| W | Week in month |
| D | Day in year |
| F | Day of week in month |

</article>

<article id="2">

## Get Date/Time Out of Moment

Moment.apex has various constructors to get Date/Time out of a Moment.

| Method | Description |
| ----------- | ----------- |
| toDate | Get Date from Moment |
| toTime | Get Time from Moment |
| toDatetime | Get Datetime from Moment |
| toDatetimeInfo | Get DatetimeInfo from Moment |
| getTime | Get time in milliseconds from Moment |
| valueOf | Get time in milliseconds from Moment |
| toList | Get a list of field values(year, month, day, hour, minute, second, and millisecond) from Moment |
| toMap | Get a map of field values(year, month, day, hour, minute, second, and millisecond) from Moment |
| toString | Get a string representation of Moment |

</article>

<article id="3">

## Timezone

Moment.apex works only in current timezone, and does not handle GMT Date/Time.

</article>
