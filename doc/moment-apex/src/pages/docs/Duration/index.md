---
title: "Duration"
description: "Duration"
layout: "guide"
icon: "cloud"
weight: 4
---

###### {$page.description}

<article id="1">

## Duration Constructors

Here are the Duration constructors.

| Constructor | Description |
| ----------- | ----------- |
| Duration(Long, Map&lt;String, Integer&gt;) | Create a Duration from time in milliseconds and different units of time |
| Duration(Map&lt;String, Integer&gt;) | Create a Duration from different units of time |
| Duration(Integer, String) | Create a Duration from some units of time |
| Duration(Long) | Create a Duration from time in milliseconds |

</article>

<article id="2">

## Get Time Out of Duration

| Method | Description |
| ------ | ----------- |
| getTime() | Get time in millis from Duration |
| getFields() | Get units of time from Duration |

</article>

<article id="3">

## Display Duration

| Method | Description |
| ------ | ----------- |
| humanize() | Show the humanized string without suffix |
| humanize(Boolean) | Show the humanized string with or without suffix |

</article>

<article id="4">

## Getters

| Method | Description |
| ------ | ----------- |
| years() | Get years |
| asYears() | Get years |
| months() | Get months |
| asMonths() | Get months |
| days() | Get days |
| asDays() | Get days |
| hours() | Get hours |
| asHours() | Get hours |
| minutes() | Get minutes |
| asMinutes() | Get minutes |
| seconds() | Get seconds |
| asSeconds() | Get seconds |
| milliseconds() | Get milliseconds |
| asMilliseconds() | Get milliseconds |
| weeks() | Get weeks |
| asWeeks() | Get weeks |

Generic getters:

| Method | Description |
| ------ | ----------- |
| field(String) | Get the field |
| asField(String) | Get the field |
| get(String) | Get the field |

</article>

<article id="5">

## Operation

Moment.apex also enables operations like adding/subtracting on fields of Duration.


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
| negate() | Negate the duration |

</article>
