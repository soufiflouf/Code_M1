function TP1

close all
format long

nn=5;

err_Dp=zeros(1,nn);
err_Dm=zeros(1,nn);
err_D2=zeros(1,nn);
err_D3=zeros(1,nn);

od_Dp=zeros(1,nn-1);
od_Dm=zeros(1,nn-1);
od_D2=zeros(1,nn-1);
od_D3=zeros(1,nn-1);

Cp=0;
Cm=0;
C2=0;
C3=0;

h=[10^(-1),5*10^(-2),10^(-2),5*10^(-3),10^(-3)];

for i=1:nn
    Dp=(sin(1+h(i))-sin(1))/h(i);
    Dm=(sin(1)-sin(1-h(i)))/h(i);
    D2=(sin(1+h(i))-sin(1-h(i)))/(2*h(i));
    D3=(2*sin(1+h(i))+3*sin(1)-6*sin(1-h(i))+sin(1-2*h(i)))/(6*h(i));

    L=cos(1);

    err_Dp(i)=Dp-L;
    err_Dm(i)=Dm-L;
    err_D2(i)=D2-L;
    err_D3(i)=D3-L;
    
    Cp=Cp+err_Dp(i)/h(i);
    Cm=Cm+err_Dm(i)/h(i);
    C2=C2+err_D2(i)/h(i)^2;
    C3=C3+err_D3(i)/h(i)^3;
    
    if (i>1)
        od_Dp(i-1)=log(err_Dp(i-1)/err_Dp(i))/log(h(i-1)/h(i));
        od_Dm(i-1)=log(err_Dm(i-1)/err_Dm(i))/log(h(i-1)/h(i));
        od_D2(i-1)=log(err_D2(i-1)/err_D2(i))/log(h(i-1)/h(i));
        od_D3(i-1)=log(err_D3(i-1)/err_D3(i))/log(h(i-1)/h(i));
    end
end

Cp=Cp/nn
Cm=Cm/nn
C2=C2/nn
C3=C3/nn

loglog(h,h,'k-+',h,h.^2,'k-s',h,h.^3,'k-*',h,abs(err_Dp),'r-d',h,abs(err_Dm),'g-d',h,abs(err_D2),'m-d',h,abs(err_D3),'b-d');
grid on;
xlabel('h');
ylabel('erreur');
title('Graphe loglog donnant la précision de la méthode');
legend('h','h^2','h^3','Dp','Dm','D2','D3','Location','southeast');

coef_Dp=polyfit(log(h),log(abs(err_Dp)),1);
coef_Dm=polyfit(log(h),log(abs(err_Dm)),1);
coef_D2=polyfit(log(h),log(abs(err_D2)),1);
coef_D3=polyfit(log(h),log(abs(err_D3)),1);

pente_Dp=coef_Dp(1)
pente_Dm=coef_Dm(1)
pente_D2=coef_D2(1)
pente_D3=coef_D3(1)

od_Dp
od_Dm
od_D2
od_D3

end
