function Laplacien_2D(cas)

close all

if (cas==1)
    x0=1;y0=1;
    odd=4;
else
    x0=0;y0=0;
    odd=6;
end

h=[5*10^(-1),10^(-1),5*10^(-2),10^(-2),5*10^(-3)];

nn=length(h);
err1=zeros(1,nn);
ordre1=zeros(1,nn-1);
err2=zeros(1,nn);
ordre2=zeros(1,nn-1);

k=2;
coef1=CoefDF(k,0,[-1,0,1]);
nk1=(length(coef1)+1)/2;

coef2=CoefDF(k,0,[-2,-1,0,1,2]);
nk2=(length(coef2)+1)/2;

L=fct_u_Lap(x0,y0);

for i=1:nn
    
    Lh1=0;
    for j=1:length(coef1)
        Lh1=Lh1+coef1(j)*(fct_u(x0+(j-nk1)*h(i),y0)+fct_u(x0,y0+(j-nk1)*h(i)));
    end
    Lh1=Lh1/h(i)^k;
    
    Lh2=0;
    for j=1:length(coef2)
        Lh2=Lh2+coef2(j)*(fct_u(x0+(j-nk2)*h(i),y0)+fct_u(x0,y0+(j-nk2)*h(i)));
    end
    Lh2=Lh2/h(i)^k;
    

    err1(i)=Lh1-L;
    err2(i)=Lh2-L;
    
    if (i>1)
        ordre1(i-1)=log(err1(i-1)/err1(i))/log(h(i-1)/h(i));
        ordre2(i-1)=log(err2(i-1)/err2(i))/log(h(i-1)/h(i));
    end
end

format long

loglog(h,h.^2,'k-*',h,abs(err1),'b-d',h,h.^odd,'k-*',h,abs(err2),'g-d');
grid on;
xlabel('h');
ylabel('erreur');
title('Graphe loglog donnant la précision de la méthode');
legend('h^2','Lh1',['h^' num2str(odd)],'Lh2','Location','southeast');

coef_err1=polyfit(log(h),log(abs(err1)),1);
coef_err2=polyfit(log(h),log(abs(err2)),1);

pente_moyenne_err1=coef_err1(1)
pente_moyenne_err2=coef_err2(1)

real(ordre1)
real(ordre2)

end

function u=fct_u(x,y)

u=cos(x.^2+y.^2);

end

function u_Lap=fct_u_Lap(x,y)

u_Lap=-4*((x.^2+y.^2).*cos(x.^2+y.^2)+sin(x.^2+y.^2));

end