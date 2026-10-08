module time_counter(
    input clk,
    input reset,
    output reg [5:0] seconds,
    output reg [5:0] minutes,
    output reg [4:0] hours
);

always @(posedge clk or posedge reset) begin

    if (reset) begin
        seconds <= 6'd0;
        minutes <= 6'd0;
        hours   <= 5'd0;
    end
    else begin

        if (seconds == 6'd59) begin
            seconds <= 6'd0;

            if (minutes == 6'd59) begin
                minutes <= 6'd0;

                if (hours == 5'd23)
                    hours <= 5'd0;
                else
                    hours <= hours + 5'd1;
            end
            else begin
                minutes <= minutes + 6'd1;
            end
        end
        else begin
            seconds <= seconds + 6'd1;
        end

    end

end

endmodule