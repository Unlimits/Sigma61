C  ���� QMDUPD.for   
C c������� ������������ QMDUPD
C ================================================================  ************************************************************************************
***************             �������� �������� � ��������� ����������� �������   
*************************************************************************************************
*   ������������ ��������� �������� ����� �������� ��� ��������� 
*   ��������� �����
*   ������� ��������� -
*   (XADJ,ADJNCY) - ��������� ���������
*   (NLIST,LIST) - ������ �����, ��� ������� ����� �������������
*
*   ���������� ���������  - 
*   DEG - ������������ ����������� �������.
*   QSIZE - ������� ������������ ����������
*   QLINK -  ��������� ������ ��� ������������ �����
*   MARKER -  ������������ ��� ���������� �����
*
*   ������� ��������� - 
*   RCHEST - ���������� ���������
*   NBRHD - ����������
*
*   ������������ ������������ - 
*  QMDRCH, QMDMRG
C =================================================================
C =============== ������ ���� QMDUPD ==============================
C ================================================================
      SUBROUTINE QMDUPD(XADJ,adjncy,NLIST,LIST,DEG,
     1                        QSIZE,QLINK,MARKER,RCHSET,NBRHD)
*
**************************************************************************************************
*
      integer adjncy(1),list(1),deg(1),marker(1),
     1            rchset(1),nbrhd(1),qsize(1),qlink(1)
      integer xadj(1),deg0,deg1,il,inhd,inode,irch,
     1            j,jstrt,jstop,mark,nabor,nhdsze,nlist,
     1            node,rchsze,root
*
**************************************************************************************************
*
*        ����� ��� ����������� ���������, ������� � ������ ������� ������ list
*        ��������� �� � (nhdsze,nbrhd)
*        deg0 - ����� ����� � ������
*
!      print*,'#',nlist
      if (nlist.le.0) return
      deg0=0
      nhdsze=0
      do 200 il=1,nlist
             node=list(il)
             deg0=deg0+QSIZE(node)
             jstrt=xadj(node)
             jstop=xadj(node+1)-1
             !print*,jstrt,jstop
             do 100 j=jstrt,jstop
                    nabor=adjncy(j)
                    !print*,'marker',marker(nabor),'deg',deg(nabor)
                    if((marker(nabor).ne.0).or.
     >               (deg(nabor).ge.0)) goto 100
                    marker(nabor)=-1
                    nhdsze=nhdsze+1
                    nbrhd(nhdsze)=nabor
100          continue
200   continue
*
*        ����� ������������ ���� � �������� ������, ������ qmdmrg
*                                
      if (nhdsze.gt.0)
     1 call QMDMRG(XADJ,ADJNCY,DEG,QSIZE,QLINK,MARKER
     1                    DEG0,NHDSZE,NBRHD,RCHSET,NBRHD(NHDSZE+1))
*
*        ����� ����� ������� �����, ������� �� ���� �����
*
      do 600 il =1,nlist
             node=list(il)
             mark=marker(node)
             if ((mark.gt.1).or.(mark.lt.0)) goto 600
             marker(node)=2
             call QMDRCH(NODE,XADJ,ADJNCY,DEG,MARKER,
     1                        RCHSZE,RCHSET,NHDSZE,NBRHD)
             deg1=deg0
             if (rchsze.le.0) goto 400
             do 300 irch=1,rchsze
                    inode=rchset(irch)
                    deg1=deg1+qsize(inode)
                    marker(inode)=0
300          continue
400          deg(node)=deg1-1
             if (nhdsze.le.0) goto 600
             do 500 inhd=1,nhdsze
                    inode=nbrhd(inhd)
                    marker(inode)=0
500          continue
600   continue
      return
      end
C =================================================================
C =================== ����� ����   QMDUPD ============================
C =================================================================
C ����� �����  QMDUPD.for                                