-- Representation d'un code binaire, suite de bits 0 ou 1.
-- D'autres operations peuvent etre ajoutees si necessaire, et 
-- toutes ne vous seront pas forcement utiles...

package body code is

	Code_Vide, Code_Trop_Court : exception;

	-- Representation de bits
	subtype Bit is Natural range 0 .. 1;
	ZERO : constant Bit := 0;
	UN   : constant Bit := 1;

	type Cellule is record
		Val: Bit;
		Suiv: Code;
	end record;

	type Code_Binaire is private;

	-- Procedure de liberation d'une Cellule (accedee par un Code)
	procedure Liberer is new Ada.Unchecked_Deallocation (Cellule, Code);

	-- Cree un code initialement vide
	function Cree_Code return Code_Binaire is
	begin
		return null;
	end Cree_Code		

	-- Copie un code existant
	function Cree_Code(C : in Code_Binaire) return Code_Binaire is
	Cc:Code_Binaire;
	pC:Code_Binaire;
	begin
	Cc := Cree_Code;
	pC := C;
	if (pC /= null)then
		while( pC.Suiv /= null )loop
			Ajoute_Apres(pC.all.Val,Cc);
			pC := pC.all.Suiv
		end loop;
		Ajoute_Apres(pc.all.Val,Cc);
	else
		raise CONSTRAINT_ERROR;
	end if;

	exception
		when CONSTRAINT_ERROR => Put("Le Code à Copier est vide"); New_Line;

	end Cree_Code;

			
		

	-- Libere un code
	procedure Libere_Code(C : in out Code_Binaire) is
	pC:Code_binaire;
	begin
	pC :=C;
	if pC /= null then 
		while pC.all.Suiv /= null loop 
			C := C.all.Suiv;
			Liberer(pC);
			pC := C;
		end loop;
		Liberer(pC);
	end if;
	end Libere_Code;
	

	-- Retourne le nb de bits d'un code
	function Longueur(C : in Code_Binaire) return Natural is
	N : Integer;
	pC:Code_binaire;
	begin
	N:=0;
	pC:=C;
	if(pC /= null) then
		N:=1;
		while (pC.all.Suiv /= null) loop
			pC := pC.all.Suiv;
			N := N+1;
		end loop;
	end if;
	return N;
	end Longueur;



	-- Affiche un code
	procedure Affiche(C : in Code_Binaire) is
	pC:Code_binaire;
	begin
	pC:=C;
	if pC /= null then
		Put(Integer'Image(pC.all.Val));
		while pC.all.Suiv /= null loop
			Put(Integer'Image(pC.all.Suiv.all.Val));
			pC:=pC.all.Suiv;
		end loop;
	end if;
	end Affiche;
	

	-- Ajoute le bit B en tete du code C
	procedure Ajoute_Avant(B : in Bit; C : in out Code_Binaire) is 
	begin
		C:= new Cellule'( B, C) ;
	end Ajout_Avant;

	-- Ajoute le bit B en queue du code C
	procedure Ajoute_Apres(B : in Bit; C : in out Code_Binaire);

	-- ajoute les bits de C1 apres ceux de C
	procedure Ajoute_Apres(C1 : in Code_Binaire; C : in out Code_Binaire);


------------------------------------------------------------------------
--   PARCOURS D'UN CODE VIA UN "ITERATEUR"
--   Permet un parcours sequentiel du premier au dernier bit d'un code
--
--   Meme modele d'utilisation qu'en Java, C++, ... :
--	It : Iterateur_Code;
--	B : Bit;    
--	...
--	It := Cree_Iterateur(Code);
--	while Has_Next(It) loop
--		B := Next(It);
--		...	-- Traiter B
--	end loop;
------------------------------------------------------------------------

	Code_Entierement_Parcouru : exception;

	type Iterateur_Code is private;

	-- Cree un iterateur initialise sur le premier bit du code
	function Cree_Iterateur(C : Code_Binaire) return Iterateur_Code;

	-- Libere un iterateur (pas le code parcouru!)
	procedure Libere_Iterateur(It : in out Iterateur_Code);

	-- Retourne True s'il reste des bits dans l'iteration
	function Has_Next(It : Iterateur_Code) return Boolean;

	-- Retourne le prochain bit et avance dans l'iteration
	-- Leve l'exception Code_Entierement_Parcouru si Has_Next(It) = False
	function Next(It : Iterateur_Code) return Bit;


private

	-- type prive: a definir dans le body du package, code.adb
	type Code_Binaire_Interne;

	type Code_Binaire is access Code_Binaire_Interne;

	-- type prive: a definir dans le body du package, code.adb
	type Iterateur_Code_Interne;

	type Iterateur_Code is access Iterateur_Code_Interne;

end code;
