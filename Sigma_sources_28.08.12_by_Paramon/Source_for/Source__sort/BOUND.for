C ���� BOUND.for
C �������� ������������ BOUND
C       ����PO�PA��� HA�O�E��� �P������� �C�OB��
C          B���BAETC� �� MAIN , B���BAEM�X MO���E� HET.       
C ==================================================================
C ================== ������ ���� BOUND =============================
C                                                ��� Example 1
C ==================================================================
      SUBROUTINE BOUND(NN,CORD,NBC,NFIX,DB,IPR,NP)
C
C       �PO�P. HA�O�. �P��. �C�OB��,B���BAETC� �� MAIN1
C
      DIMENSION CORD(1),NBC(1),NFIX(1)
      LOGICAL*1 IPR(50)
      NB=0
      WRITE(6,18)  
      DO 56 I=1,NP
      IF (CORD(2*(I-1)+1).lt.(DB-0.01)) GO TO 55
      NB=NB+1
      NBC(NB)=I
      NFIX(NB)=10
      WRITE(6,19) I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
  55  IF (CORD(2*(I-1)+2).gt.(0.0+0.01)) GO TO 56
      NB=NB+1
      NBC(NB)=I
      NFIX(NB)=1
      IF(IPR(21))WRITE(6,19)I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
  56  CONTINUE
      IF(IPR(21)) PRINT *,"����� ������������ ����� NFIX=",NB  
  18  FORMAT('  �PAH��H�E �C�OB��'/' ��E�    X      Y    ���� ')
  19  FORMAT(' ',I4,' ',F7.2,' ',F7.2,'  ',I2)
      NN=NB
      RETURN
      END
C ==================================================================
C ================== ����� ���� BOUND  =============================
C ==================================================================
C ����� ����� BOUND.for