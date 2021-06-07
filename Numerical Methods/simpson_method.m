clear;
clc;
syms X
prompt = {'Enter a function :','Enter a :','Enter b:','Enter number of segments(must be even): '};
data = inputdlg(prompt,'enter inputs',[1 70]);
fn=data{1};
indep='@(x)';
y= str2func( strcat(indep,fn) );
a=str2num(data{2});
b=str2num(data{3});
n=str2num(data{4});
h=(b-a)/n;
x=[];
x(1)=a;

for i=2:n+1 %generate x values
x(i)=x(i-1)+h;    
end
yn=y(x);
I=(h/3)*(yn(1)+yn(end)+2*sum(yn(3:2:end-1))+4*sum(yn(2:2:end-1)));
F = double (int(y(X),[a b]));

stem(x,y(x),'r');
grid on;
hold on;
plot(x,y(x));
xdash=linspace(min(x),max(x));
ydash=y(xdash);
plot(xdash,ydash);
title('Intergral using Simpson method')
msgbox(sprintf('Numerically Integration value = %f\nExact Integration value = %f',I,F));
