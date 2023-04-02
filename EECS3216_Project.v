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


parameter time1s=32'd50000000;
reg[35:0] time2s=32'd100000000;
integer index1=8;

// Internal signals
reg [3:0] shift_reg;
reg [3:0] random_number;
initial shift_reg = 1;


always @(posedge cin) begin
counter <= counter+1;

		if(counter >= time1s && index1>=-1) begin
		   counter <= 32'b0;

		   // LFSR for random number generation
		   shift_reg <= {shift_reg[2:0], shift_reg[2] ^ shift_reg[1]};
		 
		   
		   random_number = shift_reg;
		   LEDR[random_number%9]=1;
		   index1 = index1-1;
			
		end
		
		else if(index1<-1||KEY[0]==0)begin
			LEDR<=8'b0;
			index1=7;
		end
	end


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

