# Moment.apex
Moment.apex parses, manipulates and displays dates and times in Apex.

## Examples
### Parse Dates
```java
new Moment('2018/01/18', 'yyyy/MM/dd'); // 2018-01-18 00:00:00
new Moment('2018/01/18 14:20:00', 'yyyy/MM/dd HH:mm:ss'); // 2018-01-18 14:20:00
```

### Format Dates
```java
new Moment().format('yyyy/MM/dd'); // 2018/05/04
```

### Manipulate
```java
new Moment().add(1, 'month').subtract(3, 'days'); // 2018-06-01 11:25:37
new Moment().year(2018).month(3).day(1).hour(12).minute(0).second(0); // 2018-03-01 12:00:00
new Moment().year(); // 2018
```

### Relative Time
```java
new Moment().add(3, 'days').fromNow(); // in 3 days
```
