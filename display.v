module display(
    input clk,
    input reset,
    input [4:0] hours,
    input [5:0] minutes,

    output reg [6:0] seg,
    output reg [3:0] an
);

reg [1:0] digit_select;
reg [16:0] refresh_count;
reg [3:0] digit;

always @(posedge clk or posedge reset) begin

    if (reset) begin
        refresh_count <= 17'd0;
        digit_select  <= 2'd0;
    end

    else begin
        if (refresh_count == 17'd99999) begin
            refresh_count <= 17'd0;
            digit_select <= digit_select + 2'd1;
        end
        else begin
            refresh_count <= refresh_count + 17'd1;
        end
    end

end

always @(*) begin

    case (digit_select)

        2'b00: begin
            an = 4'b1110;
            digit = minutes % 10;
        end

        2'b01: begin
            an = 4'b1101;
            digit = minutes / 10;
        end

        2'b10: begin
            an = 4'b1011;
            digit = hours % 10;
        end

        2'b11: begin
            an = 4'b0111;
            digit = hours / 10;
        end

        default: begin
            an = 4'b1111;
            digit = 4'd0;
        end

    endcase

    case (digit)

        4'd0: seg = 7'b1000000;
        4'd1: seg = 7'b1111001;
        4'd2: seg = 7'b0100100;
        4'd3: seg = 7'b0110000;
        4'd4: seg = 7'b0011001;
        4'd5: seg = 7'b0010010;
        4'd6: seg = 7'b0000010;
        4'd7: seg = 7'b1111000;
        4'd8: seg = 7'b0000000;
        4'd9: seg = 7'b0010000;

        default: seg = 7'b1111111;

    endcase

end

endmodule