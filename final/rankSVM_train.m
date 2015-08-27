function  w  = rankSVM_train( X,R,S,W,C_R,C_S,C_W,W_u)
%UNTITLED2 Summary of this function goes here
%   X ~ n x m (n is the # of initial training samples, m is the # of
%   features
%   R ~ pr x n is the partial order training pair, contains
m=size(X,2);
pr = size(R,1);
ps = size(S,1);
pw = size(W,1);
alpha_index = zeros(pr,2);
for i=1:pr;
    alpha_index(i,:) = [ find(R(i,:)==1) find(R(i,:)==-1) ]; 
end
beta_index = zeros(ps,2);
for i=1:ps;
    beta_index(i,:) = [ find(S(i,:)==1) find(S(i,:)==-1) ];
end
theta_index = zeros(pw,2);
for i=1:pw;
    theta_index(i,:) = [ find(W(i,:)==1) find(W(i,:)==-1) ];
end

cvx_begin quiet
    variables w(m,1) alph(pr,1) bet(ps,1) theta(pw,1);
    minimize (0.5*sum_square_abs(w)+C_R*sum(alph)+C_S*sum(bet)+C_W*sum(theta));
    subject to 
        (X(alpha_index(:,1),:)-X(alpha_index(:,2),:))*w >= ones(pr,1)-alph;
        -bet<=(X(beta_index(:,1),:)-X(beta_index(:,2),:))*w<=bet;
        W_u*(ones(pw,1)-theta)<=(X(theta_index(:,1),:)-X(theta_index(:,2),:))*w;
        %theta<=(X(theta_index(:,1),:)-X(theta_index(:,2),:))*w;
        alph>=zeros(pr,1);
        bet>=zeros(ps,1);
        theta>=zeros(pw,1);
cvx_end

end

