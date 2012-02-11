import java.util.Arrays;


public class Main {
	public static void main(String args[])
	{
		int[] camps = new int [50];
		
	}
	
	public static void fillCamps(int [] camps)
	{
		for(int i = 6; i <= 18; i++)
		{
			fillPipe(camps,i,i);
		}
		System.out.println(Arrays.toString(camps));
	}
	
	public static void fillPipe(int [] camps, int id, int T)
	{
		int location = 0;
		int cT = 0;
		while( location < camps.length )
		{
			location = getNextLocation(location, camps.length, cT, T);
			if(camps[location] == 0)
			{
				camps[location] = id;
			}
			else
			{
				// Find another spot
				int deviation = 1;
				while(true)
				{
					int iR = location + deviation;
					int iL = location - deviation;
					boolean iRr = iR < camps.length;
					boolean iLr = iR > 0;
					
					// Search left
					if(iLr)
						if(camps[iL] == 0)
						{
							camps[iL] = id;
							break;
						}
					// Search right
					if(iRr)
						if(camps[iR] == 0)
						{
							camps[iR] = id;
							break;
						}
						
					if(!iRr && !iLr)
						break;
					deviation++;
				}
			}
		}
	}
	
	public static int getNextLocation(int location, int campsLength, int cT, int fT)
	{
		return location + (campsLength-location)/(fT - cT);
	}
}
