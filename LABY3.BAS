10 CLEAR:DEFINT A-Z:SCREEN 1:OPTION BASE 1:DIM CF(9),G(2000):CLS:EN = 150
20 LOCATE 5,10:PRINT "Le Labyrinthe infernal":PRINT:PRINT "de Darche Yoann"
25 PRINT:PRINT "Directions (2)(8)(6)(4) (P)rendre (ESC)ape "
27 PRINT:PRINT "Veuillez patienter, Preparation du jeu ... "
30 RESTORE:READ XME,YME,X,Y,XM,YM:DIM P(XME,YME,3)
40 FOR J=1 TO YME:FOR I=1 TO XME:READ C$:K=1:P(I,J,2)=0:VA=VAL(C$)
50 IF VA=0 AND C$<>"0" THEN C$=MID$(C$,2,2):P(I,J,2)=1:READ F$:P(I,J,3)=VAL(F$)
60 IF VA<0 THEN K=-1: P(I,J,2)=2:READ F$:P(I,J,3)=VAL(F$)
70 P(I,J,1)=VAL(C$)*K:NEXT I:NEXT J:X2=XM:Y2=YM
99 REM =================================== Programme Principal ===============
100 XM=X2:YM=Y2:B=P(X,Y,1):GOSUB 3000:CLS:EN=EN-1:FL=0:TP=0
101 LOCATE 25,1:PRINT "Pts d'endurance :";EN;
110 IF B=17 THEN GOTO 5000
120 IF B>=12 AND B<=16 THEN IM=8:FLAG=1 ELSE FLAG=0
130 ON IM GOSUB 4010,4090,4160,4220,4290,4370,4450,4530
135 IF EN<=0 THEN LOCATE 12,15:PRINT "Vous avez Perdu !!!!":GOTO 5010
140 FL=0:ON P(X,Y,2)+1 GOTO 150,1000,1500
150 T$=INPUT$(1):IF T$=CHR$(27) THEN 5010
160 IF (T$="p" OR T$="P") AND FL=1 THEN 1600
170 IF T$<>"2" AND TP=1 THEN BEEP:LOCATE 25,1:PRINT "- Porte fermee !";:GOTO 150
180 IF T$="2" THEN SWAP X,X2:SWAP Y,Y2:GOTO 100
190 IF FLAG=1 THEN 300 ELSE X2=X:Y2=Y:GOTO 2010
300 LOCATE 25,1:PRINT "Non ! Seulement ";MES$;" <ESC> ";:BEEP:GOTO 150
999 REM =========================== GRAPHIQUES SUPLEMENTAIRE (Coffre,Grille) ==
1000 LINE (40,28)-(280,172),3,B:GET (141,65)-(199,172),G:TP=0
1010 FOR Q=40 TO 280 STEP 20:LINE (Q,28)-(Q,172),3:NEXT
1020 FOR Q=28 TO 172 STEP 18:LINE (40,Q)-(280,Q),3:NEXT:CF=CF(P(X,Y,3))
1030 IF CF=0 THEN TP=1:LINE (141,65)-(199,172),3,BF ELSE PUT(141,65),G,PSET
1040 GOTO 150 '==================== (Coffre )==================================
1500 LINE (160,180)-(120,160),,B:LINE -(140,140):LINE -(180,140):LINE -(160,160)
1510 LINE (130,150)-(170,150):LINE -(170,170):LINE -(160,180):FL=1:GOTO 150
1600 IF P(X,Y,3)>0 THEN LOCATE 25,1:PRINT "vous trouvez une cle";:CF(P(X,Y,3))=1
1610 IF P(X,Y,3)>0 THEN P(X,Y,2)=0:GOTO 150 '========= (TESTE PRISE d'obj.) ===
1620 V=RND(1)*100:IF V/2=INT(V/2) THEN N=1:N$="donne" ELSE N=-1:N$="retire"
1630 LOCATE 25,1:PRINT "La fiole avalee vous ";N$;" 10 pts";:EN=EN+10*N:GOTO 150
2000 ' ==================== calcule de deplacement ===========================
2010 IF T$<>"8" THEN GOTO 2090 ' ::::: T$="8" tout droit ::::::::::::::::::::
2020 IF (X>XM) AND ( B=7 OR B=8 OR B=9)          THEN X=X+1:GOTO 100
2030 IF (X<XM) AND ( B=1 OR B=7 OR B=8 OR B=9)   THEN X=X-1:GOTO 100
2040 IF (Y>YM) AND ( B=7 OR B=10 OR B=11 OR B=2) THEN Y=Y+1:GOTO 100
2050 IF (Y>YM) AND ( B=2 )                       THEN Y=Y+1:GOTO 100
2060 IF (Y<YM) AND ( B=2 OR B=7 OR B=10 OR B=11) THEN Y=Y-1:GOTO 100
2070 IF (X>XM) AND ( B=1 )                       THEN X=X+1:GOTO 100
2080 GOTO 300
2090 IF T$<>"6" THEN GOTO 2190 ': T$="6" ( A droite ) :::::::::::::::::::::::
2100 IF (X=XM) AND ( B=3 OR B=8 )                THEN X=X+1:GOTO 100
2110 IF (Y<YM) AND ( B=7 OR B=10)                THEN X=X+1:GOTO 100
2120 IF (X=XM) AND ( B=5 OR B=9 )                THEN X=X-1:GOTO 100
2130 IF (Y>YM) AND ( B=7 OR B=11)                THEN X=X-1:GOTO 100
2140 IF (X>XM) AND ( B=6 OR B=7 OR B=8 )         THEN Y=Y+1:GOTO 100
2150 IF (Y=YM) AND ( B=11 )                      THEN Y=Y+1:GOTO 100
2160 IF (X<XM) AND ( B=4 OR B=7 OR B=9 )         THEN Y=Y-1:GOTO 100
2170 IF (Y=YM) AND ( B=10 )                      THEN Y=Y-1:GOTO 100
2180 GOTO 300
2190 IF T$<>"4" THEN GOTO 300 ':: T$="4" ( A gauche ) ::::::::::::::::::::
2200 IF (X=XM) AND ( B=4 OR B=9 )                THEN X=X+1:GOTO 100
2210 IF (Y>YM) AND ( B=7 OR B=10)                THEN X=X+1:GOTO 100
2220 IF (X=XM) AND ( B=6 OR B=8 )                THEN X=X-1:GOTO 100
2230 IF (Y<YM) AND ( B=7 OR B=11)                THEN X=X-1:GOTO 100
2240 IF (X<XM) AND ( B=3 OR B=7 OR B=8)          THEN Y=Y+1:GOTO 100
2250 IF (X>XM) AND ( B=5 OR B=7 OR B=9)          THEN Y=Y-1:GOTO 100
2260 IF (Y=YM) AND ( B=11 )                      THEN Y=Y-1:GOTO 100
2270 IF (Y=YM) AND ( B=10 )                      THEN Y=Y+1:GOTO 100
2280 GOTO 300  '::::::::::::::::::::::::::::::: Calcule image ::::::::::::::::
3000 IF B=1 OR B=2                                            THEN IM=1:RETURN
3010 IF X=XM AND (B=3 OR B=5) OR X<XM AND B=4 OR X>XM AND B=6 THEN IM=2:RETURN
3020 IF X=XM AND (B=4 OR B=6) OR X<XM AND B=3 OR X>XM AND B=5 THEN IM=3:RETURN
3030 IF B=7                                                   THEN IM=7:RETURN
3040 IF (X>XM AND B=8) OR (X<XM AND B=9) OR (Y<YM AND B=10)   THEN IM=5:RETURN
3045 IF (Y>YM AND B=11)                                       THEN IM=5:RETURN
3050 IF (X>XM AND B=9) OR (X<XM AND B=8) OR (Y<YM AND B=11)   THEN IM=6:RETURN
3055 IF (Y>YM AND B=10)                                       THEN IM=6:RETURN
3060 IF (X=XM AND (B=8 OR B=9)) OR (Y=YM AND (B=10 OR B=11))  THEN IM=4:RETURN
3070 RETURN ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
4010 LOCATE 1,1:PRINT " C'EST UNE SIMPLE ALLEE ":MES$=" (8) ou (2) "
4020 LINE  (110,70)-(10,10),1:LINE -(310,190),1,B:LINE -(210,130),1
4050 LINE  (310,10)-(210,70),1:LINE -(110,130),1,B:LINE -(10,190),1:RETURN '---
4090 LOCATE 1,1:PRINT "  C'est un virage droit ";:MES$=" (6) ou (2) "
4100 LINE (10,10)-(310,190),1,B:LINE (110,70)-(250,130),2,BF
4120 LINE (310,10)-(250,46),1:LINE -(250,154),1:LINE -(310,190),1
4130 LINE (10,10)-(110,70),1:LINE (110,130)-(10,190),1:RETURN '----------------
4160 LOCATE 1,1:PRINT "  C'est un virage Gauche ";:MES$=" (4) ou (2) "
4170 LINE (10,10)-(310,190),1,B:LINE (70,70)-(210,130),2,BF
4190 LINE -(310,190),1:LINE (210,70)-(310,10),1
4200 LINE (10,190)-(70,154),1:LINE -(70,46),1:LINE -(10,10),1:RETURN '---------
4220 LOCATE 1,1:PRINT "   c'est un T  ";:MES$=" (4) (2) (6) "
4230 LINE (10,10)-(310,190),1,B
4240 LINE -(230,150),1:LINE -(230,50),1:LINE -(310,10),1
4250 LINE (10,10)-(90,50),1:LINE -(90,150),1:LINE -(10,190),1
4270 LINE (90,140)-(230,60),2,BF:RETURN '--------------------------------------
4290 LOCATE 1,1:PRINT "vous pouvez aller tout droit ou a droite";
4300 LINE (10,10)-(310,190),1,B:MES$=" (8) (6) (2) "
4310 LINE -(280,172),1:LINE -(280,28),1: LINE -(310,10),1
4320 LINE (10,10)-(110,70),1:LINE -(210,130),1,B: LINE -(250,154),1
4330 LINE -(250,46),1:LINE -(210,70),1:LINE (110,130)-(10,190),1
4350 LINE (250,46)-(280,154),2,BF:RETURN '------------------------------------
4370 LOCATE 1,1:PRINT "vous pouvez aller tout droit ou a gauche";
4380 LINE (310,190)-(10,10),1,B:MES$=" (8) (4) (2) "
4390 LINE -(40,28),1:LINE -(40,172),1:LINE -(10,190),1
4400 LINE (310,190)-(210,130),1:LINE -(110,70),1,B
4410 LINE -(70,46),1:LINE -(70,154),1:LINE -(110,130),1
4420 LINE (40,46)-(70,154),2,BF:LINE (210,70)-(310,10),1:RETURN '-------------
4450 LOCATE 1,1:PRINT "C'est une intersection + ";:MES$=" (2) (8) (4) (6) "
4460 LINE (10,10)-(310,190),1,B:LINE (110,70)-(210,130),1,B
4470 LINE (40,46)-(70,154),2,BF:LINE (250,46)-(280,154),2,BF
4480 LINE (310,10)-(280,28),1:LINE -(280,172),1:LINE -(310,190),1
4490 LINE (10,10)-(40,28),1:LINE -(40,172),1:LINE -(10,190),1
4500 LINE (110,70)-(70,46),1:LINE (70,154)-(110,130),1
4510 LINE (210,70)-(250,46),1:LINE (250,154)-(210,130),1:RETURN '===============
4530 LOCATE 1,1:PRINT " C'EST UN CUL DE SAC ":MES$=" (2) "
4540 LINE  (110,70)-(10,10),1:LINE -(310,190),1,B:LINE -(210,130),1
4570 LINE  (310,10)-(210,70),1:LINE -(110,130),2,BF:LINE -(10,190),1:RETURN '::
5000 CLS:LOCATE 12,15:PRINT " Vous avez reussit ....."
5010 LOCATE 21,15:PRINT "Encore O/N":FOR I=1 TO 10:A$=INKEY$:NEXT I:A$=INPUT$(1)
5020 IF A$="o" OR A$="O" THEN 10 ELSE SCREEN 2:SCREEN 0:END
6000 DATA 14,11,4,1,4,2
6010 DATA 3,P1,1,17,16,-15,2,8,-12,3,3,-1,0,1,-1,6,P1,8,8,6
6020 DATA 10,8,6,-2,0,3,7,1,9,1,6,3,6,4,11
6030 DATA 2,p2,3,p2,2,4,11,10,1,1,6,2,2,10,8,11
6040 DATA 2,2,10,-12,7,4,5,-15,4,6,2,2,p2,6,2,14,2
6050 DATA 10,11,4,1,1,6,3,9,11,4,-5,8,10,-1,1,11
6060 DATA 2,4,1,6,3,9,9,6,10,8,p1,7,5,3,11
6070 DATA p2,4,3,6,2,4,1,6,4,11,p2,9,3,1,11,2
6080 DATA 4,5,4,7,1,1,9,p1,2,11,2,2,-15,9,11,-2,0
6090 DATA 3,1,1,9,8,6,3,p1,5,11,2,4,8,11,2
6100 DATA 4,-1,0,8,1,5,10,5,-15,5,11,4,1,7,5,2
6110 DATA 15,1,9,1,-1,0,9,1,p1,5,9,1,-1,0,9,1,5
