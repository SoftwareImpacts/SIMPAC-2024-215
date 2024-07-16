MODULE PARAMETERS
!--------------------------------------------------------------------------------------------------
IMPLICIT NONE
INTEGER,PARAMETER                      :: IM=257
INTEGER,PARAMETER                      :: JM=257
!--------------------------------------------------------------------------------------------------
REAL(8),PARAMETER                      :: LX=1.D0
REAL(8),PARAMETER                      :: LY=1.D0
REAL(8),PARAMETER                      :: DX=LX/(IM-1)
REAL(8),PARAMETER                      :: DY=LY/(JM-1)
REAL(8),PARAMETER                      :: I2DX=1.D0/(2.D0*DX)
REAL(8),PARAMETER                      :: I2DY=1.D0/(2.D0*DY)
REAL(8),PARAMETER                      :: IDX2=1.D0/(DX**2.D0)
REAL(8),PARAMETER                      :: IDY2=1.D0/(DY**2.D0)
REAL(8),PARAMETER                      :: RHO=7500.D0
REAL(8),PARAMETER                      :: MU=10.D0/75.D0
CHARACTER(15),PARAMETER                :: FILE_NAME="/code/INPUT.DAT"
!--------------------------------------------------------------------------------------------------
END MODULE PARAMETERS
!==================================================================================================
PROGRAM MAIN
USE PARAMETERS
IMPLICIT NONE
REAL(8),DIMENSION(IM,JM)    :: X,Y,U,V,EG,OMEGA
!--------------------------------------------------------------------------------------------------
CALL FILE_READING (X,Y,U,V,OMEGA)
CALL ENERGY_GRADIENT (U,V,OMEGA,EG)
CALL WRITE_SOLUTION (X,Y,U,V,OMEGA,EG)
!--------------------------------------------------------------------------------------------------
END PROGRAM
!==================================================================================================
SUBROUTINE WRITE_SOLUTION (X,Y,U,V,OMEGA,EG)
USE PARAMETERS
IMPLICIT NONE
INTEGER                             :: I,J
REAL(8),DIMENSION(IM,JM)            :: U,V,X,Y,EG,OMEGA
!--------------------------------------------------------------------------------------------------
OPEN(100,FILE='/results/EG_FIELD.DAT',POSITION='REWIND')
WRITE(100,*)'VARIABLES= "X", "Y", "U", "V", "EG", "OMEGA"'!
WRITE(100,*)'ZONE, I=',IM,',J=',JM,',F=POINT'
DO J=1,JM
DO I=1,IM
WRITE(100,*) X(I,J),Y(I,J),U(I,J),V(I,J),EG(I,J),OMEGA(I,J)!
END DO
END DO
CLOSE(100)
!--------------------------------------------------------------------------------------------------
WRITE(*,*) '==========================='
WRITE(*,*) 'PRINTING ON ENERGY_GRADIENT'
WRITE(*,*) '==========================='
!--------------------------------------------------------------------------------------------------
END SUBROUTINE WRITE_SOLUTION
!==================================================================================================
SUBROUTINE FILE_READING (X,Y,U,V,OMEGA)
USE PARAMETERS
IMPLICIT NONE
INTEGER                                :: I,J
REAL(8),DIMENSION(IM,JM)               :: X,Y,U,V,OMEGA
REAL(8)                                :: DUMMY
!--------------------------------------------------------------------------------------------------
OPEN(11230,FILE=FILE_NAME,POSITION='REWIND')
READ(11230,*)
READ(11230,*)
DO J=1,JM
DO I=1,IM
READ(11230,*)    X(I,J),Y(I,J),U(I,J),V(I,J),DUMMY,OMEGA(I,J),DUMMY
END DO
END DO
CLOSE(11230)
!--------------------------------------------------------------------------------------------------
END SUBROUTINE FILE_READING
!==================================================================================================
SUBROUTINE ENERGY_GRADIENT (U,V,OMEGA,EG)
USE PARAMETERS
IMPLICIT NONE
!--------------------------------------------------------------------------------------------------
INTEGER                   :: I,J
REAL(8),DIMENSION(IM,JM)  :: U,V,OMEGA,LAPLACIAN_U,LAPLACIAN_V,EG
!--------------------------------------------------------------------------------------------------
DO I=2,IM-1
DO J=2,JM-1
LAPLACIAN_U(I,J)=(U(I+1,J)-2.D0*U(I,J)+U(I-1,J))*IDX2+(U(I,J+1)-2.D0*U(I,J)+U(I,J-1))*IDY2
LAPLACIAN_V(I,J)=(V(I+1,J)-2.D0*V(I,J)+V(I-1,J))*IDX2+(V(I,J+1)-2.D0*V(I,J)+V(I,J-1))*IDY2
END DO
END DO
DO I=2,IM-1
DO J=2,JM-1
!    IF (((MU*(U(I,J)*LAPLACIAN_U(I,J)+V(I,J)*LAPLACIAN_V(I,J)))>0.001D0)&
!        .OR.((MU*(U(I,J)*LAPLACIAN_U(I,J)+V(I,J)*LAPLACIAN_V(I,J)))<-0.001D0)) THEN
    EG(I,J)=(MU*(U(I,J)*LAPLACIAN_V(I,J)-V(I,J)*LAPLACIAN_U(I,J))-RHO*(U(I,J)**2.D0+V(I,J)**2.D0)*OMEGA(I,J))&
           /(MU*(U(I,J)*LAPLACIAN_U(I,J)+V(I,J)*LAPLACIAN_V(I,J)))
!   END IF
END DO
END DO
EG=DABS(EG)
!--------------------------------------------------------------------------------------------------
END SUBROUTINE ENERGY_GRADIENT
!==================================================================================================
