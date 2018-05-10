---
title: "Methods"
description: "Moment Instance Methods"
layout: "guide"
icon: "code-file"
weight: 2
---

###### {$page.description}

<article id="1">

## Getter/Setter

Moment.apex has getters/setters for Date/Time fields like:

```javascript
Moment m = new Moment();
m.hour(12); // set the hour
m.hours(12); // set the hour
m.hour(); // get the hour
m.hours(); // get the hour
```

Below is the table of the fields supporting these getters/setters.

| Field | Description |
| ----- | ----------- |
| millisecond(s) | Get/set the millisecond |
| second(s) | Get/set the second |
| minute(s) | Get/set the minute |
| hour(s) | Get/set the hour |
| day(s) | Get/set the day |
| month(s) | Get/set the day |
| year(s) | Get/set the year |
| dayOfWeek | Get/set the day of week |
| dayOfYear | Get/set the day of year |
| week(s) | Get/set the week of year |
| quarter(s) | Get/set the quarter of year |

Besides, we have generic methods to access Date/Time fields.

```javascript
Moment m = new Moment();
m.field('year'); // get the year
m.field('year', 2018); // set the year
```

| Method | Description |
| ------ | ----------- |
| field | Get/set the field |

</article>

<article id="2">

## Query

Moment.apex has utility methods for querying.


| Method | Description |
| ------ | ----------- |
| weeksInYear() | Get the number of weeks in year |
| startOf(String) | Get the start moment of the Date/Time field |
| endOf(String) | Get the end moment of the Date/Time field |
| debug() | Print the debug information |
| diff(Moment) | Create a duration between two moments |
| daysInMonth() | Get the days in the current month |
| isBefore(Moment) | Check if it is before the other moment |
| isSame(Moment) | Check if it is the same as the other moment |
| isAfter(Moment) | Chekc if it is after the other moment |
| isSameOrBefore(Moment) | Check if it is the same or before the other moment |
| isSameOrAfter(Moment) | Check if it is the same or after the other moment |
| isBetween(Moment, Moment) | Check if it is between these two moments |
| isLeapYear() | Check if it is the leap year |

</article>

<article id="3">

## Operation

Moment.apex also enables operations like adding/subtracting on fields of Moment.


| Method | Description |
| ------ | ----------- |
| add(Moment.Duration) | Add a duration |
| add(Long) | Add time in milliseconds |
| add(Integer, String) | Add some units of time |
| add(Map&lt;String, Integer&gt;) | Add different units of time |
| subtract(Moment.Duration) | Subtract a duration |
| subtract(Long) | Subtract time in milliseconds |
| subtract(Integer, String) | Subtract some units of time |
| subtract(Map&lt;String, Integer&gt;) | Subtract different units of time |

</article>

<article id="4">

## Display

Moment.apex includes APIs to display Date/Time.


| Method | Description |
| ------ | ----------- |
| format(String) | Format the Moment using the format |
| fromMoment(Moment) | Show the duration from the moment with prefix |
| fromMoment(Moment, Boolean) | Show the duration from the moment with or without prefix |
| fromNow(Boolean) | Show the duration from now with or without prefix |
| fromNow() | Show the duration from now with prefix |
| toMoment(Moment) | Show the duration to the moment with prefix |
| toMoment(Moment, Boolean) | Show the duration to the moment with or without prefix |
| toNow() | Show the duration to now with prefix |
| toNow(Boolean) | Show the duration to now with or without prefix |

</article>

<article id="5">

## Units

Moment.apex supports the below units, and any shortened strings(case-insensitive) that can uniquely pick a field out.

```javascript
Moment m = new Moment();
m.field('year'); // standard
m.field('years'); // also work
m.field('yea'); // fine
m.field('y'); // works
m.field('Y'); // cool
```

| Unit | Description |
| ---- | ----------- |
| year | year |
| month | month |
| day | day |
| hour | hour |
| minute | minute |
| second | second |
| millisecond | millisecond |
| week | week |
| quarter | quarter |

</article>

<article id="6">

## Static Methods

Moment.apex has a few static methods/fields.

| Method | Description |
| ------ | ----------- |
| YEAR | year |
| MONTH | month |
| DAY | day |
| HOUR | hour |
| MINUTE | minute |
| SECOND | second |
| MILLISECOND | millisecond |
| WEEK | week |
| QUARTER | quarter |
| UNITS | a list of units |
| DURATION_YEAR | the milliseconds of year |
| DURATION_MONTH | the milliseconds of month |
| DURATION_DAY | the milliseconds of day |
| DURATION_HOUR | the milliseconds of hour |
| DURATION_MINUTE | the milliseconds of minute |
| DURATION_SECOND | the milliseconds of second |
| DURATION_MILLISECOND | the milliseconds of millisecond |
| DURATION_WEEK | the milliseconds of week |
| DURATION_QUARTER | the milliseconds of quarter |
| FORMAT_DATE | 'dd/MM/yyyy' |
| FORMAT_TIME | 'HH:mm:ss' |
| FORMAT_DATETIME | 'dd/MM/yyyy HH:mm:ss' |
| duration(Long) | Create a Duration from time in milliseconds |
| duration(Integer, String) | Create a Duration from some units of time |
| duration(Map&lt;String, Integer&gt;) | Create a Duration from different units of time |
| normalize(String) | Normalize a string of unit |

</article>
