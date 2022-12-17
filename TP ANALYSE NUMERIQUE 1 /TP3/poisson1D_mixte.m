function err=poisson1D_mixte(nint,opt_plot)

close all

a=0;b=3;al=-5;be=3;

h=(b-a)/nint;

x=zeros(nint+1,1);
A=zeros(nint);
F=zeros(nint,1);

sol=zeros(nint+1,1);
erri=zeros(nint+1,1);

x(1)=a;
A(1,1)=-3/2*h;
A(1,2)=2*h;
A(1,3)=-1/2*h;
F(1)=al;
sol(1)=exp(x(1))-exp(b)+(al-exp(a))*(x(1)-b)+be;
for i=2:nint-1
   x(i)=a+(i-1)*h;
   
   A(i,i-1)=1;
   A(i,i)=-2;
   A(i,i+1)=1;
   
   F(i)=exp(x(i));
   
   sol(i)=exp(x(i))-exp(b)+(al-exp(a))*(x(i)-b)+be;
end
x(nint)=a+(nint-1)*h;
A(nint,nint-1)=1;
A(nint,nint)=-2;
F(nint)=exp(x(nint))-be/h^2;
sol(nint)=exp(x(nint))-exp(b)+(al-exp(a))*(x(nint)-b)+be;

x(nint+1)=b;
sol(nint+1)=exp(x(nint+1))-exp(b)+(al-exp(a))*(x(nint+1)-b)+be;

A=A/h^2;

U=A\F;

V=zeros(nint+1,1);
V(1:nint)=U(1:nint);
V(nint+1)=be;

for i=1:nint+1
   erri(i)=V(i)-sol(i); 
end
err=max(abs(erri));

if (opt_plot==1)
    xsol=zeros(100,1);
    sol2=zeros(100,1);
    for i=1:100
        xsol(i)=a+(i-1)*(b-a)/99;
        sol2(i)=exp(xsol(i))-exp(b)+(al-exp(a))*(xsol(i)-b)+be;
    end
      
    plt=plot(xsol,sol2,'r-',x,V,'b-o');
    plt(1).LineWidth=3;
    plt(2).LineWidth=1.5;
end

end