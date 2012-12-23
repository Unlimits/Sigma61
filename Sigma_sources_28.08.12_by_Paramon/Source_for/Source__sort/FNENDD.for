C ���� FNENDD.for
C �������� ������������ FNENDD
C ===================================================================
C ������������ ������� ��������� �������� ����������������� �������, 
C �.�. ��������� ���������� ����� ��������.
C  MO������POBAHH�� FNENV C ��ETOM HECKO��K�X CTE�EHE� CBO�O�� B ���E  
C    ���������� ��  MAIN    ���������� ������� ���
C ===================================================================
C ================ ������ ���� FNENDD =================================
C ===================================================================
      subroutine FNENDD (NEQNS,NDF,XADJ,ADJNCY,PERM,INVP,XENV,ENVSZE,
     >                   BANDW)

      INTEGER ADJNCY(1),INVP(1),PERM(1),XADJ(1),XENV(1),BANDW,ENVSZE
      BANDW=0
      ENVSZE=1
      DO 200 I=1,NEQNS
         XENV(NDF*(I-1)+1)=ENVSZE
         IPERM=PERM(I)
         JSTRT=XADJ(IPERM)
         JSTOP=XADJ(IPERM+1)-1
         IF(JSTOP.LT.JSTRT) GO TO 200
            IFIRST=I
            DO 100 J=JSTRT,JSTOP
             NABOR=ADJNCY(J)
             NABOR=INVP(NABOR)
             IF(NABOR.LT.IFIRST) IFIRST=NABOR
 100  CONTINUE
      IBAND=(I-IFIRST)*NDF
         DO 202 J=2,NDF
 202     XENV(NDF*(I-1)+J)=XENV(NDF*(I-1)+J-1)+IBAND+J-2
      NDF1=NDF-1
      ENVSZE=ENVSZE+IBAND*NDF+(NDF1**2+NDF1)/2.
      IF (BANDW.LT.IBAND)    BANDW=IBAND
 200  CONTINUE
      XENV(NEQNS*NDF+1)=ENVSZE
      ENVSZE=ENVSZE-1
      RETURN
C     DEBUG  UNIT(9),SUBTRACE,INIT(ENVSZE,XENV)
C
      END
C =================================================================
C =================== ����� ���� FNENDD =============================
C =================================================================
C ����� ����� FNENDD.for