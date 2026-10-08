`timescale 1ns / 1ps

module smart_calendar_tb;

    reg clk;
    reg reset;

    wire [6:0] seg;
    wire [3:0] an;
    wire notification;

    //================================================
    // DEVICE UNDER TEST
    //================================================

    smart_calendar DUT (
        .clk(clk),
        .reset(reset),
        .seg(seg),
        .an(an),
        .notification(notification)
    );

    //================================================
    // 100 MHz CLOCK
    //================================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end

    //================================================
    // MAIN TEST
    //================================================

    initial begin

        // Reset
        reset = 1'b1;

        #100;

        reset = 1'b0;

        //================================================
        // TEST DATE AND TIME
        //================================================

        // Set internal calendar date
        force DUT.CAL.day   = 6'd5;
        force DUT.CAL.month = 4'd10;
        force DUT.CAL.year  = 12'd2026;

        // Set internal time
        force DUT.TC.hours   = 5'd2;
        force DUT.TC.minutes = 6'd5;
        force DUT.TC.seconds = 6'd0;

        #20;

        //================================================
        // DISPLAY DATE AND TIME
        //================================================

        $display("");
        $display("======================================");
        $display("      SMART DIGITAL CALENDAR");
        $display("======================================");

        $display("DATE: %02d/%02d/%04d",
                 DUT.CAL.day,
                 DUT.CAL.month,
                 DUT.CAL.year);

        $display("TIME: %02d:%02d:%02d",
                 DUT.TC.hours,
                 DUT.TC.minutes,
                 DUT.TC.seconds);

        $display("NOTIFICATION: %0d", notification);

        $display("======================================");

        #20;

        //================================================
        // TEST NOTIFICATION TIME
        //================================================

        force DUT.TC.hours   = 5'd2;
        force DUT.TC.minutes = 6'd5;
        force DUT.TC.seconds = 6'd0;

        #20;

        $display("");
        $display("Notification test at 02:05");

        $display("DATE: %02d/%02d/%04d",
                 DUT.CAL.day,
                 DUT.CAL.month,
                 DUT.CAL.year);

        $display("TIME: %02d:%02d:%02d",
                 DUT.TC.hours,
                 DUT.TC.minutes,
                 DUT.TC.seconds);

        $display("NOTIFICATION: %0d", notification);

        if (notification == 1'b1)
            $display("PASS: Notification ACTIVE");
        else
            $display("FAIL: Notification should be ACTIVE");

        //================================================
        // RELEASE FORCED SIGNALS
        //================================================

        release DUT.CAL.day;
        release DUT.CAL.month;
        release DUT.CAL.year;

        release DUT.TC.hours;
        release DUT.TC.minutes;
        release DUT.TC.seconds;

        //================================================
        // FINISH
        //================================================

        #20;

        $display("");
        $display("======================================");
        $display("SMART CALENDAR TEST COMPLETED");
        $display("======================================");

        $finish;

    end

endmodule