@ECHO OFF
set ROPTS=-np all --parallel-authenticate localonly --machines-file nodes
set COPTS=
set FEKO_SCRIPT_FILE=C:/Users/USUARIO/Desktop/MacroCelda/FEKO/MacroCelda_Barrido/Barrido_2Celdas/parameter_sweep/MacroCelda_Barrido_01.bof

if "%FEKO_HOME%"=="" (
echo           INFO: Parameter Sweep Solve 
echo ************************************************ 
echo *         FEKO_HOME variable is not set.       * 
echo ************************************************ 
echo  Please run initfeko, or set the environment variable FEKO_HOME to point to the FEKO installation.
echo  This script will now exit.
exit /B
) else (
call "%FEKO_HOME%/bin/initfeko.bat"
)
"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_01" %COPTS%
runfeko "MacroCelda_Barrido_01" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_02" %COPTS%
runfeko "MacroCelda_Barrido_02" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_03" %COPTS%
runfeko "MacroCelda_Barrido_03" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_04" %COPTS%
runfeko "MacroCelda_Barrido_04" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_05" %COPTS%
runfeko "MacroCelda_Barrido_05" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_06" %COPTS%
runfeko "MacroCelda_Barrido_06" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_07" %COPTS%
runfeko "MacroCelda_Barrido_07" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_08" %COPTS%
runfeko "MacroCelda_Barrido_08" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_09" %COPTS%
runfeko "MacroCelda_Barrido_09" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_10" %COPTS%
runfeko "MacroCelda_Barrido_10" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_11" %COPTS%
runfeko "MacroCelda_Barrido_11" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_12" %COPTS%
runfeko "MacroCelda_Barrido_12" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_13" %COPTS%
runfeko "MacroCelda_Barrido_13" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_14" %COPTS%
runfeko "MacroCelda_Barrido_14" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_15" %COPTS%
runfeko "MacroCelda_Barrido_15" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_16" %COPTS%
runfeko "MacroCelda_Barrido_16" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_17" %COPTS%
runfeko "MacroCelda_Barrido_17" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_18" %COPTS%
runfeko "MacroCelda_Barrido_18" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_19" %COPTS%
runfeko "MacroCelda_Barrido_19" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_20" %COPTS%
runfeko "MacroCelda_Barrido_20" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_21" %COPTS%
runfeko "MacroCelda_Barrido_21" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_22" %COPTS%
runfeko "MacroCelda_Barrido_22" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_23" %COPTS%
runfeko "MacroCelda_Barrido_23" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_24" %COPTS%
runfeko "MacroCelda_Barrido_24" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_25" %COPTS%
runfeko "MacroCelda_Barrido_25" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_26" %COPTS%
runfeko "MacroCelda_Barrido_26" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_27" %COPTS%
runfeko "MacroCelda_Barrido_27" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_28" %COPTS%
runfeko "MacroCelda_Barrido_28" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_29" %COPTS%
runfeko "MacroCelda_Barrido_29" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_30" %COPTS%
runfeko "MacroCelda_Barrido_30" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_31" %COPTS%
runfeko "MacroCelda_Barrido_31" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_32" %COPTS%
runfeko "MacroCelda_Barrido_32" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_33" %COPTS%
runfeko "MacroCelda_Barrido_33" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_34" %COPTS%
runfeko "MacroCelda_Barrido_34" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_35" %COPTS%
runfeko "MacroCelda_Barrido_35" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_36" %COPTS%
runfeko "MacroCelda_Barrido_36" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_37" %COPTS%
runfeko "MacroCelda_Barrido_37" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_38" %COPTS%
runfeko "MacroCelda_Barrido_38" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_39" %COPTS%
runfeko "MacroCelda_Barrido_39" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_40" %COPTS%
runfeko "MacroCelda_Barrido_40" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_41" %COPTS%
runfeko "MacroCelda_Barrido_41" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_42" %COPTS%
runfeko "MacroCelda_Barrido_42" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_43" %COPTS%
runfeko "MacroCelda_Barrido_43" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_44" %COPTS%
runfeko "MacroCelda_Barrido_44" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_45" %COPTS%
runfeko "MacroCelda_Barrido_45" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_46" %COPTS%
runfeko "MacroCelda_Barrido_46" %ROPTS%

"C:\Program Files\Altair\2026\FEKO/bin/cadfeko_batch" "MacroCelda_Barrido_47" %COPTS%
runfeko "MacroCelda_Barrido_47" %ROPTS%

echo           DONE: Parameter Sweep Solve
echo ************************************************
echo * Launch POSTFEKO and merge the results.       *
echo ************************************************
choice /N /M "Do you want to run POSTFEKO now (y/n):"

if not errorlevel 2 (
    if exist "%FEKO_SCRIPT_FILE%" (
        start postfeko "%FEKO_SCRIPT_FILE%" --run-script "%FEKO_SHARED_HOME%/installedapplicationmacrolibrary/Shared/ParameterSweep/combine_parameter_sweep_results.lua"
    ) else (
        start postfeko --run-script "%FEKO_SHARED_HOME%/installedapplicationmacrolibrary/Shared/ParameterSweep/combine_parameter_sweep_results.lua"
    )
)
exit
