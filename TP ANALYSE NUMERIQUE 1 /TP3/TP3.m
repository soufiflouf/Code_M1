function TP3

n_err=6;

a=0;b=3;

err=zeros(n_err,1);
hn=zeros(n_err,1);
ordre=zeros(n_err-1,1);

nn=40;
for i=1:n_err
   nint=nn*2^(i-1);
   
   hn(i)=(b-a)/nint;
   err(i)=poisson1D_mixte(nint,0);
    
    if (i>1)
        ordre(i-1)=log(err(i-1)/err(i))/log(hn(i-1)/hn(i));
    end
end

coef=polyfit(log(hn),log(abs(err)),1);
pente=coef(1);

C=10;
%C=exp(coef(2));
loglog(hn,err,'r-*',hn,C*hn.^2,'b-d');
legend('erreur','C h^2','Location','northwest');

disp(' ');
disp(['        L''Ordre de la méthode numérique est ' num2str(ordre(n_err-1))]);
disp(' ');

end