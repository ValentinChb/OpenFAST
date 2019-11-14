!STARTOFREGISTRYGENERATEDFILE 'IfW_4Dext_Types.f90'
!
! WARNING This file is generated automatically by the FAST registry.
! Do not edit.  Your changes to this file will be lost.
!
! FAST Registry
!*********************************************************************************************************************************
! IfW_4Dext_Types
!.................................................................................................................................
! This file is part of IfW_4Dext.
!
! Copyright (C) 2012-2016 National Renewable Energy Laboratory
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
!
!
! W A R N I N G : This file was automatically generated from the FAST registry.  Changes made to this file may be lost.
!
!*********************************************************************************************************************************
!> This module contains the user-defined types needed in IfW_4Dext. It also contains copy, destroy, pack, and
!! unpack routines associated with each defined data type. This code is automatically generated by the FAST Registry.
MODULE IfW_4Dext_Types
!---------------------------------------------------------------------------------------------------------------------------------
USE NWTC_Library
IMPLICIT NONE
! =========  IfW_4Dext_InitInputType  =======
  TYPE, PUBLIC :: IfW_4Dext_InitInputType
    INTEGER(IntKi) , DIMENSION(1:4)  :: n      !< number of grid points in the x, y, z, and t directions [-]
    REAL(ReKi) , DIMENSION(1:4)  :: delta      !< size between 2 consecutive grid points in each grid direction [m,m,m,s]
    REAL(ReKi) , DIMENSION(1:3)  :: pZero      !< fixed position of the XYZ grid (i.e., XYZ coordinates of m%V(:,1,1,1,:)) [m]
  END TYPE IfW_4Dext_InitInputType
! =======================
! =========  IfW_4Dext_InitOutputType  =======
  TYPE, PUBLIC :: IfW_4Dext_InitOutputType
    TYPE(ProgDesc)  :: Ver      !< Version information of this submodule [-]
  END TYPE IfW_4Dext_InitOutputType
! =======================
! =========  IfW_4Dext_MiscVarType  =======
  TYPE, PUBLIC :: IfW_4Dext_MiscVarType
    REAL(SiKi) , DIMENSION(:,:,:,:,:), ALLOCATABLE  :: V      !< this is the 4-d velocity field for each wind component [{uvw},nx,ny,nz,nt]; it is stored as a miscVar instead of an input so that we don't have 4 copies of a very large field [-]
    REAL(ReKi)  :: TgridStart      !< this is the time where the first time grid in m%V starts (i.e, the time associated with m%V(:,:,:,:,1)) [s]
  END TYPE IfW_4Dext_MiscVarType
! =======================
! =========  IfW_4Dext_ParameterType  =======
  TYPE, PUBLIC :: IfW_4Dext_ParameterType
    INTEGER(IntKi) , DIMENSION(1:4)  :: n      !< number of evenly-spaced grid points in the x, y, z, and t directions [-]
    REAL(ReKi) , DIMENSION(1:4)  :: delta      !< size between 2 consecutive grid points in each grid direction [m,m,m,s]
    REAL(ReKi) , DIMENSION(1:3)  :: pZero      !< fixed position of the XYZ grid (i.e., XYZ coordinates of m%V(:,1,1,1,:)) [m]
  END TYPE IfW_4Dext_ParameterType
! =======================
CONTAINS
 SUBROUTINE IfW_4Dext_CopyInitInput( SrcInitInputData, DstInitInputData, CtrlCode, ErrStat, ErrMsg )
   TYPE(IfW_4Dext_InitInputType), INTENT(IN) :: SrcInitInputData
   TYPE(IfW_4Dext_InitInputType), INTENT(INOUT) :: DstInitInputData
   INTEGER(IntKi),  INTENT(IN   ) :: CtrlCode
   INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
   CHARACTER(*),    INTENT(  OUT) :: ErrMsg
! Local 
   INTEGER(IntKi)                 :: i,j,k
   INTEGER(IntKi)                 :: i1, i1_l, i1_u  !  bounds (upper/lower) for an array dimension 1
   INTEGER(IntKi)                 :: i2, i2_l, i2_u  !  bounds (upper/lower) for an array dimension 2
   INTEGER(IntKi)                 :: i3, i3_l, i3_u  !  bounds (upper/lower) for an array dimension 3
   INTEGER(IntKi)                 :: i4, i4_l, i4_u  !  bounds (upper/lower) for an array dimension 4
   INTEGER(IntKi)                 :: i5, i5_l, i5_u  !  bounds (upper/lower) for an array dimension 5
   INTEGER(IntKi)                 :: ErrStat2
   CHARACTER(ErrMsgLen)           :: ErrMsg2
   CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_CopyInitInput'
! 
   ErrStat = ErrID_None
   ErrMsg  = ""
    DstInitInputData%n = SrcInitInputData%n
    DstInitInputData%delta = SrcInitInputData%delta
    DstInitInputData%pZero = SrcInitInputData%pZero
 END SUBROUTINE IfW_4Dext_CopyInitInput

 SUBROUTINE IfW_4Dext_DestroyInitInput( InitInputData, ErrStat, ErrMsg )
  TYPE(IfW_4Dext_InitInputType), INTENT(INOUT) :: InitInputData
  INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
  CHARACTER(*),    INTENT(  OUT) :: ErrMsg
  CHARACTER(*),    PARAMETER :: RoutineName = 'IfW_4Dext_DestroyInitInput'
  INTEGER(IntKi)                 :: i, i1, i2, i3, i4, i5 
! 
  ErrStat = ErrID_None
  ErrMsg  = ""
 END SUBROUTINE IfW_4Dext_DestroyInitInput

 SUBROUTINE IfW_4Dext_PackInitInput( ReKiBuf, DbKiBuf, IntKiBuf, Indata, ErrStat, ErrMsg, SizeOnly )
  REAL(ReKi),       ALLOCATABLE, INTENT(  OUT) :: ReKiBuf(:)
  REAL(DbKi),       ALLOCATABLE, INTENT(  OUT) :: DbKiBuf(:)
  INTEGER(IntKi),   ALLOCATABLE, INTENT(  OUT) :: IntKiBuf(:)
  TYPE(IfW_4Dext_InitInputType),  INTENT(IN) :: InData
  INTEGER(IntKi),   INTENT(  OUT) :: ErrStat
  CHARACTER(*),     INTENT(  OUT) :: ErrMsg
  LOGICAL,OPTIONAL, INTENT(IN   ) :: SizeOnly
    ! Local variables
  INTEGER(IntKi)                 :: Re_BufSz
  INTEGER(IntKi)                 :: Re_Xferred
  INTEGER(IntKi)                 :: Db_BufSz
  INTEGER(IntKi)                 :: Db_Xferred
  INTEGER(IntKi)                 :: Int_BufSz
  INTEGER(IntKi)                 :: Int_Xferred
  INTEGER(IntKi)                 :: i,i1,i2,i3,i4,i5
  LOGICAL                        :: OnlySize ! if present and true, do not pack, just allocate buffers
  INTEGER(IntKi)                 :: ErrStat2
  CHARACTER(ErrMsgLen)           :: ErrMsg2
  CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_PackInitInput'
 ! buffers to store subtypes, if any
  REAL(ReKi),      ALLOCATABLE   :: Re_Buf(:)
  REAL(DbKi),      ALLOCATABLE   :: Db_Buf(:)
  INTEGER(IntKi),  ALLOCATABLE   :: Int_Buf(:)

  OnlySize = .FALSE.
  IF ( PRESENT(SizeOnly) ) THEN
    OnlySize = SizeOnly
  ENDIF
    !
  ErrStat = ErrID_None
  ErrMsg  = ""
  Re_BufSz  = 0
  Db_BufSz  = 0
  Int_BufSz  = 0
      Int_BufSz  = Int_BufSz  + SIZE(InData%n)  ! n
      Re_BufSz   = Re_BufSz   + SIZE(InData%delta)  ! delta
      Re_BufSz   = Re_BufSz   + SIZE(InData%pZero)  ! pZero
  IF ( Re_BufSz  .GT. 0 ) THEN 
     ALLOCATE( ReKiBuf(  Re_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating ReKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF ( Db_BufSz  .GT. 0 ) THEN 
     ALLOCATE( DbKiBuf(  Db_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating DbKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF ( Int_BufSz  .GT. 0 ) THEN 
     ALLOCATE( IntKiBuf(  Int_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating IntKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF(OnlySize) RETURN ! return early if only trying to allocate buffers (not pack them)

  Re_Xferred  = 1
  Db_Xferred  = 1
  Int_Xferred = 1

      IntKiBuf ( Int_Xferred:Int_Xferred+(SIZE(InData%n))-1 ) = PACK(InData%n,.TRUE.)
      Int_Xferred   = Int_Xferred   + SIZE(InData%n)
      ReKiBuf ( Re_Xferred:Re_Xferred+(SIZE(InData%delta))-1 ) = PACK(InData%delta,.TRUE.)
      Re_Xferred   = Re_Xferred   + SIZE(InData%delta)
      ReKiBuf ( Re_Xferred:Re_Xferred+(SIZE(InData%pZero))-1 ) = PACK(InData%pZero,.TRUE.)
      Re_Xferred   = Re_Xferred   + SIZE(InData%pZero)
 END SUBROUTINE IfW_4Dext_PackInitInput

 SUBROUTINE IfW_4Dext_UnPackInitInput( ReKiBuf, DbKiBuf, IntKiBuf, Outdata, ErrStat, ErrMsg )
  REAL(ReKi),      ALLOCATABLE, INTENT(IN   ) :: ReKiBuf(:)
  REAL(DbKi),      ALLOCATABLE, INTENT(IN   ) :: DbKiBuf(:)
  INTEGER(IntKi),  ALLOCATABLE, INTENT(IN   ) :: IntKiBuf(:)
  TYPE(IfW_4Dext_InitInputType), INTENT(INOUT) :: OutData
  INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
  CHARACTER(*),    INTENT(  OUT) :: ErrMsg
    ! Local variables
  INTEGER(IntKi)                 :: Buf_size
  INTEGER(IntKi)                 :: Re_Xferred
  INTEGER(IntKi)                 :: Db_Xferred
  INTEGER(IntKi)                 :: Int_Xferred
  INTEGER(IntKi)                 :: i
  LOGICAL                        :: mask0
  LOGICAL, ALLOCATABLE           :: mask1(:)
  LOGICAL, ALLOCATABLE           :: mask2(:,:)
  LOGICAL, ALLOCATABLE           :: mask3(:,:,:)
  LOGICAL, ALLOCATABLE           :: mask4(:,:,:,:)
  LOGICAL, ALLOCATABLE           :: mask5(:,:,:,:,:)
  INTEGER(IntKi)                 :: i1, i1_l, i1_u  !  bounds (upper/lower) for an array dimension 1
  INTEGER(IntKi)                 :: i2, i2_l, i2_u  !  bounds (upper/lower) for an array dimension 2
  INTEGER(IntKi)                 :: i3, i3_l, i3_u  !  bounds (upper/lower) for an array dimension 3
  INTEGER(IntKi)                 :: i4, i4_l, i4_u  !  bounds (upper/lower) for an array dimension 4
  INTEGER(IntKi)                 :: i5, i5_l, i5_u  !  bounds (upper/lower) for an array dimension 5
  INTEGER(IntKi)                 :: ErrStat2
  CHARACTER(ErrMsgLen)           :: ErrMsg2
  CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_UnPackInitInput'
 ! buffers to store meshes, if any
  REAL(ReKi),      ALLOCATABLE   :: Re_Buf(:)
  REAL(DbKi),      ALLOCATABLE   :: Db_Buf(:)
  INTEGER(IntKi),  ALLOCATABLE   :: Int_Buf(:)
    !
  ErrStat = ErrID_None
  ErrMsg  = ""
  Re_Xferred  = 1
  Db_Xferred  = 1
  Int_Xferred  = 1
    i1_l = LBOUND(OutData%n,1)
    i1_u = UBOUND(OutData%n,1)
    ALLOCATE(mask1(i1_l:i1_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating mask1.', ErrStat, ErrMsg,RoutineName)
       RETURN
    END IF
    mask1 = .TRUE. 
      OutData%n = UNPACK( IntKiBuf ( Int_Xferred:Int_Xferred+(SIZE(OutData%n))-1 ), mask1, 0_IntKi )
      Int_Xferred   = Int_Xferred   + SIZE(OutData%n)
    DEALLOCATE(mask1)
    i1_l = LBOUND(OutData%delta,1)
    i1_u = UBOUND(OutData%delta,1)
    ALLOCATE(mask1(i1_l:i1_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating mask1.', ErrStat, ErrMsg,RoutineName)
       RETURN
    END IF
    mask1 = .TRUE. 
      OutData%delta = UNPACK(ReKiBuf( Re_Xferred:Re_Xferred+(SIZE(OutData%delta))-1 ), mask1, 0.0_ReKi )
      Re_Xferred   = Re_Xferred   + SIZE(OutData%delta)
    DEALLOCATE(mask1)
    i1_l = LBOUND(OutData%pZero,1)
    i1_u = UBOUND(OutData%pZero,1)
    ALLOCATE(mask1(i1_l:i1_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating mask1.', ErrStat, ErrMsg,RoutineName)
       RETURN
    END IF
    mask1 = .TRUE. 
      OutData%pZero = UNPACK(ReKiBuf( Re_Xferred:Re_Xferred+(SIZE(OutData%pZero))-1 ), mask1, 0.0_ReKi )
      Re_Xferred   = Re_Xferred   + SIZE(OutData%pZero)
    DEALLOCATE(mask1)
 END SUBROUTINE IfW_4Dext_UnPackInitInput

 SUBROUTINE IfW_4Dext_CopyInitOutput( SrcInitOutputData, DstInitOutputData, CtrlCode, ErrStat, ErrMsg )
   TYPE(IfW_4Dext_InitOutputType), INTENT(IN) :: SrcInitOutputData
   TYPE(IfW_4Dext_InitOutputType), INTENT(INOUT) :: DstInitOutputData
   INTEGER(IntKi),  INTENT(IN   ) :: CtrlCode
   INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
   CHARACTER(*),    INTENT(  OUT) :: ErrMsg
! Local 
   INTEGER(IntKi)                 :: i,j,k
   INTEGER(IntKi)                 :: ErrStat2
   CHARACTER(ErrMsgLen)           :: ErrMsg2
   CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_CopyInitOutput'
! 
   ErrStat = ErrID_None
   ErrMsg  = ""
      CALL NWTC_Library_Copyprogdesc( SrcInitOutputData%Ver, DstInitOutputData%Ver, CtrlCode, ErrStat2, ErrMsg2 )
         CALL SetErrStat(ErrStat2, ErrMsg2, ErrStat, ErrMsg,RoutineName)
         IF (ErrStat>=AbortErrLev) RETURN
 END SUBROUTINE IfW_4Dext_CopyInitOutput

 SUBROUTINE IfW_4Dext_DestroyInitOutput( InitOutputData, ErrStat, ErrMsg )
  TYPE(IfW_4Dext_InitOutputType), INTENT(INOUT) :: InitOutputData
  INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
  CHARACTER(*),    INTENT(  OUT) :: ErrMsg
  CHARACTER(*),    PARAMETER :: RoutineName = 'IfW_4Dext_DestroyInitOutput'
  INTEGER(IntKi)                 :: i, i1, i2, i3, i4, i5 
! 
  ErrStat = ErrID_None
  ErrMsg  = ""
  CALL NWTC_Library_Destroyprogdesc( InitOutputData%Ver, ErrStat, ErrMsg )
 END SUBROUTINE IfW_4Dext_DestroyInitOutput

 SUBROUTINE IfW_4Dext_PackInitOutput( ReKiBuf, DbKiBuf, IntKiBuf, Indata, ErrStat, ErrMsg, SizeOnly )
  REAL(ReKi),       ALLOCATABLE, INTENT(  OUT) :: ReKiBuf(:)
  REAL(DbKi),       ALLOCATABLE, INTENT(  OUT) :: DbKiBuf(:)
  INTEGER(IntKi),   ALLOCATABLE, INTENT(  OUT) :: IntKiBuf(:)
  TYPE(IfW_4Dext_InitOutputType),  INTENT(IN) :: InData
  INTEGER(IntKi),   INTENT(  OUT) :: ErrStat
  CHARACTER(*),     INTENT(  OUT) :: ErrMsg
  LOGICAL,OPTIONAL, INTENT(IN   ) :: SizeOnly
    ! Local variables
  INTEGER(IntKi)                 :: Re_BufSz
  INTEGER(IntKi)                 :: Re_Xferred
  INTEGER(IntKi)                 :: Db_BufSz
  INTEGER(IntKi)                 :: Db_Xferred
  INTEGER(IntKi)                 :: Int_BufSz
  INTEGER(IntKi)                 :: Int_Xferred
  INTEGER(IntKi)                 :: i,i1,i2,i3,i4,i5
  LOGICAL                        :: OnlySize ! if present and true, do not pack, just allocate buffers
  INTEGER(IntKi)                 :: ErrStat2
  CHARACTER(ErrMsgLen)           :: ErrMsg2
  CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_PackInitOutput'
 ! buffers to store subtypes, if any
  REAL(ReKi),      ALLOCATABLE   :: Re_Buf(:)
  REAL(DbKi),      ALLOCATABLE   :: Db_Buf(:)
  INTEGER(IntKi),  ALLOCATABLE   :: Int_Buf(:)

  OnlySize = .FALSE.
  IF ( PRESENT(SizeOnly) ) THEN
    OnlySize = SizeOnly
  ENDIF
    !
  ErrStat = ErrID_None
  ErrMsg  = ""
  Re_BufSz  = 0
  Db_BufSz  = 0
  Int_BufSz  = 0
   ! Allocate buffers for subtypes, if any (we'll get sizes from these) 
      Int_BufSz   = Int_BufSz + 3  ! Ver: size of buffers for each call to pack subtype
      CALL NWTC_Library_Packprogdesc( Re_Buf, Db_Buf, Int_Buf, InData%Ver, ErrStat2, ErrMsg2, .TRUE. ) ! Ver 
        CALL SetErrStat(ErrStat2, ErrMsg2, ErrStat, ErrMsg, RoutineName)
        IF (ErrStat >= AbortErrLev) RETURN

      IF(ALLOCATED(Re_Buf)) THEN ! Ver
         Re_BufSz  = Re_BufSz  + SIZE( Re_Buf  )
         DEALLOCATE(Re_Buf)
      END IF
      IF(ALLOCATED(Db_Buf)) THEN ! Ver
         Db_BufSz  = Db_BufSz  + SIZE( Db_Buf  )
         DEALLOCATE(Db_Buf)
      END IF
      IF(ALLOCATED(Int_Buf)) THEN ! Ver
         Int_BufSz = Int_BufSz + SIZE( Int_Buf )
         DEALLOCATE(Int_Buf)
      END IF
  IF ( Re_BufSz  .GT. 0 ) THEN 
     ALLOCATE( ReKiBuf(  Re_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating ReKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF ( Db_BufSz  .GT. 0 ) THEN 
     ALLOCATE( DbKiBuf(  Db_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating DbKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF ( Int_BufSz  .GT. 0 ) THEN 
     ALLOCATE( IntKiBuf(  Int_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating IntKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF(OnlySize) RETURN ! return early if only trying to allocate buffers (not pack them)

  Re_Xferred  = 1
  Db_Xferred  = 1
  Int_Xferred = 1

      CALL NWTC_Library_Packprogdesc( Re_Buf, Db_Buf, Int_Buf, InData%Ver, ErrStat2, ErrMsg2, OnlySize ) ! Ver 
        CALL SetErrStat(ErrStat2, ErrMsg2, ErrStat, ErrMsg, RoutineName)
        IF (ErrStat >= AbortErrLev) RETURN

      IF(ALLOCATED(Re_Buf)) THEN
        IntKiBuf( Int_Xferred ) = SIZE(Re_Buf); Int_Xferred = Int_Xferred + 1
        IF (SIZE(Re_Buf) > 0) ReKiBuf( Re_Xferred:Re_Xferred+SIZE(Re_Buf)-1 ) = Re_Buf
        Re_Xferred = Re_Xferred + SIZE(Re_Buf)
        DEALLOCATE(Re_Buf)
      ELSE
        IntKiBuf( Int_Xferred ) = 0; Int_Xferred = Int_Xferred + 1
      ENDIF
      IF(ALLOCATED(Db_Buf)) THEN
        IntKiBuf( Int_Xferred ) = SIZE(Db_Buf); Int_Xferred = Int_Xferred + 1
        IF (SIZE(Db_Buf) > 0) DbKiBuf( Db_Xferred:Db_Xferred+SIZE(Db_Buf)-1 ) = Db_Buf
        Db_Xferred = Db_Xferred + SIZE(Db_Buf)
        DEALLOCATE(Db_Buf)
      ELSE
        IntKiBuf( Int_Xferred ) = 0; Int_Xferred = Int_Xferred + 1
      ENDIF
      IF(ALLOCATED(Int_Buf)) THEN
        IntKiBuf( Int_Xferred ) = SIZE(Int_Buf); Int_Xferred = Int_Xferred + 1
        IF (SIZE(Int_Buf) > 0) IntKiBuf( Int_Xferred:Int_Xferred+SIZE(Int_Buf)-1 ) = Int_Buf
        Int_Xferred = Int_Xferred + SIZE(Int_Buf)
        DEALLOCATE(Int_Buf)
      ELSE
        IntKiBuf( Int_Xferred ) = 0; Int_Xferred = Int_Xferred + 1
      ENDIF
 END SUBROUTINE IfW_4Dext_PackInitOutput

 SUBROUTINE IfW_4Dext_UnPackInitOutput( ReKiBuf, DbKiBuf, IntKiBuf, Outdata, ErrStat, ErrMsg )
  REAL(ReKi),      ALLOCATABLE, INTENT(IN   ) :: ReKiBuf(:)
  REAL(DbKi),      ALLOCATABLE, INTENT(IN   ) :: DbKiBuf(:)
  INTEGER(IntKi),  ALLOCATABLE, INTENT(IN   ) :: IntKiBuf(:)
  TYPE(IfW_4Dext_InitOutputType), INTENT(INOUT) :: OutData
  INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
  CHARACTER(*),    INTENT(  OUT) :: ErrMsg
    ! Local variables
  INTEGER(IntKi)                 :: Buf_size
  INTEGER(IntKi)                 :: Re_Xferred
  INTEGER(IntKi)                 :: Db_Xferred
  INTEGER(IntKi)                 :: Int_Xferred
  INTEGER(IntKi)                 :: i
  LOGICAL                        :: mask0
  LOGICAL, ALLOCATABLE           :: mask1(:)
  LOGICAL, ALLOCATABLE           :: mask2(:,:)
  LOGICAL, ALLOCATABLE           :: mask3(:,:,:)
  LOGICAL, ALLOCATABLE           :: mask4(:,:,:,:)
  LOGICAL, ALLOCATABLE           :: mask5(:,:,:,:,:)
  INTEGER(IntKi)                 :: ErrStat2
  CHARACTER(ErrMsgLen)           :: ErrMsg2
  CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_UnPackInitOutput'
 ! buffers to store meshes, if any
  REAL(ReKi),      ALLOCATABLE   :: Re_Buf(:)
  REAL(DbKi),      ALLOCATABLE   :: Db_Buf(:)
  INTEGER(IntKi),  ALLOCATABLE   :: Int_Buf(:)
    !
  ErrStat = ErrID_None
  ErrMsg  = ""
  Re_Xferred  = 1
  Db_Xferred  = 1
  Int_Xferred  = 1
      Buf_size=IntKiBuf( Int_Xferred )
      Int_Xferred = Int_Xferred + 1
      IF(Buf_size > 0) THEN
        ALLOCATE(Re_Buf(Buf_size),STAT=ErrStat2)
        IF (ErrStat2 /= 0) THEN 
           CALL SetErrStat(ErrID_Fatal, 'Error allocating Re_Buf.', ErrStat, ErrMsg,RoutineName)
           RETURN
        END IF
        Re_Buf = ReKiBuf( Re_Xferred:Re_Xferred+Buf_size-1 )
        Re_Xferred = Re_Xferred + Buf_size
      END IF
      Buf_size=IntKiBuf( Int_Xferred )
      Int_Xferred = Int_Xferred + 1
      IF(Buf_size > 0) THEN
        ALLOCATE(Db_Buf(Buf_size),STAT=ErrStat2)
        IF (ErrStat2 /= 0) THEN 
           CALL SetErrStat(ErrID_Fatal, 'Error allocating Db_Buf.', ErrStat, ErrMsg,RoutineName)
           RETURN
        END IF
        Db_Buf = DbKiBuf( Db_Xferred:Db_Xferred+Buf_size-1 )
        Db_Xferred = Db_Xferred + Buf_size
      END IF
      Buf_size=IntKiBuf( Int_Xferred )
      Int_Xferred = Int_Xferred + 1
      IF(Buf_size > 0) THEN
        ALLOCATE(Int_Buf(Buf_size),STAT=ErrStat2)
        IF (ErrStat2 /= 0) THEN 
           CALL SetErrStat(ErrID_Fatal, 'Error allocating Int_Buf.', ErrStat, ErrMsg,RoutineName)
           RETURN
        END IF
        Int_Buf = IntKiBuf( Int_Xferred:Int_Xferred+Buf_size-1 )
        Int_Xferred = Int_Xferred + Buf_size
      END IF
      CALL NWTC_Library_Unpackprogdesc( Re_Buf, Db_Buf, Int_Buf, OutData%Ver, ErrStat2, ErrMsg2 ) ! Ver 
        CALL SetErrStat(ErrStat2, ErrMsg2, ErrStat, ErrMsg, RoutineName)
        IF (ErrStat >= AbortErrLev) RETURN

      IF(ALLOCATED(Re_Buf )) DEALLOCATE(Re_Buf )
      IF(ALLOCATED(Db_Buf )) DEALLOCATE(Db_Buf )
      IF(ALLOCATED(Int_Buf)) DEALLOCATE(Int_Buf)
 END SUBROUTINE IfW_4Dext_UnPackInitOutput

 SUBROUTINE IfW_4Dext_CopyMisc( SrcMiscData, DstMiscData, CtrlCode, ErrStat, ErrMsg )
   TYPE(IfW_4Dext_MiscVarType), INTENT(IN) :: SrcMiscData
   TYPE(IfW_4Dext_MiscVarType), INTENT(INOUT) :: DstMiscData
   INTEGER(IntKi),  INTENT(IN   ) :: CtrlCode
   INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
   CHARACTER(*),    INTENT(  OUT) :: ErrMsg
! Local 
   INTEGER(IntKi)                 :: i,j,k
   INTEGER(IntKi)                 :: i1, i1_l, i1_u  !  bounds (upper/lower) for an array dimension 1
   INTEGER(IntKi)                 :: i2, i2_l, i2_u  !  bounds (upper/lower) for an array dimension 2
   INTEGER(IntKi)                 :: i3, i3_l, i3_u  !  bounds (upper/lower) for an array dimension 3
   INTEGER(IntKi)                 :: i4, i4_l, i4_u  !  bounds (upper/lower) for an array dimension 4
   INTEGER(IntKi)                 :: i5, i5_l, i5_u  !  bounds (upper/lower) for an array dimension 5
   INTEGER(IntKi)                 :: ErrStat2
   CHARACTER(ErrMsgLen)           :: ErrMsg2
   CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_CopyMisc'
! 
   ErrStat = ErrID_None
   ErrMsg  = ""
IF (ALLOCATED(SrcMiscData%V)) THEN
  i1_l = LBOUND(SrcMiscData%V,1)
  i1_u = UBOUND(SrcMiscData%V,1)
  i2_l = LBOUND(SrcMiscData%V,2)
  i2_u = UBOUND(SrcMiscData%V,2)
  i3_l = LBOUND(SrcMiscData%V,3)
  i3_u = UBOUND(SrcMiscData%V,3)
  i4_l = LBOUND(SrcMiscData%V,4)
  i4_u = UBOUND(SrcMiscData%V,4)
  i5_l = LBOUND(SrcMiscData%V,5)
  i5_u = UBOUND(SrcMiscData%V,5)
  IF (.NOT. ALLOCATED(DstMiscData%V)) THEN 
    ALLOCATE(DstMiscData%V(i1_l:i1_u,i2_l:i2_u,i3_l:i3_u,i4_l:i4_u,i5_l:i5_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
      CALL SetErrStat(ErrID_Fatal, 'Error allocating DstMiscData%V.', ErrStat, ErrMsg,RoutineName)
      RETURN
    END IF
  END IF
    DstMiscData%V = SrcMiscData%V
ENDIF
    DstMiscData%TgridStart = SrcMiscData%TgridStart
 END SUBROUTINE IfW_4Dext_CopyMisc

 SUBROUTINE IfW_4Dext_DestroyMisc( MiscData, ErrStat, ErrMsg )
  TYPE(IfW_4Dext_MiscVarType), INTENT(INOUT) :: MiscData
  INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
  CHARACTER(*),    INTENT(  OUT) :: ErrMsg
  CHARACTER(*),    PARAMETER :: RoutineName = 'IfW_4Dext_DestroyMisc'
  INTEGER(IntKi)                 :: i, i1, i2, i3, i4, i5 
! 
  ErrStat = ErrID_None
  ErrMsg  = ""
IF (ALLOCATED(MiscData%V)) THEN
  DEALLOCATE(MiscData%V)
ENDIF
 END SUBROUTINE IfW_4Dext_DestroyMisc

 SUBROUTINE IfW_4Dext_PackMisc( ReKiBuf, DbKiBuf, IntKiBuf, Indata, ErrStat, ErrMsg, SizeOnly )
  REAL(ReKi),       ALLOCATABLE, INTENT(  OUT) :: ReKiBuf(:)
  REAL(DbKi),       ALLOCATABLE, INTENT(  OUT) :: DbKiBuf(:)
  INTEGER(IntKi),   ALLOCATABLE, INTENT(  OUT) :: IntKiBuf(:)
  TYPE(IfW_4Dext_MiscVarType),  INTENT(IN) :: InData
  INTEGER(IntKi),   INTENT(  OUT) :: ErrStat
  CHARACTER(*),     INTENT(  OUT) :: ErrMsg
  LOGICAL,OPTIONAL, INTENT(IN   ) :: SizeOnly
    ! Local variables
  INTEGER(IntKi)                 :: Re_BufSz
  INTEGER(IntKi)                 :: Re_Xferred
  INTEGER(IntKi)                 :: Db_BufSz
  INTEGER(IntKi)                 :: Db_Xferred
  INTEGER(IntKi)                 :: Int_BufSz
  INTEGER(IntKi)                 :: Int_Xferred
  INTEGER(IntKi)                 :: i,i1,i2,i3,i4,i5
  LOGICAL                        :: OnlySize ! if present and true, do not pack, just allocate buffers
  INTEGER(IntKi)                 :: ErrStat2
  CHARACTER(ErrMsgLen)           :: ErrMsg2
  CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_PackMisc'
 ! buffers to store subtypes, if any
  REAL(ReKi),      ALLOCATABLE   :: Re_Buf(:)
  REAL(DbKi),      ALLOCATABLE   :: Db_Buf(:)
  INTEGER(IntKi),  ALLOCATABLE   :: Int_Buf(:)

  OnlySize = .FALSE.
  IF ( PRESENT(SizeOnly) ) THEN
    OnlySize = SizeOnly
  ENDIF
    !
  ErrStat = ErrID_None
  ErrMsg  = ""
  Re_BufSz  = 0
  Db_BufSz  = 0
  Int_BufSz  = 0
  Int_BufSz   = Int_BufSz   + 1     ! V allocated yes/no
  IF ( ALLOCATED(InData%V) ) THEN
    Int_BufSz   = Int_BufSz   + 2*5  ! V upper/lower bounds for each dimension
      Re_BufSz   = Re_BufSz   + SIZE(InData%V)  ! V
  END IF
      Re_BufSz   = Re_BufSz   + 1  ! TgridStart
  IF ( Re_BufSz  .GT. 0 ) THEN 
     ALLOCATE( ReKiBuf(  Re_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating ReKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF ( Db_BufSz  .GT. 0 ) THEN 
     ALLOCATE( DbKiBuf(  Db_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating DbKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF ( Int_BufSz  .GT. 0 ) THEN 
     ALLOCATE( IntKiBuf(  Int_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating IntKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF(OnlySize) RETURN ! return early if only trying to allocate buffers (not pack them)

  Re_Xferred  = 1
  Db_Xferred  = 1
  Int_Xferred = 1

  IF ( .NOT. ALLOCATED(InData%V) ) THEN
    IntKiBuf( Int_Xferred ) = 0
    Int_Xferred = Int_Xferred + 1
  ELSE
    IntKiBuf( Int_Xferred ) = 1
    Int_Xferred = Int_Xferred + 1
    IntKiBuf( Int_Xferred    ) = LBOUND(InData%V,1)
    IntKiBuf( Int_Xferred + 1) = UBOUND(InData%V,1)
    Int_Xferred = Int_Xferred + 2
    IntKiBuf( Int_Xferred    ) = LBOUND(InData%V,2)
    IntKiBuf( Int_Xferred + 1) = UBOUND(InData%V,2)
    Int_Xferred = Int_Xferred + 2
    IntKiBuf( Int_Xferred    ) = LBOUND(InData%V,3)
    IntKiBuf( Int_Xferred + 1) = UBOUND(InData%V,3)
    Int_Xferred = Int_Xferred + 2
    IntKiBuf( Int_Xferred    ) = LBOUND(InData%V,4)
    IntKiBuf( Int_Xferred + 1) = UBOUND(InData%V,4)
    Int_Xferred = Int_Xferred + 2
    IntKiBuf( Int_Xferred    ) = LBOUND(InData%V,5)
    IntKiBuf( Int_Xferred + 1) = UBOUND(InData%V,5)
    Int_Xferred = Int_Xferred + 2

      IF (SIZE(InData%V)>0) ReKiBuf ( Re_Xferred:Re_Xferred+(SIZE(InData%V))-1 ) = PACK(InData%V,.TRUE.)
      Re_Xferred   = Re_Xferred   + SIZE(InData%V)
  END IF
      ReKiBuf ( Re_Xferred:Re_Xferred+(1)-1 ) = InData%TgridStart
      Re_Xferred   = Re_Xferred   + 1
 END SUBROUTINE IfW_4Dext_PackMisc

 SUBROUTINE IfW_4Dext_UnPackMisc( ReKiBuf, DbKiBuf, IntKiBuf, Outdata, ErrStat, ErrMsg )
  REAL(ReKi),      ALLOCATABLE, INTENT(IN   ) :: ReKiBuf(:)
  REAL(DbKi),      ALLOCATABLE, INTENT(IN   ) :: DbKiBuf(:)
  INTEGER(IntKi),  ALLOCATABLE, INTENT(IN   ) :: IntKiBuf(:)
  TYPE(IfW_4Dext_MiscVarType), INTENT(INOUT) :: OutData
  INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
  CHARACTER(*),    INTENT(  OUT) :: ErrMsg
    ! Local variables
  INTEGER(IntKi)                 :: Buf_size
  INTEGER(IntKi)                 :: Re_Xferred
  INTEGER(IntKi)                 :: Db_Xferred
  INTEGER(IntKi)                 :: Int_Xferred
  INTEGER(IntKi)                 :: i
  LOGICAL                        :: mask0
  LOGICAL, ALLOCATABLE           :: mask1(:)
  LOGICAL, ALLOCATABLE           :: mask2(:,:)
  LOGICAL, ALLOCATABLE           :: mask3(:,:,:)
  LOGICAL, ALLOCATABLE           :: mask4(:,:,:,:)
  LOGICAL, ALLOCATABLE           :: mask5(:,:,:,:,:)
  INTEGER(IntKi)                 :: i1, i1_l, i1_u  !  bounds (upper/lower) for an array dimension 1
  INTEGER(IntKi)                 :: i2, i2_l, i2_u  !  bounds (upper/lower) for an array dimension 2
  INTEGER(IntKi)                 :: i3, i3_l, i3_u  !  bounds (upper/lower) for an array dimension 3
  INTEGER(IntKi)                 :: i4, i4_l, i4_u  !  bounds (upper/lower) for an array dimension 4
  INTEGER(IntKi)                 :: i5, i5_l, i5_u  !  bounds (upper/lower) for an array dimension 5
  INTEGER(IntKi)                 :: ErrStat2
  CHARACTER(ErrMsgLen)           :: ErrMsg2
  CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_UnPackMisc'
 ! buffers to store meshes, if any
  REAL(ReKi),      ALLOCATABLE   :: Re_Buf(:)
  REAL(DbKi),      ALLOCATABLE   :: Db_Buf(:)
  INTEGER(IntKi),  ALLOCATABLE   :: Int_Buf(:)
    !
  ErrStat = ErrID_None
  ErrMsg  = ""
  Re_Xferred  = 1
  Db_Xferred  = 1
  Int_Xferred  = 1
  IF ( IntKiBuf( Int_Xferred ) == 0 ) THEN  ! V not allocated
    Int_Xferred = Int_Xferred + 1
  ELSE
    Int_Xferred = Int_Xferred + 1
    i1_l = IntKiBuf( Int_Xferred    )
    i1_u = IntKiBuf( Int_Xferred + 1)
    Int_Xferred = Int_Xferred + 2
    i2_l = IntKiBuf( Int_Xferred    )
    i2_u = IntKiBuf( Int_Xferred + 1)
    Int_Xferred = Int_Xferred + 2
    i3_l = IntKiBuf( Int_Xferred    )
    i3_u = IntKiBuf( Int_Xferred + 1)
    Int_Xferred = Int_Xferred + 2
    i4_l = IntKiBuf( Int_Xferred    )
    i4_u = IntKiBuf( Int_Xferred + 1)
    Int_Xferred = Int_Xferred + 2
    i5_l = IntKiBuf( Int_Xferred    )
    i5_u = IntKiBuf( Int_Xferred + 1)
    Int_Xferred = Int_Xferred + 2
    IF (ALLOCATED(OutData%V)) DEALLOCATE(OutData%V)
    ALLOCATE(OutData%V(i1_l:i1_u,i2_l:i2_u,i3_l:i3_u,i4_l:i4_u,i5_l:i5_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating OutData%V.', ErrStat, ErrMsg,RoutineName)
       RETURN
    END IF
    ALLOCATE(mask5(i1_l:i1_u,i2_l:i2_u,i3_l:i3_u,i4_l:i4_u,i5_l:i5_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating mask5.', ErrStat, ErrMsg,RoutineName)
       RETURN
    END IF
    mask5 = .TRUE. 
      IF (SIZE(OutData%V)>0) OutData%V = REAL( UNPACK(ReKiBuf( Re_Xferred:Re_Xferred+(SIZE(OutData%V))-1 ), mask5, 0.0_ReKi ), SiKi)
      Re_Xferred   = Re_Xferred   + SIZE(OutData%V)
    DEALLOCATE(mask5)
  END IF
      OutData%TgridStart = ReKiBuf( Re_Xferred )
      Re_Xferred   = Re_Xferred + 1
 END SUBROUTINE IfW_4Dext_UnPackMisc

 SUBROUTINE IfW_4Dext_CopyParam( SrcParamData, DstParamData, CtrlCode, ErrStat, ErrMsg )
   TYPE(IfW_4Dext_ParameterType), INTENT(IN) :: SrcParamData
   TYPE(IfW_4Dext_ParameterType), INTENT(INOUT) :: DstParamData
   INTEGER(IntKi),  INTENT(IN   ) :: CtrlCode
   INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
   CHARACTER(*),    INTENT(  OUT) :: ErrMsg
! Local 
   INTEGER(IntKi)                 :: i,j,k
   INTEGER(IntKi)                 :: i1, i1_l, i1_u  !  bounds (upper/lower) for an array dimension 1
   INTEGER(IntKi)                 :: ErrStat2
   CHARACTER(ErrMsgLen)           :: ErrMsg2
   CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_CopyParam'
! 
   ErrStat = ErrID_None
   ErrMsg  = ""
    DstParamData%n = SrcParamData%n
    DstParamData%delta = SrcParamData%delta
    DstParamData%pZero = SrcParamData%pZero
 END SUBROUTINE IfW_4Dext_CopyParam

 SUBROUTINE IfW_4Dext_DestroyParam( ParamData, ErrStat, ErrMsg )
  TYPE(IfW_4Dext_ParameterType), INTENT(INOUT) :: ParamData
  INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
  CHARACTER(*),    INTENT(  OUT) :: ErrMsg
  CHARACTER(*),    PARAMETER :: RoutineName = 'IfW_4Dext_DestroyParam'
  INTEGER(IntKi)                 :: i, i1, i2, i3, i4, i5 
! 
  ErrStat = ErrID_None
  ErrMsg  = ""
 END SUBROUTINE IfW_4Dext_DestroyParam

 SUBROUTINE IfW_4Dext_PackParam( ReKiBuf, DbKiBuf, IntKiBuf, Indata, ErrStat, ErrMsg, SizeOnly )
  REAL(ReKi),       ALLOCATABLE, INTENT(  OUT) :: ReKiBuf(:)
  REAL(DbKi),       ALLOCATABLE, INTENT(  OUT) :: DbKiBuf(:)
  INTEGER(IntKi),   ALLOCATABLE, INTENT(  OUT) :: IntKiBuf(:)
  TYPE(IfW_4Dext_ParameterType),  INTENT(IN) :: InData
  INTEGER(IntKi),   INTENT(  OUT) :: ErrStat
  CHARACTER(*),     INTENT(  OUT) :: ErrMsg
  LOGICAL,OPTIONAL, INTENT(IN   ) :: SizeOnly
    ! Local variables
  INTEGER(IntKi)                 :: Re_BufSz
  INTEGER(IntKi)                 :: Re_Xferred
  INTEGER(IntKi)                 :: Db_BufSz
  INTEGER(IntKi)                 :: Db_Xferred
  INTEGER(IntKi)                 :: Int_BufSz
  INTEGER(IntKi)                 :: Int_Xferred
  INTEGER(IntKi)                 :: i,i1,i2,i3,i4,i5
  LOGICAL                        :: OnlySize ! if present and true, do not pack, just allocate buffers
  INTEGER(IntKi)                 :: ErrStat2
  CHARACTER(ErrMsgLen)           :: ErrMsg2
  CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_PackParam'
 ! buffers to store subtypes, if any
  REAL(ReKi),      ALLOCATABLE   :: Re_Buf(:)
  REAL(DbKi),      ALLOCATABLE   :: Db_Buf(:)
  INTEGER(IntKi),  ALLOCATABLE   :: Int_Buf(:)

  OnlySize = .FALSE.
  IF ( PRESENT(SizeOnly) ) THEN
    OnlySize = SizeOnly
  ENDIF
    !
  ErrStat = ErrID_None
  ErrMsg  = ""
  Re_BufSz  = 0
  Db_BufSz  = 0
  Int_BufSz  = 0
      Int_BufSz  = Int_BufSz  + SIZE(InData%n)  ! n
      Re_BufSz   = Re_BufSz   + SIZE(InData%delta)  ! delta
      Re_BufSz   = Re_BufSz   + SIZE(InData%pZero)  ! pZero
  IF ( Re_BufSz  .GT. 0 ) THEN 
     ALLOCATE( ReKiBuf(  Re_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating ReKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF ( Db_BufSz  .GT. 0 ) THEN 
     ALLOCATE( DbKiBuf(  Db_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating DbKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF ( Int_BufSz  .GT. 0 ) THEN 
     ALLOCATE( IntKiBuf(  Int_BufSz  ), STAT=ErrStat2 )
     IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating IntKiBuf.', ErrStat, ErrMsg,RoutineName)
       RETURN
     END IF
  END IF
  IF(OnlySize) RETURN ! return early if only trying to allocate buffers (not pack them)

  Re_Xferred  = 1
  Db_Xferred  = 1
  Int_Xferred = 1

      IntKiBuf ( Int_Xferred:Int_Xferred+(SIZE(InData%n))-1 ) = PACK(InData%n,.TRUE.)
      Int_Xferred   = Int_Xferred   + SIZE(InData%n)
      ReKiBuf ( Re_Xferred:Re_Xferred+(SIZE(InData%delta))-1 ) = PACK(InData%delta,.TRUE.)
      Re_Xferred   = Re_Xferred   + SIZE(InData%delta)
      ReKiBuf ( Re_Xferred:Re_Xferred+(SIZE(InData%pZero))-1 ) = PACK(InData%pZero,.TRUE.)
      Re_Xferred   = Re_Xferred   + SIZE(InData%pZero)
 END SUBROUTINE IfW_4Dext_PackParam

 SUBROUTINE IfW_4Dext_UnPackParam( ReKiBuf, DbKiBuf, IntKiBuf, Outdata, ErrStat, ErrMsg )
  REAL(ReKi),      ALLOCATABLE, INTENT(IN   ) :: ReKiBuf(:)
  REAL(DbKi),      ALLOCATABLE, INTENT(IN   ) :: DbKiBuf(:)
  INTEGER(IntKi),  ALLOCATABLE, INTENT(IN   ) :: IntKiBuf(:)
  TYPE(IfW_4Dext_ParameterType), INTENT(INOUT) :: OutData
  INTEGER(IntKi),  INTENT(  OUT) :: ErrStat
  CHARACTER(*),    INTENT(  OUT) :: ErrMsg
    ! Local variables
  INTEGER(IntKi)                 :: Buf_size
  INTEGER(IntKi)                 :: Re_Xferred
  INTEGER(IntKi)                 :: Db_Xferred
  INTEGER(IntKi)                 :: Int_Xferred
  INTEGER(IntKi)                 :: i
  LOGICAL                        :: mask0
  LOGICAL, ALLOCATABLE           :: mask1(:)
  LOGICAL, ALLOCATABLE           :: mask2(:,:)
  LOGICAL, ALLOCATABLE           :: mask3(:,:,:)
  LOGICAL, ALLOCATABLE           :: mask4(:,:,:,:)
  LOGICAL, ALLOCATABLE           :: mask5(:,:,:,:,:)
  INTEGER(IntKi)                 :: i1, i1_l, i1_u  !  bounds (upper/lower) for an array dimension 1
  INTEGER(IntKi)                 :: ErrStat2
  CHARACTER(ErrMsgLen)           :: ErrMsg2
  CHARACTER(*), PARAMETER        :: RoutineName = 'IfW_4Dext_UnPackParam'
 ! buffers to store meshes, if any
  REAL(ReKi),      ALLOCATABLE   :: Re_Buf(:)
  REAL(DbKi),      ALLOCATABLE   :: Db_Buf(:)
  INTEGER(IntKi),  ALLOCATABLE   :: Int_Buf(:)
    !
  ErrStat = ErrID_None
  ErrMsg  = ""
  Re_Xferred  = 1
  Db_Xferred  = 1
  Int_Xferred  = 1
    i1_l = LBOUND(OutData%n,1)
    i1_u = UBOUND(OutData%n,1)
    ALLOCATE(mask1(i1_l:i1_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating mask1.', ErrStat, ErrMsg,RoutineName)
       RETURN
    END IF
    mask1 = .TRUE. 
      OutData%n = UNPACK( IntKiBuf ( Int_Xferred:Int_Xferred+(SIZE(OutData%n))-1 ), mask1, 0_IntKi )
      Int_Xferred   = Int_Xferred   + SIZE(OutData%n)
    DEALLOCATE(mask1)
    i1_l = LBOUND(OutData%delta,1)
    i1_u = UBOUND(OutData%delta,1)
    ALLOCATE(mask1(i1_l:i1_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating mask1.', ErrStat, ErrMsg,RoutineName)
       RETURN
    END IF
    mask1 = .TRUE. 
      OutData%delta = UNPACK(ReKiBuf( Re_Xferred:Re_Xferred+(SIZE(OutData%delta))-1 ), mask1, 0.0_ReKi )
      Re_Xferred   = Re_Xferred   + SIZE(OutData%delta)
    DEALLOCATE(mask1)
    i1_l = LBOUND(OutData%pZero,1)
    i1_u = UBOUND(OutData%pZero,1)
    ALLOCATE(mask1(i1_l:i1_u),STAT=ErrStat2)
    IF (ErrStat2 /= 0) THEN 
       CALL SetErrStat(ErrID_Fatal, 'Error allocating mask1.', ErrStat, ErrMsg,RoutineName)
       RETURN
    END IF
    mask1 = .TRUE. 
      OutData%pZero = UNPACK(ReKiBuf( Re_Xferred:Re_Xferred+(SIZE(OutData%pZero))-1 ), mask1, 0.0_ReKi )
      Re_Xferred   = Re_Xferred   + SIZE(OutData%pZero)
    DEALLOCATE(mask1)
 END SUBROUTINE IfW_4Dext_UnPackParam

END MODULE IfW_4Dext_Types
!ENDOFREGISTRYGENERATEDFILE