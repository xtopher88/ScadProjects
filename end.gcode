
M400
M104 S0                                      ; hotend off
M140 S0                                      ; heated bed heater off (if you have it)
M107                                         ; fans off
G92 E5                                       ; set extruder to 5mm for retract on print end
G1 X5 Y5 Z158 E0 F10000                      ; move to cooling positioning
M190 R50                                     ; wait for bed to cool
M140 S0                                      ;
G1 X145 F1000                                ; move to cooling positioning
G1 Y175 F1000                                ; move to cooling positioning
M84                                          ; steppers off
G90                                          ; absolute positioning
;{profile_string}
