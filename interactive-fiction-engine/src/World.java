import java.util.ArrayList;

/**
 * Motif utilisé : singleton (afin que l'unicité du monde soit garantie, il n'y a qu'une seule instance)
 */
public class World {
	private static final World world = new World();
	private static final Player player = new Player("player00");
	
	private ArrayList<Scene> scenes = new ArrayList<Scene>();
	
	
	private World() {}
	
	public static World getWorld() {return world;}
	public static Player getPlayer() {return player;}
	
	
	public void addScene(Scene newScene) {
		scenes.add(newScene);
	}
	
	public void removeScene(String idScene) {
		scenes.remove(getScene(idScene));
	}
	
	/**
	 * Méthode qui renvoie la scène avec l'id idScene
	 * @param idScene
	 * @return
	 */
	public Scene getScene(String idScene) {
		for (int i=0; i<scenes.size(); i++) {
			if (scenes.get(i).getId().equals(idScene)) {
				return scenes.get(i);
			}
		}
		
		return null;
	}
	
	/**
	 * Méthode qui renvoie l'accessoire avec l'id idProp (recherche l'accessoire parmi toutes les scènes)
	 * @param idProp
	 * @return
	 */
	public Prop getProp(String idProp) {
		Prop prop;
		
		for (int i=0; i<scenes.size(); i++) {
			prop = scenes.get(i).getProp(idProp);
			
			if (prop != null) {
				return prop;
			}
		}
		
		return null;
	}
}