/**
 * MIT License
 *
 * Copyright (c) 2018 Click to Cloud Pty Ltd
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * */
/**
 * Moment class to wrap datetime instance in a chaining style
 * */
public class Moment implements Comparable {
    // wrapped datetime instance
    private Datetime value;

    /**
     * Construct an instance of now
     * */
    public Moment() {
        this.value = Datetime.now();
    }

    /**
     * Construct an instance of the datetime
     * */
    public Moment(Datetime dt) {
        this.value = dt;
    }

    /**
     * Construct an instance of the date
     * */
    public Moment(Date d) {
        this.value = Datetime.newInstance(d, Time.newInstance(0, 0, 0, 0));
    }

    /**
     * Construct an instance of the time
     * */
    public Moment(Time t) {
        this.value = Datetime.newInstance(Datetime.now().date(), t);
    }

    /**
     * Construct an instance based on the total millisecond
     * */
    public Moment(Long millisecond) {
        this.value = Datetime.newInstance(millisecond);
    }

    /**
     * Parse the string to construct the instance
     * */
    public Moment(String input) {
        this.value = Datetime.parse(input);
    }

    /**
     * Parse the string according to the pattern to construct the instance
     * */
    public Moment(String input, String pattern) {
        this.value = parse(input, pattern);
    }

    /**
     * Parse the string according to the patterns to construct the instance
     * If one pattern fails, the next one will be used
     * */
    public Moment(String input, List<String> patterns) {
        for(String pattern : patterns) {
            try {
                this.value = parse(input, pattern);
            }
            catch(Exception e) {
            }
        }
    }

    /**
     * Parse the string according to the format to construct the instance
     * */
    public Moment(String input, Format fmt) {
        this(input, fmt.getPattern());
    }

    /**
     * Construct the instance from the date and time
     * */
    public Moment(Date md, Time mt) {
        this.value = Datetime.newInstance(md, mt);
    }

    /**
     * Construct the instance from year, month and day
     * */
    public Moment(Integer year, Integer month, Integer day) {
        this(year, month, day, 0, 0, 0);
    }

    /**
     * Construct the instance from year, month, day, hour, minute, and second
     * */
    public Moment(Integer year, Integer month, Integer day, Integer hour, Integer minute, Integer second) {
        this(year, month, day, hour, minute, second, 0);
    }

    /**
     * Construct the instance from year, month, day, hour, minute, second and millisecond
     * */
    public Moment(Integer year, Integer month, Integer day, Integer hour, Integer minute, Integer second, Integer millisecond) {
        year = year == null ? 0 : year;
        month = month == null ? 0 : month;
        day = day == null ? 0 : day;
        hour = hour == null ? 0 : hour;
        minute = minute == null ? 0 : minute;
        second = second == null ? 0 : second;
        millisecond = millisecond == null ? 0 : millisecond;
        Datetime dt = Datetime.newInstance(year, month, day, hour, minute, second);
        this.value = Datetime.newInstance(dt.getTime() + millisecond);
    }

    /**
     * Construct the instance from a map of datetime fields
     * */
    public Moment(Map<String, Integer> data) {
        this(
            getFieldAt(data, YEAR),
            getFieldAt(data, MONTH),
            getFieldAt(data, DAY),
            getFieldAt(data, HOUR),
            getFieldAt(data, MINUTE),
            getFieldAt(data, SECOND),
            getFieldAt(data, MILLISECOND)
        );
    }

    /**
     * Construct the instance from a list of datetime fields, in the order of
     * year, month, day, hour, minute, second, millisecond
     * */
    public Moment(List<Integer> data) {
        this(
            getNumberAt(data, 0),
            getNumberAt(data, 1),
            getNumberAt(data, 2),
            getNumberAt(data, 3),
            getNumberAt(data, 4),
            getNumberAt(data, 5),
            getNumberAt(data, 6)
        );
    }

    /**
     * Construct the instance from another instance
     * */
    public Moment(Moment m) {
        this.value = m.toDatetime();
    }

    /**
     * Construct the instance from DateTimeInfo
     * */
    public Moment(DatetimeInfo info) {
        this(info.year, info.month, info.day, info.hour, info.minute, info.second, info.millisecond);
    }

    /**
     * Convert to Apex Date
     * */
    public Date toDate() {
        return this.value.date();
    }

    /**
     * Convert to Apex Time
     * */
    public Time toTime() {
        return this.value.time();
    }

    /**
     * Convert to Apex Datetime
     * */
    public Datetime toDatetime() {
        return this.value;
    }

    /**
     * Convert to DatetimeInfo
     * */
    public DatetimeInfo toDatetimeInfo() {
        DatetimeInfo info = new DatetimeInfo();
        info.year = this.value.year();
        info.month = this.value.month();
        info.day = this.value.day();
        info.hour = this.value.hour();
        info.minute = this.value.minute();
        info.second = this.value.second();
        info.millisecond = this.value.millisecond();

        return info;
    }

    /**
     * Get total time in millisecond
     * */
    public Long getTime() {
        return this.value.getTime();
    }

    /**
     * Get total time in millisecond
     * */
    public Long valueOf() {
        return this.getTime();
    }

    /**
     * Get time field values in a list
     * */
    public List<Integer> toList() {
        return new List<Integer>{
            this.year(),
            this.month(),
            this.day(),
            this.hour(),
            this.minute(),
            this.second(),
            this.millisecond()
        };
    }

    /**
     * Get time field values in a map
     * */
    public Map<String, Integer> toMap() {
        return new Map<String, Integer>{
            YEAR => this.year(),
            MONTH => this.month(),
            DAY => this.day(),
            HOUR => this.hour(),
            MINUTE => this.minute(),
            SECOND => this.second(),
            MILLISECOND => this.millisecond()
        };
    }

    /**
     * Get the string representation of the wrapped date time
     * */
    public override String toString() {
        return String.valueOf(this.value);
    }

    /**
     * Compare with the other moment
     * */
    public Integer compareTo(Object other) {
        if(other == null) {
            return 0;
        }

        if(other instanceof Moment) {
            return this.value < ((Moment)other).value ? -1 :
                this.value == ((Moment)other).value ? 0 : 1;
        }

        return 0;
    }

    /**
     * Get the millisecond component
     * */
    public Integer millisecond() {
        return this.value.millisecond();
    }

    /**
     * Set the millisecond component
     * */
    public Moment millisecond(Integer millisecond) {
        DatetimeInfo info = this.toDatetimeInfo();
        info.millisecond = millisecond;
        return new Moment(info);
    }

    /**
     * Get the millisecond component
     * */
    public Integer milliseconds() {
        return this.millisecond();
    }

    /**
     * Set the millisecond component
     * */
    public Moment milliseconds(Integer millisecond) {
        return this.millisecond(millisecond);
    }

    /**
     * Get the second component
     * */
    public Integer second() {
        return this.value.second();
    }

    /**
     * Set the second component
     * */
    public Moment second(Integer second) {
        DatetimeInfo info = this.toDatetimeInfo();
        info.second = second;
        return new Moment(info);
    }

    /**
     * Get the second component
     * */
    public Integer seconds() {
        return this.second();
    }

    /**
     * Set the second component
     * */
    public Moment seconds(Integer second) {
        return this.second(second);
    }

    /**
     * Get the minute component
     * */
    public Integer minute() {
        return this.value.minute();
    }

    /**
     * Set the minute component
     * */
    public Moment minute(Integer minute) {
        DatetimeInfo info = this.toDatetimeInfo();
        info.minute = minute;
        return new Moment(info);
    }

    /**
     * Get the minute component
     * */
    public Integer minutes() {
        return this.minute();
    }

    /**
     * Set the minute component
     * */
    public Moment minutes(Integer minute) {
        return this.minute(minute);
    }

    /**
     * Get the hour component
     * */
    public Integer hour() {
        return this.value.hour();
    }

    /**
     * Set the hour component
     * */
    public Moment hour(Integer hour) {
        DatetimeInfo info = this.toDatetimeInfo();
        info.hour = hour;
        return new Moment(info);
    }

    /**
     * Get the hour component
     * */
    public Integer hours() {
        return this.hour();
    }

    /**
     * Set the hour component
     * */
    public Moment hours(Integer hour) {
        return this.hour(hour);
    }

    /**
     * Get the day component
     * */
    public Integer day() {
        return this.value.day();
    }

    /**
     * Set the day component
     * */
    public Moment day(Integer day) {
        DatetimeInfo info = this.toDatetimeInfo();
        info.day = day;
        return new Moment(info);
    }

    /**
     * Get the day component
     * */
    public Integer days() {
        return this.day();
    }

    /**
     * Set the day component
     * */
    public Moment days(Integer day) {
        return this.day(day);
    }

    /**
     * Get the month component
     * */
    public Integer month() {
        return this.value.month();
    }

    /**
     * Set the month component
     * */
    public Moment month(Object month) {
        DatetimeInfo info = this.toDatetimeInfo();
        info.month = toMonth(month);
        return new Moment(info);
    }

    /**
     * Get the month component
     * */
    public Integer months() {
        return this.month();
    }

    /**
     * Set the month component
     * */
    public Moment months(Integer month) {
        return this.month(month);
    }

    /**
     * Get the year component
     * */
    public Integer year() {
        return this.value.year();
    }

    /**
     * Set the year component
     * */
    public Moment year(Integer year) {
        DatetimeInfo info = this.toDatetimeInfo();
        info.year = year;
        return new Moment(info);
    }

    /**
     * Get the year component
     * */
    public Integer years() {
        return this.year();
    }

    /**
     * Set the year component
     * */
    public Moment years(Integer year) {
        return this.year(year);
    }

    /**
     * Get the day of week
     * */
    public Integer dayOfWeek() {
        return getDayNumberInWeek(this.year(), this.month(), this.day());
    }

    /**
     * Set the day of week
     * */
    public Moment dayOfWeek(Object val) {
        Datetime dt = this.toDatetime();
        Integer dayOfWeek = toDayOfWeek(val);
        Integer currentDayOfWeek = this.dayOfWeek();
        Integer deltaDays = 0;
        if(startOfWeek == 1) {
            deltaDays = dayOfWeek - currentDayOfWeek;
        }
        else if(startOfWeek == 7) {
            deltaDays = dayOfWeek == 7 ? -currentDayOfWeek : dayOfWeek - currentDayOfWeek;
        }
        dt = dt.addDays(deltaDays);

        return new Moment(dt);
    }

    /**
     * Get the day of year
     * */
    public Integer dayOfYear() {
        return this.value.dayOfYear();
    }

    /**
     * Set the day of year
     * */
    public Moment dayOfYear(Integer dayOfYear) {
        Datetime dt = Datetime.newInstance(this.year(), 1, 1);
        dt = dt.addDays(dayOfYear - 1);

        return new Moment(dt);
    }

    /**
     * Get the week component
     * */
    public Integer week() {
        return Integer.valueOf(this.value.format('w'));
    }

    /**
     * Set the week component
     * */
    public Moment week(Integer week) {
        Integer currentWeek = this.week();
        Integer deltaWeek = week - currentWeek;
        Datetime dt = this.value.addDays(deltaWeek * 7);

        return new Moment(dt);
    }

    /**
     * Get the week component
     * */
    public Integer weeks() {
        return this.week();
    }

    /**
     * Set the week component
     * */
    public Moment weeks(Integer week) {
        return this.week(week);
    }

    /**
     * Get the quarter component
     * */
    public Integer quarter() {
        Integer month = this.month();

        if(month >= 1 && month <= 3) {
            return 1;
        }
        else if(month >= 4 && month <= 6) {
            return 2;
        }
        else if(month >= 7 && month <= 9) {
            return 3;
        }
        else if(month >= 10 && month <= 12) {
            return 4;
        }
        else {
            return null;
        }
    }

    /**
     * Set the quarter component
     * */
    public Moment quarter(Integer quarter) {
        Integer currentQuarter = this.quarter();
        Integer currentMonth = this.month();
        Integer deltaQuarter = quarter - currentQuarter;
        Integer month = currentMonth + deltaQuarter * 3;

        return this.month(month);
    }

    /**
     * Get the quarter component
     * */
    public Integer quarters() {
        return this.quarter();
    }

    /**
     * Set the quarter component
     * */
    public Moment quarters(Integer quarter) {
        return this.quarter(quarter);
    }

    /**
     * Get weeks in year
     * */
    public Integer weeksInYear() {
        Datetime lastDay = Datetime.newInstance(this.year(), 12, 31);
        Integer weeks = Integer.valueOf(lastDay.format('w'));
        if(weeks == 1) {
            weeks = Integer.valueOf(lastDay.addDays(-7).format('w'));
        }

        return weeks;
    }

    /**
     * Get the field value
     * */
    public Integer field(String field) {
        if(field == null) {
            return null;
        }

        String nField = normalize(field);

        if(nField == YEAR) {
            return this.year();
        }
        else if(nField == MONTH) {
            return this.month();
        }
        else if(nField == DAY) {
            return this.day();
        }
        else if(nField == HOUR) {
            return this.hour();
        }
        else if(nField == MINUTE) {
            return this.minute();
        }
        else if(nField == SECOND) {
            return this.second();
        }
        else if(nField == MILLISECOND) {
            return this.millisecond();
        }
        else if(nField == WEEK) {
            return this.week();
        }
        else if(nField == QUARTER) {
            return this.quarter();
        }
        else {
            return null;
        }
    }

    /**
     * Set the field value
     * */
    public Moment field(String field, Object value) {
        if(field == null) {
            return this;
        }

        String nField = normalize(field);

        if(nField == YEAR) {
            return this.year((Integer)value);
        }
        else if(nField == MONTH) {
            return this.month(value);
        }
        else if(nField == DAY) {
            return this.day((Integer)value);
        }
        else if(nField == HOUR) {
            return this.hour((Integer)value);
        }
        else if(nField == MINUTE) {
            return this.minute((Integer)value);
        }
        else if(nField == SECOND) {
            return this.second((Integer)value);
        }
        else if(nField == MILLISECOND) {
            return this.millisecond((Integer)value);
        }
        else if(nField == WEEK) {
            return this.week((Integer)value);
        }
        else if(nField == QUARTER) {
            return this.quarter((Integer)value);
        }
        else {
            return this;
        }
    }

    /**
     * Add time in millisecond
     * */
    public Moment add(Long timeMillis) {
        return this.add(new Duration(timeMillis));
    }

    /**
     * Add duration
     * */
    public Moment add(Moment.Duration dur) {
        if(dur == null) {
            return this;
        }

        Moment m = this;
        Long timeMillis = dur.getTime();
        if(timeMillis != null) {
            m = new Moment(this.value.getTime() + timeMillis);
        }

        Map<String, Integer> fields = dur.getFields();
        for(String key : fields.keySet()) {
            Integer val = fields.get(key);
            String nKey = normalize(key);
            if(nKey == YEAR) {
                Integer old = this.year();
                m = this.year(old + val);
            }
            else if(nKey == MONTH) {
                Integer old = this.month();
                m = this.month(old + val);
            }
            else if(nKey == DAY) {
                Integer old = this.day();
                m = this.day(old + val);
            }
            else if(nKey == HOUR) {
                Integer old = this.hour();
                m = this.hour(old + val);
            }
            else if(nKey == MINUTE) {
                Integer old = this.minute();
                m = this.minute(old + val);
            }
            else if(nKey == SECOND) {
                Integer old = this.second();
                m = this.second(old + val);
            }
            else if(nKey == MILLISECOND) {
                Integer old = this.millisecond();
                m = this.millisecond(old + val);
            }
            else if(nKey == WEEK) {
                Integer old = this.week();
                m = this.week(old + val);
            }
            else if(nKey == QUARTER) {
                Integer old = this.quarter();
                m = this.quarter(old + val);
            }
        }

        return m;
    }

    /**
     * Add some time units
     * */
    public Moment add(Integer count, String unit) {
        return this.add(new Duration(count, unit));
    }

    /**
     * Add a map of time units
     * */
    public Moment add(Map<String, Integer> fields) {
        return this.add(new Duration(fields));
    }

    /**
     * Subtract time in millis
     * */
    public Moment subtract(Long timeMillis) {
        return this.subtract(new Duration(timeMillis));
    }

    /**
     * Subtract some time units
     * */
    public Moment subtract(Integer count, String unit) {
        return this.subtract(new Duration(count, unit));
    }

    /**
     * Subtract a map of time units
     * */
    public Moment subtract(Map<String, Integer> fields) {
        return this.subtract(new Duration(fields));
    }

    /**
     * Subtract a duration
     * */
    public Moment subtract(Moment.Duration dur) {
        return this.add(dur.negate());
    }

    /**
     * Get the start of the field value
     * */
    public Moment startOf(String field) {
        if(field == null) {
            return this;
        }

        String nField = normalize(field);

        Datetime now = Datetime.now();
        if(nField == YEAR) {
            return new Moment(this.year(), 1, 1);
        }
        else if(nField == MONTH) {
            return new Moment(this.year(), this.month(), 1);
        }
        else if(nField == DAY) {
            return new Moment(this.year(), this.month(), this.day());
        }
        else if(nField == HOUR) {
            return new Moment(this.year(), this.month(), this.day(), now.hour(), 0, 0);
        }
        else if(nField == MINUTE) {
            return new Moment(this.year(), this.month(), this.day(), now.hour(), now.minute(), 0);
        }
        else if(nField == SECOND) {
            return new Moment(this.year(), this.month(), this.day(), now.hour(), now.minute(), now.millisecond(), 0);
        }
        else if(nField == WEEK) {
            return new Moment(this.value.date().toStartOfWeek());
        }
        else if(nField == QUARTER) {
            Integer quarter = this.quarter();
            Integer month = quarter * 3 - 2;
            return new Moment(this.year(), month, 1);
        }
        else {
            return this;
        }
    }

    /**
     * Get the end of the field value
     * */
    public Moment endOf(String field) {
        if(field == null) {
            return this;
        }

        String nField = normalize(field);

        Datetime now = Datetime.now();
        if(nField == YEAR) {
            return new Moment(this.year(), 12, 31, 23, 59, 59, 999);
        }
        else if(nField == MONTH) {
            return new Moment(this.year(), this.month(), Date.daysInMonth(this.year(), this.month()), 23, 59, 59, 999);
        }
        else if(nField == DAY) {
            return new Moment(this.year(), this.month(), this.day(), 23, 59, 59, 999);
        }
        else if(nField == HOUR) {
            return new Moment(this.year(), this.month(), this.day(), now.hour(), 59, 59, 999);
        }
        else if(nField == MINUTE) {
            return new Moment(this.year(), this.month(), this.day(), now.hour(), now.minute(), 59, 999);
        }
        else if(nField == SECOND) {
            return new Moment(this.year(), this.month(), this.day(), now.hour(), now.minute(), now.millisecond(), 999);
        }
        else if(nField == WEEK) {
            Date endOfWeek = this.value.date().toStartOfWeek().addDays(6);
            return new Moment(endOfWeek.year(), endOfWeek.month(), endOfWeek.day(), 23, 59, 59, 999);
        }
        else if(nField == QUARTER) {
            Integer quarter = this.quarter();
            Integer month = quarter * 3 - 2;
            return new Moment(this.year(), month, Date.daysInMonth(this.year(), month), 23, 59, 59, 999);
        }
        else {
            return this;
        }
    }

    /**
     * Print debug information
     * */
    public Moment debug() {
        System.debug(String.valueOf(this.value));

        return this;
    }

    /**
     * Format the date time
     * */
    public String format(String format) {
        return this.value.format(format);
    }

    /**
     * Get a duration from the moment
     * */
    public String fromMoment(Moment m, Boolean withoutSuffix) {
        return new Duration(this.getTime() - m.getTime()).humanize(!withoutSuffix);
    }

    /**
     * Get a duration from the moment
     * */
    public String fromMoment(Moment m) {
        return this.fromMoment(m, false);
    }

    /**
     * Get a duration from now
     * */
    public String fromNow(Boolean withoutSuffix) {
        return this.fromMoment(new Moment(), withoutSuffix);
    }

    /**
     * Get a duration from now
     * */
    public String fromNow() {
        return this.fromMoment(new Moment());
    }

    /**
     * Get a duration to moment
     * */
    public String toMoment(Moment m, Boolean withoutSuffix) {
        return new Duration(m.getTime() - this.getTime()).humanize(!withoutSuffix);
    }

    /**
     * Get a duration to moment
     * */
    public String toMoment(Moment m) {
        return this.toMoment(m, false);
    }

    /**
     * Get a duration to now
     * */
    public String toNow(Boolean withoutSuffix) {
        return this.toMoment(new Moment(), withoutSuffix);
    }

    /**
     * Get a duration to now
     * */
    public String toNow() {
        return this.toMoment(new Moment());
    }

    /**
     * Get a duration as the difference between two moments
     * */
    public Moment.Duration diff(Moment m) {
        return new Duration(this.getTime() - m.getTime());
    }

    /**
     * Get the days in this month
     * */
    public Integer daysInMonth() {
        return Date.daysInMonth(this.year(), this.month());
    }

    /**
     * Check if it is before the other moment
     * */
    public Boolean isBefore(Moment m) {
        return this.getTime() < m.getTime();
    }

    /**
     * Check if it is the same as the other moment
     * */
    public Boolean isSame(Moment m) {
        return this.getTime() == m.getTime();
    }

    /**
     * Check if it is after the other moment
     * */
    public Boolean isAfter(Moment m) {
        return this.getTime() > m.getTime();
    }

    /**
     * Check if it is the same or before the other moment
     * */
    public Boolean isSameOrBefore(Moment m) {
        return this.getTime() <= m.getTime();
    }

    /**
     * Check if it is the same or after the other moment
     * */
    public Boolean isSameOrAfter(Moment m) {
        return this.getTime() >= m.getTime();
    }

    /**
     * Check if it is between the two moments
     * */
    public Boolean isBetween(Moment m1, Moment m2) {
        return (this.isAfter(m1) && this.isBefore(m2)) ||
            (this.isAfter(m2) && this.isBefore(m1));
    }

    /**
     * Check if it is a leap year
     * */
    public Boolean isLeapYear() {
        return Date.isLeapYear(this.year());
    }

    /**
     * Field name for year
     * */
    public static final String YEAR = 'year';

    /**
     * Field name for month
     * */
    public static final String MONTH = 'month';

    /**
     * Field name for day
     * */
    public static final String DAY = 'day';

    /**
     * Field name for hour
     * */
    public static final String HOUR = 'hour';

    /**
     * Field name for minute
     * */
    public static final String MINUTE = 'minute';

    /**
     * Field name for second
     * */
    public static final String SECOND = 'second';

    /**
     * Field name for millisecond
     * */
    public static final String MILLISECOND = 'millisecond';

    /**
     * Field name for week
     * */
    public static final String WEEK = 'week';

    /**
     * Field name for quarter
     * */
    public static final String QUARTER = 'quarter';

    /**
     * A list of all the time units
     * */
    public static final List<String> UNITS = new List<String>{
        YEAR,
        MONTH,
        DAY,
        HOUR,
        MINUTE,
        SECOND,
        MILLISECOND,
        WEEK,
        QUARTER
    };

    /**
     * Duration of a millisecond
     * */
    public static final Long DURATION_MILLISECOND = 1;

    /**
     * Duration of a second
     * */
    public static final Long DURATION_SECOND = DURATION_MILLISECOND * 1000;

    /**
     * Duration of a minute
     * */
    public static final Long DURATION_MINUTE = DURATION_SECOND * 60;

    /**
     * Duration of an hour
     * */
    public static final Long DURATION_HOUR = DURATION_MINUTE * 60;

    /**
     * Duration of a day
     * */
    public static final Long DURATION_DAY = DURATION_HOUR * 24;

    /**
     * Duration of a week
     * */
    public static final Long DURATION_WEEK = DURATION_DAY * 7;

    /**
     * Duration of a month
     * */
    public static final Long DURATION_MONTH = DURATION_DAY * 30;

    /**
     * Duration of a quarter
     * */
    public static final Long DURATION_QUARTER = DURATION_MONTH * 3;

    /**
     * Duration of a year
     * */
    public static final Long DURATION_YEAR = DURATION_QUARTER * 4;

    /**
     * Common format for date
     * */
    public static final Format FORMAT_DATE = new Format('dd/MM/yyyy');

    /**
     * Common format for time
     * */
    public static final Format FORMAT_TIME = new Format('HH:mm:ss');

    /**
     * Common format for date time
     * */
    public static final Format FORMAT_DATETIME = new Format('dd/MM/yyyy HH:mm:ss');

    /**
     * Create a duration from time in millisecond
     * */
    public static Moment.Duration duration(Long timeMillis) {
        return new Duration(timeMillis);
    }

    /**
     * Create a duration from the time units
     * */
    public static Moment.Duration duration(Integer count, String unit) {
        return new Duration(count, unit);
    }

    /**
     * Create a duration from a map of time field values
     * */
    public static Moment.Duration duration(Map<String, Integer> fields) {
        return new Duration(fields);
    }

    /**
     * Convert the unit to a normalized unit
     *
     * Example:
     * y => year
     * years => year
     * */
    public static String normalize(String unit) {
        if(unit == null) {
            return null;
        }

        unit = unit.toLowerCase();

        List<String> result = new List<String>();
        for(String u : UNITS) {
            if(u.startsWith(unit) || unit.startsWith(u)) {
                result.add(u);
            }
        }

        if(result.size() == 1) {
            return result.get(0);
        }
        else {
            throw new MomentException('Ambiguous units found: ' + String.valueOf(result));
        }
    }

    private static Integer startOfWeek = 1;

    static {
        startOfWeek = Integer.valueOf(Datetime.newInstance(Datetime.now().date().toStartOfWeek(), Time.newInstance(0, 0, 0, 0)).format('u'));
    }

    private static Datetime parse(String input, String ptn) {
        List<String> chars = ptn.split('');
        List<String> patternList = new List<String>();
        List<String> groups = new List<String>();
        String lastChar = null;

        while(!chars.isEmpty()) {
            String ch = chars.remove(0);
            if(FIELD_REGEXES.containsKey(ch)) {
                if(ch != lastChar) {
                    lastChar = ch;
                    groups.add(ch);
                    patternList.add('(' + FIELD_REGEXES.get(ch) + ')');
                }
                else {
                    continue;
                }
            }
            else {
                patternList.add(ch);
            }
        }

        Pattern p = Pattern.compile(String.join(patternList, ''));
        Matcher m = p.matcher(input);
        Map<String, String> data = new Map<String, String>();

        if(m.matches()) {
            for(Integer i = 1; i <= m.groupCount(); i++) {
                String capturedGroup = m.group(i);
                data.put(groups.get(i - 1), capturedGroup);
            }
        }

        DatetimeInfo info = new DatetimeInfo();

        populateYear(info, data);
        populateMonth(info, data);
        populateDay(info, data);
        populateHour(info, data);
        populateMinute(info, data);
        populateSecond(info, data);
        populateMillisecond(info, data);
        populateWeekInYear(info, data);
        populateWeekInMonth(info, data);
        populateDayInYear(info, data);
        populateDayOfWeekInMonth(info, data);

        if(info.year == null || info.month == null || info.hour == null) {
            throw new MomentException('Failed to parse datetime');
        }

        Long millis = Datetime.newInstance(info.year, info.month, info.day, info.hour, info.minute, info.second).getTime() + info.millisecond;
        return Datetime.newInstance(millis);
    }

    private static void populateDayOfWeekInMonth(DatetimeInfo info, Map<String, String> data) {
        if(data.containsKey('F')) {
            Integer dayOfWeekInMonth = Integer.valueOf(data.get('F'));
            Integer dayNumberInWeek = getDayNumberInWeek(data);
            if(dayNumberInWeek != null && info.year != 0 && info.month != 0) {
                Integer dayOfWeekInMonthFirstDay = getDayNumberInWeek(info.year, info.month, 1);
                Integer firstWeekLength = Math.mod(dayNumberInWeek - dayOfWeekInMonthFirstDay + 7, 7);
                Integer days = firstWeekLength + (dayOfWeekInMonth - 1) * 7;
                Date firstDay = Date.newInstance(info.year, info.month, 1);
                Date theDay = firstDay.addDays(days);
                info.year = theDay.year();
                info.month = theDay.month();
                info.day = theDay.day();
            }
        }
    }

    private static void populateDayInYear(DatetimeInfo info, Map<String, String> data) {
        if(data.containsKey('D')) {
            Integer dayInYear = Integer.valueOf(data.get('D'));
            if(info.year != 0) {
                Date firstDay = Date.newInstance(info.year, 1, 1);
                Date theDay = firstDay.addDays(dayInYear - 1);
                info.year = theDay.year();
                info.month = theDay.month();
                info.day = theDay.day();
            }
        }
    }

    private static void populateWeekInMonth(DatetimeInfo info, Map<String, String> data) {
        if(data.containsKey('W')) {
            Integer weekInMonth = Integer.valueOf(data.get('W'));
            Integer dayNumberInWeek = getDayNumberInWeek(data);
            if(dayNumberInWeek != null && info.year != 0 && info.month != 0) {
                Integer dayNumberInWeekOfFirstDay = getDayNumberInWeek(info.year, info.month, 1);
                Date firstDay = Date.newInstance(info.year, info.month, 1);
                Integer firstWeekLength, days;
                if(startOfWeek == 1) {
                    firstWeekLength = 8 - dayNumberInWeekOfFirstDay;
                    days = firstWeekLength + (weekInMonth - 2) * 7 + dayNumberInWeek;
                }
                else if(startOfWeek == 7) {
                    firstWeekLength = 7 - dayNumberInWeekOfFirstDay;
                    firstWeekLength = firstWeekLength == 0 ? 7 : firstWeekLength;
                    days = firstWeekLength + (weekInMonth - 2) * 7 + (dayNumberInWeek == 7 ? 1 : dayNumberInWeek + 1);
                }
                Date theDay = firstDay.addDays(days - 1);
                info.year = theDay.year();
                info.month = theDay.month();
                info.day = theDay.day();
            }
        }
    }

    private static Integer toDayOfWeek(Object val) {
        if(val == null) {
            return null;
        }

        if(val instanceof Integer) {
            return (Integer)val;
        }
        else if(val instanceof String) {
            String dayStr = (String)val;
            for(Integer i = 0; i < WEEKDAY_NAMES.size(); i++) {
                if(dayStr.startsWith(WEEKDAY_NAMES.get(i))) {
                    return i + 1;
                }
            }

            return Integer.valueOf(dayStr);
        }
        else {
            return null;
        }
    }

    private static Integer getDayNumberInWeek(Map<String, String> data) {
        if(data.containsKey('E')) {
            return toDayOfWeek(data.get('E'));
        }
        if(data.containsKey('u')) {
            return toDayOfWeek(data.get('u'));
        }

        return null;
    }

    private static Integer getDayNumberInWeek(Integer year, Integer month, Integer day) {
        if(month == 1 || month == 2) {
            month += 12;
            year -= 1;
        }

        Integer num = Math.mod((day + 1 + 2 * month + 3 * (month + 1) / 5 + year + year / 4 - year / 100 + year / 400), 7);
        return num == 0 ? 7 : num; // 1 for Mon, 7 for Sun
    }

    private static void populateWeekInYear(DatetimeInfo info, Map<String, String> data) {
        if(data.containsKey('w')) {
            Integer year = info.year;
            Integer weekInYear = Integer.valueOf(data.get('w'));
            Integer dayNumberInWeek = getDayNumberInWeek(data);
            if(dayNumberInWeek != null && year != 0) {
                Integer dayNumberInWeekOfFirstDay = getDayNumberInWeek(year, 1, 1);
                Integer firstWeekLength, days;
                if(startOfWeek == 1) {
                    firstWeekLength = 8 - dayNumberInWeekOfFirstDay;
                    days = firstWeekLength + (weekInYear - 2) * 7 + dayNumberInWeek;
                }
                else if(startOfWeek == 7) {
                    firstWeekLength = 7 - dayNumberInWeekOfFirstDay;
                    firstWeekLength = firstWeekLength == 0 ? 7 : firstWeekLength;
                    days = firstWeekLength + (weekInYear - 2) * 7 + (dayNumberInWeek == 7 ? 1 : dayNumberInWeek + 1);
                }
                Date firstDay = Date.newInstance(year, 1, 1);
                Date theDay = firstDay.addDays(days - 1);
                info.year = theDay.year();
                info.month = theDay.month();
                info.day = theDay.day();
            }
        }
    }

    private static void populateMillisecond(DatetimeInfo info, Map<String, String> data) {
        if(data.containsKey('S')) {
            info.millisecond = Integer.valueOf(data.get('S'));
        }
    }

    private static void populateSecond(DatetimeInfo info, Map<String, String> data) {
        if(data.containsKey('s')) {
            info.second = Integer.valueOf(data.get('s'));
        }
    }

    private static void populateMinute(DatetimeInfo info, Map<String, String> data) {
        if(data.containsKey('m')) {
            info.minute = Integer.valueOf(data.get('m'));
        }
    }

    private static void populateHour(DatetimeInfo info, Map<String, String> data) {
        if(data.containsKey('H') ||
            data.containsKey('k') ||
            data.containsKey('K') ||
            data.containsKey('h')) {
            Boolean isIn24 = data.containsKey('H') || data.containsKey('k');
            Integer hour = null;
            if(data.containsKey('H')) {
                hour = Math.mod(Integer.valueOf(data.get('H')), 24);
            }
            if(data.containsKey('k')) {
                hour = Math.mod(Integer.valueOf(data.get('k')), 24);
            }
            if(data.containsKey('K')) {
                hour = Math.mod(Integer.valueOf(data.get('K')), 12);
            }
            if(data.containsKey('h')) {
                hour = Math.mod(Integer.valueOf(data.get('h')), 12);
            }

            if(!isIn24) {
                String amStr = data.get('a');
                amStr = amStr == null ? 'am' : amStr;
                if(amStr.equalsIgnoreCase('pm')) {
                    hour += 12;
                }
            }

            info.hour = hour;
        }
    }

    private static void populateDay(DatetimeInfo info, Map<String, String> data) {
        String dayStr = data.get('d');
        if(dayStr != null) {
            info.day = Integer.valueOf(dayStr);
        }
    }

    private static Integer toMonth(Object val) {
        if(val == null) {
            return null;
        }

        if(val instanceof Integer) {
            return (Integer)val;
        }
        else if(val instanceof String) {
            String monthStr = (String)val;
            Integer month = null;
            for(Integer i = 0; i < MONTH_NAMES.size(); i++) {
                if(monthStr.startsWith(MONTH_NAMES.get(i))) {
                    month = i + 1;
                    break;
                }
            }

            if(month == null) {
                month = Integer.valueOf(monthStr);
            }

            return month;
        }
        else {
            return null;
        }
    }

    private static void populateMonth(DatetimeInfo info, Map<String, String> data) {
        String monthStr = data.get('M');
        if(monthStr != null) {
            Integer month = toMonth(monthStr);

            info.month = month;
        }
    }

    private static void populateYear(DatetimeInfo info, Map<String, STring> data) {
        String yearStr = null;
        if(data.containsKey('y')) {
            yearStr = data.get('y');
        }
        if(data.containsKey('Y')) {
            yearStr = data.get('Y');
        }

        if(yearStr != null) {
            if(yearStr.length() == 2) {
                info.year = 100 * Math.mod(Datetime.now().year(), 100) + Integer.valueOf(yearStr);
            }
            else {
                info.year = Integer.valueOf(yearStr);
            }
        }
    }

    private static Integer getNumberAt(List<Integer> numbers, Integer index) {
        return index >= 0 && index < numbers.size() ? numbers.get(index) : null;
    }

    private static Integer getFieldAt(Map<String, Integer> fields, String name) {
        for(String key : fields.keySet()) {
            Integer value = fields.get(key);
            String nKey = normalize(key);
            if(name == nKey) {
                return value;
            }
        }

        return null;
    }

    private static final List<String> MONTH_NAMES = new List<String>{
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
    };

    private static final List<String> WEEKDAY_NAMES = new List<String>{
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun'
    };

    private static final Map<String, String> FIELD_REGEXES = new Map<String, String>{
        'y' => '\\d+',
        'Y' => '\\d+',
        'M' => '\\w+',
        'd' => '\\d+',

        'a' => '\\w+',
        'H' => '\\d{1,2}',
        'k' => '\\d{1,2}',
        'K' => '\\d{1,2}',
        'h' => '\\d{1,2}',
        'm' => '\\d{1,2}',
        's' => '\\d{1,2}',
        'S' => '\\d+',

        'w' => '\\d+',
        'E' => '\\w+',
        'u' => '\\d+',

        'W' => '\\d+',

        'D' => '\\d+',

        'F' => '\\d+'
    };

    /**
     * Helper class
     * */
    public class DatetimeInfo {
        public Integer year = 0;
        public Integer month = 0;
        public Integer day = 0;
        public Integer hour = 0;
        public Integer minute = 0;
        public Integer second = 0;
        public Integer millisecond = 0;
    }

    /**
     * A duration between two moments
     * */
    public class Duration {
        // can be time in millisecond
        private Long timeMillis;

        // can be specified by time field values
        private Map<String, Integer> fields = new Map<String, Integer>();

        /**
         * Construct an instance from time in millis and time field values
         *
         * If both time in millisecond and time field values are specified, it means the sum of both
         * */
        public Duration(Long timeMillis, Map<String, Integer> fields) {
            this.timeMillis = timeMillis;
            if(fields != null) {
                for(String key : fields.keySet()) {
                    Integer value = fields.get(key);
                    String nKey = normalize(key);
                    if(nKey == YEAR) {
                        this.fields.put(YEAR, value);
                    }
                    else if(nKey == QUARTER) {
                        this.fields.put(QUARTER, value);
                    }
                    else if(nKey == MONTH) {
                        this.fields.put(MONTH, value);
                    }
                    else if(nKey == WEEK) {
                        this.fields.put(WEEK, value);
                    }
                    else if(nKey == DAY) {
                        this.fields.put(DAY, value);
                    }
                    else if(nKey == HOUR) {
                        this.fields.put(HOUR, value);
                    }
                    else if(nKey == MINUTE) {
                        this.fields.put(MINUTE, value);
                    }
                    else if(nKey == SECOND) {
                        this.fields.put(SECOND, value);
                    }
                    else if(nKey == MILLISECOND) {
                        this.fields.put(MILLISECOND, value);
                    }
                }
            }
        }

        /**
         * Construct an instance from time in millisecond
         * */
        public Duration(Long timeMillis) {
            this(timeMillis, null);
        }

        /**
         * Construct an instance from time field values
         * */
        public Duration(Map<String, Integer> fields) {
            this(null, fields);
        }

        /**
         * Construct an instance from time field values
         * */
        public Duration(Integer count, String unit) {
            this(new Map<String, Integer>{ unit => count });
        }

        /**
         * Get the time in millisecond component
         * */
        public Long getTime() {
            return this.timeMillis;
        }

        /**
         * Get the time fields component
         * */
        public Map<String, Integer> getFields() {
            return this.fields;
        }

        /**
         * Return a human-readable string representation
         * */
        public String humanize() {
            return this.humanize(false);
        }

        /**
         * Return a human-readable string representation
         * */
        public String humanize(Boolean suffix) {
            Long timeMillis = toTime();
            Long absTime = Math.abs(timeMillis);
            String str = null;
            Long years = toYears(absTime);
            Long months = toMonths(absTime);
            Long days = toDays(absTime);
            Long hours = toHours(absTime);
            Long minutes = toMinutes(absTime);
            Long seconds = toSeconds(absTime);

            if(days >= 548) {
                str = years + ' years';
            }
            else if(days >= 320) {
                str = 'a year';
            }
            else if(days >= 45) {
                str = months + ' months';
            }
            else if(days >= 26) {
                str = 'a month';
            }
            else if(hours >= 36) {
                str = days + ' days';
            }
            else if(hours >= 22) {
                str = 'a day';
            }
            else if(minutes >= 90) {
                str = hours + ' hours';
            }
            else if(minutes >= 45) {
                str = 'an hour';
            }
            else if(seconds >= 90) {
                str = minutes + ' minutes';
            }
            else if(seconds >= 45) {
                str = 'a minute';
            }
            else {
                str = 'a few seconds';
            }

            if(suffix) {
                return timeMillis > 0 ? 'in ' + str : str + ' ago';
            }
            else {
                return str;
            }
        }

        /**
         * Get the field of the duration
         * */
        public Integer field(String field) {
            if(field == null) {
                return null;
            }

            String nField = normalize(field);
            Map<String, Integer> fields = toFields();

            if(nField == YEAR) {
                return fields.containsKey(YEAR) ? fields.get(YEAR) : 0;
            }
            else if(nField == MONTH) {
                return fields.containsKey(MONTH) ? fields.get(MONTH) : 0;
            }
            else if(nField == WEEK) {
                return fields.containsKey(DAY) ? (Integer)(fields.get(DAY) / 7) : 0;
            }
            else if(nField == DAY) {
                return fields.containsKey(DAY) ? fields.get(DAY) : 0;
            }
            else if(nField == HOUR) {
                return fields.containsKey(HOUR) ? fields.get(HOUR) : 0;
            }
            else if(nField == MINUTE) {
                return fields.containsKey(MINUTE) ? fields.get(MINUTE) : 0;
            }
            else if(nField == SECOND) {
                return fields.containsKey(SECOND) ? fields.get(SECOND) : 0;
            }
            else if(nField == MILLISECOND) {
                return fields.containsKey(MILLISECOND) ? fields.get(MILLISECOND) : 0;
            }
            else {
                return null;
            }
        }

        /**
         * Get the millisecond component
         * */
        public Integer milliseconds() {
            return this.field('millisecond');
        }

        /**
         * Get the millisecond component
         * */
        public Integer asMilliseconds() {
            return this.milliseconds();
        }

        /**
         * Get the second component
         * */
        public Integer seconds() {
            return this.field('second');
        }

        /**
         * Get the second component
         * */
        public Integer asSeconds() {
            return this.seconds();
        }

        /**
         * Get the minute component
         * */
        public Integer minutes() {
            return this.field('minute');
        }

        /**
         * Get the minute component
         * */
        public Integer asMinutes() {
            return this.minutes();
        }

        /**
         * Get the hour component
         * */
        public Integer hours() {
            return this.field('hour');
        }

        /**
         * Get the hour component
         * */
        public Integer asHours() {
            return this.hours();
        }

        /**
         * Get the day component
         * */
        public Integer days() {
            return this.field('day');
        }

        /**
         * Get the day component
         * */
        public Integer asDays() {
            return this.days();
        }

        /**
         * Get the month component
         * */
        public Integer months() {
            return this.field('month');
        }

        /**
         * Get the month component
         * */
        public Integer asMonths() {
            return this.months();
        }

        /**
         * Get the week component
         * */
        public Integer weeks() {
            return this.field('week');
        }

        /**
         * Get the week component
         * */
        public Integer asWeeks() {
            return this.weeks();
        }

        /**
         * Get the year component
         * */
        public Integer years() {
            return this.field('year');
        }

        /**
         * Get the year component
         * */
        public Integer asYears() {
            return this.years();
        }

        /**
         * Get the field of the duration
         * */
        public Integer asField(String field) {
            return this.field(field);
        }

        /**
         * Get the field of the duration
         * */
        public Integer get(String field) {
            return this.field(field);
        }

        /**
         * Add a duration
         * */
        public Moment.Duration add(Moment.Duration dur) {
            Long timeMillis = concat(this.timeMillis, dur.timeMillis);
            Map<String, Integer> fields = concat(this.fields, dur.fields);

            return new Duration(timeMillis, fields);
        }

        /**
         * Add a duration in time in millisecond
         * */
        public Moment.Duration add(Long timeMillis) {
            return this.add(new Duration(timeMillis));
        }

        /**
         * Add a duration in a map of time field values
         * */
        public Moment.Duration add(Map<String, Integer> fields) {
            return this.add(new Duration(fields));
        }

        /**
         * Add a duration in time field values
         * */
        public Moment.Duration add(Integer count, String unit) {
            return this.add(new Duration(count, unit));
        }

        /**
         * Subtract a duration
         * */
        public Moment.Duration subtract(Moment.Duration dur) {
            return this.add(dur.negate());
        }

        /**
         * Subtract a duration in time in millisecond
         * */
        public Moment.Duration subtract(Long timeMillis) {
            return this.subtract(new Duration(timeMillis));
        }

        /**
         * Subtract a duration in a map of time field values
         * */
        public Moment.Duration subtract(Map<String, Integer> fields) {
            return this.subtract(new Duration(fields));
        }

        /**
         * Subtract a duration in time field value
         * */
        public Moment.Duration subtract(Integer count, String unit) {
            return this.subtract(new Duration(count, unit));
        }

        /**
         * Negate the duration
         * */
        public Moment.Duration negate() {
            Long timeMillis = this.timeMillis == null ? null : -(this.timeMillis);
            Map<String, Integer> fields = negate(this.fields);

            return new Duration(timeMillis, fields);
        }

        private Long toYears(Long timeMillis) {
            return (Long)(Math.roundToLong(timeMillis * 1.0 / DURATION_YEAR));
        }

        private Long toMonths(Long timeMillis) {
            return (Long)(Math.roundToLong(timeMillis * 1.0 / DURATION_MONTH));
        }

        private Long toDays(Long timeMillis) {
            return (Long)(Math.roundToLong(timeMillis * 1.0 / DURATION_DAY));
        }

        private Long toHours(Long timeMillis) {
            return (Long)(Math.roundToLong(timeMillis * 1.0 / DURATION_HOUR));
        }

        private Long toMinutes(Long timeMillis) {
            return (Long)(Math.roundToLong(timeMillis * 1.0 / DURATION_MINUTE));
        }

        private Long toSeconds(Long timeMillis) {
            return (Long)(Math.roundToLong(timeMillis * 1.0 / DURATION_SECOND));
        }

        private Long toTime(Map<String, Integer> fields) {
            Long timeMillis = 0;

            if(fields.containsKey(YEAR)) {
                timeMillis += fields.get(YEAR) * DURATION_YEAR;
            }
            else if(fields.containsKey(QUARTER)) {
                timeMillis += fields.get(QUARTER) * DURATION_QUARTER;
            }
            else if(fields.containsKey(MONTH)) {
                timeMillis += fields.get(MONTH) * DURATION_MONTH;
            }
            else if(fields.containsKey(WEEK)) {
                timeMillis += fields.get(WEEK) * DURATION_WEEK;
            }
            else if(fields.containsKey(DAY)) {
                timeMillis += fields.get(DAY) * DURATION_DAY;
            }
            else if(fields.containsKey(HOUR)) {
                timeMillis += fields.get(HOUR) * DURATION_HOUR;
            }
            else if(fields.containsKey(MINUTE)) {
                timeMillis += fields.get(MINUTE) * DURATION_MINUTE;
            }
            else if(fields.containsKey(SECOND)) {
                timeMillis += fields.get(SECOND) * DURATION_SECOND;
            }
            else if(fields.containsKey(MILLISECOND)) {
                timeMillis += fields.get(MILLISECOND) * DURATION_MILLISECOND;
            }

            return timeMillis;
        }

        private Map<String, Integer> toFields(Long timeMillis) {
            Map<String, Integer> data = new Map<String, Integer>();

            Integer years = (Integer)(timeMillis / DURATION_YEAR);
            timeMillis -= years * DURATION_YEAR;
            Integer months = (Integer)(timeMillis / DURATION_MONTH);
            timeMillis -= months * DURATION_MONTH;
            Integer days = (Integer)(timeMillis / DURATION_DAY);
            timeMillis -= days * DURATION_DAY;
            Integer hours = (Integer)(timeMillis / DURATION_HOUR);
            timeMillis -= hours * DURATION_HOUR;
            Integer minutes = (Integer)(timeMillis / DURATION_MINUTE);
            timeMillis -= minutes * DURATION_MINUTE;
            Integer seconds = (Integer)(timeMillis / DURATION_SECOND);
            Integer milliseconds = (Integer)(timeMillis - seconds * DURATION_SECOND);

            data.put(YEAR, years);
            data.put(MONTH, months);
            data.put(DAY, days);
            data.put(HOUR, hours);
            data.put(MINUTE, minutes);
            data.put(SECOND, seconds);
            data.put(MILLISECOND, milliseconds);

            return data;
        }

        private Map<String, Integer> negate(Map<String, Integer> fields) {
            Map<String, Integer> data = new Map<String, Integer>();

            for(String key : fields.keySet()) {
                Integer val = fields.get(key);
                if(val != null) {
                    val = -val;
                }

                data.put(key, val);
            }

            return data;
        }

        private Long concat(Long num1, Long num2) {
            if(num1 != null && num2 != null) {
                return num1 + num2;
            }
            else if(num1 != null) {
                return num1;
            }
            else if(num2 != null) {
                return num2;
            }
            else {
                return null;
            }
        }

        private Integer concat(Integer num1, Integer num2) {
            if(num1 != null && num2 != null) {
                return num1 + num2;
            }
            else if(num1 != null) {
                return num1;
            }
            else if(num2 != null) {
                return num2;
            }
            else {
                return null;
            }
        }

        private Map<String, Integer> concat(Map<String, Integer> fields1, Map<String, Integer> fields2) {
            Map<String, Integer> data = new Map<String, Integer>();

            Set<String> fieldKeys = new Set<String>();
            fieldKeys.addAll(fields1.keySet());
            fieldKeys.addAll(fields2.keySet());
            for(String key : fieldKeys) {
                Integer val1 = fields1.get(key);
                Integer val2 = fields2.get(key);
                Integer val = concat(val1, val2);
                data.put(key, val);
            }

            return data;
        }

        private Long toTime() {
            Long timeMillis = this.toTime(this.fields);
            if(this.timeMillis != null) {
                timeMillis += this.timeMillis;
            }

            return timeMillis;
        }

        private Map<String, Integer> toFields() {
            Map<String, Integer> data = this.fields;

            if(this.timeMillis != null) {
                data = this.concat(this.fields, toFields(this.timeMillis));
            }

            return data;
        }
    }

    /**
     * The format class for the Moment
     * */
    public class Format {
        private String pattern;

        public Format(String pattern) {
            this.pattern = pattern;
        }

        public String getPattern() {
            return this.pattern;
        }
    }

    /**
     * Common moment exception
     * */
    public class MomentException extends Exception {
    }
}
