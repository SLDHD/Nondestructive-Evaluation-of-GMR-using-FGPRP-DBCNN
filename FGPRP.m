function PRP = FGPRP(x,G,sigma_prp)
% Inputs:
%   x         - 1D signal (vector)
%   G         - number of fuzzy granules
%   sigma_prp - Gaussian kernel width for probabilistic RP
%
% Output:
%   PRP       - N-by-N probabilistic recurrence matrix
x=x(:);

N=length(x);


% 每个采样点作为一个状态
Y=x;


dataMin=min(Y);
dataMax=max(Y);

centers=linspace(dataMin,dataMax,G);

granuleWidth=centers(2)-centers(1);


Memb=zeros(N,G);


for g=1:G

    c=centers(g);

    a=c-1*granuleWidth;

    b=c+1*granuleWidth;


    % Z-shaped membership
    Memb(:,g)=zmf(Y,[a b]);

end


U=Memb;


DistU=pdist2(U,U,'euclidean');


PRP=exp(-(DistU.^2)/(2*sigma_prp^2));

end