function coef=CoefDF(k,xbar,x)

close all;

format rat;

n=length(x);
A=zeros(n,n);
B=zeros(n,1);

h=min(x(2:n)-x(1:n-1));
h2=min(abs(x-xbar));
if (h2>0); h=min(h,h2); end

p=n-k;
for i=1:n
    for j=1:n

        A(i,j)=(x(j)-xbar)^(i-1)/factorial(i-1);
        
    end
end
B(k+1)=1;

coef=A\B;
coef=coef*h^k;

end