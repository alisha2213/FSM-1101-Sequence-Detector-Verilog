`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2025 16:12:14
// Design Name: 
// Module Name: FSM_1101
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


module FSM_1101(
    input clk,
    input rst,
    input in,
    output reg out

    );
     // State encoding
       parameter S0 = 2'b00,
                 S1 = 2'b01,
                 S11 = 2'b10,
                 S110 = 2'b11;
   
       reg [1:0] state;
   
       always @(posedge clk ) begin
           if (rst) begin
               state <= S0;
               out <= 0;
           end else begin
               case(state)
                   S0: begin
                       state <= in ? S1 : S0;
                       out <= 0;
                   end
   
                   S1: begin
                       state <= in ? S11 : S0;
                       out <= 0;
                   end
   
                   S11: begin
                       state <= in ? S11 : S110;
                       out <= 0;
                   end
   
                   S110: begin
                       state <= in ? S1 : S0;
                       out <= in;  // Output 1 only if next input is 1, i.e., "1101"
                   end
   
                   default: begin
                       state <= S0;
                       out <= 0;
                   end
               endcase
           end
       end

endmodule
