!**********************************************************************************************************************************
!> ## SoilDyn
!! The SoilDyn and SoilDyn_Types modules make up a template for creating user-defined calculations in the FAST Modularization
!! Framework. SoilDyn_Types will be auto-generated by the FAST registry program, based on the variables specified in the
!! SoilDyn_Registry.txt file.
!!
!! This template file contains comments in the style required for Doxygen, and it contains methods for handling errors.
!!
!! "SoilDyn" should be replaced with the name of your module. Example: ElastoDyn \n
!! "SoilDyn" (in SoilDyn_*) should be replaced with the module name or an abbreviation of it. Example: ED
! ..................................................................................................................................
!! ## LICENSING
!! Copyright (C) 2012-2013, 2015-2016  National Renewable Energy Laboratory
!!
!!    This file is part of SoilDyn.
!!
!! Licensed under the Apache License, Version 2.0 (the "License");
!! you may not use this file except in compliance with the License.
!! You may obtain a copy of the License at
!!
!!     http://www.apache.org/licenses/LICENSE-2.0
!!
!! Unless required by applicable law or agreed to in writing, software
!! distributed under the License is distributed on an "AS IS" BASIS,
!! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!! See the License for the specific language governing permissions and
!! limitations under the License.
!**********************************************************************************************************************************
MODULE SoilDyn

!FIXME: stuff we need to do
!     -  cannot allow checkpoints.  The DLL starts at T=0 always, and builds the history for histerysis loops
!     -  Is the stiffness matrix returned about a given operating point, or is it just what is read in?  Can it be used in linearization?
!     -

   USE SoilDyn_Types
   USE SoilDyn_IO
   USE NWTC_Library
   USE REDWINinterface

   IMPLICIT NONE

   PRIVATE

   TYPE(ProgDesc), PARAMETER :: SlD_Ver = ProgDesc( 'SoilDyn', 'v0.01.00', '99-Feb-2020' ) !< module date/version information

      ! ..... Public Subroutines ...................................................................................................
   PUBLIC :: SlD_Init                          !  Initialization routine
   PUBLIC :: SlD_End                           !  Ending routine (includes clean up)
   PUBLIC :: SlD_UpdateStates                  !  Loose coupling routine for solving for constraint states, integrating
   PUBLIC :: SlD_CalcOutput                    !  Routine for computing outputs

!NOTE: these are placeholders for now.
!!!   PUBLIC :: SlD_CalcConstrStateResidual        !  Tight coupling routine for returning the constraint state residual
!!!   PUBLIC :: SlD_CalcContStateDeriv             !  Tight coupling routine for computing derivatives of continuous states
!!!   PUBLIC :: SlD_UpdateDiscState                !  Tight coupling routine for updating discrete states
!!!   PUBLIC :: SlD_JacobianPInput                 !  Routine to compute the Jacobians of the output (Y), continuous- (X), discrete- (Xd), and constraint-state (Z) functions all with respect to the inputs (u)
!!!   PUBLIC :: SlD_JacobianPContState             !  Routine to compute the Jacobians of the output (Y), continuous- (X), discrete- (Xd), and constraint-state (Z) functions all with respect to the continuous states (x)
!!!   PUBLIC :: SlD_JacobianPDiscState             !  Routine to compute the Jacobians of the output (Y), continuous- (X), discrete- (Xd), and constraint-state (Z) functions all with respect to the discrete states (xd)
!!!   PUBLIC :: SlD_JacobianPConstrState           !  Routine to compute the Jacobians of the output (Y), continuous- (X), discrete- (Xd), and constraint-state (Z) functions all with respect to the constraint states (z)
!!!   PUBLIC :: SlD_GetOP                          !  Routine to get the operating-point values for linearization (from data structures to arrays)

contains

!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!> This routine is called at the start of the simulation to perform initialization steps.
!! The parameters are set here and not changed during the simulation.
!! The initial states and initial guess for the input are defined.
subroutine SlD_Init( InitInp, u, p, x, xd, z, OtherState, y, m, Interval, InitOut, ErrStat, ErrMsg )

   type(SlD_InitInputType),            intent(in   )  :: InitInp     !< Input data for initialization routine
   type(SlD_InputType),                intent(  out)  :: u           !< An initial guess for the input; input mesh must be defined
   type(SlD_ParameterType),            intent(  out)  :: p           !< Parameters
   type(SlD_ContinuousStateType),      intent(  out)  :: x           !< Initial continuous states
   type(SlD_DiscreteStateType),        intent(  out)  :: xd          !< Initial discrete states
   type(SlD_ConstraintStateType),      intent(  out)  :: z           !< Initial guess of the constraint states
   type(SlD_OtherStateType),           intent(  out)  :: OtherState  !< Initial other states (logical, etc)
   type(SlD_OutputType),               intent(  out)  :: y           !< Initial system outputs
   type(SlD_MiscVarType),              intent(  out)  :: m           !< Misc variables for optimization (not copied in glue code)
   real(DbKi),                         intent(inout)  :: Interval    !< Coupling interval in seconds
   type(SlD_InitOutputType),           intent(  out)  :: InitOut     !< Output for initialization routine
   integer(IntKi),                     intent(  out)  :: ErrStat     !< Error status of the operation
   character(*),                       intent(  out)  :: ErrMsg      !< Error message if ErrStat /= ErrID_None

      ! local variables
   integer(IntKi)                                     :: j           !< generic counter
   integer(IntKi)                                     :: ErrStat2    !< local error status
   character(ErrMsgLen)                               :: ErrMsg2     !< local error message
   character(*), parameter                            :: RoutineName = 'SlD_Init'
   type(SlD_InputFile)                                :: InputFileData   !< Data stored in the module's input file
   character(1024)                                    :: EchoFileName

      ! Initialize variables
   ErrStat = ErrID_None
   ErrMsg  = ""

      ! Initialize the NWTC Subroutine Library
   call NWTC_Init( )

      ! Display the module information
   call DispNVD( SlD_Ver )

      ! Set some names
   call GetRoot( InitInp%InputFile, p%RootFileName )
   p%EchoFileName  = TRIM(p%RootFileName)//".ech"
   p%SumFileName   = TRIM(p%RootFileName)//"SlD.sum"


   call SlD_ReadInput( InitInp%InputFile, p%EchoFileName, InputFileData, ErrStat2, ErrMsg2 );  if (Failed()) return;

      ! Define parameters here:
   p%DT           =  Interval
   p%DLL_Model    =  InputFileData%DLL_Model
   p%CalcOption   =  InputFileData%CalcOption

      ! Define initial system states here:
   x%DummyContState           = 0.0_ReKi
   xd%DummyDiscState          = 0.0_ReKi
   z%DummyConstrState         = 0.0_ReKi
   OtherState%DummyOtherState = 0.0_ReKi


!FIXME: set some initial values of y and u here)

   if (InitInp%Linearize) then

      ! If the module does not implement the four Jacobian routines at the end of this template, or the module cannot
      ! linearize with the features that are enabled, stop the simulation if InitInp%Linearize is true.

      CALL SetErrStat( ErrID_Fatal, 'SoilDyn cannot perform linearization analysis.', ErrStat, ErrMsg, RoutineName)
      return

      ! Otherwise, if the module does allow linearization, return the appropriate Jacobian row/column names and rotating-frame flags here:
      ! Allocate and set these variables: InitOut%LinNames_y, InitOut%LinNames_x, InitOut%LinNames_xd, InitOut%LinNames_z, InitOut%LinNames_u
      ! Allocate and set these variables: InitOut%RotFrame_y, InitOut%RotFrame_x, InitOut%RotFrame_xd, InitOut%RotFrame_z, InitOut%RotFrame_u

   end if

      ! Set miscvars: including dll_data arrays and checking for input files.
   call SlD_InitMisc( InputFileData, m, ErrStat2,ErrMsg2); if (Failed()) return;


   call SlD_InitMeshes( InputFileData, InitInp, u, y, p, m, ErrStat2,ErrMsg2);  if (Failed()) return;


   select case(p%CalcOption)
      case (Calc_StiffDamp)
      case (Calc_PYcurve)
      case (Calc_REDWIN)
         ! Initialize the dll
         do j=1,size(m%dll_data)
            call REDWINinterface_Init( InputFileData%DLL_FileName, InputFileData%DLL_ProcName, p%DLL_Trgt, p%DLL_Model, &
                  m%dll_data(j), p%UseREDWINinterface, ErrStat2, ErrMsg2); if (Failed()) return;
         enddo
   end select

      ! set paramaters for I/O data
   InitOut%Ver = SlD_Ver
   p%NumOuts   =  InputFileData%NumOuts
   call AllocAry( InitOut%WriteOutputHdr, p%NumOuts, 'WriteOutputHdr', errStat2, errMsg2 );  if (Failed()) return;
   call AllocAry( InitOut%WriteOutputUnt, p%NumOuts, 'WriteOutputUnt', errStat2, errMsg2 );  if (Failed()) return;
   call AllocAry( y%WriteOutput, p%NumOuts, 'WriteOutput', ErrStat2, ErrMsg2 ); if (Failed()) return;
   y%WriteOutput = 0

   call SetOutParam(InputFileData%OutList, p, ErrStat2, ErrMsg2);    if (Failed()) return;
   do j=1,p%NumOuts
      InitOut%WriteOutputHdr(j) = p%OutParam(j)%Name
      InitOut%WriteOutputUnt(j) = p%OutParam(j)%Units
   end do

contains
   logical function Failed()
      call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)
      Failed =    ErrStat >= AbortErrLev
   end function Failed

   !> Allocate arrays for storing the DLL input file names, and check that they exist. The DLL has no error checking (as of 2020.02.10)
   !! and will create empty input files before segfaulting.
   subroutine SlD_InitMisc( InputFileData, m, ErrStat, ErrMsg )
      type(SlD_InputFile),    intent(in   )  :: InputFileData  !< Data stored in the module's input file
      type(SlD_MiscVarType),  intent(inout)  :: m              !< Misc variables for optimization (not copied in glue code)
      integer(IntKi),         intent(  out)  :: ErrStat
      character(*),           intent(  out)  :: ErrMsg
      integer(IntKi)                         :: i              ! Generic counter
      integer(IntKi)                         :: ErrStat2       !< local error status
      character(ErrMsgLen)                   :: ErrMsg2        !< local error message
      logical                                :: FileExist
      character(1024)                        :: PropsLoc       !< Full path to PropsFile location
      character(1024)                        :: LDispLoc       !< Full path to LDispFile location

      ErrStat = ErrID_None
      ErrMsg  = ''

      select case(p%CalcOption)
         case (Calc_StiffDamp)
         case (Calc_PYcurve)
         case (Calc_REDWIN)
            !-------------------
            ! Set DLL data
            allocate( m%dll_data(InputFileData%DLL_NumPoints), STAT=ErrStat2 )
            if (ErrStat2 /= 0) then
               call SetErrStat(ErrID_Fatal, 'Could not allocate m%dll_data', ErrStat, ErrMsg, RoutineName)
               return
            endif

            ! Set the input file names and check they are not too long.  Existance checks done in the interface routine.
            do i=1,InputFileData%DLL_NumPoints
               m%dll_data(i)%PROPSfile = trim(InputFileData%DLL_PropsFile(i))
               if ( len(m%dll_data(i)%PROPSfile) < len_trim(InputFileData%DLL_PropsFile(i)) ) then
                  call SetErrStat(ErrID_Fatal, 'PropsFile #'//trim(Num2LStr(i))//' name is longer than '//trim(Num2LStr(len(m%dll_data(i)%PROPSfile)))// &
                              ' characters (DLL limititation)', ErrStat, ErrMsg, '')
               endif
               m%dll_data(i)%LDISPfile = trim(InputFileData%DLL_LDispFile(i))
               if ( len(m%dll_data(i)%LDISPfile) < len_trim(InputFileData%DLL_LDispFile(i)) ) then
                  call SetErrStat(ErrID_Fatal, 'LDispFile #'//trim(Num2LStr(i))//' name is longer than '//trim(Num2LStr(len(m%dll_data(i)%LDISPfile)))// &
                              ' characters (DLL limititation)', ErrStat, ErrMsg, '')
               endif
            enddo
      end select
      if (ErrStat >= AbortErrLev) return
   end subroutine SlD_InitMisc

   subroutine SlD_InitMeshes( InputFileData, InitInp, u, y, p, m, ErrStat, ErrMsg )
      type(SlD_InputFile),       intent(in   )  :: InputFileData  !< Data stored in the module's input file
      type(SlD_InitInputType),   intent(in   )  :: InitInp        !< Input data for initialization routine
      type(SlD_InputType),       intent(inout)  :: u              !< An initial guess for the input; input mesh must be defined
      type(SlD_OutputType),      intent(inout)  :: y              !< Initial system outputs
      type(SlD_ParameterType),   intent(inout)  :: p              !< Parameters
      type(SlD_MiscVarType),     intent(inout)  :: m              !< Misc variables for optimization (not copied in glue code)
      integer(IntKi),            intent(  out)  :: ErrStat
      character(*),              intent(  out)  :: ErrMsg
      integer(IntKi)                            :: i              ! Generic counter
      integer(IntKi)                            :: ErrStat2       !< local error status
      character(ErrMsgLen)                      :: ErrMsg2        !< local error message

      real(R8Ki)                                :: DCM(3,3)
      real(ReKi)                                :: Pos(3)
      real(ReKi),                allocatable    :: MeshLocations(:,:)

      select case(p%CalcOption)
         case (Calc_StiffDamp)
            p%NumPoints =  1_IntKi
!FIXME: update to allow more than one set of points
!            NumPoints   =  InputFileData%StiffDamp_NumPoints
!            call AllocAry(MeshLocations,3,p%NumPoints,'Mesh locations',ErrStat2,ErrMsg2);
!            do i=1,size(MeshLocations,2)
!               MeshLocations(1:3,i)  =  InputFileData%StiffDamp_locations(1:3,i)
!            enddo
         case (Calc_PYcurve)
            p%NumPoints =  InputFileData%PY_NumPoints
            call AllocAry(MeshLocations,3,p%NumPoints,'Mesh locations',ErrStat2,ErrMsg2);
            do i=1,size(MeshLocations,2)
               MeshLocations(1:3,i)  =  InputFileData%PY_locations(1:3,i)
            enddo
         case (Calc_REDWIN)
            p%NumPoints =  InputFileData%DLL_NumPoints
            call AllocAry(MeshLocations,3,p%NumPoints,'Mesh locations',ErrStat2,ErrMsg2);
            do i=1,size(MeshLocations,2)
               MeshLocations(1:3,i)  =  InputFileData%DLL_locations(1:3,i)
            enddo
      end select

      !.................................
      ! u%SoilMesh (for coupling with external codes)
      !.................................

      CALL MeshCreate(  BlankMesh         = u%SoilMesh          &
                     ,  IOS               = COMPONENT_INPUT       &
                     ,  NNodes            = p%NumPoints             &
                     ,  TranslationDisp   = .TRUE.                &
                     ,  TranslationVel    = .TRUE.                &
                     ,  TranslationAcc    = .TRUE.                &
                     ,  Orientation       = .TRUE.                &
                     ,  RotationVel       = .TRUE.                &
                     ,  RotationAcc       = .TRUE.                &
                     ,  ErrStat           = ErrStat2              &
                     ,  ErrMess           = ErrMsg2               )
         CALL SetErrStat( ErrStat2, ErrMsg2, ErrStat, ErrMsg, RoutineName )
         if (ErrStat>=AbortErrLev) return

      ! Assuming zero orientation displacement for start
      DCM = 0.0_DbKi
      DCM(1,1) = 1.0_DbKi
      DCM(2,2) = 1.0_DbKi
      DCM(3,3) = 1.0_DbKi

      do i=1,p%NumPoints
         CALL MeshPositionNode( Mesh    = u%SoilMesh            &
                              , INode   = i                       &
                              , Pos     = MeshLocations(1:3,i)    &
                              , ErrStat = ErrStat2                &
                              , ErrMess = ErrMsg2                 &
                              , Orient  = DCM                     )
            CALL SetErrStat( ErrStat2, ErrMsg2, ErrStat, ErrMsg, RoutineName )

         CALL MeshConstructElement  ( Mesh     = u%SoilMesh       &
                                    , Xelement = ELEMENT_POINT      &
                                    , P1       = i                  &
                                    , ErrStat  = ErrStat2           &
                                    , ErrMess  = ErrMsg2            )
            CALL SetErrStat( ErrStat2, ErrMsg2, ErrStat, ErrMsg, RoutineName )
      enddo

      CALL MeshCommit ( Mesh = u%SoilMesh, ErrStat = ErrStat2,  ErrMess = ErrMsg2 )
         CALL SetErrStat( ErrStat2, ErrMsg2, ErrStat, ErrMsg, RoutineName )
         if (ErrStat>=AbortErrLev) return


   !.................................
   ! y%SoilMesh (for coupling with external codes)
   !.................................

   CALL MeshCopy( SrcMesh   = u%SoilMesh     &
                 , DestMesh = y%SoilMesh  &
                 , CtrlCode = MESH_SIBLING     &
                 , IOS      = COMPONENT_OUTPUT &
                 , Force    = .TRUE.           &
                 , Moment   = .TRUE.           &
                 , ErrStat  = ErrStat2         &
                 , ErrMess  = ErrMsg2          )
      CALL SetErrStat( ErrStat2, ErrMsg2, ErrStat, ErrMsg, RoutineName )
      if (ErrStat>=AbortErrLev) RETURN



   end subroutine SlD_InitMeshes
end subroutine SlD_Init


!----------------------------------------------------------------------------------------------------------------------------------
!> This routine is called at the end of the simulation.
subroutine SlD_End( u, p, x, xd, z, OtherState, y, m, ErrStat, ErrMsg )

   type(SlD_InputType),               intent(inout)  :: u           !< System inputs
   type(SlD_ParameterType),           intent(inout)  :: p           !< Parameters
   type(SlD_ContinuousStateType),     intent(inout)  :: x           !< Continuous states
   type(SlD_DiscreteStateType),       intent(inout)  :: xd          !< Discrete states
   type(SlD_ConstraintStateType),     intent(inout)  :: z           !< Constraint states
   type(SlD_OtherStateType),          intent(inout)  :: OtherState  !< Other states
   type(SlD_OutputType),              intent(inout)  :: y           !< System outputs
   type(SlD_MiscVarType),             intent(inout)  :: m           !< Misc variables for optimization (not copied in glue code)
   integer(IntKi),                    intent(  out)  :: ErrStat     !< Error status of the operation
   character(*),                      intent(  out)  :: ErrMsg      !< Error message if ErrStat /= ErrID_None

      ! local variables
   integer(IntKi)                                    :: ErrStat2    ! local error status
   character(ErrMsgLen)                              :: ErrMsg2     ! local error message
   character(*), parameter                           :: RoutineName = 'SlD_End'

      ! Initialize ErrStat
   ErrStat = ErrID_None
   ErrMsg  = ""

      !! Place any last minute operations or calculations here:
   if (p%UseREDWINinterface) then
      call REDWINinterface_End( p%DLL_Trgt, ErrStat, ErrMsg )
   endif

      !! Close files here (but because of checkpoint-restart capability, it is not recommended to have files open during the simulation):

      !! Destroy the input data:
   call SlD_DestroyInput(        u,          ErrStat2,ErrMsg2);   call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)

      !! Destroy the parameter data: We won't keep warnings from p since it will complain about FreeDynamicLib when not compiled with it
   call SlD_DestroyParam(        p,          ErrStat2,ErrMsg2) !;   call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)

      !! Destroy the state data:
   call SlD_DestroyContState(    x,          ErrStat2,ErrMsg2);   call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)
   call SlD_DestroyDiscState(    xd,         ErrStat2,ErrMsg2);   call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)
   call SlD_DestroyConstrState(  z,          ErrStat2,ErrMsg2);   call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)
   call SlD_DestroyOtherState(   OtherState, ErrStat2,ErrMsg2);   call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)

      !! Destroy the output data:
   call SlD_DestroyOutput(       y,          ErrStat2,ErrMsg2);   call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)

      !! Destroy the misc data:
   call SlD_DestroyMisc(         m,          ErrStat2,ErrMsg2);   call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)

end subroutine SlD_End


!====================================================================================================
! The following routines were added to satisfy the framework, but do nothing useful.
!====================================================================================================
!> This is a loose coupling routine for solving constraint states, integrating continuous states, and updating discrete and other
!! states. Continuous, constraint, discrete, and other states are updated to values at t + Interval.
subroutine SlD_UpdateStates( t, n, Inputs, InputTimes, p, x, xd, z, OtherState, m, ErrStat, ErrMsg )
   real(DbKi),                         intent(in   ) :: t               !< Current simulation time in seconds
   integer(IntKi),                     intent(in   ) :: n               !< Current step of the simulation: t = n*Interval
   type(SlD_InputType),                intent(inout) :: Inputs(:)       !< Inputs at InputTimes (output from this routine only
                                                                        !!  because of record keeping in routines that copy meshes)
   real(DbKi),                         intent(in   ) :: InputTimes(:)   !< Times in seconds associated with Inputs
   type(SlD_ParameterType),            intent(in   ) :: p               !< Parameters
   type(SlD_ContinuousStateType),      intent(inout) :: x               !< Input: Continuous states at t;
                                                                        !!   Output: Continuous states at t + Interval
   type(SlD_DiscreteStateType),        intent(inout) :: xd              !< Input: Discrete states at t;
                                                                        !!   Output: Discrete states at t + Interval
   type(SlD_ConstraintStateType),      intent(inout) :: z               !< Input: Constraint states at t;
                                                                        !!   Output: Constraint states at t + Interval
   type(SlD_OtherStateType),           intent(inout) :: OtherState      !< Other states: Other states at t;
                                                                        !!   Output: Other states at t + Interval
   type(SlD_MiscVarType),              intent(inout) :: m               !<  Misc variables for optimization (not copied in glue code)
   integer(IntKi),                     intent(  out) :: ErrStat         !< Error status of the operation
   character(*),                       intent(  out) :: ErrMsg          !< Error message if ErrStat /= ErrID_None

      ! Local variables
   type(SlD_ContinuousStateType)                     :: dxdt            ! Continuous state derivatives at t
   type(SlD_DiscreteStateType)                       :: xd_t            ! Discrete states at t (copy)
   type(SlD_ConstraintStateType)                     :: z_Residual      ! Residual of the constraint state functions (Z)
   type(SlD_InputType)                               :: u               ! Instantaneous inputs
   integer(IntKi)                                    :: ErrStat2        ! local error status
   character(ErrMsgLen)                              :: ErrMsg2         ! local error message
   character(*), parameter                           :: RoutineName = 'SlD_UpdateStates'

      ! Initialize variables
   ErrStat   = ErrID_None           ! no error has occurred
   ErrMsg    = ""

!FIXME: is this even needed?  We don't have states that we have access to when using the REDWIN dll
   ! This subroutine contains an example of how the states could be updated. Developers will
   ! want to adjust the logic as necessary for their own situations.

!      ! Get the inputs at time t, based on the array of values sent by the glue code:
!   ! before calling ExtrapInterp routine, memory in u must be allocated; we can do that with a copy:
!   call SlD_CopyInput( Inputs(1), u, MESH_NEWCOPY, ErrStat2, ErrMsg2 )
!      call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)
!      if ( ErrStat >= AbortErrLev ) then
!         call cleanup()       ! to avoid memory leaks, we have to destroy the local variables that may have allocatable arrays or meshes
!         return
!      end if
!
!   call SlD_Input_ExtrapInterp( Inputs, InputTimes, u, t, ErrStat2, ErrMsg2 )
!      call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)
!      if ( ErrStat >= AbortErrLev ) then
!         call cleanup()
!         return
!      end if

      ! Destroy local variables before returning
   call cleanup()

contains
   subroutine cleanup()
      call SlD_DestroyInput(       u,          ErrStat2, ErrMsg2)
      call SlD_DestroyConstrState( Z_Residual, ErrStat2, ErrMsg2)
      call SlD_DestroyContState(   dxdt,       ErrStat2, ErrMsg2)
      call SlD_DestroyDiscState(   xd_t,       ErrStat2, ErrMsg2)
   end subroutine cleanup
end subroutine SlD_UpdateStates


!----------------------------------------------------------------------------------------------------------------------------------
!> This is a routine for computing outputs, used in both loose and tight coupling.
subroutine SlD_CalcOutput( t, u, p, x, xd, z, OtherState, y, m, ErrStat, ErrMsg )

   real(DbKi),                         intent(in   )  :: t           !< Current simulation time in seconds
   type(SlD_InputType),                intent(in   )  :: u           !< Inputs at t
   type(SlD_ParameterType),            intent(in   )  :: p           !< Parameters
   type(SlD_ContinuousStateType),      intent(in   )  :: x           !< Continuous states at t
   type(SlD_DiscreteStateType),        intent(in   )  :: xd          !< Discrete states at t
   type(SlD_ConstraintStateType),      intent(in   )  :: z           !< Constraint states at t
   type(SlD_OtherStateType),           intent(in   )  :: OtherState  !< Other states at t
   type(SlD_MiscVarType),              intent(inout)  :: m           !< Misc variables for optimization (not copied in glue code)
   type(SlD_OutputType),               intent(inout)  :: y           !< Outputs computed at t (Input only so that mesh con-
                                                                     !!   nectivity information does not have to be recalculated)
   integer(IntKi),                     intent(  out)  :: ErrStat     !< Error status of the operation
   character(*),                       intent(  out)  :: ErrMsg      !< Error message if ErrStat /= ErrID_None

   integer(IntKi)                                     :: ErrStat2    ! local error status
   character(ErrMsgLen)                               :: ErrMsg2     ! local error message
   character(*), parameter                            :: RoutineName = 'SlD_CalcOutput'

   real(ReKi)                                         :: AllOuts(0:MaxOutPts)
   real(R8Ki)                                         :: Displacement(6)
   real(R8Ki)                                         :: Force(6)
   integer(IntKi)                                     :: i           !< generic counter

      ! Initialize ErrStat
   ErrStat = ErrID_None
   ErrMsg  = ""

!FIXME: wrap logic around this for option 3 only
      ! Initialize the dll
   do i=1,size(m%dll_data)

      ! Copy displacement from point mesh (angles in radians -- REDWIN dll also uses rad)
      Displacement(1:3) = u%SoilMesh%TranslationDisp(1:3,i)                 ! Translations -- This is R8Ki in the mesh
      Displacement(4:6) = GetSmllRotAngs(u%SoilMesh%Orientation(1:3,1:3,i), ErrStat, ErrMsg)   ! Small angle assumption should be valid here -- Note we are assuming reforientation is 0

      call    REDWINinterface_CalcOutput( p%DLL_Trgt, p%DLL_Model, Displacement, Force, m%dll_data(i), ErrStat2, ErrMsg2 ); if (Failed()) return;

      ! Return reaction force onto the resulting point mesh
      y%SoilMesh%Force (1,i)  =  -real(Force(1),ReKi)
      y%SoilMesh%Force (2,i)  =  -real(Force(2),ReKi)
      y%SoilMesh%Force (3,i)  =  -real(Force(3),ReKi)
      y%SoilMesh%Moment(1,i)  =  -real(Force(4),ReKi)
      y%SoilMesh%Moment(2,i)  =  -real(Force(5),ReKi)
      y%SoilMesh%Moment(3,i)  =  -real(Force(6),ReKi)
   enddo

      ! Outputs
   call SlD_WriteOutput( p, AllOuts, u, y, m, ErrStat2, ErrMsg2 );     if (Failed()) return;
   do i=1,p%NumOuts
      y%WriteOutput(i) = p%OutParam(i)%SignM * Allouts( p%OutParam(i)%Indx )
   enddo

   return

contains
   logical function Failed()
      call SetErrStat(ErrStat2,ErrMsg2,ErrStat,ErrMsg,RoutineName)
      Failed =    ErrStat >= AbortErrLev
   end function Failed
end subroutine SlD_CalcOutput


END MODULE SoilDyn

!**********************************************************************************************************************************
!NOTE: the following have been omitted.  When we add the other methods for calculating (6x6 Stiffness/Damping) and the P-Y curve, then
!      some of these will need to be added.  Leaving this as a placeholder for the moment.
!SUBROUTINE SlD_CalcContStateDeriv( t, u, p, x, xd, z, OtherState, m, dxdt, ErrStat, ErrMsg )
!SUBROUTINE SlD_UpdateDiscState( t, n, u, p, x, xd, z, OtherState, m, ErrStat, ErrMsg )
!SUBROUTINE SlD_CalcConstrStateResidual( t, u, p, x, xd, z, OtherState, m, Z_residual, ErrStat, ErrMsg )
!SUBROUTINE SlD_JacobianPInput( t, u, p, x, xd, z, OtherState, y, m, ErrStat, ErrMsg, dYdu, dXdu, dXddu, dZdu)
!SUBROUTINE SlD_JacobianPContState( t, u, p, x, xd, z, OtherState, y, m, ErrStat, ErrMsg, dYdx, dXdx, dXddx, dZdx )
!SUBROUTINE SlD_JacobianPDiscState( t, u, p, x, xd, z, OtherState, y, m, ErrStat, ErrMsg, dYdxd, dXdxd, dXddxd, dZdxd )
!SUBROUTINE SlD_JacobianPConstrState( t, u, p, x, xd, z, OtherState, y, m, ErrStat, ErrMsg, dYdz, dXdz, dXddz, dZdz )
!SUBROUTINE SlD_GetOP( t, u, p, x, xd, z, OtherState, y, m, ErrStat, ErrMsg, u_op, y_op, x_op, dx_op, xd_op, z_op )
