function TP2

close all

nn=5;

err=zeros(1,nn);
ordre=zeros(1,nn-1);
CC=0;

h=[5*10^(-1),10^(-1),5*10^(-2),10^(-2),5*10^(-3)];

%k=2;
%coef=CoefDF(k,0,[-1,0,1])
k=4;
coef=CoefDF(k,0,[-2,-1,0,1,2])
nk=(length(coef)+1)/2;

format long

if (k==1)
    L=cos(1);
elseif (k==2)
    L=-sin(1);
elseif (k==3)
    L=-cos(1);
elseif (k==4)
    L=sin(1);
end

for i=1:nn
    
    Lh=0;
    for j=1:length(coef)
        Lh=Lh+coef(j)*sin(1+(j-nk)*h(i));
    end
    Lh=Lh/h(i)^k;
    

    err(i)=Lh-L;
    
    CC=CC+err(i)/h(i)^2;
    
    if (i>1)
        ordre(i-1)=log(err(i-1)/err(i))/log(h(i-1)/h(i));
    end
end

CC=CC/nn

loglog(h,h.^2,'k-*',h,abs(err),'b-d');
grid on;
xlabel('h');
ylabel('erreur');
title('Graphe loglog donnant la précision de la méthode');
legend('h^2','Lh','Location','southeast');

coef_err=polyfit(log(h),log(abs(err)),1);

pente_err=coef_err(1)

ordre

end
