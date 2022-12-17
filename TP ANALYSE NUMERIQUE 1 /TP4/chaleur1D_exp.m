function [err_1,err_2,err_i]=chaleur1D_exp(cas,Nx,cfl,opt)

close all;

L=10;
nu=1;
T=10;

if (cas==0)
    L=1;
    T=0.2;
end

h=L/Nx;

if (cfl==0)
    Nt=input('Nombre de pas de temps : ');
    deltat=T/Nt;
    Nt2=Nt;
elseif (cfl>0)
    deltat=cfl*h^2/nu;
    Nt=floor(T/deltat);
    if (Nt*deltat~=T)
       Nt2=Nt+1;
    else
       Nt2=Nt;
    end
else
    deltat=h^2/(6*nu);
    Nt=floor(T/deltat);
    if (Nt*deltat~=T)
       Nt2=Nt+1;
    else
       Nt2=Nt;
    end
end
disp(['Le nombre de pas de temps est ' int2str(Nt2)]);

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
   t(Nt2+1)=T;
end

nimp=10;
dnimp=floor(Nt2/nimp);

u=zeros(Nx+1,Nt2+1);

for i=1:Nx+1
   if (cas==1)
       u(i,1)=exp(-5*(x(i)-L/2)^2);
   elseif (cas==2)
       if (L/2-1<=x(i)) && (x(i)<=L/2+1)
           u(i,1)=1;
       end
   elseif (cas==3)
       u(i,1)=sin(pi*x(i)/L)+sin(10*pi*x(i)/L);
   else
       u(i,1)=sin(pi*x(i));
   end
end
%%
A=zeros(Nx-1,Nx-1);
for i=1:Nx-1
   A(i,i)=1-2*lambda;
   if (i>1)
       A(i,i-1)=lambda;
   end
   if (i<Nx-1)
       A(i,i+1)=lambda;
   end
end


for n=2:Nt+1
   u(2:Nx,n)=A*u(2:Nx,n-1);
end

if (Nt~=Nt2)
    deltat=T-t(Nt+1);
    lambda=nu*deltat/h^2;
    for i=1:Nx-1
        A(i,i)=1-2*lambda;
        if (i>1)
            A(i,i-1)=lambda;
        end
        if (i<Nx-1)
            A(i,i+1)=lambda;
        end
    end
    
    u(2:Nx,Nt2+1)=A*u(2:Nx,Nt2);
end
%%
%plot(x,u(:,1),'k',x,u(:,floor((Nt+1)/2)),'b',x,u(:,Nt+1),'b')
xsol=zeros(500,1);
for i=1:500
    xsol(i)=(i-1)/499;
end

if (cas==0)
    erri=zeros(Nx+1,1);

    err_1=0;err_2=0;
    for i=1:Nx+1
       erri(i)=u(i,Nt2+1)-sol_exact(x(i),T);
       err_1=err_1+abs(erri(i));
       err_2=err_2+(erri(i))^2;
    end
    err_1=err_1*h;
    err_2=sqrt(h*err_2);
    err_i=max(abs(erri));
    
    sol=sol_exact(xsol,T);
    plot(x,sol_exact(x,T),'*-b',xsol,sol,'-r')
end

if (cas>0)
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
end

if (opt==1)
    for nn=0:nimp
        nn2=nn*dnimp+1;
        Datas=[x(1,:);u(:,nn2)'];
        fileID=fopen(['chaleur1D_EE_' num2str(cfl) '_' sprintf('%03i',nn) '.txt'],'w');
        fprintf(fileID,'%2.6f \t %2.6f \n',Datas);
        fclose(fileID);
        
        sol=sol_exact(xsol,t(nn2));
        Datas_ex=[xsol(:,1)';sol(:,1)'];
        fileID=fopen(['chaleur1D_EE_sol_' sprintf('%03i',nn) '.txt'],'w');
        fprintf(fileID,'%2.6f \t %2.6f \n',Datas_ex);
        fclose(fileID);
    end
    if (nimp*dnimp~=Nt2+1)
        nn2=Nt2+1;
        Datas=[x(1,:);u(:,nn2)'];
        fileID=fopen(['chaleur1D_EE_' num2str(cfl) '_' sprintf('%03i',nimp+1) '.txt'],'w');
        fprintf(fileID,'%2.6f \t %2.6f \n',Datas);
        fclose(fileID);
        
        
        sol=sol_exact(xsol,t(nn2));
        Datas_ex=[xsol(:,1)';sol(:,1)'];
        fileID=fopen(['chaleur1D_EE_sol_' sprintf('%03i',nimp+1) '.txt'],'w');
        fprintf(fileID,'%2.6f \t %2.6f \n',Datas_ex);
        fclose(fileID);
    end
end
    
end


function [uex]=sol_exact(x,t)

uex=sin(pi*x).*exp(-pi^2*t);

end