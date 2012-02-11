
public abstract class Boat implements Comparable<Boat> {
	private int location = -1;
	private final int range; //nodes travelled per day
	private int distLeft;
	private int daysLeft;
	private int age = 0;
	private boolean arrived = false;
	private Stats s;
	
	public Boat(double speed, double hours, double goalAvg, double goalVar, Stats s) {
		range = (int) (speed * hours / s.DELTA);
		daysLeft = (int)Math.round(goalAvg + (2 * Constants.RANDOM.nextDouble() - 1) * goalVar);
		//daysLeft = (int)Math.round(Constants.RANDOM.nextGaussian() * goalVar/2 + goalAvg);
		distLeft = s.NUM_CAMPS;
		this.s = s;
	}

	public int getLocation() {
		return location;
	}

	public void setLocation(int location) {
		this.location = location;
		distLeft = s.NUM_CAMPS - location;
	}
	
	public boolean move(boolean[] occupied) {
		int origIntent = Math.min(getDestination(), location + range);
		//System.out.printf("%s %s %s\n", getDestination(), location, range);
		int intent;
		if (inTrouble()) {
			for (intent = origIntent; intent < s.NUM_CAMPS && occupied[intent]
			    && intent < location + range; intent++);
			if (occupied[intent])
				for (intent = origIntent - 1; occupied[intent] && intent > location + 1; intent--);
		} else {
			for (intent = origIntent; occupied[intent] && intent > location + 2; intent--);
			if (occupied[intent])
				for (intent = origIntent + 1; intent < s.NUM_CAMPS && occupied[intent]
				    && intent < location + range; intent++);
		}
		if (intent >= 0 && intent <= s.NUM_CAMPS && !occupied[intent]) {
			location = intent;
			distLeft = s.NUM_CAMPS - location;
			return true;
		} // maybe behave differently if no move is possible
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
		//System.out.printf("%d %d\n", distLeft, daysLeft);
		return location + (int)Math.round((double)distLeft / Math.max(daysLeft, 1));
	}
	
	public double getPriority() {
		return s.PRIORITY_BIAS / (daysLeft * range - distLeft) + 1.0/daysLeft;
	}
	
	private boolean inTrouble() {
		return daysLeft * range < distLeft;
	}
	
	@Override
	public int compareTo(Boat b) {
		return Double.compare(getPriority(), b.getPriority());
	}
	
	public void arrive() {
		arrived = true;
		s.completedTrip(this);
	}
	
	public boolean hasArrived() {
		return arrived;
	}
}