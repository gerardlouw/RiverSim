
public class Camp {
	private final int location;
	private boolean occupied;

	public Camp(int location) {
		this.location = location;
	}

	public int getLocation() {
		return location;
	}
	
	public void setOccupied(boolean occupied) {
		this.occupied = occupied;
	}
	
	public boolean isOccupied() {
		return occupied;
	}
	
	@Override
	public String toString() {
		return occupied ? "1" : "0";
	}
}
