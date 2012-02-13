
public abstract class Boat implements Comparable<Boat> {
	private int location = -1;
	private final int range; //nodes travelled per day
	private int distLeft;
	private int daysLeft;
	private final int tripDays;
	private int age = 0;
	private boolean arrived = false;
	private Stats s;
	
	public Boat(double speed, double hours,int T, Stats s) {
		range = (int) (speed * hours / s.DELTA);
		daysLeft = T;
		tripDays = daysLeft;
		distLeft = s.NUM_CAMPS+1;
		this.s = s;
	}

	public int getLocation() {
		return location;
	}

	public void setLocation(int location) {
		this.location = location;
		distLeft = s.NUM_CAMPS - location;
	}
	
	/*
	 * FUNCTION MOVE ()
	 * {
	 *   GOAL_DESTINATION = LOCATION + MIN(DIST_LEFT / DAYS_LEFT, RANGE)
	 *   IF (GOAL_DESTINATION IS UNOCCUPIED) {
	 *     MOVE TO GOAL_DESTINATION
	 *   }
	 *   ELSE {
	 *     SEARCH FOR UNOCCUPIED CAMP CLOSEST TO GOAL_DESTINATION, WITHIN RANGE
	 *   
	 *     IF (RUNNING LATE ON SCHEDULE [CURRENT AVERAGE MILES PER DAY < GOAL AVERAGE MILES PER DAY]) {
	 *       START THE SEARCH DOWNSTREAM FROM GOAL_DESTINATION, THEN TRY UPSTREAM
	 *     }
	 *     ELSE
	 *     {
	 *       START THE SEARCH UPSTREAM FROM GOAL_DESTINATION, THEN TRY DOWNSTREAM
	 *     }
	 *   
	 *     IF (UNOCCUPIED CAMP WAS FOUND) {
	 *       MOVE TO CAMP
	 *     }
	 *     ELSE {
	 *       BOAT IS STUCK, DELETE INFORMATION FROM SCHEDULE
	 *     }
	 *   }
	 * }
	 */	
	public boolean move(boolean[] occupied) {
		int origIntent = Math.min(getDestination(), location + range);
		if(range == 0){
			s.deadlock(age);
			return false;
		}
		if(occupied[origIntent])
		{
			int intent;
			int upperBound = Math.min(location + range, s.NUM_CAMPS);
			int lowerBound = location + 1;
			if (runningLate()) 
			{
				// Search right of goal
				for (intent = origIntent; intent < upperBound; intent++)
				{
					if(!occupied[intent])
					{
						setLocation(intent);
						return true;
					}
				}
				// Search left of goal
				for (intent = origIntent - 1; intent >= lowerBound; intent--)
				{
					if(!occupied[intent])
					{
						setLocation(intent);
						return true;
					}
				}
			}
			else 
			{
				// Search left of goal
				for (intent = origIntent - 1; intent >= lowerBound; intent--)
				{
					if(!occupied[intent])
					{
						setLocation(intent);
						return true;
					}
				}
				// Search right of goal
				for (intent = origIntent; intent < upperBound; intent++)
				{
					if(!occupied[intent])
					{
						setLocation(intent);
						return true;
					}
				}
			}
		}
		else
		{
			setLocation(origIntent);
			return true;
		}
		s.deadlock(age);
		return false;
	}
		
	public int getRange() {
		return range;
	}
	
	public void age() {
		daysLeft--;
		age++;
	}
	
	public int getAge() {
		return age;
	}
	
	public int getDaysLeft() {
		return daysLeft;
	}
	
	public int getDestination() {
		return location + (int)Math.round((double)distLeft / Math.max(daysLeft, 1));
	}
	
	public double getPriority() {
		switch(s.PRIORITY_FUNC)
		{
		case Stats.RANDOM:
			return Math.random();
		case Stats.AGE:
			return age;
		case Stats.WEIGHTED_AGE:
			return age /(double)tripDays;
		case Stats.MOVABILITY:
			return s.PRIORITY_BIAS / (daysLeft * range - distLeft) + (double)tripDays / Math.max(daysLeft, 1);
		default:
			return 1;
		}
	}
	
	private boolean runningLate() {
		return location < (double)s.NUM_CAMPS / tripDays * getAge();
	}
	
	@Override
	public int compareTo(Boat b) {
		return Double.compare(b.getPriority(), getPriority());
	}
	
	public void arrive() {
		arrived = true;
		s.completedTrip(this);
	}
	
	public boolean hasArrived() {
		return arrived;
	}
}
