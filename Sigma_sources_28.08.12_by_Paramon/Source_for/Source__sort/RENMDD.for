C  ���� RENMDD.for   
C �������� ������������ RENMDD
C =============================================================
C     �O��PO�PAMMA �EPEH�MEPA��� ���OB
C ���������� �� MAIN,B���BAET MO���� GENQMD,STSM,GENRCM
C =================================================================
C ================ ������ ���� RENMDD ==============================    

       subroutine RENMDD ( NP,NE,NCN,NOP,PERM,INVP,XADJ,ADJNCY,IPR,
     >CORD,ESIGMA,FL,deg,marker,RCHESET,NBRHD,QSIZE,QLINK,ADJNCYBC)

       INTEGER NOP(1),XADJ(1),ADJNCY(1), PERM(1),FL,
     > INVP(1),XENV(1),MASK(5000),XLC(5000),CORD(1),ESIGMA(1),
     >deg(1),marker(1),RCHESET(1),NBRHD(1),
     >QSIZE(1),QLINK(1), ADJNCYBC(1)
       LOGICAL*1 IPR(1)
       IF(IPR(10))PRINT 16,NP,NE
 16    FORMAT(/,5X,'����������: ���OB',I5,2X,'��EMEHTOB',I5)
C     DO 14 I=1,NE
C 14  READ(NT2)  (NOP(NCN*(I-1)+J),J=1,NCN)
       XADJ(1)=1
       IF(IPR(10)) PRINT 10,(I,(NOP(NCN*(I-1)+J),J=1,NCN),I=1,NE)
       IF(IPR(26))WRITE(6,900)
900    FORMAT(/,10X,'*****Start STSM in RENMDD',/,
     >10X,'(������������ ��������� ��������� )',/)
       CALL STSM (NP,NE,NCN,NOP,XADJ,ADJNCY)
       IF(IPR(26)) WRITE(6,901)
901    FORMAT(/,10X,'*****Finish STSM in RENMDD')
       IF(IPR(11)) PRINT 13
13     FORMAT(/14X, '��������� ���������',/
     >6X,'K',6X,'XADJ',15X,'ADJNCY')
       DO 15 K=1,NP
       JB=XADJ(K)
       JE=XADJ(K+1)-1
       IF(IPR(11)) PRINT 11,XADJ(K),(ADJNCY(J),J=JB,JE)
  15   CONTINUE
       IF(IPR(11)) PRINT 12,XADJ(NP+1)
       IF(IPR(26)) WRITE(6,902)
* ����� ������    

!  --------------------------------- ������ ����������� ������ ---------------------------------
!        �����: �������� �.�., 06-422  
!        ����: ���, 2010 �.
!        ����: ����� ������� (������) � ���� ��� ���������� ������ �����
                                                                                      
      if (FL.EQ.21.OR.FL.EQ.22.OR.FL.EQ.23.OR.FL.EQ.24) then 
         IF(IPR(26))  WRITE(6, 1301)
1301     FORMAT(/, 10X, '*****Start GENAU in RENMDD', /,
     >10X, '(�������� ��� �� �������... )',/)
         CALL GENAU(NP, XADJ, ADJNCY, PERM) 
!         CALL GENAU_MATRIX(NP, XADJ, ADJNCY, PERM)     
         IF(IPR(26)) WRITE(6, 1302)
1302     FORMAT(/, 10X, '*****Finish GENAU in RENMDD')
         IF(IPR(13)) PRINT 22,(K, PERM(K), K=1, NP) 
C       print *,(perm(i),i=1,NP) 
C         do i=1,NP
C             print *,PERM(i)
C         enddo 
         goto 333 
      endif     
!  ---------------------------------- ����� ����������� ������ --------------------------------- 

      if((fl.eq.2).or.(fl.eq.3).or.(fl.eq.6).or.(fl.eq.7))goto 4532
      if((fl.eq.-1).or.(fl.eq.-2).or.(fl.eq.-3)
     > .or.(fl.eq.-4))goto 3421
      
902    FORMAT(/,10X,'*****Start GENRCM in RENMDD',/,
     >10X,'(����������� �������� ������������ )',/)
       CALL GENRCM( NP,XADJ,ADJNCY,PERM,MASK,XLC,FL)
C         do i=1,NP
C             Perm(i) = i
C         Enddo      
       IF(IPR(26)) WRITE(6,903)
903    FORMAT(/,10X,'*****Finish GENRCM in RENMDD')
       IF(IPR(13)) PRINT 22,(K,PERM(K),K=1,NP)
C      PRINT 12,XADJ(NP+1)
       goto 333
4532   IF(IPR(26))  WRITE(6,703)
C       print*,'�������� GENQMD...'
703    FORMAT(/,10X,'*****Start GENQMD in RENMDD',/,
     >10X,'(�����������................)',/)

       call GENQMD(np,XADJ,ADJNCY,ADJNCYBC,PERM,INVP,DEG,
     1            MARKER,RCHSET,NBRHD,QSIZE,QLINK,NOFSB)
       IF(IPR(26)) WRITE(6,704)
704    FORMAT(/,10X,'*****Finish GENQMD in RENMDD')
C       print*,'GENQMD ���������'   
       goto 333
3421   print*,'���������: ��������� ���������� ������� ���������'
       do 26 ij=1,np
26      perm(ij)=ij
c      print *,'kva!!!!kva!!!!'
      
c      do 44 i=1,np
c44      print *, perm(i)
c      do 17 ij=1,np
c17    invp(perm(ij))=1.
c      write (6,*) perm(np),invp(PERM(IJ))
      
 333   DO 17 IJ=1,NP
 17    INVP(PERM(IJ))=IJ
       IF(IPR(12)) PRINT 21,(K,INVP(K),K=1,NP)

c             HOB�M HOMEPAM - �X KOOP��HAT�

       DO 81 I=1,NP
       DO 81 J=1,2
 81    ESIGMA(2*(I-1)+J)=CORD(2*(I-1)+J)
       DO 82 I=1,NP
       DO 82 J=1,2
 82    CORD(2*(INVP(I)-1)+J)=ESIGMA(2*(I-1)+J)

C            �PEO�PA�OBAH�E NOP
C
       DO 71 IEL=1,NE
       DO 71 I=1,NCN
 71    NOP(NCN*(IEL-1)+I)=INVP(NOP(NCN*(IEL-1)+I))
C          PRINT 20,(NN,(NOP(NCN*(NN-1)+J),J=1,NCN),
C    >        (INVP(NOP(NCN*(NN-1)+J)),J=1,NCN),NN=1,NE)
C     IF(IPR(14)) PRINT 23,(NN,( INVP(NOP(NCN*(NN-1)+J)),J=1,NCN),NN=1,N
C     CALL FNENV ( NP,XADJ,ADJNCY,PERM,INVP,XENV,ENVSZE,BANDW)
C     REWIND NT2
C     WRITE(NT2)((INVP (NOP(NCN*(I-1)+J)),J=1,NCN),I=1,NE)
C     IF(IPR(  ))  PRINT 18,(XENV(I),I=1,NP)
C     IF(IPR(  ))  PRINT 19,ENVSZE,BANDW
 18    FORMAT(/'  MACC�B XENV'/(10I5))
 19    FORMAT(/'  PA�MEP O�O�O�K� -',I5,'   ��P�HA �EHT� -',I5)
 20    FORMAT(/'    N   CTAP�E *NOP*   HOB�E  *NOP*   '/(7I5))
 21    FORMAT(/'  +OLD+ +NEW+ +OLD+ +NEW+ +OLD+ +NEW+      '/(6I6))
 22    FORMAT(/'  +NEW+ +OLD+ +NEW+ +OLD+ +NEW+ +OLD+      '/(6I6))

 23    FORMAT(/'  HOB�E  <<NOP>>'/(4('  N',I4,' (',3I5,'  )')))
 10    FORMAT(/' ��������� ��������� ����� (������� � ��� ����)',
     >2X,' MACC�B <<NOP>>'/(3('  *N',I3,'(' ,3I4,')')))
11     FORMAT(2X,I5,4X,I5,3X,20I5)
 12    FORMAT(/'  ���HA MACC�BA <<ADJNCY>>',I10)
       RETURN
C      DEBUG UNIT(9),INIT
       END
C =============================================================
C ================= ����� ���� RENMDD============================
C =============================================================
C  ����� ����� RENMDD.for
