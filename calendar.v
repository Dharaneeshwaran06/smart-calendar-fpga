module calendar(
    input clk,
    input reset,
    input new_day,

    output reg [5:0] day,
    output reg [3:0] month,
    output reg [11:0] year
);

reg [5:0] days_in_month;
reg leap_year;

always @(*) begin

    // Check leap year
    if ((year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0)))
        leap_year = 1'b1;
    else
        leap_year = 1'b0;

    // Determine number of days in current month
    case (month)

        4'd1:  days_in_month = 6'd31; // January

        4'd2: begin                   // February
            if (leap_year)
                days_in_month = 6'd29;
            else
                days_in_month = 6'd28;
        end

        4'd3:  days_in_month = 6'd31; // March
        4'd4:  days_in_month = 6'd30; // April
        4'd5:  days_in_month = 6'd31; // May
        4'd6:  days_in_month = 6'd30; // June
        4'd7:  days_in_month = 6'd31; // July
        4'd8:  days_in_month = 6'd31; // August
        4'd9:  days_in_month = 6'd30; // September
        4'd10: days_in_month = 6'd31; // October
        4'd11: days_in_month = 6'd30; // November
        4'd12: days_in_month = 6'd31; // December

        default: days_in_month = 6'd31;

    endcase
end


always @(posedge clk or posedge reset) begin

    if (reset) begin

        day   <= 6'd1;
        month <= 4'd1;
        year  <= 12'd2026;

    end

    else if (new_day) begin

        // End of current month
        if (day == days_in_month) begin

            day <= 6'd1;

            // End of December
            if (month == 4'd12) begin

                month <= 4'd1;
                year  <= year + 12'd1;

            end

            else begin

                month <= month + 4'd1;

            end

        end

        else begin

            day <= day + 6'd1;

        end

    end

end

endmodule