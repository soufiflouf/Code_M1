function LCS(pb,flx_num,Nc,cfl,nimp_tot)

close all;

if (pb==0)
    tflx=1;
    dini=1;
    xdeb=0;
    xfin=1;
    
    tc=1./(2*pi);
    Tfin=0.9*tc;
elseif (pb==1)
    tflx=1;
    dini=1;
    xdeb=0;
    xfin=1;
    
    tc=1./(2*pi);
    Tfin=4*tc;
elseif (pb==2)
    tflx=1;
    dini=2;
    xdeb=-1.5;
    xfin=1;
    
    Tfin=3.2;
else
    tflx=2;
    dini=3;
    xdeb=-1;
    xfin=1;
    
    Tfin=0.4;
end 

L=xfin-xdeb;
h=L/Nc;

Nc_sol=max(Nc,200);

u=zeros(1,Nc);
x=zeros(1,Nc);
for i=1:Nc
    x(i)=xdeb+(i-1/2)*h;
    u(i)=u_ini(dini,x(i));
end
u_old=u;

us=zeros(1,Nc_sol);
x_sol=zeros(1,Nc_sol);
for i=1:Nc_sol
    x_sol(i)=xdeb+(i-1/2)*L/Nc_sol;
    us(i)=u_ini(dini,x_sol(i));
end

hold on
if (nimp_tot>1)
    if (pb<3)
        plot(x_sol,us(:),'LineWidth',3,'Color',[1,0,0])
    end
    plot(x,u(:),'LineWidth',2,'Color',[0,1,0])
end
nimp=1;

nit=0;
time=0;
while (time < Tfin)
    if (pb<3)
        ac=-1;
        for i=1:Nc
            ac=max(ac,abs(dflux(u(i),tflx)));
        end
    else
        ac=2.34;
    end
    
    deltat=cfl*h/ac;
    lbd=deltat/h;
    
    for i=1:Nc
        ui=u_old(i);
        if (i>1)
            ug=u_old(i-1);
        else
            if (pb==2)
                ug=u_sol(2,xdeb,time);
            else
                ug=u_old(Nc);
            end
        end
        if (i<Nc)
            ud=u_old(i+1);
        else
            if (pb==2)
                ud=u_sol(2,xfin,time);
            else
                ud=u_old(1);
            end
        end
        

        u(i)=ui-lbd*(flux_num(ui,ud,ac,flx_num,tflx)-flux_num(ug,ui,ac,flx_num,tflx));
                
    end
    
    time=time+deltat;
    nit=nit+1;
    u_old=u;
    
    if (abs(time-nimp*Tfin/nimp_tot)<=deltat/2+eps)
        if (nimp<nimp_tot)
            if (pb<3)
               for i=1:Nc_sol
                   us(i)=u_sol(pb,x_sol(i),time);
               end
               
               if (pb~=1 || time< 1./(2*pi))
                   plot(x_sol,us,'LineWidth',3,'Color',[1,0,0])
               end
            end
            plot(x,u,'LineWidth',2,'Color',[0,1.-nimp/nimp_tot,nimp/nimp_tot])
            nimp=nimp+1;
        end
    end   
end

if (pb==3)
    Nc_sol=30000;
    us=zeros(1,Nc_sol);
    x_sol=zeros(1,Nc_sol);
    
    file_sol=fopen('buckley.dat','r');
    for i=1:Nc_sol
        a = fscanf(file_sol,'%g %g',[2 1]);
        x_sol(i)=a(1);
        us(i)=a(2);
    end
    fclose(file_sol);
else
    for i=1:Nc_sol
       us(i)=u_sol(pb,x_sol(i),Tfin);
    end
end

if (pb~=1)
    plot(x_sol,us,'LineWidth',3,'Color',[1,0,0])
end
plot(x,u,'LineWidth',2,'Color',[0,0,1])

end


function [ff]=flux_num(ug,ud,ac,flx_num,tflx)

if (flx_num==1)
    ai=ac;
elseif (flx_num==2)
    ai=max(abs(dflux(ug,tflx)),abs(dflux(ud,tflx)));
else
    if (abs(ud-ug)<1.D-10)
        ai=(abs(dflux(ug,tflx))+abs(dflux(ud,tflx)))/2;
    else
        ai=abs((flux(ud,tflx)-flux(ug,tflx))/(ud-ug));
    end
end

ff=(flux(ug,tflx)+flux(ud,tflx)-ai*(ud-ug))/2;

end


function [ff]=flux(uu,tflx)

if (tflx==0)
    ff=uu;
elseif (tflx==1)
    ff=uu^2/2;
else
    ff=4*uu^2/(4*uu^2+(1-uu)^2);
end

end


function [dff]=dflux(uu,tflx)

if (tflx==0)
    dff=1;
elseif (tflx==1)
    dff=uu;
else
    dff=8*uu*(1-uu)/(4*uu^2+(1-uu)^2)^2;
end

end


function [uu]=u_ini(dini,x)

uu=0;
if (dini==1)
    uu=sin(2.*pi*x);
elseif (dini==2)
    if (x>=0.3 && x<0.7)
        uu=-1;
    elseif (x>=0.7)
        uu=0.5;
    end
else
    if (x>-0.5 && x<=0)
        uu=1;
    end
end

end


function [us]=u_sol(pb,x,tps)

us=0;
if (pb<=1)
    tc=1./(2*pi);
    if (tps<tc-1.D-10)
        X0=carac_newton(x,tps);
        us=sin(2.*pi*X0);
    end
elseif (pb==2)
    if (tps<0.8)
        if (x>0.3-tps/2 && x<=0.7-tps)
            us=-1;
        elseif (x>0.7-tps && x<=0.7+tps/2)
            us=(x-0.7)/tps;
        elseif (x>0.7+tps/2)
            us=0.5;
        end
    else
        xc=-sqrt(0.8*tps)+0.7;
        if (x>xc && x<=0.7+tps/2)
            us=(x-0.7)/tps;
        elseif (x>0.7+tps/2)
            us=0.5;
        end
    end
end

end


function [X0]=carac_newton(x,t)
    
X0=x;
errn=10;

it=0;
while (errn>1.D-10 && it<10000)
    Xold=X0;
    fct_g=sin(2.*pi*Xold)*t+Xold-x;
    fct_dg=2.*pi*cos(2.*pi*Xold)*t+1;
    
    X0=Xold-fct_g/fct_dg;
    errn=abs(X0-Xold);
end
    
end

