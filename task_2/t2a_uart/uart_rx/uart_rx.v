// AstroTinker Bot : Task 2A : UART Receiver
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to receive UART Rx data packet from receiver line and then update the rx_msg and rx_complete data lines.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Receiver

Input:  clk_50M - 50 MHz clock
        rx      - UART Receiver

Output: rx_msg      - read incoming message
        rx_complete - message received flag
*/

// module declaration
module uart_rx (
  input clk_50M, rx,
  output reg [7:0] rx_msg,
  output reg rx_complete
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

initial begin

rx_msg = 0; rx_complete = 0;

end

integer counter1=0,counter2=0,counter3=0;
reg [7:0] RX_MSG;
always @(posedge clk_50M) begin
		if (counter3 == 0) counter3=1;
		else begin
			rx_complete=0;
			if (counter1 < 433) begin
				if (counter2 > 0 & counter2 < 9) RX_MSG[8-counter2] = rx;
				counter1 = counter1 + 1;
			end
			else begin
				counter2 = counter2 + 1;
				if (counter2 == 10) begin
					counter2=0;
					rx_msg=RX_MSG;
					rx_complete=1;
				end
				counter1=0;
			end
		end
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule