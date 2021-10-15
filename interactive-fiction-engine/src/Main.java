import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

public class Main {
	private static JFileChooser fc;
	private static DocumentBuilder builder;
	private static Document doc;
	private static int typeError;
	
	private static World world = World.getWorld();
	private static Player player = World.getPlayer();
	
	public static void main(String[] args) {
		init();
		validate();
		load();
		startGame(true);
		
		System.exit(0);
	}
	
	/**
	 * Méthode qui initialise les structures principales :
	 * 	- 1. Les éléments nécessaires sont initialisés pour générer la fenêtre de sélection de document xml
	 * 	- 2. Les éléments nécessaires pour effectuer l'analyse du document chargé sont initialisés
	 */
	private static void init() {
		// file chooser window
		fc = new JFileChooser(); // création de l'objet FileChooser avec valeurs par défaut.
		fc.setCurrentDirectory(new File(System.getProperty("user.dir"))); // équivalent d'un pwd, renvoit là où on est.
		fc.setDialogTitle("Sélectionnez un fichier XML"); // S'affiche dans la fenêtre 
	    
		fc.setFileSelectionMode(JFileChooser.FILES_ONLY);
		fc.setAcceptAllFileFilterUsed(false);
	    FileNameExtensionFilter filter = new FileNameExtensionFilter("XML files (.xml)", "xml");
	    fc.setFileFilter(filter);
	    
	    
	    // xml parser
	    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
	    domFactory.setValidating(true);
	    
	    try { // parse le doc xml et vérifie s'il a des erreurs
			builder = domFactory.newDocumentBuilder();
		} catch (ParserConfigurationException e) { // catch récupère le message d'erreur
			e.printStackTrace();
		}
	    
		builder.setErrorHandler(new ErrorHandler() { // Le parser de SAx vérifie si le xml est bien formé. 3 types d'erreurs :
	        public void fatalError(SAXParseException exception) throws SAXException {typeError=0;throw exception;}
	        public void error(SAXParseException exception) throws SAXException {typeError=1;throw exception;}
	        public void warning(SAXParseException exception) throws SAXException {typeError=2;throw exception;}
	    });
	}

	/**
	 * Méthode qui exécute la fenêtre de sélection de document xml et qui gère les interactions des utilisateurs avec cette fenêtre
	 */
	private static void validate() {
		String msj;
		int msjType;
		Object[] options = {"oui", "sortir"};

		while (true) {
			if (fc.showOpenDialog(fc) == JFileChooser.APPROVE_OPTION) {
				try {
					doc = builder.parse(fc.getSelectedFile().getAbsolutePath());
					msj = "Le document XML est bien formé et valide.\n";
					msjType = JOptionPane.QUESTION_MESSAGE;
				} catch (SAXException | IOException e) {
					if (typeError == 0) {
						msj = "Le document xml n'est pas bien formé :\n";
					} else if (typeError == 1) {
						msj = "Le document XML n'est pas valide :\n";
					} else {
						msj = "Un problème est survenu lors de l'exécution du programme :\n";
					}
					msj += "- " + e.getMessage() + "\n\n";
					msjType = JOptionPane.ERROR_MESSAGE;
				}

				if (msjType == JOptionPane.QUESTION_MESSAGE) {
					System.out.println("Document XML chargé et analysé correctement");
					break;
				} else if (JOptionPane.showOptionDialog(fc, msj + "Voulez-vous essayer un autre document ?", "", JOptionPane.YES_NO_OPTION, msjType, null, options, options[0]) != 0) {
					break;
				}
			} else {
				break;
			}
		}
	}

	/**
	 * Méthode qui effectue la lecture du document XML chargé et génère toutes les scènes, accessoires, joueurs, etc.
	 * C'est-à-dire qu'il est chargé de créer tous les éléments de la structure xml et de les configurer avec les attributs dont ils disposent.
	 */
	private static void load() {
		NodeList nodeList;
		NamedNodeMap attrList;
		NodeList actionList;
		
		String id, msj, variable, type, param01, param02;
		int numDoors, numBoxes;
		boolean state;
		Scene scene;
		Prop prop;
		
		doc.getDocumentElement().normalize();
		
		/*
		 * player
		 */
		
		nodeList = doc.getElementsByTagName("player");	// saisir les éléments avec le tag player
		// Doc contient tous le XML
		
		for (int i=0; i<nodeList.getLength(); i++) {
			attrList = nodeList.item(i).getAttributes();	// prendre tous les attributs du nœud i
			
			player.setCurrentScene(attrList.item(0).getNodeValue());	// sauvegarder la scène initiale du joueur en prenant la valeur du premier attribut (il n'y a qu'un seul attribut dans player)
		}
		
		/*
		 * scenes
		 */
		
		nodeList = doc.getElementsByTagName("scene");	// saisir les éléments avec la balise de scène
		
		for (int i=0; i<nodeList.getLength(); i++) { // boucle qui prévoit d'avoir plusieurs joueurs 
			if (nodeList.item(i).getNodeType() != Node.ELEMENT_NODE) continue;	// sauter l'itération si le nœud n'est pas de type élément
			
			id = null; // On remet à 0 ces variables à chaque fois qu'oin itère
			numDoors = 0;
			numBoxes = 0;
			msj = null; 
			
			// attributes
			
			attrList = nodeList.item(i).getAttributes();	// prendre tous les attributs du nœud i (de la scène i)
			
			for (int j=0; j<attrList.getLength(); j++) { // la limite est la longueur de la liste
				switch (attrList.item(j).getNodeName()) {	// étant donné que les attributs peuvent être chargés dans le désordre, ils doivent être enregistrés au fur et à mesure qu'ils sont trouvés
					case "id": id = attrList.item(j).getNodeValue(); break;
					case "numDoors": numDoors = Integer.parseInt(attrList.item(j).getNodeValue()); break;
					case "numBoxes": numBoxes = Integer.parseInt(attrList.item(j).getNodeValue()); break;
					case "msj": msj = attrList.item(j).getNodeValue(); break;
				}
			}
			
			scene = new Scene(id, numDoors, numBoxes, msj);	// une fois les attributs pris, la scène de base est créée

			// actions
			
			actionList = nodeList.item(i).getChildNodes();	// prendre toutes les mesures (enfants) à partir du nœud i
			
			for (int j=0; j<actionList.getLength(); j++)  {
				if (actionList.item(j).getNodeType() != Node.ELEMENT_NODE) continue;	// sauter l'itération si le nœud n'est pas de type élément
				
				variable = null;
				msj = null;

				attrList = actionList.item(j).getAttributes();	// prendre tous les attributs du nœud j (de l'action j)
				
				for (int k=0; k<attrList.getLength(); k++) {
					switch (attrList.item(k).getNodeName()) {	// étant donné que les attributs peuvent être chargés dans le désordre, ils doivent être enregistrés au fur et à mesure qu'ils sont trouvés
						case "dest": variable = attrList.item(k).getNodeValue(); break;
						case "msj": msj = attrList.item(k).getNodeValue(); break;
					}
				}
				
				scene.addInteraction(new Interaction(variable, msj));	// une fois les attributs pris, l'interaction est créée et enregistrée dans la scène à laquelle elle appartient
			}
			
			world.addScene(scene);	// enfin, une fois la scène entière prise (avec ses attributs et actions), elle est sauvegardée dans world
		}
		
		/*
		 * props
		 */
		
		nodeList = doc.getElementsByTagName("prop");	// saisir les éléments avec la balise prop
		
		for (int i=0; i<nodeList.getLength(); i++) {
			if (nodeList.item(i).getNodeType() != Node.ELEMENT_NODE) continue;	// sauter l'itération si le nœud n'est pas de type élément
			
			id = null;
			type = null;
			state = true;
			param01 = null;
			param02 = null;
			
			// attributes
			
			attrList = nodeList.item(i).getAttributes();	// prendre tous les attributs du nœud i (de la porte i)
			
			for (int j=0; j<attrList.getLength(); j++) {
				switch (attrList.item(j).getNodeName()) {	// étant donné que les attributs peuvent être chargés dans le désordre, ils doivent être enregistrés au fur et à mesure qu'ils sont trouvés
					case "id": id = attrList.item(j).getNodeValue(); break;
					case "type": type = attrList.item(j).getNodeValue(); break;
					case "state": state = Boolean.parseBoolean(attrList.item(j).getNodeValue()); break;
					case "scene01": param01 = attrList.item(j).getNodeValue(); break;
					case "scene02": param02 = attrList.item(j).getNodeValue(); break;
					case "unlock": param02 = attrList.item(j).getNodeValue(); break;
				}
			}
			
			if (type.equals("door")) {	// une fois les attributs pris, le prop de base est créé
				prop = new Prop(id, type, state, param01, param02);
			} else if (type.equals("box")) { // Rajouter un type créature par exemple. Elle aurait des attributs comme (vivant, mort, gentil, méchant...)
				prop = new Prop(id, type, param01, param02);
			} else {
				break;
			}
			
			// actions
			
			actionList = nodeList.item(i).getChildNodes();	// prendre toutes les mesures (enfants) à partir du nœud i
			
			for (int j=0; j<actionList.getLength(); j++)  {
				if (actionList.item(j).getNodeType() != Node.ELEMENT_NODE) continue;	// sauter l'itération si le nœud n'est pas de type élément
				
				variable = null;
				msj = null;

				attrList = actionList.item(j).getAttributes();	// prendre tous les attributs du nœud j (de l'action j)
				
				for (int k=0; k<attrList.getLength(); k++) {
					switch (attrList.item(k).getNodeName()) {	// étant donné que les attributs peuvent être chargés dans le désordre, ils doivent être enregistrés au fur et à mesure qu'ils sont trouvés
						case "condition": variable = attrList.item(k).getNodeValue(); break;
						case "msj": msj = attrList.item(k).getNodeValue(); break;
					}
				}
				
				prop.addInteraction(new Interaction(variable, msj));	// une fois les attributs pris, l'interaction est créée et enregistrée dans la prop à laquelle elle appartient
			}
			
			scene = world.getScene(param01);	// enfin, une fois l'accessoire entier pris (avec ses attributs et actions), il est sauvegardé dans les scènes auxquelles il appartient (deux dans le cas de porte et un dans le cas de boîte)
			scene.addProp(prop);
			
			if (type.equals("door") && !param01.equals(param02)) {
				scene = world.getScene(param02);
				scene.addProp(prop);
			}
		}
	}

	/**
	 * Méthode qui effectue l'exécution du jeu par console, affiche les messages et exécute les actions choisies par l'utilisateur.
	 * @param info (indique si le message et les options de scène doivent être affichés)
	 */
	private static void startGame(boolean info) { // Appelé pour chaque scène
		Scene scene;
		String dest, msj, type, param01, param02;
		boolean state, nextScene;
		Prop prop;
		ArrayList<Interaction> interactions;
		int input;
		
		scene = world.getScene(player.getCurrentScene());	// scène actuelle du joueur
		nextScene = true;
		
		msj = scene.getDescription();
		interactions = scene.getInteractions();
		
		/*
		 * imprimer le msg et les options et lire l'option choisie
		 */
		
		if (info) {	// il ne s'imprime que si info est vrai (afin que le msg et les options ne sortent pas en continu)
			System.out.println("----------------------------------------------");
			System.out.println(msj);
			
			for (int i=0; i<interactions.size(); i++) {
				System.out.print("  " + i + ". "); // Faire i+=1 pour pas que la première option soit 0 mais 1
				System.out.println(interactions.get(i).getDescription());
			}
		}
		
		input = readInput(interactions.size());	// lecture de l'option choisie
		
		/*
		 * appliquer l'option choisie
		 */
		
		dest = interactions.get(input).getVariable();	// destinataire de l'option choisie (porte/boîte)
		
		prop = scene.getProp(dest);	// prop à modifier
		
		type = prop.getType();
		state = prop.getState();
		param01 = prop.getParam01();
		param02 = prop.getParam02();
		interactions = prop.getInteractions();
		
		if (type.equals("door")) {	// hypothèse dans laquelle le prop est une porte
			if (state) {	// hypothèse dans laquelle la porte est ouverte
				msj = "open";
				info = true;
				
				if (player.getCurrentScene().equals(param01)) {	// si la porte est ouverte, il bascule sur le lecteur de scène, à moins que le suivant ne soit le dernier
					if (param02.equals(param01)) {	// cas particulier où la porte est ouverte mais ne peut être franchie
						info = false;
					} else {
						if (param02.equals("final")) {	// si la scène suivante est la dernière, le jeu ne continue pas
							nextScene = false;
						}
						player.setCurrentScene(param02);
					}
				} else if (player.getCurrentScene().equals(param02)) {
					if (param01.equals(param02)) {	// cas particulier où la porte est ouverte mais ne peut être franchie
						info = false;
					} else {
						if (param01.equals("final")) {	// si la scène suivante est la dernière, le jeu ne continue pas
							nextScene = false;
						}
						player.setCurrentScene(param01);
					}
				}
			} else {	// hypothèse dans laquelle la porte est fermée
				msj = "closed";
				info = false;
			}
			
			for (int i=0; i<interactions.size(); i++) {	// le msg est recherché parmi les actions de la porte et le vrai msg est pris
				if (interactions.get(i).getVariable().equals(msj)) {
					msj = interactions.get(i).getDescription();
					break;
				}
			}
		} else if (type.equals("box")) {	// hypothèse dans laquelle l'accessoire est une boîte
			prop = world.getProp(param02);	// prendre l'accessoire à changer (porte à déverrouiller)
			
			if (prop != null) {
				prop.openProp();	// le prop est ouvert en changeant son état en vrai
			}
			
			msj = interactions.get(0).getDescription();	// il prend le msg de la boîte
			info = false;
		}
		
		System.out.println(msj);
		
		if (nextScene) {
			startGame(info);
		} else {
			System.out.print(world.getScene(player.getCurrentScene()).getDescription());
		}
	}

	/**
	 * Méthode qui lit par console les commandes saisies par l'utilisateur.
	 * @param options (limite supérieure du nombre d'options au choix)
	 * @return (renvoie un entier avec l'option choisie par l'utilisateur)
	 */
	private static int readInput(int options) {
		@SuppressWarnings("ressource")
		java.util.Scanner in = new java.util.Scanner(System.in);
		int input;
		
		System.out.print("> ");
		
		try {
			input = in.nextInt();
			if (input < 0 || input >= options) throw new java.util.InputMismatchException();
			return input;
		} catch (java.util.InputMismatchException e) {	// une exception se produit si la valeur saisie n'est pas un entier ou n'est pas une valeur valide
			System.out.println("Erreur : un numéro valide doit être saisi");
			return readInput(options);
		}
	}
}