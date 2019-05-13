`timescale 1ns / 1ps


module minuteCounter #(parameter maxVal=4'd5)(
    input clk,
    input enable,
    input reset,
    input up_dn,
    input [3:0]resetVal,
    output reg [3:0]count=0,
    output reg thr
    );
    
    always@(posedge clk or posedge reset)begin
        
        
        
        if(reset)begin
        //Sets initial value of the count on the displays
            count <= resetVal;
            
        end
        
        else if(enable)begin
        
            if(up_dn) //If counting up
            begin
                if(count==maxVal)begin
                    count<=4'd0;
                end
                else begin
                    count<=count+1;
                end
                
            end
            else begin //If counting down
                if(count==4'd0)begin
                    count<=maxVal;
                end
                else
                begin
                    count<=count-1;
                end
                
            end 
        end    
    
    end
    
    
    always@(count or up_dn)begin
    
        if(up_dn) begin //If counting up
             if(count==maxVal)
               begin
                   thr=1;
               end
               else
               begin
                   thr=0;
               end
        end
        else begin //If counting down
            if(count==4'd0)
            begin
                thr=1;
            end
            else
            begin
                thr=0;
            end
        end
    
    end
    
    
    
endmodule
