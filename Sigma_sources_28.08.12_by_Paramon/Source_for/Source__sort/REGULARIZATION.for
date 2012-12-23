C ���� REGULARIZATION.for
C �������� ������������ REGULARIZATION
C ===================================================================
C REGULARIZATION - ��������� ����������� �������� ��������� �� �����
C ���������� �� GRIDDM,
C �������� ������ FINDNODD, GET_STAR, FIND_MIN_ANG
C ===================================================================
C  ������� ���������:
C    NRC  - �������� ���������
C    INRG - ����� ���
C    NOPR - ������ ������� �����, ����-��� ��������
C    NROWS - ����� ����� ����� � ���� ( ����� NRC)
C    NCOL - ����� �������� ����� � ���� ( ����� NRC)
C    CORDDR  - ������ ��������� �����
C    INOUTR - ������ ��������� ����� (���� ��������� ��� ����������)
C    NP - ����� �����
C    NUMOFEL - ����� ���������
C  �������� ��������� �����������
C =================================================================
C ================ ������ ���� REGULARIZATION ======================

      subroutine REGULARIZATION(NRC,INRG,NOPR,NROWS,NCOL,
     > CORDDR,INOUTR,NP,NUMOFEL,IPR)
      DIMENSION NOPR(1),CORDDR(1),INOUTR(NP),ISTAR(100),CDNT(6),
     > EX(4),EY(4), CORDDR_NO_OPT(6000),NOTMOVE(6000)
      INTEGER NOUTPNT,IND,NSTEL,L,MAXL,K,INDSTAR,
     > JNDSTAR,KTIMES,MAXTIMES
      REAL MINANG,NEWMINANG,MINSIDE,NEWMINSIDE,CURMINANG,CURMINSIDE,
     > STEP,COORX,COORY,MAXDELTA,CURDELTA,MANG,MODMANG,
     > NEWMODMANG
         INTEGER I,MM,J,NOTMOVE
* NOTMOVE - ������ ��� �������� ������� �����, ������� ����� �� ������� ����������
* J - ����������� ��������� � ������� NOTMOVE
       LOGICAL*1 IPR(50)
      REAL X1,Y1
      DATA EX/1,0,-1,0/,EY/0,1,0,-1/,MAXL/3/
      DATA KTIMES/0/,MAXTIMES/100/

      NOUTPNT=(3*NRC-4)*INRG+NRC-(INRG-1)*NRC

C =================================================================
c      �������� 21.12.2006
c      �������� ������ ��������� ��� ������������ ���������
         do i=1,np
            CORDDR_NO_OPT(2*(i-1)+1) = CORDDR(2*(i-1)+1)
            CORDDR_NO_OPT(2*(i-1)+2) = CORDDR(2*(i-1)+2)
         enddo
C =============================================================
c       ����� ��������� ������ �����, ������� �� ������� ������� ��
C =============================================================
       IF(IPR(26))WRITE(6,601)
601    FORMAT(/,20X,'*****Start FINDNODD in REGULARIZATION'
     > ' in GRIDDM',/,
     > 20X,'(����� �����, ������� �� ������� ������� ��)')     
       CALL FINDNODD(INOUTR,NP,CORDDR)
       IF(IPR(26)) WRITE(6,602)
602    FORMAT(20X,'*****Finish FINDNODD in REGULARIZATION'
     > ' in GRIDDM',/)
      IF(IPR(15)) WRITE(6,*) ' nomer prohoda;','  max izm ugla;', 
     > ' naim- ugol iz;',' naim-y izm ug;'
* -- ����� �������� ��������� �����������
 71    KTIMES= KTIMES+1
         MANG=1.0472
         MODMANG=1.0472
         NEWMODMANG=1.0472
         MAXDELTA=0.0
* -- ���� �� �����
       DO 61 IND=1,NP

* ���� ������� ���� �� ����������� ������� ������� � �� ��������� � �����,
* ������� ����� �� ������� ����������      
*       IF ((INOUTR(IND).EQ.0).AND.(NTM(IND,NOTMOVE,J).EQ.0)) THEN

*       PRINT*, "�������� � ����� ====== ",IND,"---",NTM(IND,NOTMOVE,J)
* -- ����������� �� ���� ������� �������
       IF(INOUTR(IND).EQ.0)THEN
C ==============================================================
C -- ���������� ������, �����-� ������� ����
C =================================================================

        CALL GET_STAR(IND,NOPR,NUMOFEL,ISTAR,NSTEL)

*        WRITE(6,*) NSTEL,(((ISTAR(3*(I-1)+J)),J=1,3),I=1,NSTEL)
* 18     FORMAT(I,6(/3I4))

* -- ����� ����� ������� ��������� ����
* ���������� ���. ���� ��� �������� ����-���
* ������� ��-��� ������
         MINANG=1.0472
        DO 62 INDSTAR=1,NSTEL
* ������� ����� �������� ��-��
         DO 63 JNDSTAR=1,3
* ���-��� ����-� ����� ���. ��-�� ��� ������. ���. ����
          CDNT(2*(JNDSTAR-1)+1)=
     >    CORDDR(2*(ISTAR(3*(INDSTAR-1)+JNDSTAR)-1)+1)
          CDNT(2*(JNDSTAR-1)+2)=
     >    CORDDR(2*(ISTAR(3*(INDSTAR-1)+JNDSTAR)-1)+2)
*         WRITE(6,*) CDNT(2*(JNDSTAR-1)+1),CDNT(2*(JNDSTAR-1)+2),IND
 63     ENDDO
C ==============================================================
*     ����������� ���. ���� � ��-��
C =================================================================
         CALL FIND_MIN_ANG(CDNT,CURMINANG,CURMINSIDE)
*         WRITE(6,69) INDSTAR,IND,CURMINANG/3.141592*180,CURMINSIDE
 69   FORMAT(' EL',I3,'  ND',I3,'  ANG',F12.6,'  MSD',F12.6)
* ����������� ������������ ���� ������
*          WRITE(6,*)MINANG,CURMINANG,MINANG/CURMINANG
         IF((MINANG/CURMINANG).GT.1.001) THEN
          MINANG=CURMINANG
          MINSIDE=CURMINSIDE
         ENDIF

 62      ENDDO
*         WRITE(6,69) IND,IND,MINANG/3.141592*180,MINSIDE

C < ������������ ����������� ��������� ����
        STEP=MINSIDE/3
        DO 64 L=1,MAXL
         STEP=STEP/2
* 68     WRITE(6,*) 'STEP',STEP
  68     DO  65 K=1,4
          COORX=CORDDR(2*(IND-1)+1)+STEP*EX(K)
          COORY=CORDDR(2*(IND-1)+2)+STEP*EY(K)
*         WRITE(6,*) COORX,COORY

* ���������� ������������ ������ ���� ��� ����� ��������� ����
          NEWMINANG=1.0472
          DO 66 INDSTAR=1,NSTEL
* ������� ����� �������� ��-��
           DO 67 JNDSTAR=1,3
* ���-��� ����-� ����� ���. ��-�� ��� ������. ���. ����
* ���� ��� �������������� ����, ������� ����� ����������
            IF(ISTAR(3*(INDSTAR-1)+JNDSTAR).EQ.IND)THEN
             CDNT(2*(JNDSTAR-1)+1)=COORX
             CDNT(2*(JNDSTAR-1)+2)=COORY
            ELSE             
             CDNT(2*(JNDSTAR-1)+1)=
     >       CORDDR(2*(ISTAR(3*(INDSTAR-1)+JNDSTAR)-1)+1)
             CDNT(2*(JNDSTAR-1)+2)=
     >       CORDDR(2*(ISTAR(3*(INDSTAR-1)+JNDSTAR)-1)+2)
            ENDIF
 67        ENDDO
C ==============================================================
C < ���������� ���. ���� � ������� ���. ��-�� ������
C =================================================================
           CALL FIND_MIN_ANG(CDNT,CURMINANG,CURMINSIDE)
*         WRITE(6,70) INDSTAR,IND,CURMINANG/3.141592*180,CURMINSIDE
 70   FORMAT(' K',I3,'  ND',I3,'  ANG',F12.6,'  MSD',F12.6)
* FORMAT(' COORY',F12.6,'  COORY',F12.6,'  ANG',F12.6,'  MSD',F12.6)
*          WRITE(6,*)NEWMINANG,CURMINANG,NEWMINANG/CURMINANG

* ����������� ������������ ���� ������
           IF((NEWMINANG/CURMINANG).GT.1.001) THEN
             NEWMINANG=CURMINANG
             NEWMINSIDE=CURMINSIDE
           ENDIF
 66       ENDDO
*         WRITE(6,70) K,IND,NEWMINANG/3.141592*180,NEWMINSIDE
* ����������� ������������ ���� �� ����
* ����� ���� ��� ��������
          IF(MINANG.LE.MANG)THEN
           MANG=MINANG
          ENDIF

* ��������, ����� �� ���. ����. ����, �.�. ���������� �� ���. ����
          IF(NEWMINANG/MINANG.GT.1.001)THEN
           CURDELTA=NEWMINANG-MINANG
           IF(CURDELTA.GT.MAXDELTA)THEN
            MAXDELTA=CURDELTA
           ENDIF
* ����������� ������������ ����������� ���� �� ����
* ����� ���� ��� ��������
           IF(MODMANG.GE.MINANG) MODMANG=MINANG
           IF(NEWMODMANG.GE.NEWMINANG) NEWMODMANG=NEWMINANG
           CORDDR(2*(IND-1)+1)=COORX
           CORDDR(2*(IND-1)+2)=COORY
           MINANG=NEWMINANG
           GO TO 68
          ENDIF
*         WRITE(6,*) '            ---------------------------         ' 
 65      ENDDO
 64     ENDDO
       ENDIF
 61   ENDDO
      IF(IPR(15)) WRITE (6,72) KTIMES,MAXDELTA/3.141592*180,
     >MANG/3.141592*180, MODMANG/3.141592*180
  72  FORMAT(10X,I3,3(5X,F10.6))
C ==============================================================
c      �������� 21.12.2006
C       IF(MAXDELTA.GT.(0.0).AND.KTIMES.LT.MAXTIMES) GO TO 71
       IF(MAXDELTA.GT.(0.001).AND.KTIMES.LT.MAXTIMES) GO TO 71
c      �������� ���������� ����������� �� �����
C ==============================================================
      IF(IPR(15)) write (6,*) 
      IF(IPR(15)) write (6,*) '---- ���������� ����������� ----'
      IF(IPR(15)) write (6,*) 
      IF(IPR(15)) write (6,800)
       do i=1,np
      IF(IPR(15))write (6,801) i,CORDDR(2*(i-1)+1),
     >      CORDDR_NO_OPT(2*(i-1)+1),
     >      Abs(CORDDR(2*(i-1)+1)-CORDDR_NO_OPT(2*(i-1)+1)),
     >      CORDDR(2*(i-1)+2),CORDDR_NO_OPT(2*(i-1)+2),
     >      Abs(CORDDR(2*(i-1)+2)-CORDDR_NO_OPT(2*(i-1)+2))
       enddo
 800   format (4x,'N ���.   X_opt   ','X_no_opt  ','|Delta_X|  ',
     >            'Y_opt     ','Y_no_opt  ','|Delta_Y|  ')   
 801   format (4x,i4,3x,f7.2,3x,f7.2,3x,f7.4,3x,f7.2,3x,f7.2,3x,f7.4)   
c     -------------------------------------

C > ���������� ������, �����-� ������� ���� -- END
      END
C / END REGULARIZATION /
C =================================================================
C ============== ����� ���� REGULARIZATION =========================
C =================================================================
C  ����� �����  REGULARIZATION.for