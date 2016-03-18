function [Tdist,town]=traveling2(x,y,D)

% uses simulated annealing to solve the Traveling Salesman Problem: given n
% towns and the distances between any two of them, finds the shortest route 
% that starts at one of the towns, goes once through everyone of the others 
% and returns to the first one

% traveling2.m usa a funcao rand do Matlab (que gera numeros pseudo-aleatorios com distribuicao uniforme entre 0 e 1) 
% Para obter uma rota inicial e inicia um processo de busca alterando localmente cada rota e aceitando a nova rota se o comprimento desta for inferior ao da rota anterior. 
% Este processo de optimizacao e levado a cabo sobre uma matriz (simetrica) de distancias entre as diferentes cidades;

n=length(x);
% FIRST tentative route 
town=randperm(n); % a random permutation of the first n integers 
Tdist=D(town(n),town(1));
for i=1:n-1                               % initial length
    Tdist=Tdist+D(town(i),town(i+1));     % of route
end

i=0;
while i < 100  % stop if no changes for 1000 iterations
    c=ceil(n*rand);     % randomly chooses a town (at position c in route)
    if c==1  
        previous=n; next1=2; next2=3;
    elseif c==n-1
        previous=n-2; next1=n; next2=1;
    elseif c==n
        previous=n-1; next1=1; next2=2;
    else
        previous=c-1; next1=c+1; next2=c+2;
    end

    % delta=increment in length of route
    delta=D(town(previous),town(next1))+D(town(c),town(next2))-D(town(previous),town(c))-D(town(next1),town(next2)); 
    % accept or discard change to route 
    if delta<0 
        temp=town(c); town(c)=town(next1); town(next1)=temp; % swap order of town(c) and town(c+1) in route                 
        Tdist=Tdist+delta;   
    else i=i+1;
    end
   
end



