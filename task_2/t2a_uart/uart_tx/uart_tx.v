// AstroTinker Bot : Task 2A : UART Transmitter
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to generate UART Tx data packet to transmit the messages based on the input data.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Transmitter

Input:  clk_50M - 50 MHz clock
        data    - 8-bit data line to transmit
Output: tx      - UART Transmission Line
*/

// module declaration
module uart_tx(
    input  clk_50M,
    input  [7:0] data,
    output reg tx
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

initial begin
	 tx = 0;
end

integer counter1=0,counter2=0;

always @(posedge clk_50M) begin
		if (counter1<434) begin
			if (counter2 == 0) tx=0;
			else if (counter2 == 9) tx=1;
			else tx=data[counter2-1];
			counter1 = counter1 + 1;
		end
		if (counter1 == 434) begin
			counter2 = counter2 + 1;
			if (counter2 == 10) counter2=0;
			counter1 = 0;
		end
end
		

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
