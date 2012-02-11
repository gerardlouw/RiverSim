import java.util.Arrays;
import java.util.PriorityQueue;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		int numCamps;
		int mbHours, mbGoalAvg, mbGoalVar;
		int obHours, obGoalAvg, obGoalVar;
		double priorityBias, mbBias;
		
		numCamps = 3;
		mbHours = 12;
		mbGoalAvg = 8;
		mbGoalVar = 2;
		mbBias = 0.5;
		
		obHours = 12;
		obGoalAvg = 14;
		obGoalVar = 2;
		
		priorityBias = 0.1;
		
		Stats s1 = new Stats(numCamps,mbHours,mbGoalAvg,mbGoalVar,obHours,obGoalAvg,obGoalVar,priorityBias, mbBias);
		
		runSim(s1);
		System.out.println(s1);
		
		mbBias = 0;
		priorityBias = 0.01;
		s1 = new Stats(numCamps,mbHours,mbGoalAvg,mbGoalVar,obHours,obGoalAvg,obGoalVar,priorityBias, mbBias);
		runSim(s1);
		System.out.println(s1);
		
		for (int run = 1; run <= 10; run++) {
			s1 = new Stats(numCamps,mbHours,mbGoalAvg,mbGoalVar,obHours,obGoalAvg,obGoalVar,priorityBias, mbBias);
			runSim(s1);
			double mbPercent = (double)s1.getTotalTripsMotorBoat() / s1.getTotalTrips();
			mbBias *= 0.5 / mbPercent;
		}
		System.out.println(s1.MB_BIAS);
		System.out.println(s1);
	}
	
	public static void runSim(Stats stats)
	{
		PriorityQueue<Boat> boats = new PriorityQueue<Boat>();
		PriorityQueue<Boat> boats_bak = new PriorityQueue<Boat>();
		
		boolean[] occupied = new boolean[stats.NUM_CAMPS + 1];
		for (int days = 1; days <= Constants.SIMUL_DAYS; days++) {
			
				Arrays.fill(occupied, false);
			while (!boats.isEmpty())
			{
				Boat top = boats.poll();
				if( top.hasArrived() ) continue;
				if( !top.move(occupied) ) continue;
				boats_bak.add(top);
				top.age();
				if (top.getLocation() == stats.NUM_CAMPS)
				{
					top.arrive();
				}
				else
				{
					occupied[top.getLocation()] = true;
				}
			}
			
			PriorityQueue<Boat> tmp = boats;
			boats = boats_bak;
			boats_bak = tmp;
			
			//fill boats
			int i;
			for (i = 0; i < stats.MB_RANGE; i++) {
				if (occupied[i]) continue;
				Boat b;
				if(i < stats.OB_RANGE){
					b = (Constants.RANDOM.nextDouble() < stats.MB_BIAS) ? new MotorBoat(stats) : new OarBoat(stats);
				}
				else{
					b = new MotorBoat(stats);
				}
				b.setLocation(i);
				occupied[i] = true;
				boats.add(b);
			}
			
			stats.completeDay(days,occupied);
		}
	}
}