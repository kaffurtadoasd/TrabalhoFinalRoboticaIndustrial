
s=serial('COM4','BAUD', 9600); % Make sure the baud rate and COM port is 
                              % same as in Arduino IDE
fopen(s);
user = 1;
steps = 0;
mask = 128;

while(user ~= 0)
    user = input('Enter the angle or "0" to close: ');
    if (user == 0)
        if ~isempty(instrfind)
            fclose(instrfind);
            delete(instrfind);
            clear;
        end
        return;
    end
    if (user < 0)
       user = user*(-1);
       steps = user/5.625;
       steps = round(steps);
       steps = uint8(steps);
       steps = steps + uint8(mask);
       fwrite(s,steps,'uint8');
    else
       steps = user/5.625;
       steps = round(steps);
       steps = uint8(steps);
       fwrite(s,steps,'uint8');
    end
   

end   
if ~isempty(instrfind)
            fclose(instrfind);
            delete(instrfind);
            clear;
end
