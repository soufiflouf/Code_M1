function chaleur1D_CN(cfl,opt)

close all;

L=10;
nu=1;
T=10;

Nx=input('Nombre de mailles : ');
h=L/Nx;

if (cfl==0)
    Nt=input('Nombre de pas de temps : ');
    deltat=T/Nt;
    Nt2=Nt;
else
    deltat=cfl*h^2/nu;
    Nt=floor(T/deltat);
    if (Nt*deltat~=T)
       Nt2=Nt+1;
    else
       Nt2=Nt;
    end
end
disp(['Le nombre de pas de temps est ' int2str(Nt2)]);
cas=input('Quel type de donnée intiale (1, 2 ou 3) : ');

lambda=nu*deltat/h^2;

x=zeros(1,Nx+1);
t=zeros(1,Nt2+1);

for i=1:Nx+1
   x(i)=(i-1)*h; 
end
for j=1:Nt+1
   t(j)=(j-1)*deltat; 
end
if (Nt2~=Nt)
   t(Nt2+1)=T-t(Nt2);
end

u=zeros(Nx+1,Nt2+1);

for i=1:Nx+1
   if (cas==1)
       u(i,1)=exp(-5*(x(i)-L/2)^2);
   elseif (cas==2)
       if (L/2-1<=x(i)) && (x(i)<=L/2+1)
           u(i,1)=1;
       end
   else
       u(i,1)=sin(pi*x(i)/L)+sin(10*pi*x(i)/L);
   end
end

A=zeros(Nx-1,Nx-1);
B=zeros(Nx-1,Nx-1);
for i=1:Nx-1
   B(i,i)=1-lambda;
   A(i,i)=1+lambda;
   if (i>1)
       B(i,i-1)=lambda/2;
       A(i,i-1)=-lambda/2;
   end
   if (i<Nx-1)
       B(i,i+1)=lambda/2;
       A(i,i+1)=-lambda/2;
   end
end

Ai=inv(A)*B;

for n=2:Nt2+1
   u(2:Nx,n)=Ai*u(2:Nx,n-1);
end

%plot(x,u(:,1),'k',x,u(:,floor((Nt+1)/2)),'b',x,u(:,Nt+1),'b')

hold on

nn2=0;
for nn=10:-1:1
    nn2=nn2+ceil((Nt2+1)/2^nn);
    if (nn2>Nt2+1)
        break
    end
    plot(x,u(:,nn2),'b')
end
if (nn2~=Nt2+1)
    plot(x,u(:,Nt2+1),'r')
end
plot(x,u(:,1),'k')

if (opt==1)
    nn2=0;
    for nn=10:-1:1
        nn2=nn2+ceil((Nt2+1)/2^nn);
        if (nn2>Nt2+1)
            break
        end
        Datas=[x(1,:);u(:,nn2)'];
        fileID=fopen(['chaleur1D_CN_' num2str(cfl) '_' sprintf('%03i',11-nn) '.txt'],'w');
        fprintf(fileID,'%2.6f \t %2.6f \n',Datas);
        fclose(fileID);
    end
    if (nn2~=Nt2+1)
        nn2=Nt2+1;
        Datas=[x(1,:);u(:,nn2)'];
        fileID=fopen(['chaleur1D_CN_' num2str(cfl) '_' sprintf('%03i',10-nn) '.txt'],'w');
        fprintf(fileID,'%2.6f \t %2.6f \n',Datas);
        fclose(fileID);
    end
    nn2=1;
    Datas=[x(1,:);u(:,nn2)'];
    fileID=fopen(['chaleur1D_CN_' num2str(cfl) '_' sprintf('%03i',0) '.txt'],'w');
    fprintf(fileID,'%2.6f \t %2.6f \n',Datas);
    fclose(fileID);
end


end