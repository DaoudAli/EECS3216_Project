module EECS3216_Project(SW, KEY, HEX0, HEX1, LEDR, cin);

input [8:0] SW; // Push buttons (on breadboard)
input [1:0] KEY; // Reset button (on DE10-lite)
input cin; // clock

output wire [7:0] HEX0, HEX1; // HEX display for score
reg[7:0] segment0, segment1;
assign HEX0 = segment0; // Display Ones in HEX0
assign HEX1 = segment1; // Display Tens in HEX1
output reg [8:0] LEDR;

reg [35:0] counter; //35-bit counter 
parameter mole_timer = 32'd100000000; // 2s for mole to be on

integer random = 0; // index of LED


always @(posedge cin) begin
	
	LEDR[random] = 1;
	if (counter >= mole_timer) begin
		LEDR[random] = 0;
		counter <= 35'b0;
		random = random + 1; // for next loop
	end
	
	if (random >= 9) begin
		random = 0;
	end
	counter <= counter + 1;
end

endmodule

