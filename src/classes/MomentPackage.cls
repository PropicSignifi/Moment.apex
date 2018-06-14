public class MomentPackage extends Func.DefaultPackage {
    public override void init() {
        this.export('parse', new ParseFunc());
    }

    private class ParseFunc extends Func {
        public ParseFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String pattern = (String)R.toString.run(arg1);
            String input = (String)R.toString.run(arg2);

            return new Moment(input, pattern).toDatetime();
        }
    }
}
