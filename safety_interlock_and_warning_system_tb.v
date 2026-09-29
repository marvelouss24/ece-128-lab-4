`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 02:30:10 PM
// Design Name: 
// Module Name: safety_interlock_and_warning_system_tb
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

module safety_interlock_and_warning_system_tb;
//inputs
reg  SB;
reg  DOOR;
reg  KEY;
reg  BRK;
reg  PARK;
reg  HOOD;
reg  BAT_OK;
reg  AIB_OK;
reg  TMP_OK
;
reg  PASS_OCC;
reg  SB_P;
reg  TRUNK;
reg  PBRK;
reg  SRV;
//outputs
wire START_PERMIT;
wire CHIME;
wire WARN_PRI2;
wire WARN_PRI1;
wire SEAT_WARN;
wire DOOR_WARN;
wire HOOD_WARN;
wire TRUNK_WARN;
wire BAT_WARN;
wire AIRBAG_WARN;
wire TMP_WARN;

// Instantiate original module
safety_interlock_and_warning_system uut(SB, DOOR, KEY, BRK, PARK, HOOD, BAT_OK, AIB_OK, TMP_OK, PASS_OCC, SB_P, TRUNK, PBRK, SRV,
START_PERMIT, CHIME, WARN_PRI2, WARN_PRI1, SEAT_WARN, DOOR_WARN, HOOD_WARN, TRUNK_WARN, BAT_WARN, AIRBAG_WARN, TMP_WARN);

initial begin
    #10 PARK=1'b1; //car parked
    #10 KEY=1'b0;SB=1'b0;DOOR=1'b0;HOOD=1'b0;BAT_OK=1'b0;AIB_OK=1'b0;TMP_OK=1'b0;PASS_OCC=1'b0;SB_P=1'b0;TRUNK=1'b0; //key not inserted and no passenger
    #10 SB=1'b1;DOOR=1'b1;HOOD=1'b1;BAT_OK=1'b1;AIB_OK=1'b1;TMP_OK=1'b1;PASS_OCC=1'b1;SB_P=1'b1;TRUNK=1'b1; //no warnings
    #10 KEY=1'b1;SB=1'b0; //driver seatbelt off
    #10 SB=1'b1; //driver seatbelt on
    SB_P=1'b0;PASS_OCC=1'b1; //passenger seatbelt off
    #10 SB_P=1'b1;PASS_OCC=1'b0; //passenger seatbelt on
    DOOR=1'b0;PARK=1'b1; //door open and car parked
    #10 DOOR=1'b1; //door closed
    HOOD=1'b0;PARK=1'b1;//hood open and car parked
    #10 HOOD=1'b1; //hood closed
    TRUNK=1'b0; //trunk open
    #10 TRUNK=1'b1; //trunk closed
    BAT_OK=1'b0; //battery not okay
    #10 BAT_OK=1'b1; //battery okay
    AIB_OK=1'b0; //airbag not okay
    #10 AIB_OK=1'b1; //airbag okay
    TMP_OK=1'b0; //temperature not okay
    #10 TMP_OK=1'b1; //temperature okay
    DOOR=1'b0;PARK=1'b0;PBRK=1'b0;BRK=1'b0; //door open and car moving
    #10 DOOR=1'b1;PARK=1'b1; //door closed and car parked
    HOOD=1'b0;PARK=1'b0;PBRK=1'b0;BRK=1'b0; //hood open and car moving
    #10 HOOD=1'b1;PARK=1'b1; //hood closed and car parked
    #10 KEY=1'b1;SB=1'b0;DOOR=1'b0;HOOD=1'b0;BAT_OK=1'b0;AIB_OK=1'b0;TMP_OK=1'b0;PASS_OCC=1'b1;SB_P=1'b0;TRUNK=1'b0; //all warnings on
    #10 KEY=1'b1;SB=1'b1;DOOR=1'b1;HOOD=1'b1;BAT_OK=1'b1;AIB_OK=1'b1;TMP_OK=1'b1;PASS_OCC=1'b1;SB_P=1'b1;TRUNK=1'b1; //no warnings
    #10 KEY=1'b1;PARK=1'b1;BAT_OK=1'b1;TMP_OK=1'b1;SRV=1'b1; //car in conditions for start permit besides SRV
    #10 KEY=1'b1;PARK=1'b1;BAT_OK=1'b1;TMP_OK=1'b1;SRV=1'b0; //SRV changed to give start permit
    #10 $stop;
end  

endmodule
