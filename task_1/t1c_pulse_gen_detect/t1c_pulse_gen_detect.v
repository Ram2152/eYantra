// AstroTinker Bot : Task 1C : Pulse Generator and Detector
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to design a module which will generate a 10us pulse and detect incoming pulse signal.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

// t1c_pulse_gen_detect
//Inputs : clk_50M, reset, echo_rx
//Output : trigger, distance, pulses, state

// module declaration
module t1c_pulse_gen_detect (
    input clk_50M, reset, echo_rx,
    output reg trigger, out,
    output reg [21:0] pulses,
    output reg [1:0] state
);

initial begin
    trigger = 0; out = 0; pulses = 0; state = 0;
end


//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

reg [21:0] counter1 = 0;
reg [21:0] counter2 = 0;
reg [21:0] counter3 = 0;

always @(clk_50M,reset) begin
	if(reset) begin
		trigger = 0; out = 0; pulses = 0; state = 0; 
		counter1 = 0; counter2 = 0; counter3 = 0;
	end
	case (state)
		0: begin
			if(counter1 < 100) begin					
				counter1 = counter1+1'b1;
			end
			else state = 1;
		end
		1: begin
			counter1 = 0;
			trigger = 1;
			if(counter2 < 999) begin
				counter2 = counter2+1'b1;
			end
			else begin
				state = 2;
			end
		end
		2: begin
			trigger = 0;
			counter2 = 0;
			if(counter3 < 99999) begin
				counter3 = counter3+1'b1;
				if(echo_rx == 1) begin
					pulses = pulses + 4'b1010;
				end
			end	
			else state = 3;
		end
		3: begin
			if(pulses == 588200) begin
				out = 1;
			end
			counter3 = 0;
			pulses = 0;
			state = 0;
		end
		default: state = 0;
	endcase
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
