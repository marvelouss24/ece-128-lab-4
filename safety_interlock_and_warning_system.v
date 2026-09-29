`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 02:30:10 PM
// Design Name: 
// Module Name: safety_interlock_and_warning_system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module safety_interlock_and_warning_system(
    input SB,
    input DOOR,
    input KEY,
    input BRK,
    input PARK,
    input HOOD,
    input BAT_OK,
    input AIB_OK,
    input TMP_OK,
    input PASS_OCC,
    input SB_P,
    input TRUNK,
    input PBRK,
    input SRV,
    output START_PERMIT,
    output CHIME,
    output WARN_PRI2,
    output WARN_PRI1,
    output SEAT_WARN,
    output DOOR_WARN,
    output HOOD_WARN,
    output TRUNK_WARN,
    output BAT_WARN,
    output AIRBAG_WARN,
    output TEMP_WARN
    );
    
    assign SEAT_WARN = (~SB | PASS_OCC & ~SB_P) & KEY;
    assign DOOR_WARN = ~DOOR & KEY;
    assign HOOD_WARN = ~HOOD & KEY;
    assign TRUNK_WARN = ~TRUNK & KEY;
    assign BAT_WARN = ~BAT_OK & KEY;
    assign AIRBAG_WARN = ~AIB_OK & KEY;
    assign TEMP_WARN = ~TMP_OK & KEY;
    
    assign WARN_PRI1 = BAT_WARN | TEMP_WARN | AIRBAG_WARN | ((DOOR_WARN | HOOD_WARN) & ~PARK & ~PBRK & ~ BRK);
    assign WARN_PRI2 = (DOOR_WARN | SEAT_WARN | TRUNK_WARN | HOOD_WARN) & ~ WARN_PRI1; 
    assign CHIME = WARN_PRI1 | WARN_PRI2;
    assign START_PERMIT = KEY & PARK & BAT_OK & TMP_OK & ~SRV;
    
endmodule
