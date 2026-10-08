module clock_divider(
    input clk,
    input reset,
    output reg one_sec
);

reg [26:0] count;

always @(posedge clk) begin

    if (reset) begin
        count <= 0;
        one_sec <= 0;
    end

    else begin
        if (count == 9) begin
            count <= 0;
            one_sec <= ~one_sec;
        end

        else begin
            count <= count + 1;
        end
    end

end

endmodule