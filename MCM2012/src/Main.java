import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.PriorityQueue;

public class Main {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		int numCamps;
		double mbHours, mbGoalAvg, mbGoalVar;
		double obHours, obGoalAvg, obGoalVar;
		double priorityBias, mbBias;
		
		numCamps = 50;
		/*mbHours = 12;
		mbGoalAvg = 9;
		mbGoalVar = 3.5;
		mbBias = 0.5;
		
		obHours = 8;
		obGoalAvg = 16;
		obGoalVar = 3;*/
		
		mbHours = 12;
		mbGoalAvg = 9;
		mbGoalVar = 3.5;
		mbBias = 0.5;
		
		obHours = 8;
		obGoalAvg = 16;
		obGoalVar = 3;
		
		priorityBias = 0.1;
		
		Stats s1;
		
		BufferedWriter sf = new BufferedWriter(new FileWriter("sf.txt"));
		BufferedWriter mbf = new BufferedWriter(new FileWriter("mbf.txt"));
		BufferedWriter obf = new BufferedWriter(new FileWriter("obf.txt"));
		
		Stats.writeHeader(sf);
		
		for(int i = 0; i < 1000; i++){
			s1 = new Stats(numCamps,mbHours,mbGoalAvg,mbGoalVar,obHours,obGoalAvg,obGoalVar,priorityBias);
			runSim(s1);
			s1.writeFileEntry(sf, mbf, obf);
		}
		
		sf.close();
		mbf.close();
		obf.close();
		
		sf = new BufferedWriter(new FileWriter("num_camps_sf.txt"));
		mbf = new BufferedWriter(new FileWriter("num_camps_mbf.txt"));
		obf = new BufferedWriter(new FileWriter("num_camps_obf.txt"));
		
		Stats.writeHeader(sf);
		
		for(int i = 2; i < 200; i++){
			for(int ii = 0; ii < 20; ii++)
			{
				s1 = new Stats(i,mbHours,mbGoalAvg,mbGoalVar,obHours,obGoalAvg,obGoalVar,priorityBias);
				runSim(s1);
				s1.writeFileEntry(sf, mbf, obf);
			}
			if(i % 10 == 0)
				System.out.println(i);
		}
		
		sf.close();
		mbf.close();
		obf.close();
		
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
