-- paquetage generique de file de priorite 
-- Les priorites sont munies d'un ordre total "Est_Prioritaire"


package body File_Priorite is
	

	type Cellule is record 
		D : Donnee;
		Prio : Priorite;
	end record;
	
	type File_Priorite is array (Integer range <>) of Cellule;

	File_Prio_Pleine, File_Prio_Vide: exception ;
	
	procedure Liberer_C is new Ada.Unchecked_Deallocation (Cellule,???);
	procedure Liberer_F is new Ada.Unchecked_Deallocation (File_Prio, ???);

	-- Cree et retourne une nouvelle file de priorite, initialement vide 
	-- et de capacite maximale Capacite
	function Cree_File(Capacite: Positive) return File_Prio is 
	File_Prio File_Priorite(1..Capacite) ;
	begin
	return File_Prio;
	end Cree_File;

	-- Libere une file de priorite.
	-- garantit: en sortie toute la memoire a ete libere, et F = null.
	procedure Libere_File(F : in out File_Prio)is 
	begin
	for I in File_Prio'Range loop
		Liberer_C(File_Prio(I));
		end loop;
	Liberer_F(File_Prio);
	end Libere_File;
	
	-- retourne True si la file est vide, False sinon
	function Est_Vide(F: in File_Prio) return Boolean is
	begin
	if (File_Prio(1) = null) then 
		return true;
	end if;
	return false;
	end Est_Vide;

	-- retourne True si la file est pleine, False sinon
	function Est_Pleine(F: in File_Prio) return Boolean is
	begin
	if(File_Prio(File_Prio'Last) = null ) then 
		return false;	
	end if;
	return true;
	end Est_Pleine;

	-- si not Est_Pleine(F)
	--   si la donnee D n'est pas présente dans la file F
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



	
end File_Priorite;

