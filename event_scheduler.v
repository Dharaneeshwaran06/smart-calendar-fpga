module event_scheduler(
    input [4:0] hours,
    input [5:0] minutes,
    output reg notification
);

always @(*) begin
    if ((hours == 5'd2) && (minutes == 6'd5))
        notification = 1'b1;
    else
        notification = 1'b0;
end

endmodule