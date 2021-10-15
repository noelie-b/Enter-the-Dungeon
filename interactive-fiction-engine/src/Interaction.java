public class Interaction {
	private String variable, msj;	// la variable peut être le destinataire (scènes) ou la condition (accessoires type porte)
	
	public Interaction(String var, String desc) {
		variable = var;
		msj = desc;
	}
	
	public String getVariable() {return variable;}
	public String getDescription() {return msj;}
}