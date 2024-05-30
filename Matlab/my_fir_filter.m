fs=10000; %% sampling frequency
f1=500;  %% first sinewave freq (in band)
f2=3500; %% second sinnewave freq (out band)
%%y_c = [0,-16,-16,-32,-32,-48,-48,-48,-48,-64,-32,-64,-64,-64,-80,-64,-64,-80,-80,-80,-96,-80,-80,-96,-80,-80,-96,-80,-64,-64,-32,-64,-64,-80,-96,-80,-80,-96,-80,-80,-96,-80,-80,-96,-80,-80,-96,-80,-64,-64,-32,-64,-64,-64,-80,-64,-64,-80,-80,-80,-96,-80,-80,-80,-64,-64,-80,-64,-64,-64,-32,-64,-64,-64,-80,-64,-64,-80,-80,-80,-96,-80,-80,-96,-80,-80,-96,-80,-64,-64,-32,-64,-64,-80,-96,-80,-80,-96,-80,-80,-96,-80,-80,-96,-80,-80,-96,-80,-64,-64,-32,-64,-64,-64,-80,-64,-64,-80,-80,-80,-96,-80,-80,-80,-64,-64,-80,-64,-64,-64,-32,-64,-64,-64,-80,-64,-64,-80,-80,-80,-96,-80,-80,-96,-80,-80,-96,-80,-64,-64,-32,-64,-64,-64,-80,-64,-64,-80,-80,-80,-96,-80,-80,-96,-80,-80,-96,-80,-64,-64,-32,-64,-64,-80,-96,-80,-80,-96,-80,-80,-96,-80,-80,-80,-64,-64,-80,-64,-64,-64,-32,-64,-64,-64,-80,-64,-64,-80,-80,-80,-96];
file = fopen('output.txt', 'r');
C = textscan(file, '%f', 'Delimiter', '\n');
fclose(file);
y_c = cell2mat(C).';

file2 = fopen('results_hdl.txt', 'r');
M = textscan(file2, '%f', 'Delimiter', '\n');
fclose(file2);
y_M = cell2mat(M).';

N=10; %% filter order
%% nb=11 number group
nb=8; %% number of bits

T=1/500; %% maximum period
tt=0:1/fs:10*T; %% time samples

x1=sin(2*pi*f1*tt); %% first sinewave
x2=sin(2*pi*f2*tt); %% second sinewave

x=(x1+x2)/2; %% input signal

[bi, bq]=myfir_design(N, nb); %% filter design

y=filter(bq, 1, x); %% apply filter

%% plots
figure
%%plot(tt,x1,'--d');
hold on
%%plot(tt,x2,'r--s');
%%plot(tt,x, 'g--+');
plot(tt, y_m, 'c--o');
plot(tt, y_c, 'y--o');
legend('x','y','y_c')
%%legend('x1', 'x2', 'x', 'y')

%% quantize input and output
xq=floor(x*2^(nb-1));
idx=find(xq==2^(nb-1));
xq(idx)=2^(nb-1)-1;

yq=floor(y*2^(nb-1));
idy=find(yq==2^(nb-1));
yq(idy)=2^(nb-1)-1;

r = thd(yq);
r_m = thd(y_M);
r_c = thd(y_c);

%% save input and output
fp=fopen('samples.txt','w');
fprintf(fp,'%d\n', xq);
fclose(fp);

fp=fopen('resultsm.txt', 'w');
fprintf(fp, '%d\n', yq);
fclose(fp);
