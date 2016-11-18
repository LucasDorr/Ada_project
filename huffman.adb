with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;
with dico; use dico;
with Code; use Code;

-- paquetage representant un arbre de Huffman de caracteres

package body Huffman is

	--Definition du type Noeud
	type Noeud is record
		Val : Element;
		Fg, Fd : Arbre;
	end record;

	procedure Libere_Noeud is new Ada.Unchecked_Deallocation (Noeud, Arbre);

	-- Libere l'arbre de racine A.
	-- garantit: en sortie toute la memoire a ete libere, et A = null.
	procedure Libere(H : in out Arbre_Huffman) is
	begin
	if(H/=NULL) then 
		Libere_Noeud(H.Fg);
		Libere_Noeud(H.Fd);
		Libere_Noeud(H);		
	end if;
	end Libere;

	procedure Affiche(H : in Arbre_Huffman)
	begin
	if(H/=NULL) then 
		Affiche(H.Fg);
		Put(" ");
		Put(H.Val);
		Put(" ");
		Affiche(H.Fd);
	end if;
	end Affiche;
	

	-- Cree un arbre de Huffman a partir d'un fichier texte
	-- Cette function lit le fichier et compte le nb d'occurences des
	-- differents caracteres presents, puis genere l'arbre correspondant
	-- et le retourne.
	function Cree_Huffman(Nom_Fichier : in String) return Arbre_Huffman is
	H : Arbre_Huffman;
	B :Arbre_Huffman;
	Fichier : Ada.Streams.Stream_IO.File_Type;
	Flux : Ada.Streams.Stream_IO.Stream_Access;
	C : Character;
	F_Prio : File_Prio;
	A_1 ,A_2, Arbre_Courant : Arbre_Huffman;
	Prio_1 , Prio_2, Prio_Courant: Priorite;
	
	begin
	-- Initialise la file de prio
	F_Prio := Cree_File(30);

	--Ouverture du fichier dans le Flux

	Open(Fichier, In_File, Nom_Fichier);
	Flux := Stream(Fichier);

	-- Lecture du fichier caractère par caractère

	while not End_Of_File(Fichier) loop
		C := Character'Input(Flux);
		-- On rajoute le caractère à la file de priorité		
		Insere(F_Prio,C,1);
		
	end loop;
	Close(Fichier);

	-- Construction de l'arbre d'Huffman
	-- Parcourt de la file de priorite et on garde les 2 éléments qui ont la plus petite priotite : dans A_1 = plus petite priorite et dans A_2 la 2eme plus petite priorite
	-- On crée l'arbre constitué de ces 2 elements et on ajoute l'arbre à la file de priorite avec une priorite qui est egale à la somme des 2 priorite précédentes
	-- On recommence tant que la file de priorité n'est pas constitué que de 1 element
	
	--tant que 2 éléments sont présents dans la file de priorite on continue
	while(F_Prio.Suiv.Suiv /=null) loop
		-- N_1 et N_2 contiennent les 2 elements de priorite maximale et Prio_1 et Prio_2 contiennent leur priorites respectives
		Supprime(F_Prio,N_1,Prio_1);
		Supprime(F_Prio,N_2,Prio_2);
		B := new Noeud;
		B.val := null;
		B.Fg := N_1;
		B.Fd := N_2;
		Insere_Tete(F_Prio,B,Prio_1+Prio_2);
		
	end loop;
	-- On crée un arbre avec les 2 éléments restants
	H := new Noeud;
	Supprime(F_Prio,N_1,Prio_1);
	Supprime(F_Prio,N_2,Prio_2);
	H.val := null;
	H.Fg := N_1;
	H.Fd := N_2;
	return H;
	end Cree_Huffman;

	-- Stocke un arbre dans un flux ouvert en ecriture
	-- Le format de stockage est celui decrit dans le sujet
	-- Retourne le nb d'octets ecrits dans le flux (pour les stats)
	function Ecrit_Huffman(H : in Arbre_Huffman;
	                        Flux : Ada.Streams.Stream_IO.Stream_Access)
		return Positive;

	-- Lit un arbre stocke dans un flux ouvert en lecture
	-- Le format de stockage est celui decrit dans le sujet
	function Lit_Huffman(Flux : Ada.Streams.Stream_IO.Stream_Access)
		return Arbre_Huffman;


	-- Retourne un dictionnaire contenant les caracteres presents
	-- dans l'arbre et leur code binaire (evite les parcours multiples)
	-- de l'arbre
	function Genere_Dictionnaire(H : in Arbre_Huffman) return Dico_Caracteres;



------ Parcours de l'arbre (decodage)

-- Parcours a l'aide d'un iterateur sur un code, en partant du noeud A
--  * Si un caractere a ete trouve il est retourne dans Caractere et
--    Caractere_Trouve vaut True. Le code n'a eventuellement pas ete
--    totalement parcouru. A est une feuille.
--  * Si l'iteration est terminee (plus de bits a parcourir ds le code)
--    mais que le parcours s'est arrete avant une feuille, alors
--    Caractere_Trouve vaut False, Caractere est indetermine
--    et A est le dernier noeud atteint.
	procedure Get_Caractere(It_Code : in Iterateur_Code; A : in out Arbre;
				Caractere_Trouve : out Boolean;
				Caractere : out Character);


private

	-- type Noeud prive: a definir dans le body du package, huffman.adb
	type Noeud;

	type Arbre is Access Noeud;

end Huffman;

