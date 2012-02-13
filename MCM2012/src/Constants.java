import java.util.Random;


public class Constants {
	public static final int SIMUL_DAYS = 183;
	//public static final int NUM_CAMPS = 40;
	
	public static final double RIVER_LENGTH = 225.0;
	//public static final double DELTA = RIVER_LENGTH / (NUM_CAMPS + 1);
	public static final int MIN_DAYS = 6;
	public static final int MAX_DAYS = 18;
	public static final int MAX_DAYS_BOUNDS_DEVIATION = 200;
	public static final int MAX_DOCUMENTED_T = MAX_DAYS + MAX_DAYS_BOUNDS_DEVIATION;
	public static final int STD_MB_HOURS = 12;
	public static final int STD_OB_HOURS = 8;
	public static final double STD_PRIORITY_BIAS = 0.1;
	public static final int DEFAULT_PRIORITY_FUNC = Stats.WEIGHTED_AGE;
	
	public static final Random RANDOM = new Random();
}
