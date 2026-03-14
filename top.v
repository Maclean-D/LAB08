module top(
    output [15:0] led,
    input [15:0] sw,
    input btnL,
    input btnU,
    input btnD,
    input btnR,
    input btnC
);
    wire [1:0] mux_sel;
    wire [1:0] demux_sel;
    wire [3:0] internet_data;
    wire [3:0] local_lib;
    wire [3:0] fire_dept;
    wire [3:0] school;
    wire [3:0] rib_shack;

    assign mux_sel = {btnU, btnL};
    assign demux_sel = {btnR, btnD};

    assign internet_data = !btnC ? 4'b0000 :
                           mux_sel == 2'b00 ? sw[3:0] :
                           mux_sel == 2'b01 ? sw[7:4] :
                           mux_sel == 2'b10 ? sw[11:8] :
                                              sw[15:12];

    assign local_lib = (btnC && demux_sel == 2'b00) ? internet_data : 4'b0000;
    assign fire_dept = (btnC && demux_sel == 2'b01) ? internet_data : 4'b0000;
    assign school = (btnC && demux_sel == 2'b10) ? internet_data : 4'b0000;
    assign rib_shack = (btnC && demux_sel == 2'b11) ? internet_data : 4'b0000;

    assign led[3:0] = local_lib;
    assign led[7:4] = fire_dept;
    assign led[11:8] = school;
    assign led[15:12] = rib_shack;
endmodule
