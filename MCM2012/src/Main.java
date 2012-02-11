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
		
		numCamps = 50;
		mbHours = 12;
		mbGoalAvg = 8;
		mbGoalVar = 2;
		mbBias = 0.5;
		
		obHours = 8;
		obGoalAvg = 12;
		obGoalVar = 2;
		
		priorityBias = 0.1;
		
		Stats s1 = new Stats(numCamps,mbHours,mbGoalAvg,mbGoalVar,obHours,obGoalAvg,obGoalVar,priorityBias, mbBias,1);
		
		double mb = mbBias;
		for (int run = 1; run <= 1; run++) {
			s1 = new Stats(numCamps,mbHours,mbGoalAvg,mbGoalVar,obHours,obGoalAvg,obGoalVar,priorityBias, mb,1);
			runSim(s1);
			double mbPercent = (double)s1.getTotalTripsMotorBoat() / s1.getTotalTrips();
			mb *= mbBias / mbPercent;
		}
		System.out.println(mb);
		System.out.println(s1);
	}
	
	public static void runSim(Stats stats)
	{
		PriorityQueue<Boat> boats = new PriorityQueue<Boat>();
		PriorityQueue<Boat> boats_bak = new PriorityQueue<Boat>();
		
		//double [] campsDemand = new double[stats.NUM_CAMPS];
		boolean[] occupied = new boolean[stats.NUM_CAMPS + 1];
		int mbcount = 0;
		int obcount = 0;
		for (int days = 1; days <= Constants.SIMUL_DAYS; days++) {
			
			// Calculate demand
			//Arrays.fill(campsDemand, 0);
			/*double ampScale = 1.0/stats.NUM_CAMPS;
			for(Boat b : boats)
			{
				int lowerBound;
				int upperBound;
				int goal;
				
				lowerBound = b.getLocation() + 1;
				upperBound = Math.min(stats.NUM_CAMPS - 1,b.getLocation() + b.getRange());
				goal = b.getDestination();
				
				for (int i = lowerBound; i <= upperBound; i++) {
					campsDemand[i] += ampScale*Math.exp(-0.5 * Math.pow((i - goal) / stats.DEMAND_STDDEV, 2));
				}
			}*/
			
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
					if (mbcount > obcount){
						b = new OarBoat(stats);
						obcount++;
					}else{
						b = new MotorBoat(stats);
						mbcount++;
					}
					//b = (Constants.RANDOM.nextDouble() < stats.MB_BIAS) ? new MotorBoat(stats) : new OarBoat(stats);
				}
				else{
					b = new MotorBoat(stats);
					mbcount++;
				}
				b.setLocation(i);
				occupied[i] = true;
				boats.add(b);
			}
			
			stats.completeDay(days,occupied);
		}
		
		//System.out.println("Demand: "+ Arrays.toString(campsDemand));
	}
}
