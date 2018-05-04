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
@isTest
private class MomentTest {
    @isTest
    private static void isBeforeTest() {
        Moment m = new Moment(2018, 1, 1);
        Moment base = new Moment(2019, 1, 1);
        System.assertEquals(true, m.isBefore(base));
    }

    @isTest
    private static void diffTest() {
        Moment m = new Moment(2018, 1, 1);
        Moment base = new Moment(2019, 1, 1);
        System.assertEquals(-1, m.diff(base).years());
    }

    @isTest
    private static void toMomentTest() {
        Moment m = new Moment(2018, 1, 1);
        Moment base = new Moment(2019, 1, 1);
        System.assertEquals('in a year', m.toMoment(base));
    }

    @isTest
    private static void fromMomentTest() {
        Moment m = new Moment(2018, 1, 1);
        Moment base = new Moment(2019, 1, 1);
        System.assertEquals('a year ago', m.fromMoment(base));
    }

    @isTest
    private static void durationSubtractTest() {
        Moment.Duration dur = Moment.duration(3, 'hour');
        Moment.Duration dur1 = Moment.duration(1, 'hour');
        System.assertEquals(2, dur.subtract(dur1).hours());
    }

    @isTest
    private static void durationAddTest() {
        Moment.Duration dur = Moment.duration(3, 'hour');
        Moment.Duration dur1 = Moment.duration(3, 'hour');
        System.assertEquals(6, dur.add(dur1).hours());
    }

    @isTest
    private static void durationFieldTest() {
        Moment.Duration dur = Moment.duration(3, 'hour');
        System.assertEquals(3, dur.field('hour'));
    }

    @isTest
    private static void durationHumanizeTest() {
        Moment.Duration dur = Moment.duration(3, 'hour');
        System.assertEquals('in 3 hours', dur.humanize(true));

        dur = Moment.duration(60000);
        System.assertEquals('a minute', dur.humanize());
    }

    @isTest
    private static void formatTest() {
        Moment m = new Moment(2018, 1, 7);
        System.assertEquals('2018/01/07', m.format('yyyy/MM/dd'));
    }

    @isTest
    private static void endOfTest() {
        Moment m = new Moment(2018, 1, 7)
            .endOf('year');
        System.assertEquals(31, m.day());
        System.assertEquals(999, m.millisecond());
    }

    @isTest
    private static void startOfTest() {
        Moment m = new Moment(2018, 1, 7)
            .startOf('year');
        System.assertEquals(1, m.day());
    }

    @isTest
    private static void subtractTest() {
        Moment m = new Moment(2018, 1, 7)
            .subtract(3, 'days');
        System.assertEquals(4, m.day());
    }

    @isTest
    private static void addTest() {
        Moment m = new Moment(2018, 1, 1)
            .add(3, 'days');
        System.assertEquals(4, m.day());
    }

    @isTest
    private static void setAndSetFieldTest() {
        Moment m = new Moment()
            .field('year', 2018)
            .field('month', 10)
            .field('day', 10);
        System.assertEquals(2018, m.field('year'));
        System.assertEquals(10, m.field('month'));
        System.assertEquals(10, m.field('day'));
    }

    @isTest
    private static void weeksInYear() {
        Moment m = new Moment().year(2018).month(1).day(3).hour(10).minute(0).second(0).millisecond(0);
        System.assertEquals(52, m.weeksInYear());
    }

    @isTest
    private static void quarterTest() {
        Moment m = new Moment().year(2018).month(1).day(3).hour(10).minute(0).second(0).millisecond(0);
        m = m.quarter(2);

        System.assertEquals(4, m.month());
    }

    @isTest
    private static void monthNameTest() {
        Moment m = new Moment().year(2018).month('January').day(3).hour(10).minute(0).second(0).millisecond(0);
        System.assertEquals(1, m.month());
    }

    @isTest
    private static void weekTest() {
        Moment m = new Moment().year(2018).month(1).day(3).hour(10).minute(0).second(0).millisecond(0);
        System.assertEquals(1, m.week());

        m = m.week(2);
        System.assertEquals(10, m.day());
    }

    @isTest
    private static void dayOfYearTest() {
        Moment m = new Moment().year(2018).month(1).day(3).hour(10).minute(0).second(0).millisecond(0);
        System.assertEquals(3, m.dayOfYear());

        m = m.dayOfYear(5);
        System.assertEquals(5, m.dayOfYear());
    }

    @isTest
    private static void dayOfWeekTest() {
        Moment m = new Moment().year(2018).month(5).day(3).hour(10).minute(0).second(0).millisecond(0);
        System.assertEquals(4, m.dayOfWeek());

        m = m.dayOfWeek(5);
        System.assertEquals(5, m.dayOfWeek());
    }

    @isTest
    private static void getAndSetFieldsTest() {
        Moment m = new Moment().year(2018).month(5).day(1).hour(10).minute(0).second(0).millisecond(0);
        System.assertEquals(2018, m.year());
        System.assertEquals(5, m.month());
        System.assertEquals(1, m.day());
        System.assertEquals(10, m.hour());
        System.assertEquals(0, m.minute());
        System.assertEquals(0, m.second());
        System.assertEquals(0, m.millisecond());
    }

    @isTest
    private static void parseDayOfWeekInMonthTest() {
        Datetime dt = Datetime.newInstance(2018, 1, 1, 0, 0, 0);

        String ptn = 'yyyy MM F E';
        String str;
        Moment m;
        Integer step = 1;

        while(step < 1500) {
            str = dt.format(ptn);
            m = new Moment(str, ptn);
            System.assertEquals(dt.date(), m.toDate());
            dt = dt.addDays(1);

            step += 1;
        }
    }

    @isTest
    private static void parseDayInYearTest() {
        Datetime dt = Datetime.newInstance(2018, 1, 1, 0, 0, 0);

        String ptn = 'yyyy MM D';
        String str;
        Moment m;
        Integer step = 1;

        while(step < 1500) {
            str = dt.format(ptn);
            m = new Moment(str, ptn);
            System.assertEquals(dt.date(), m.toDate());
            dt = dt.addDays(1);

            step += 1;
        }
    }

    @isTest
    private static void parseWeekOfMonthTest() {
        Datetime dt = Datetime.newInstance(2018, 1, 1, 0, 0, 0);

        String ptn = 'yyyy MM W E u';
        String str;
        Moment m;
        Integer step = 1;

        while(step < 1500) {
            str = dt.format(ptn);
            m = new Moment(str, ptn);
            System.assertEquals(dt.date(), m.toDate());
            dt = dt.addDays(1);

            step += 1;
        }
    }

    @isTest
    private static void parseWeekOfYearTest() {
        Datetime dt = Datetime.newInstance(2018, 1, 1, 0, 0, 0);

        String ptn = 'YYYY w E u';
        String str;
        Moment m;
        Integer step = 1;

        while(step < 1500) {
            str = dt.format(ptn);
            m = new Moment(str, ptn);
            System.assertEquals(dt.date(), m.toDate());
            dt = dt.addDays(1);

            step += 1;
        }
    }

    @isTest
    private static void parseSimpleTest() {
        Moment m = new Moment('2018/1/1 12:05:30', 'yyyy/MM/dd HH:mm:ss');
        System.assertEquals(
            Datetime.newInstance(2018, 1, 1, 12, 5, 30),
            m.toDatetime()
        );
    }

    @isTest
    private static void instanceTest() {
        Moment m = new Moment(Datetime.newInstance(2000, 1, 1));
        System.assertEquals(
            Datetime.newInstance(2000, 1, 1),
            m.toDatetime()
        );
    }
}
