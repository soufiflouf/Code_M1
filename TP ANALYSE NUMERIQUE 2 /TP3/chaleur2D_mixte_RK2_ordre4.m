function chaleur2D_mixte_RK2_ordre4(cfl,pos,opt)

close all;
format long;

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

for n=2:Nt2+1
    
    V=u(:,:,n-1)+residu(u(:,:,n-1),1.,lambdax,lambday,deltat,x,y,pos);
    
    for i=2:Nx
        V(i,1)=(48*V(i,2)-36*V(i,3)+16*V(i,4)-3*V(i,5))/25;
        V(i,Ny+1)=(48*V(i,Ny)-36*V(i,Ny-1)+16*V(i,Ny-2)-3*V(i,Ny-3))/25;
    end
    for j=2:Ny
        if (y(j)>=0.4 && y(j)<=0.6)
            V(1,j)=Text;
        else
            V(1,j)=(48*V(2,j)-36*V(3,j)+16*V(4,j)-3*V(5,j))/25;
        end
        V(Nx+1,j)=(48*V(Nx,j)-36*V(Nx-1,j)+16*V(Nx-2,j)-3*V(Nx-3,j))/25;
    end
    
    V(1,1)=(48*V(2,1)-36*V(3,1)+16*V(4,1)-3*V(5,1)+48*V(1,2)-36*V(1,3)+16*V(1,4)-3*V(1,5))/50;
    V(Nx+1,Ny+1)=(48*V(Nx,Ny+1)-36*V(Nx-1,Ny+1)+16*V(Nx-2,Ny+1)-3*V(Nx-3,Ny+1)+48*V(Nx+1,Ny)-36*V(Nx+1,Ny-1)+16*V(Nx+1,Ny-2)-3*V(Nx+1,Ny-3))/50;
    V(Nx+1,1)=(48*V(Nx,1)-36*V(Nx-1,1)+16*V(Nx-2,1)-3*V(Nx-3,1)+48*V(Nx+1,2)-36*V(Nx+1,3)+16*V(Nx+1,4)-3*V(Nx+1,5))/50;
    V(1,Ny+1)=(48*V(2,Ny+1)-36*V(3,Ny+1)+16*V(4,Ny+1)-3*V(5,Ny+1)+48*V(1,Ny)-36*V(1,Ny-1)+16*V(1,Ny-2)-3*V(1,Ny-3))/50;
    
    
    u(:,:,n)=(u(:,:,n-1)+V(:,:))/2+residu(V,0.5,lambdax,lambday,deltat,x,y,pos);
    
    for i=2:Nx
        u(i,1,n)=(48*u(i,2,n)-36*u(i,3,n)+16*u(i,4,n)-3*u(i,5,n))/25;
        u(i,Ny+1,n)=(48*u(i,Ny,n)-36*u(i,Ny-1,n)+16*u(i,Ny-2,n)-3*u(i,Ny-3,n))/25;
    end
    for j=2:Ny
        if (y(j)>=0.4 && y(j)<=0.6)
            u(1,j,n)=Text;
        else
            u(1,j,n)=(48*u(2,j,n)-36*u(3,j,n)+16*u(4,j,n)-3*u(5,j,n))/25;
        end
        u(Nx+1,j,n)=(48*u(Nx,j,n)-36*u(Nx-1,j,n)+16*u(Nx-2,j,n)-3*u(Nx-3,j,n))/25;
    end
    
    u(1,1,n)=(48*u(2,1,n)-36*u(3,1,n)+16*u(4,1,n)-3*u(5,1,n)+48*u(1,2,n)-36*u(1,3,n)+16*u(1,4,n)-3*u(1,5,n))/50;
    u(Nx+1,Ny+1,n)=(48*u(Nx,Ny+1,n)-36*u(Nx-1,Ny+1,n)+16*u(Nx-2,Ny+1,n)-3*u(Nx-3,Ny+1,n)+48*u(Nx+1,Ny,n)-36*u(Nx+1,Ny-1,n)+16*u(Nx+1,Ny-2,n)-3*u(Nx+1,Ny-3,n))/50;
    u(Nx+1,1,n)=(48*u(Nx,1,n)-36*u(Nx-1,1,n)+16*u(Nx-2,1,n)-3*u(Nx-3,1,n)+48*u(Nx+1,2,n)-36*u(Nx+1,3,n)+16*u(Nx+1,4,n)-3*u(Nx+1,5,n))/50;
    u(1,Ny+1,n)=(48*u(2,Ny+1,n)-36*u(3,Ny+1,n)+16*u(4,Ny+1,n)-3*u(5,Ny+1,n)+48*u(1,Ny,n)-36*u(1,Ny-1,n)+16*u(1,Ny-2,n)-3*u(1,Ny-3,n))/50;

end

minnn=min(u(:));
maxxx=max(u(:));

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


function resi=residu(W,cf_rk,lambdax,lambday,deltat,x,y,pos)

llx=cf_rk*lambdax;
lly=cf_rk*lambday;
Nx=length(x)-1;
Ny=length(y)-1;

resi=zeros(Nx+1,Ny+1);

for i=3:Nx-1
    for j=3:Ny-1
        resi(i,j)=-5*(llx+lly)/2*W(i,j);
        resi(i,j)=resi(i,j)+llx*(16*(W(i+1,j)+W(i-1,j))-(W(i+2,j)+W(i-2,j)))/12;
        resi(i,j)=resi(i,j)+lly*(16*(W(i,j+1)+W(i,j-1))-(W(i,j+2)+W(i,j-2)))/12;
        resi(i,j)=resi(i,j)+fct_src(x(i),y(j),pos,W(i,j))*deltat*cf_rk;
    end
end

for i=2:Nx
    resi(i,2)=-5*lly/4*W(i,2);
    resi(i,Ny)=-5*lly/4*W(i,Ny);
    resi(i,2)=resi(i,2)+lly*(10*W(i,1)-4*W(i,3)+14*W(i,4)-6*W(i,5)+W(i,6))/12;
    resi(i,Ny)=resi(i,Ny)+lly*(10*W(i,Ny+1)-4*W(i,Ny-1)+14*W(i,Ny-2)-6*W(i,Ny-3)+W(i,Ny-4))/12;
    if (i>2 && i<Nx)
        resi(i,2)=resi(i,2)-5*llx/2*W(i,2);
        resi(i,2)=resi(i,2)+llx*(16*(W(i+1,2)+W(i-1,2))-(W(i+2,2)+W(i-2,2)))/12;
        resi(i,Ny)=resi(i,Ny)-5*llx/2*W(i,Ny);
        resi(i,Ny)=resi(i,Ny)+llx*(16*(W(i+1,Ny)+W(i-1,Ny))-(W(i+2,Ny)+W(i-2,Ny)))/12;
    elseif (i==2)
        resi(2,2)=resi(2,2)-5*llx/4*W(2,2);
        resi(2,2)=resi(2,2)+llx*(10*W(1,2)-4*W(3,2)+14*W(4,2)-6*W(5,2)+W(6,2))/12;
        resi(2,Ny)=resi(2,Ny)-5*llx/4*W(2,Ny);
        resi(2,Ny)=resi(2,Ny)+llx*(10*W(1,Ny)-4*W(3,Ny)+14*W(4,Ny)-6*W(5,Ny)+W(6,Ny))/12;
    elseif (i==Nx)
        resi(Nx,2)=resi(Nx,2)-5*llx/4*W(Nx,2);
        resi(Nx,2)=resi(Nx,2)+llx*(10*W(Nx+1,2)-4*W(Nx-1,2)+14*W(Nx-2,2)-6*W(Nx-3,2)+W(Nx-4,2))/12;
        resi(Nx,Ny)=resi(Nx,Ny)-5*llx/4*W(Nx,Ny);
        resi(Nx,Ny)=resi(Nx,Ny)+llx*(10*W(Nx+1,Ny)-4*W(Nx-1,Ny)+14*W(Nx-2,Ny)-6*W(Nx-3,Ny)+W(Nx-4,Ny))/12;
    end
    resi(i,2)=resi(i,2)+fct_src(x(i),y(2),pos,W(i,2))*deltat*cf_rk;
    resi(i,Ny)=resi(i,Ny)+fct_src(x(i),y(Ny),pos,W(i,Ny))*deltat*cf_rk;
end
for j=2:Ny
    resi(2,j)=-5*llx/4*W(2,j);
    resi(Nx,j)=-5*llx/4*W(Nx,j);
    resi(2,j)=resi(2,j)+llx*(10*W(1,j)-4*W(3,j)+14*W(4,j)-6*W(5,j)+W(6,j))/12;
    resi(Nx,j)=resi(Nx,j)+llx*(10*W(Nx+1,j)-4*W(Nx-1,j)+14*W(Nx-2,j)-6*W(Nx-3,j)+W(Nx-4,j))/12;
    if (j>2 && j<Ny)
        resi(2,j)=resi(2,j)-5*lly/2*W(2,j);
        resi(2,j)=resi(2,j)+lly*(16*(W(2,j+1)+W(2,j-1))-(W(2,j+2)+W(2,j-2)))/12;
        resi(Nx,j)=resi(Nx,j)-5*lly/2*W(Nx,j);
        resi(Nx,j)=resi(Nx,j)+lly*(16*(W(Nx,j+1)+W(Nx,j-1))-(W(Nx,j+2)+W(Nx,j-2)))/12;
    elseif (j==2)
        resi(2,2)=resi(2,2)-5*lly/4*W(2,2);
        resi(2,2)=resi(2,2)+lly*(10*W(2,1)-4*W(2,3)+14*W(2,4)-6*W(2,5)+W(2,6))/12;
        resi(Nx,2)=resi(Nx,2)-5*lly/4*W(Nx,2);
        resi(Nx,2)=resi(Nx,2)+lly*(10*W(Nx,1)-4*W(Nx,3)+14*W(Nx,4)-6*W(Nx,5)+W(Nx,6))/12;
    elseif (j==Ny)
        resi(2,Ny)=resi(2,Ny)-5*lly/4*W(2,Ny);
        resi(2,Ny)=resi(2,Ny)+lly*(10*W(2,Ny+1)-4*W(2,Ny-1)+14*W(2,Ny-2)-6*W(2,Ny-3)+W(2,Ny-4))/12;
        resi(Nx,Ny)=resi(Nx,Ny)-5*lly/4*W(Nx,Ny);
        resi(Nx,Ny)=resi(Nx,Ny)+lly*(10*W(Nx,Ny+1)-4*W(Nx,Ny-1)+14*W(Nx,Ny-2)-6*W(Nx,Ny-3)+W(Nx,Ny-4))/12;
    end
    resi(2,j)=resi(2,j)+fct_src(x(2),y(j),pos,W(2,j))*deltat*cf_rk;
    resi(Nx,j)=resi(Nx,j)+fct_src(x(Nx),y(j),pos,W(Nx,j))*deltat*cf_rk;
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