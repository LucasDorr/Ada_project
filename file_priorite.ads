-- paquetage generique de file de priorite 
-- Les priorites sont munies d'un ordre total "Est_Prioritaire"

generic
	-- le type representant une donnee de la file on prendra un noeud
	type Donnee is private;
	-- le type representant la priorite d'une donnee
	type Priorite is private;
	-- et l'operateur d'ordre sur ce type on prendra P1 > P2 alors P2 est prioritaire
	with function Est_Prioritaire(P1, P2: Priorite) return Boolean;

package File_Priorite is
	
	type File_Prio is private;

	File_Prio_Pleine, File_Prio_Vide: exception ;

	-- Cree et retourne une nouvelle file, initialement vide 
	-- et de capacite maximale Capacite
	function Cree_File(Capacite: Positive) return File_Prio;

	-- Libere une file de priorite.
	-- garantit: en sortie toute la memoire a ete libere, et F = null.
	procedure Libere_File(F : in out File_Prio);
	
	-- retourne True si la file est vide, False sinon
	function Est_Vide(F: in File_Prio) return Boolean;

	-- retourne True si la file est pleine, False sinon
	function Est_Pleine(F: in File_Prio) return Boolean;

	-- si not Est_Pleine(F)
	--   si la donnee D n'ets pas présente dans la file F
	--   insere la donnee D de priorite 1 dans la file F en allouant de la mémoire pour un Noeud en mettant FG et FD à Null
	--   sinon rajoute 1 à la priorité de D dans la file F
	-- sinon
	--   leve l'exception File_Pleine
	procedure Insere(F : in File_Prio; D : in Character; P : in Priorite);

	-- Insere un arbre en tete de la file
	procedure Insere_Tete(F : in File_Prio; A : in Arbre_Huffman ; P : in Priorite);

	-- si not Est_Vide(F)
	--   supprime la donnee la plus prioritaire de F.
	--   sortie: D est la donnee, P sa priorite
	-- sinon
	--   leve l'exception File_Vide
	procedure Supprime(F: in File_Prio; D: out Donnee; P: out Priorite);

	-- si not Est_Vide(F)
	--   retourne la donnee la plus prioritaire de F (sans la
	--   sortir de la file)
	--   sortie: D est la donnee, P sa priorite
	-- sinon
	--   leve l'exception File_Vide
	procedure Prochain(F: in File_Prio; D: out Donnee; P: out Priorite);
		
private
	-- Le type File_Interne doit etre defini dans le corps du package
	-- defini avec un Suiv et un Arbre_Huffman et une Priorite
	-- (file_priorite.adb)
	type File_Interne;
	type File_Prio is access File_Interne;
	
end File_Priorite;

