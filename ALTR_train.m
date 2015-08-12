function w = ALTR_train(Xt,R,S,C_R,C_S)
% X ~ n x m (n is the # of samples, m is the # of features)
% R ~ pr x n contains exactly one 1 and one -1
% S ~ ps x n contains exactly one 1 and one -1
% C_R and C_S are penalty constants for R and S, respectively
% 
m=size(Xt,2);
pr = size(R,1); ps = size(S,1);
% C_R = ones(pr,1)*C_R; C_S = ones(ps,1)*C_S;
% 
% [K,~, model.sigma] = KNNGraph(Xt',size(Xt,1)-1,0,1);
% model.x = Xt;
% %R=full(R);
% %S=full(S);
alpha_index = [];
for i=1:pr;
    alpha_index = [alpha_index; find(R(i,:)==1) find(R(i,:)==-1) ]; 
end
% size(alpha_index)
%size((Xt(alpha_index(:,1),:)-Xt(alpha_index(:,2),:)))
beta_index = [];
for i=1:ps;
    beta_index = [beta_index; find(S(i,:)==1) find(S(i,:)==-1) ];
end
% model.alpha_index = alpha_index; model.beta_index = beta_index;
% % K_R = [];
% % for i=1:pr-1; 
% %     for j=i+1:pr;
% %         K_R = [K_R; K(alpha_index(i,1),alpha_index(j,1)) - K(alpha_index(i,1),alpha_index(j,2)) - K(alpha_index(i,2),alpha_index(j,1)) + K(alpha_index(i,2),alpha_index(j,2)) ];
% %     end
% % end
% K_R=ones(pr,pr);
% for i=1:pr-1; 
%     for j=i+1:pr;
%         K_R(i,j)=K(alpha_index(i,1),alpha_index(j,1)) - K(alpha_index(i,1),alpha_index(j,2)) - K(alpha_index(i,2),alpha_index(j,1)) + K(alpha_index(i,2),alpha_index(j,2));
%         K_R(j,i)=K_R(i,j);
%     end
% end
% K_R=nearestSPD(K_R);
% K_S = ones(ps,ps);
% for i=1:ps-1
%     for j=i+1:ps
%         K_S(i,j)=K(beta_index(i,1),beta_index(j,1)) - K(beta_index(i,1),beta_index(j,2)) - K(beta_index(i,2),beta_index(j,1)) + K(beta_index(i,2),beta_index(j,2));
%         K_S(j,i)=K_S(i,j);
%     end
% end
% K_S=nearestSPD(K_S);
% % for i=1:ps-1
% %     for j=i+1:ps
% %         K_S = [K_S; K(beta_index(i,1),beta_index(j,1)) - K(beta_index(i,1),beta_index(j,2)) - K(beta_index(i,2),beta_index(j,1)) + K(beta_index(i,2),beta_index(j,2)) ];
% %     end
% % end
% K_RS =ones(pr,pr);
% for i=1:pr
%     for j=1:ps
%         K_RS(i,j)=K(alpha_index(i,1),beta_index(j,1)) - K(alpha_index(i,1),beta_index(j,2)) - K(alpha_index(i,2),beta_index(j,1)) + K(alpha_index(i,2),beta_index(j,2));
%         %K_RS = [K_RS; K(alpha_index(i,1),beta_index(j,1)) - K(alpha_index(i,1),beta_index(j,2)) - K(alpha_index(i,2),beta_index(j,1)) + K(alpha_index(i,2),beta_index(j,2)) ];
%     end
% end
% K_RS=nearestSPD(K_RS);
%size(cmul(ones(pr,1)))
%size(K_R)
% cvx_begin
%     variables alph(pr,1) bet(ps,1);
%     %maximize( sum(alph) - 0.5*sum(cmul(alph).*K_R) - 0.5*sum(cmul(bet).*K_S) + sum(cmulrs(alph,bet).*K_RS ) );
%     %maximize( sum(alph) - 0.5*quad_form(alph,K_R) - 0.5*quad_form(bet,K_S) + alph'*K_RS*[bet;zeros(pr-ps,1)]);
%     subject to
%         zeros(pr,1) <= alph <= C_R
%         zeros(ps,1) <= bet <= C_S
% cvx_end
cvx_begin
    variables w(m,1) alph(pr,1) bet(ps,1);
    minimize (0.5*sum_square_abs(w)+C_R*sum_square_abs(alph)+C_S*sum_square_abs(bet));
    subject to 
        (Xt(alpha_index(:,1),:)-Xt(alpha_index(:,2),:))*w >= ones(pr,1)-alph;
        -bet<=(Xt(beta_index(:,1),:)-Xt(beta_index(:,2),:))*w<=bet;
        alph>=zeros(pr,1);
        bet>=zeros(ps,1);
cvx_end
w=w';
%model.alpha = alph;
%model.beta = bet;


%%
function ma = cmul(a)
ma = [];
for c=1:length(a)-1
    for d=c+1:length(a)
        ma = [ma;a(c)*a(d)];
    end
end

%%
function mab = cmulrs(as,bs)
mab = [];
for e=1:length(as)
    for f=1:length(bs)
        mab = [mab;as(e)*bs(f)];
    end
end
