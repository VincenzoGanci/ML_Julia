using Pkg
Pkg.activate("Lecture2.jl")
Pkg.add("Plots")
using Plots
function Euler_solver!(sol,f!::Function,du,u,p,t,dt=0.1,N=1000)
   
    f!(du,u,p,t)
    sol[:,1]=u
    for j=2:N
    
        sol[:,j]=du*dt+sol[:,j-1]
        f!(du,sol[:,j],p,t)
    end
   
end

function Impr_euler_solver!(sol,f!::Function,du,u,p,t,dt=0.1,N=1000)
   
    f!(du,u,p,t)
    sol[:,1]=u
    for j=2:N
    
        sol[:,j]=du*dt+sol[:,j-1]
        tmp=du;
        f!(du,sol[:,j],p,t)
        sol[:,j]=sol[:,j-1]+0.5*(tmp+du)*dt
        f!(du,sol[:,j],p,t)
    end
   
end

function LV!(du, u, p, t)
    H, F = u
    a, b, c, d = p
    
    du[1] = a*H -b*H*F
    du[2] = -c*F +d*H*F
   
    
    return nothing
end
du=zeros(2)
u0=[20.,5.]
p=[1.,0.5,1.,0.2]
int=[0.,50.]
dt=0.01
t=int[1]:dt:int[2]
N=(int[2]-int[1])/dt
N=floor(Int, N)
len=length(u0)
sol=zeros(Float32,len,N)
Euler_solver!(sol,LV!,du,u0,p,t,dt,N)
plot(sol[1,:])
plot!(sol[2,:])
Impr_euler_solver!(sol,LV!,du,u0,p,t,dt,N)
plot!(sol[1,:])
plot!(sol[2,:])