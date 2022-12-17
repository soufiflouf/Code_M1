function chaleur2D_mixte_exp(cfl,pos,opt)

close all;

L=1;
nu=1;
T=3.;

Tini=20.;
Text=5.;

%Nx=input('Nombre de mailles : ');
Nx=20;
hx=L/Nx;
Ny=Nx;
hy=L/Ny;
Ncell=Nx*Ny;

if (cfl==0)
    Nt=input('Nombre de pas de temps : ');
    deltat=T/Nt;
    Nt2=Nt;
else
    deltat=cfl*(hx^2*hy^2)/(nu*(hx^2+hy^2));
    Nt=floor(T/deltat);
    if (Nt*deltat~=T)
       Nt2=Nt+1;
    else
       Nt2=Nt;
    end
end
disp(['Le nombre de pas de temps est ' int2str(Nt2)]);

nimp=10;
dnimp=floor(Nt2/nimp);

lambdax=nu*deltat/hx^2;
lambday=nu*deltat/hy^2;

x=zeros(1,Nx+1);
y=zeros(1,Ny+1);
t=zeros(1,Nt2+1);

for i=1:Nx+1
   x(i)=(i-1)*hx; 
end
for j=1:Ny+1
   y(j)=(j-1)*hy; 
end
for j=1:Nt+1
   t(j)=(j-1)*deltat; 
end
if (Nt2~=Nt)
   t(Nt2+1)=T-t(Nt2);
end

u=zeros(Nx+1,Ny+1,Nt2+1);
u(:,:,1)=Tini;
for j=1:Ny+1
    if (y(j)>=0.4 && y(j)<=0.6)
        u(1,j,1)=Text;
    end
end

minnn=min(Text,Tini);
maxxx=max(Text,Tini);
for n=2:Nt2+1
    for i=2:Nx
        for j=2:Ny
            u(i,j,n)=(1-2*(lambdax+lambday))*u(i,j,n-1);
            u(i,j,n)=u(i,j,n)+lambdax*(u(i+1,j,n-1)+u(i-1,j,n-1))+lambday*(u(i,j+1,n-1)+u(i,j-1,n-1));
            u(i,j,n)=u(i,j,n)+fct_src(x(i),y(j),pos,u(i,j,n-1))*deltat;
        end
    end
    
    for i=2:Nx
       u(i,1,n)=(4*u(i,2,n)-u(i,3,n))/3;
       u(i,Ny+1,n)=(4*u(i,Ny,n)-u(i,Ny-1,n))/3;
    end
    for j=2:Ny
        if (y(j)>=0.4 && y(j)<=0.6)
            u(1,j,n)=Text;
        else
            u(1,j,n)=(4*u(2,j,n)-u(3,j,n))/3;
        end
        u(Nx+1,j,n)=(4*u(Nx,j,n)-u(Nx-1,j,n))/3;
    end
    
    %u(1,1,n)=(u(2,1,n)+u(2,2,n)+u(1,2,n))/3;
    %u(Nx+1,Ny+1,n)=(u(Nx,Ny+1,n)+u(Nx,Ny,n)+u(Nx+1,Ny,n))/3;
    %u(Nx+1,1,n)=(u(Nx,1,n)+u(Nx,2,n)+u(Nx+1,2,n))/3;
    %u(1,Ny+1,n)=(u(2,Ny+1,n)+u(2,Ny,n)+u(1,Ny,n))/3;
    u(1,1,n)=(4*u(1,2,n)-u(1,3,n)+4*u(2,1,n)-u(3,1,n))/6;
    u(Nx+1,Ny+1,n)=(4*u(Nx+1,Ny,n)-u(Nx+1,Ny-1,n)+4*u(Nx,Ny+1,n)-u(Nx-1,Ny+1,n))/6;
    u(Nx+1,1,n)=(4*u(Nx+1,2,n)-u(Nx+1,3,n)+4*u(Nx,1,n)-u(Nx-1,1,n))/6;
    u(1,Ny+1,n)=(4*u(1,Ny,n)-u(1,Ny-1,n)+4*u(2,Ny+1,n)-u(3,Ny+1,n))/6;
    
    V=u(:,:,n);
    minnn=min(minnn,min(V(:)));
    maxxx=max(maxxx,max(V(:)));
end

minnn
maxxx

%plot(x,u(:,1),'k',x,u(:,floor((Nt+1)/2)),'b',x,u(:,Nt+1),'b')

hold on


%nn=500;
nn=Nt2+1;

minut=10000000;
maxut=-100000000;
for i=1:Nx+1
    for j=1:Ny+1
        minut=min(minut,u(i,j,nn));
        maxut=max(maxut,u(i,j,nn));
    end
end
minut
maxut

[X,Y]=meshgrid(x,y);
vx=-23;vy=41;
view(vx,vy)
if (opt==0)
    nn=Nt2+1;
    V=u(:,:,nn);
    minu=min(V(:));maxu=max(V(:));
    if (maxu-minu<=1.D-6)
        minu=minu-1;
        maxu=maxu+1;
    end
    axis([x(1) x(Nx+1) y(1) y(Ny+1) minu maxu])
    colormap jet;
    colorbar;
    caxis([minu maxu]);
    surf(X,Y,u(:,:,nn));
end

V=u(:,:,Nt2+1);
moy=sum(V(:))/((Nx+1)*(Ny+1))


ecart_type=0;
for i=2:Nx
    for j=2:Ny
        ecart_type=ecart_type+(V(i,j)-moy)^2;
    end
end
ecart_type=sqrt(ecart_type/(Nx*Ny))

% if (opt==1)
%     for nn=0:nimp
%         nn2=nn*dnimp+1;
%         V=u(:,:,nn2);
%         minu=min(V(:));maxu=max(V(:));
%         if (maxu-minu<=1.D-6)
%             minu=minu-1;
%             maxu=maxu+1;
%         end
%         surf(X,Y,u(:,:,nn2));
%         view(vx,vy)
%         %axis([x(1) x(Nx+1) y(1) y(Ny+1) minu maxu])
%         axis([x(1) x(Nx+1) y(1) y(Ny+1) minnn maxxx])
%         colormap jet;
%         colorbar;
%         %caxis([minu maxu]);
%         caxis([minnn maxxx]);
%         saveas(gcf,['chaleur2D_' num2str(Ncell) '_pos' num2str(pos) '_' num2str(nn) '.ps'],'psc')
%         close all;
%     end
%     if (nimp*dnimp~=Nt2+1)
%         V=u(:,:,Nt2+1);
%         minu=min(V(:));maxu=max(V(:));
%         if (maxu-minu<=1.D-6)
%             minu=minu-1;
%             maxu=maxu+1;
%         end
%         surf(X,Y,u(:,:,Nt2+1));
%         view(vx,vy)
%         %axis([x(1) x(Nx+1) y(1) y(Ny+1) minu maxu])
%         axis([x(1) x(Nx+1) y(1) y(Ny+1) minnn maxxx])
%         colormap jet;
%         colorbar;
%         %caxis([minu maxu]);
%         caxis([minnn maxxx]);
%         saveas(gcf,['chaleur2D_' num2str(Ncell) '_pos' num2str(pos) '_' num2str(nimp+1) '.ps'],'psc')
%         close all;
%     end
% end

if (opt==1)
    nn2=0;
    for nn=10:-1:1
        nn2=nn2+ceil((Nt2+1)/2^nn);
        if (nn2>Nt2+1)
            break
        end
        V=u(:,:,nn2);
        surf(X,Y,V);
        view(vx,vy)
        axis([x(1) x(Nx+1) y(1) y(Ny+1) minnn maxxx])
        colormap jet;
        colorbar;
        caxis([minnn maxxx]);
        saveas(gcf,['chaleur2D_' num2str(Ncell) '_pos' num2str(pos) '_' num2str(10-nn) '.ps'],'psc')
        close all;
    end
    if (nn2~=Nt2+1)
        nn2=Nt2+1;
        V=u(:,:,nn2);
        surf(X,Y,V);
        view(vx,vy)
        axis([x(1) x(Nx+1) y(1) y(Ny+1) minnn maxxx])
        colormap jet;
        colorbar;
        caxis([minnn maxxx]);
        saveas(gcf,['chaleur2D_' num2str(Ncell) '_pos' num2str(pos) '_' num2str(10-nn) '.ps'],'psc')
        close all;
    end
    nn2=1;
    V=u(:,:,nn2);
    surf(X,Y,V);
    view(vx,vy)
    axis([x(1) x(Nx+1) y(1) y(Ny+1) minnn maxxx])
    colormap jet;
    colorbar;
    caxis([minnn maxxx]);
    saveas(gcf,['chaleur2D_' num2str(Ncell) '_pos' num2str(pos) '_0' '.ps'],'psc')
    close all;
end
    
end


function [ff]=fct_src(x,y,pos,fold)

f0=1;
frad=40;
if (pos==1)
    a=0.45;b=0.55;
elseif (pos==2)
    a=0.9;b=1;
elseif (pos==3)
    a=0;b=0.1;
else
    a=1;b=-1;
end
c=0.4;d=0.6;

ff=0;
if (x>=a && x<=b)
    if (y>=c && y<=d)
        ff=f0*(frad-fold)^3;
    end
end

end