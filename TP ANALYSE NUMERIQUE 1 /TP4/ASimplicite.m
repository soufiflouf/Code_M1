a=0;
b=L;
T=10;
L=10;
v=1;%=D
Nt=50;
Nx=55; 
dt=T/Nt ;
t=[0:dt:T]; 
dx=(b-a)/Nx; 
x=[a:dx:L];
lambda=dt/dx.^2
u=zeros(Nx+1,Nt+1);

C=1+2*lambda;
E=lambda;

for i=1:Nx+1
  
       u(i,1)=exp(-5(x(i)-L/2)^2);
end

A=assembleMat1D(Nx+1,1+2*lambda,-lambda,3,-4); % (d,alpha,beta,gamma,delta)
%(d,alpha,beta,gamma,delta)
v=zeros(Nx-2,Nt);
for n=1:Nt
    for i=1:Nx-2
        v(i)=u(i+1,n)+dt*f(t(n),x(i));
    end
end
for i=1:Nx-2
    
B=SndMbrGen1d(Nx+1,v(i),0,1); %(d,c,alpha,beta)

end

U=A\B' ;


surf (t,x,u)
xlabel('t'),ylabel('x'),zlabel('u(t,x)')
shading interp , colormap(jet)
%axis image 