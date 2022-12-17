function chaleur2D_exp(cfl,opt)

close all;

L=1;
nu=1;
T=0.01;

%Nx=input('Nombre de mailles : ');
Nx=40;
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

lambdax=nu*deltat/hx^2;
lambday=nu*deltat/hy^2;

x=zeros(1,Nx+1);
y=zeros(1,Ny+1);
t=zeros(1,Nt2+1);

for i=1:Nx+1
   x(i)=(i-1)*hx; 
end
for i=1:Ny+1
   y(i)=(i-1)*hy; 
end
for j=1:Nt+1
   t(j)=(j-1)*deltat; 
end
if (Nt2~=Nt)
   t(Nt2+1)=T-t(Nt2);
end

u=zeros(Nx+1,Ny+1,Nt2+1);
for i=1:Nx+1
    if (x(i)>=0.4 && x(i)<=0.6)
        for j=1:Ny+1
            if (y(j)>=0.4 && y(j)<=0.6)
                u(i,j,1)=1;
            end
        end
    end
end

for n=2:Nt2+1
    for i=2:Nx
        for j=2:Ny
            u(i,j,n)=(1-2*(lambdax+lambday))*u(i,j,n-1);
            u(i,j,n)=u(i,j,n)+lambdax*(u(i+1,j,n-1)+u(i-1,j,n-1))+lambday*(u(i,j+1,n-1)+u(i,j-1,n-1));
            u(i,j,n)=u(i,j,n)+fct_src(x(i),y(j))*deltat;
        end
    end
end

%plot(x,u(:,1),'k',x,u(:,floor((Nt+1)/2)),'b',x,u(:,Nt+1),'b')

hold on


%nn=1;
%nn=500;
nn=Nt2+1;

mminu=10000000;
mmaxu=-100000000;
minut=10000000;
maxut=-100000000;
for i=2:Nx
    for j=2:Ny
        mminu=min(mminu,u(i,j,1));
        mmaxu=max(mmaxu,u(i,j,1));
        
        minut=min(minut,u(i,j,nn));
        maxut=max(maxut,u(i,j,nn));
    end
end
minut
maxut

[X,Y]=meshgrid(x,y);
vx=-23;vy=41;
view(vx,vy)
V=u(:,:,Nt2+1);
minu=min(V(:));maxu=max(V(:));
if (maxu-minu<=1.D-6)
    maxu=max(maxu,1.D-6);
end
if (opt==0)
    surf(X,Y,u(:,:,nn));

    saveas(gcf,['chaleur2D_exp_' sprintf('%03i',Ncell) '_' num2str(cfl) '_' num2str(T) 's' '.ps'],'psc')
end

moy=sum(V(:))/((Nx+1)*(Ny+1))

if (opt==1)
    %axis([x(1) x(Nx+1) y(1) y(Ny+1) minu maxu])
    %mesh(X,Y,u(:,:,nn));
    %surf(X,Y,u(:,:,nn));

    nn2=0;
    for nn=10:-1:1
        nn2=nn2+ceil((Nt2+1)/2^nn);
        if (nn2>Nt2+1)
            break
        end
        V=u(:,:,nn2);
        minu=min(V(:));maxu=max(V(:));
        if (maxu-minu<=1.D-6)
            minu=minu-1;
            maxu=maxu+1;
        end
        minu=min(mminu,minu);maxu=max(mmaxu,maxu);
        surf(X,Y,u(:,:,nn2));
        view(vx,vy)
        axis([x(1) x(Nx+1) y(1) y(Ny+1) minu maxu])
        colormap jet;
        colorbar;
        caxis([minu maxu]);
        saveas(gcf,['chaleur2D_' sprintf('%03i',Ncell) '_' num2str(cfl) '_' sprintf('%03i',11-nn) '.ps'],'psc')
        %saveas(gcf,['chaleur2D_' sprintf('%03i',Ncell) '_' num2str(cfl) '_' sprintf('%03i',11-nn) '.pdf'],'-dpsc2','-painters','-bestfit')
        close all;
    end
    if (nn2~=Nt2+1)
        V=u(:,:,Nt2+1);
        minu=min(V(:));maxu=max(V(:));
        if (maxu-minu<=1.D-6)
            minu=minu-1;
            maxu=maxu+1;
        end
        minu=min(mminu,minu);maxu=max(mmaxu,maxu);
        surf(X,Y,u(:,:,Nt2+1));
        view(vx,vy)
        axis([x(1) x(Nx+1) y(1) y(Ny+1) minu maxu])
        colormap jet;
        colorbar;
        caxis([minu maxu]);
        saveas(gcf,['chaleur2D_' sprintf('%03i',Ncell) '_' num2str(cfl) '_' sprintf('%03i',11-nn) '.ps'],'psc')
        close all;
    end
    surf(X,Y,u(:,:,1));
    view(vx,vy)
    V=u(:,:,1);
    minu=min(V(:));maxu=max(V(:));
    if (maxu-minu<=1.D-6)
        minu=minu-1;
        maxu=maxu+1;
    end
    axis([x(1) x(Nx+1) y(1) y(Ny+1) minu maxu])
    colormap jet;
    colorbar;
    caxis([minu maxu]);
    saveas(gcf,['chaleur2D_' sprintf('%03i',Ncell) '_' num2str(cfl) '_' sprintf('%03i',0) '.ps'],'psc')
    close all;
end


%fill(x,y,u(:,:,Nt2+1),'LineStyle','none');

% if (opt==1)
%     nn2=0;
%     for nn=10:-1:1
%         nn2=nn2+ceil((Nt2+1)/2^nn);
%         if (nn2>Nt2+1)
%             break
%         end
%         Datas=[x(1,:);u(:,nn2)'];
%         fileID=fopen(['chaleur1D_EE_' num2str(cfl) '_' sprintf('%03i',11-nn) '.txt'],'w');
%         fprintf(fileID,'%2.6f \t %2.6f \n',Datas);
%         fclose(fileID);
%     end
%     if (nn2~=Nt2+1)
%         nn2=Nt2+1;
%         Datas=[x(1,:);u(:,nn2)'];
%         fileID=fopen(['chaleur1D_EE_' num2str(cfl) '_' sprintf('%03i',10-nn) '.txt'],'w');
%         fprintf(fileID,'%2.6f \t %2.6f \n',Datas);
%         fclose(fileID);
%     end
%     nn2=1;
%     Datas=[x(1,:);u(:,nn2)'];
%     fileID=fopen(['chaleur1D_EE_' num2str(cfl) '_' sprintf('%03i',0) '.txt'],'w');
%     fprintf(fileID,'%2.6f \t %2.6f \n',Datas);
%     fclose(fileID);
% end
    
end


function [ff]=fct_src(x,y)

f0=0;
%f0=2000;
a=0.45;b=0.55;
c=0.4;d=0.6;

ff=0;
if (x>=a && x<=b)
    if (y>=c && y<=d)
        ff=f0;
    end
end

end