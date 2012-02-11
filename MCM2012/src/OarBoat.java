
public class OarBoat extends Boat {
	public static final double SPEED = 4;
	
	public OarBoat(Stats s) {
		super(SPEED, s.OB_HOURS, s.OB_GOAL_AVG, s.OB_GOAL_VAR,s);
	}
}
