module EECS3216_Project(SW, KEY, HEX0, HEX1, LED, cin);

input [8:0] SW; // Push buttons (on breadboard)
input [1:0] KEY; // Reset button (on DE10-lite)
input cin; // clock

output wire [7:0] HEX0, HEX1; // HEX display for score
assign HEX0 = segment0; // Display Ones in HEX0
assign HEX1 = segment1; // Display Tens in HEX1

parameter mole_timer = 32'd100000000; // 2s for mole to be on

always @(posedge cin) begin
	
end

endmodule