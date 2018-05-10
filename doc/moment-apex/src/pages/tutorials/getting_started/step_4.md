---
title: "Date/Time Display"
description: "Date/Time Display"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 4
---

## {$page.title}

We can format Date/Time, and also we can show humanized duration strings.

```javascript
new Moment().format('yyyy/MM/dd'); // 2018/05/04

new Moment().add(3, 'days').fromNow(); // in 3 days
```
