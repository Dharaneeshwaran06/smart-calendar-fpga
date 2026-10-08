`timescale 1ns / 1ps

module smart_calendar(
    input clk,
    input reset,

    output [6:0] seg,
    output [3:0] an,
    output notification
);

    //================================================
    // CLOCK
    //================================================

    wire one_sec;

    //================================================
    // TIME
    //================================================

    wire [5:0] seconds;
    wire [5:0] minutes;
    wire [4:0] hours;

    //================================================
    // CALENDAR
    //================================================

    wire [5:0] day;
    wire [3:0] month;
    wire [11:0] year;

    wire new_day;

    //================================================
    // CLOCK DIVIDER
    //================================================

    clock_divider CD (
        .clk(clk),
        .reset(reset),
        .one_sec(one_sec)
    );

    //================================================
    // TIME COUNTER
    //================================================

    time_counter TC (
        .clk(one_sec),
        .reset(reset),
        .seconds(seconds),
        .minutes(minutes),
        .hours(hours)
    );

    //================================================
    // NEW DAY DETECTION
    //================================================

    assign new_day = (hours == 5'd23) &&
                     (minutes == 6'd59) &&
                     (seconds == 6'd59);

    //================================================
    // CALENDAR
    //================================================

    calendar CAL (
        .clk(one_sec),
        .reset(reset),
        .new_day(new_day),
        .day(day),
        .month(month),
        .year(year)
    );

    //================================================
    // EVENT SCHEDULER
    //================================================

    event_scheduler ES (
        .hours(hours),
        .minutes(minutes),
        .notification(notification)
    );

    //================================================
    // DISPLAY
    //================================================

    display DISP (
        .clk(clk),
        .reset(reset),
        .hours(hours),
        .minutes(minutes),
        .seg(seg),
        .an(an)
    );

endmodule