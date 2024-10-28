using Plots

function logistic(x0,r,N)
    x=zeros(N);
    x[1]=x0;
    x[2]=r*x0*(1-x0);
    for i=3:N
        x[i]=r*x[i-1]*(1-x[i-1]);
    end
    return (x)
end


x0=0.4;
r=3.12;
N=50;
x=logistic(x0,r,N);
# print(x)
plot(x, xlims=[0, 60], title = "Logistic Map with r=3.12", xlabel = "Steps", ylabel = "Population")

r=
