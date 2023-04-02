module EECS3216_Project(SW, KEY, HEX0, HEX1, LEDR, cin);

input [8:0] SW; // Push buttons (on breadboard)
input [1:0] KEY; // Reset button (on DE10-lite)
input cin; // clock

output wire [7:0] HEX0, HEX1; // HEX display for score
reg[7:0] segment0, segment1;
assign HEX0 = segment0; // Display Ones in HEX0
assign HEX1 = segment1; // Display Tens in HEX1
output reg [8:0] LEDR;

reg [32:0] counter; //32-bit counter 
reg [32:0] mole_timer = 32'd100000000; // 2s for mole to be on
//reg [32:0] mole_timer = 32'd50000000; // 1s for mole to be on

integer index = 8; // index of LED
integer i = 0; 
integer score = 0;
integer displayTens = 0;
integer displayOnes = 0;

<<<<<<< Updated upstream

parameter time1s=32'd50000000;

integer index1=8;

// Internal signals
=======
// LEDS
>>>>>>> Stashed changes
reg [3:0] shift_reg;
reg [3:0] random_number;
initial shift_reg = 1;

// Score variables
reg [8:0] s_reg;
reg[31:0] time_deb= 32'd0;


always @(posedge cin) begin
	counter <= counter + 1;
	
	// Reset button
	if (KEY[0] == 0) begin
		score = 0;
		counter <= 35'b0;
		LEDR[0] = 0;
		LEDR[1] = 0;
		LEDR[2] = 0;
		LEDR[3] = 0;
		LEDR[4] = 0;
		LEDR[5] = 0;
		LEDR[6] = 0;
		LEDR[7] = 0;
		LEDR[8] = 0;
	end
	
	// Score
	if (LEDR[random_number%9] == 1 & SW[random_number%9] == 1 && s_reg[random_number%9] == 0) begin // LED is on and push button is clicked) USING SWITCHES FOR TEST CHANGE TO '0' LATER
		time_deb <= time_deb + 1;
		if (time_deb > 100000) begin
			score = score + 1; // increment score by 1
			LEDR[random_number%9] = 0;
			//mole_timer = mole_timer/1.05; // shaves off 100ms each time the player scores
			s_reg[random_number%9] = 1;
			time_deb <= 32'd0;
		end
	end
	else if (SW[random_number%9] == 0) begin
		s_reg[random_number%9] = 0;
	end
	
	// Display HEX Segment for Player Score
	displayTens = score/10;
	displayOnes = score%10;
	
	case(displayTens)
		0: segment1 <= 8'b1000000;
		1: segment1 <= 8'b1111001;
		2: segment1 <= 8'b0100100;
		3: segment1 <= 8'b0110000;
		4: segment1 <= 8'b0011001;
		5: segment1 <= 8'b0010010;
		6: segment1 <= 8'b0000010;
		7: segment1 <= 8'b1111000;
		8: segment1 <= 8'b0000000;
		9: segment1 <= 8'b0010000;
	endcase
	
	case(displayOnes)
		0: segment0 <= 8'b1000000;
		1: segment0 <= 8'b1111001;
		2: segment0 <= 8'b0100100;
		3: segment0 <= 8'b0110000;
		4: segment0 <= 8'b0011001;
		5: segment0 <= 8'b0010010;
		6: segment0 <= 8'b0000010;
		7: segment0 <= 8'b1111000;
		8: segment0 <= 8'b0000000;
		9: segment0 <= 8'b0010000;
	endcase
	
	
	// Turning on/off LEDS
	if (counter >= mole_timer && index >= -1 && LEDR[random_number%9] == 0) begin // Turns on LEDs
	   counter <= 32'b0;

	   // LFSR for random number generation
	   shift_reg <= {shift_reg[2:0], shift_reg[2] ^ shift_reg[1]};
   
	   random_number = shift_reg;
	   LEDR[random_number%9] = 1;
	   index = index - 1;
	end
	else if (counter >= mole_timer && index >= -1 && LEDR[random_number%9] == 1) begin // Turns off LEDs
		LEDR[random_number%9] = 0;
	end
	else if (index < -1 || KEY[0] == 0) begin
		LEDR <= 8'b0;
		index = 7;
	end
	
	
end

endmodule

