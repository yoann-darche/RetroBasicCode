' ***************************************************************************
' **        Routine supl�mentaire � appeller par un $INCLUDE "CREAPSUP.BAS"**
' **    Pour le programme Cr�apage.BAS ( Compilable par QB Ver 2.0 )       **
' ***************************************************************************


'---------------------------------------------------------------------------
'                      ** MODE d'EMPLOIE **
' Table de V�rit� en fonction des donn�es entrante :
' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
' ������������������������������������������������Ŀ
' �RC%��  F1%  �  F2%  �    RC%      �    NC%      �
' ������������������������������������������������͵    Sytaxe :
' � +  �   0   �   0   � Couleur CAR �   Novelle   �
' �    �       �       � Recherch�e  �   Couleur   � FILTRES(RC%,NC%,F1%,F2%)
' ������������������������������������������������Ĵ
' � +  �   0   �   1   � couleur CAR � Code du     �
' �    �       �       � RECHERCHE   � NOUVEAU CAR � En respectant ce tableau
' ������������������������������������������������Ĵ <-------
' � +  �   1   �   0   � code du CAR � Nouvelle    �   pour les diff�rents
' �    �       �       � Recherch�e  � Couleur     � filtres possibles
' ������������������������������������������������Ĵ
' � +  �   1   �   1   � code du CAR � Code du     � Par ailleur les valeurs :
' �    �       �       � Recherch�e  � Nouveau     �Couleurs en systeme POKE
' ������������������������������������������������ĴCaract�re en ASCII
' � -  �CDE CAR�NOUVEAU� Couleur CAR � Nouvelle    �
' �    �RECH.  �CDE CAR� Recherch�e  � Couleur     �
' ��������������������������������������������������
' RC%� = signe de RC%  +: Positif  -: N�gatif  attention 0 cod� 256 !!
' CAR = CARACTERE, CDE = CODE, RECH. = RECHERCHE
' Dans X1%,Y1%,X2%,Y2% d�finition de la fen�tre (Fa�on poke !!! )

SUB FILTRES(RC%,NC%,F1%,F2%,X1%,Y1%,X2%,Y2%) STATIC

PCOPY 0,3:' SAUVEGARDE d' �cran

STATIC F3%,X,Y,PO%,P1%,P2%,cr%,cpn%,cor%,con%
SHARED FI%,CI%,cn%,fn%

 IF (RC%)<0 then F3%=-1 Else F3%=0
 RC%=ABS(RC%):IF RC%=256 THEN RC%=0

IF F3%         Then CR%=F1%:CpN%=F2%:COR%=RC%:CON%=NC%:GOTO FLS
IF F1% AND F2% THEN CR%=RC%:CpN%=NC%:COR%= 2 :CON%= -1:GOTO FLS
IF F1%         THEN CR%=RC%:CpN%= -1:COR%= 1 :CON%=NC%:GOTO FLS
IF         F2% THEN CR%= 4 :CpN%=NC%:COR%=RC%:CON%= -1:GOTO FLS
		    CR%= 2 :CpN%= -1:COR%=RC%:CON%=NC%
FLS :

    FOR X=X1% TO X2%
       FOR Y=Y1% TO Y2%
	  A$=INKEY$
	  PO% = (X*2) + (Y*160)
	  WHILE A$=""
	       P1%=PEEK(PO%):P2%=PEEK(PO%+1)

	       IF (CR%=2)  AND (P2% =COR%) THEN P2%=CoN%:goto SUITEFL
	       IF (CR%=4)  AND (P2% =COR%) THEN P1%=CpN% :goto SUITEFL
	       IF (COR%=1) AND (CR% =P1% ) THEN P2%=CON%:goto SUITEFL
	       IF (COR%=2) AND (CR% =P1% ) THEN P1%=CpN% :goto SUITEFL
	       'IF (CR% = P1%)   AND (COR%=P1% ) THEN P1%=CpN%:P2%=CON%

	  SUITEFL :
	  POKE PO%,P1%:POKE PO%+1,P2%
       NEXT Y
    NEXT X:A$=" "
	  WEND

COLOR CI,FI:LOCATE 25,12:PRINT "Voulez-vous conserver la Transformation [O/N]";
A$=INPUT$(1)
IF A$="N" OR a$="n" THEN PCOPY 3,0
COLOR CN%,FN%
Locate 25,1:PRINT " Mode Tra�age <ENTER> pour valider, <F1>  options , Votre Trac� sera : ";:locate 1,1
pcopy 0,3
END SUB


