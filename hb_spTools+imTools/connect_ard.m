
try
    ard
catch
    ardport = 'COM3'; % correct this port number
%     ardport = '/dev/cu.usbmodem1411';
    ard = serial(ardport, 'BaudRate', 9600);
    fopen(ard);
    disp(['Please wait for arduino loading ... (5 sec)']);
    pause(5)
end

fprintf(ard, 'h');
% pause(1);
% fprintf(ard, 'x');

