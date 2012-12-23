C  ���� GENQMD.for   
C �������� ������������ GENQMD
C =================================================================
***************   ������������ ����������� ������� � �������������� ������������    
*************************************************************************************************
*   ������������ ��������� �������� ����������� �������.
*   ������������ ������� ������������� ������ ����������
*   ����������� ������ - ������ � ������� ������������ �����. 
*
*   ��������������: ���������� ������� ADJNCY �� �����������
*
*   ������� ��������� -
*   NEQNS - ����� ���������
*   (XADJ,ADJNCY) - ��������� ���������
*
*   �������� ��������� - 
*   PEREM - ������������ ����������� �������.
*   INVP - �������� � PEREM
*
*   ������� ��������� - 
*   DEG - ������ ��������. ������������� ����� DEG(I) 
*         ���������, ��� ���� I ���������
*   MARKER - ������ ����������. ������������� MARKER(I)
*                      ���������, ��� ���� I ���� � ������ ����� � ��� ����� ������������
*   RCHEST - ������ ��� ����������� ���������
*   NBRHD - ������ ��� �����������
*   QSIZE - ������ ��� �������� �������� ������������ ����������
*   QLINK - ������, �������� ������������ ���� 
*                I, QLINK(I), (QLINK(QLINK(I))... - �������� ���������,
*              ��������������� ����� I.
*
*   ������������ ������������ - 
*  QMDRCH, QMDQT, QMDUPD
C =================================================================
C =============== ������ ���� GENQMD ==============================
C =================================================================
      SUBROUTINE GENQMD(NEQNS,XADJ,ADJNCY,ADJNCYBC,PERM,INVP,DEG,
     1                        MARKER,RCHSET,NBRHD,QSIZE,QLINK,
     1                        NOFSB)
*                    
******************************************************************************************************
*
      INTEGER ADJNCY(1),ADJNCYBC(1),PERM(1),INVP(1),DEG(1),MARKER(1),
     1RCHSET(1),NBRHD(1),QSIZE(1),QLINK(1),ADJENCYBC,XADJ(1)
      INTEGER INODE,IP,IPCH,J,MINDEG,NDEG,
     1            NEQNCS,NHDSZE,NODE,NOFSUB,NP,NUM,NUMP1,
     1            NXNODE,RCHSZE,SEARCH,THRESH
*                    
******************************************************************************************************                    
*
*            ������������� DEGREE � ������ ������� ����������
*            
      print*,'����� ADJNCY...'
      do 123 temp=1,(xadj(NEQNS+1)-1)
  123 ADJNCYBC(temp)= ADJNCY(temp)
      
      mindeg=neqns
      nofsub=0
      do 100 node=1,neqns
             perm(node)=node
             invp(node)=node
             marker(node)=0
             qsize(node)=1
             qlink(node)=0
             ndeg=xadj(node+1) - xadj(node)
             deg(node)=ndeg
             !print*,'������� �����',node,deg(node)
             if(ndeg.lt.mindeg) mindeg=ndeg
100   continue
      num=0
*                        
*            ��������� ����� ���� � ����������� ��������. search ���������, ������ �������� �����.
*                        
200   search=1
      !print*,'point2'
      thresh=mindeg
      mindeg=neqns
300   nump1=num+1
      if(nump1.gt.search) search=nump1
      do 400 j=search,neqns
             node=perm(j)
             if(marker(node).lt.0) goto 400
             ndeg=deg(node)
             if(ndeg.le.thresh) goto 500
             if(ndeg.lt.mindeg) mindeg=ndeg
400   continue
      goto 200
*
*            ����������� ������� ����� node. ���������� ��� ���������� ���������, ��������� � QMDRCH
*
500   search=j
      nofsub=nofsub+deg(node)
      marker(node)=1
*      print*,''
*      write(6,1)(node)
1     format(' �������������� ���� �',i4)
!      print *, '�������� QMDRCH...'
      call QMDRCH(NODE,XADJ,ADJNCY,DEG,MARKER,
     1                RCHSZE,RCHSET,NHDSZE,NBRHD)
*
*            ��������� ��� ����, ������������ � node. ��� ����� node, qlink(node),...                    
*
      
!      print *, 'QMDRCH ��������� '
*      print*,'���������� ����'
*      write(6,*)(rchset(temp),temp=1,RCHSZE)
      nxnode=node
600   num=num+1
      np=invp(nxnode)
      ip=perm(num)
      perm(np)=ip
      invp(ip)=np
      perm(num)=nxnode
      invp(nxnode)=num
      deg(nxnode)=-1
*      write(6,2)(nxnode)
   2  format(' ����������� ���� �',i4)
      nxnode=qlink(nxnode)
      if(nxnode.gt.0) goto 600
                        
      if(rchsze.le.0) goto 800
*                        
*            ����������� ������� ����� � ���������� ��������� � ���������� ������������ ����.                        
*
!      print*,'�������� QMDUPD....'
      call QMDUPD(XADJ,ADJNCY,RCHSZE,RCHSET,DEG,QSIZE,
     1QLINK,MARKER,RCHSET(RCHSZE+1),NBRHD(NHDSZE+1))

!      print*,'QMDUPD ���������...'              
*
*            �������� � marker ��������, �����. ����� ���������� ���������. �������� ���������
*            �������� ��� ������������ ������. ������� QMDQT
*
      marker(node)=0
      do 700 irch=1,rchsze
             inode=rchset(irch)
             if(marker(inode).lt.0) goto 700
             marker(inode)=0
             ndeg=deg(inode)
             if(ndeg.lt.mindeg) mindeg=ndeg
             if(ndeg.gt.thresh) goto 700
             mindeg=thresh
             thresh=ndeg
             search=invp(inode)
700   continue    
                        
      if(nhdsze.gt.0) then
!      print *,'�������� QMDQT...'
      call QMDQT(NODE,XADJ,ADJNCY,MARKER,RCHSZE,RCHSET,NBRHD)
!      print*,'QMDQT ���������'
      endif
800   if(num.lt.neqns) goto 300
      print*,'������ ADJNCY...'
      do 124 temp=1,(xadj(NEQNS+1)-1)
  124 ADJNCY(temp)= ADJNCYBC(temp)
      return
      end
C =================================================================
C =================== ����� ���� GENQMD ============================
C =================================================================
C ����� ����� GENQMD.for             