//-------------------------------------------------------------------------
// crossbar.v
//-------------------------------------------------------------------------
// This file is generated by PyMTL SystemVerilog translation pass.

// PyMTL VerilogPlaceholder crossbarTestHarnessVRTL Definition
// Full name: crossbarTestHarnessVRTL__BIT_WIDTH_32__N_INPUTS_2__N_OUTPUTS_2__CONTROL_BIT_WIDTH_42
// At /home/deg273/c2s2/xbar_testing/tape_in_sim_mar_23_xbar_test/sim/BlockingXBar/crossbarRTL.py

//***********************************************************
// Pickled source file of placeholder crossbarTestHarnessVRTL__ffab133301f624fe
//***********************************************************

//-----------------------------------------------------------
// Dependency of placeholder crossbarTestHarnessVRTL
//-----------------------------------------------------------

`ifndef CROSSBARTESTHARNESSVRTL
`define CROSSBARTESTHARNESSVRTL

// The source code below are included because they are specified
// as the v_libs Verilog placeholder option of component crossbarTestHarnessVRTL__ffab133301f624fe.

// If you get a duplicated def error from files included below, please
// make sure they are included either through the v_libs option or the
// explicit `include statement in the Verilog source code -- if they
// appear in both then they will be included twice!


// End of all v_libs files for component crossbarTestHarnessVRTL__ffab133301f624fe

`line 1 "crossbarTestHarnessVRTL.v" 0
`line 1 "crossbarVRTL.v" 0
`ifndef PROJECT_CROSSBAR_V
`define PROJECT_CROSSBAR_V

//Crossbar in Verilog

module crossbarVRTL
    #(
        parameter BIT_WIDTH = 32, 
        parameter N_INPUTS = 2,
        parameter N_OUTPUTS = 2,
        parameter CONTROL_BIT_WIDTH = 42
    )
    (
        input  logic [BIT_WIDTH - 1:0] recv_msg [0:N_INPUTS - 1] ,
        input  logic                   recv_val [0:N_INPUTS - 1] ,
        output logic                   recv_rdy [0:N_INPUTS - 1] ,

        output logic [BIT_WIDTH - 1:0] send_msg [0:N_OUTPUTS - 1],
        output logic                   send_val [0:N_OUTPUTS - 1],
        input  logic                   send_rdy [0:N_OUTPUTS - 1],

        input  logic                   reset                     ,
        input  logic                   clk                       ,

        input  logic [CONTROL_BIT_WIDTH - 1:0]      control      ,
        input  logic                   control_val               ,
        output logic                   control_rdy               
    );

    logic [CONTROL_BIT_WIDTH - 1:0] stored_control;
    logic [$clog2(N_INPUTS)  - 1:0] input_sel;
    logic [$clog2(N_OUTPUTS) - 1:0] output_sel;

    always @(posedge clk) begin
        if ( reset ) begin
            stored_control <= 0;
        end
        else if ( control_val ) begin
            stored_control <= control;
        end
    end

    assign control_rdy = 1;

    

    assign input_sel = stored_control[CONTROL_BIT_WIDTH - 1: CONTROL_BIT_WIDTH-$clog2(N_INPUTS)];

    assign output_sel = stored_control[CONTROL_BIT_WIDTH - $clog2(N_INPUTS) - 1 : CONTROL_BIT_WIDTH-$clog2(N_INPUTS)-$clog2(N_OUTPUTS)];

    always @(*) begin
        send_msg[output_sel] = recv_msg[input_sel];
        send_val[output_sel] = recv_val[input_sel];
        recv_rdy[input_sel]  = send_rdy[output_sel];

        for (integer i = 0; i < N_OUTPUTS; i = i+1) begin
            if ( (i != output_sel)) begin
                send_msg[i] = 0;
                send_val[i] = 0;
            end
        end
        for (integer i = 0; i < N_INPUTS; i = i+1) begin
            if ( (i != input_sel)) begin
                recv_rdy[i] = 0;
            end
        end
    end
    
endmodule

`endif
`line 2 "crossbarTestHarnessVRTL.v" 0

module crossbarTestHarnessVRTL
    #(
        parameter BIT_WIDTH = 32, 
        parameter N_INPUTS = 2,
        parameter N_OUTPUTS = 2,
        parameter CONTROL_BIT_WIDTH = 42
    )

    (
        input  logic [BIT_WIDTH*N_INPUTS-1:0]       recv_msg                  ,
        input  logic [N_INPUTS - 1:0]               recv_val                  ,
        output logic [N_INPUTS - 1:0]               recv_rdy                  ,

        output logic [BIT_WIDTH*N_OUTPUTS-1:0]      send_msg                  ,
        output logic [N_OUTPUTS - 1:0]              send_val                  ,
        input  logic [N_OUTPUTS - 1:0]              send_rdy                  ,

        input  logic                                reset                     ,
        input  logic                                clk                       ,

        input  logic [CONTROL_BIT_WIDTH - 1:0]      control                   ,
        input  logic                                control_val               ,
        output logic                                control_rdy               
    );

logic [BIT_WIDTH-1:0]  temp_send_msg  [N_OUTPUTS-1:0];
logic [BIT_WIDTH-1:0]  temp_recv_msg  [N_INPUTS-1:0];
logic temp_send_val [N_OUTPUTS-1:0];
logic temp_recv_rdy [N_INPUTS-1:0];
logic temp_recv_val [N_INPUTS-1:0];
logic temp_send_rdy [N_OUTPUTS-1:0];

crossbarVRTL #(
    .BIT_WIDTH(BIT_WIDTH),
    .N_INPUTS(N_INPUTS),
    .N_OUTPUTS(N_OUTPUTS),
    .CONTROL_BIT_WIDTH(CONTROL_BIT_WIDTH)
  ) crossbar_inst (
    .recv_msg(temp_recv_msg),
    .recv_val(temp_recv_val),
    .recv_rdy(temp_recv_rdy),
    .send_msg(temp_send_msg),
    .send_val(temp_send_val),
    .send_rdy(temp_send_rdy),          
    .reset(reset),
    .clk(clk),
    .control(control),
    .control_val(control_val),
    .control_rdy(control_rdy)
  );

  generate
    for (genvar i = 0; i < N_OUTPUTS; i = i + 1) begin : output_gen
      assign send_val[i +: 1] = temp_send_val[i];
    end
  endgenerate

  generate
    for (genvar j = 0; j < N_INPUTS; j = j + 1) begin : output_gen
      assign recv_rdy[j +: 1] = temp_recv_rdy[j];
    end
  endgenerate

  generate
    for ( genvar l = 0; l < N_OUTPUTS; l = l + 1) begin : output_gen
      assign send_msg[l*(BIT_WIDTH) +: BIT_WIDTH] = temp_send_msg[l];
    end
  endgenerate

  generate
    for ( genvar k = 0; k < N_INPUTS; k = k + 1) begin : output_gen
      assign temp_recv_val[k] = recv_val[k +: 1];
    end
  endgenerate

  generate
    for ( genvar m = 0; m < N_OUTPUTS; m = m + 1) begin : output_gen
      assign temp_send_rdy[m] = send_rdy[m +: 1];
    end
  endgenerate

  generate
    for ( genvar n = 0; n < N_INPUTS; n = n + 1) begin : output_gen
      assign temp_recv_msg[n] = recv_msg[n*(BIT_WIDTH) +: BIT_WIDTH];
    end
  endgenerate

  endmodule

`endif /* CROSSBARTESTHARNESSVRTL */
//-----------------------------------------------------------
// Wrapper of placeholder crossbarTestHarnessVRTL__ffab133301f624fe
//-----------------------------------------------------------

`ifndef CROSSBARTESTHARNESSVRTL__FFAB133301F624FE
`define CROSSBARTESTHARNESSVRTL__FFAB133301F624FE

module crossbar
(
  input logic [1-1:0] clk ,
  input logic [42-1:0] control ,
  output logic [1-1:0] control_rdy ,
  input logic [1-1:0] control_val ,
  input logic [64-1:0] recv_msg ,
  output logic [2-1:0] recv_rdy ,
  input logic [2-1:0] recv_val ,
  input logic [1-1:0] reset ,
  output logic [64-1:0] send_msg ,
  input logic [2-1:0] send_rdy ,
  output logic [2-1:0] send_val 
);
  crossbarTestHarnessVRTL
  #(
    .BIT_WIDTH( 32 ),
    .N_INPUTS( 2 ),
    .N_OUTPUTS( 2 ),
    .CONTROL_BIT_WIDTH( 42 )
  ) v
  (
    .clk( clk ),
    .control( control ),
    .control_rdy( control_rdy ),
    .control_val( control_val ),
    .recv_msg( recv_msg ),
    .recv_rdy( recv_rdy ),
    .recv_val( recv_val ),
    .reset( reset ),
    .send_msg( send_msg ),
    .send_rdy( send_rdy ),
    .send_val( send_val )
  );
endmodule

`endif /* CROSSBARTESTHARNESSVRTL__FFAB133301F624FE */
