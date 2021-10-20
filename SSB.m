%Design an SSB-AM system using simulink and MATLAB.The message signal 
%m(t)=cos(2?t+?/4).*3sin(6?t) is used.The carrier frequency is selected as 
%25Hz.The sample time parameter value of 1/1000 is used.The parameters of 
%simulation including carrier frequency,and sampling rate are set up by a 
%companion MATLAB m-file.The m-file also computes transfer functions of the
%BP and LP filters in the USB-AM receiver using coherent demodulation.

fc=input('Enter friquency of carrier signal ');
Ac=input('Enter Amplitude of carrier signal ');
fs=input('Enter Sammpling period ');
q=input('Enter Phase differance in Local Signal at Demodulater Side ');
t=0:1/fs:1;    % Time Period

% MESSAGE SIGNAL
m=3.*(cos((2.*pi.*t)+(pi/4)).*sin(6.*pi.*t));  % MESSAGE SIGNAL 
subplot(611);
plot(t,m)
xlabel('Time');  
ylabel('Amplitude');
title('Message Signal');
grid on

% CARRIER SIGNAL
Ec=Ac.*sin(2.*pi.*fc.*t);     % CARRIER SIGNAL  
subplot(612);
plot(t,Ec)
xlabel('Time');  
ylabel('Amplitude');
title('Carrier Signal');
grid on

% SSB-SC MODULATION
s=m.*Ec              % DSB-SC MODULATED SIGNAL
w=hilbert(m).*Ec;    % HILBERT TRANSFER FUNCTION
c=(w+s)/2;           % SSB-SC MODULATED SIGNAL
subplot(613);
plot(t,c)
xlabel('Time');  
ylabel('Amplitude');
title('SSB-SC AM');
grid on

% CO-HERENT DETECTOR
% PRODUCT MODULATOR
l=sin((2.*pi.*fc.*t)+q);
v=c.*l
subplot(614);
plot(t,v)
xlabel('Time');  
ylabel('Amplitude');
title('PRODUCT MODULATOR(CO-HERENT DETECTOR)');
grid on

% LOWPASS FILTER
y=lowpass(v,20,fs);
subplot(615);
plot(t,y)
xlabel('Time');  
ylabel('Amplitude');
title('SSB-SC DEMODULATION (LOWPASS FILTER)');
grid on
% BANDPASS FILTER
Z=bandpass(v,[1 5],fs);
subplot(616);
plot(t,Z)
xlabel('Time');  
ylabel('Amplitude');
title('SSB-SC DEMODULATION (BANDPASS FILTER)');
grid on