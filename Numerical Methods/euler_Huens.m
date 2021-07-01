%=========================Euler&Heun's Methods=============================
clear 
clc
prompt = {'Enter X initial :','Enter X end :','Enter H :','Enter Function :','Enter Y intial  :'};
data = inputdlg(prompt,'Euler&Heuns Methods');
x0=str2num(data{1});
xend=str2num(data{2});
h=str2num(data{3});
y0=str2num(data{5});
d='@(x,y)';
f=str2func( strcat(d,data{4}));
euler_X= [];
euler_Y= [];
  
  while x0 <= xend
       euler_X=[euler_X ; x0];
       euler_Y=[euler_Y ; y0];
       y1=y0+h*f(x0,y0);
       x1=x0+h;
       x0=x1;
       y0=y1;
  end
 M= [ euler_X  euler_Y ];
f = figure;
t = uitable('ColumnName', {'X', 'Y(Euler)'});
drawnow;
set(t, 'Data', M)


x0=str2num(data{1});
xend=str2num(data{2});
h=str2num(data{3});
y0=str2num(data{5});
d='@(x,y)';
f=str2func( strcat(d,data{4}));
heuns_x=[];
heuns_y=[];
while x0<=xend
    heuns_x=[heuns_x;x0];
    heuns_y=[heuns_y;y0];
    y1=y0+h.*f(x0,y0);
    x1=x0+h;
    y1=y0+(h./2).*(f(x0,y0)+f(x1,y1));
    x0=x1;
    y0=y1;
end
 M= [ heuns_x  heuns_y ];
f = figure;
t = uitable('ColumnName', {'X', 'Y(Heuns)'});
drawnow;
set(t, 'Data', M)
