package Degree;

public class Degree{
	private int lid; //location id of the degree obtained
	private int uid; //university id of the degree obtained
	private int did; //discipline id of the degree obtained
	
	private String gpa;
	private String degreeLevel;
	private String gradMonth;
	private String gradYear;
	
	public Degree(){
		lid = -1;
		uid = -1;
		did = -1;
		
		gpa = "";
		degreeLevel = "";
		gradMonth = "";
		gradYear = "";
	}
	
	public void setLID(int newLID){
		this.lid = newLID;
	}
	
	public int getLID(){
		return this.lid;
	}
	
	public void setUID(int newUID){
		this.uid = newUID;
	}
	
	public int getUID(){
		return this.uid;
	}
	
	public void setDID(int newDID){
		this.did = newDID;
	}
	
	public int getDID(){
		return this.did;
	}
	
	public void setGPA(String newGPA){
		this.gpa = newGPA;
	}
	
	public String getGPA(){
		return this.gpa;
	}
	
	public void setDegreeLevel(String newDegreeLevel){
		this.degreeLevel = newDegreeLevel;
	}
	
	public String getDegreeLevel(){
		return this.degreeLevel;
	}
	
	public void setGradMonth(String newGradMonth){
		this.gradMonth = newGradMonth;
	}
	
	public String getGradMonth(){
		return this.gradMonth;
	}
	
	public void setGradYear(String newGradYear){
		this.gradYear = newGradYear;
	}
	
	public String getGradYear(){
		return this.gradYear;
	}
}