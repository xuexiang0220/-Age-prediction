%%power ratio
clear all ;
load('*\all.mat'); 
dt=data;
Data.age=round([dt.age]);
Data.power=[{dt.hls}];

data00=Data;
hls=data00.power;
%hls=hls';
hls=cell2mat(hls);

hls=(2.7148).^hls
delta=hls(1:10,:);
theta=hls(11:20,:);
alpha=hls(21:30,:);
beta=hls(31:47,:);

delta_sum=sum(delta,1);
theta_sum=sum(theta,1);
alpha_sum=sum(alpha,1);
beta_sum=sum(beta,1);

all(:,1)=delta_sum;
all(:,2)=theta_sum;
all(:,3)=alpha_sum;
all(:,4)=beta_sum;
rate_theta_beta = all(:,2)./all(:,4);
rate_delta_theta =all(:,1)./all(:,2);
rate_delta_alpha =all(:,1)./all(:,3);
rate_theta_alpha =all(:,2)./all(:,3);

L=length(hls);
for j=1:1:18
      k=1;
      for i=j:18:L
      Rate_theta_beta(k,j)=rate_theta_beta(i);
      Rate_delta_theta(k,j)=rate_delta_theta(i);
      Rate_delta_alpha (k,j)=rate_delta_alpha (i);
     Rate_theta_alpha(k,j)=rate_theta_alpha(i);
      k=k+1;
      end
end

RATE_ALL=[Rate_theta_beta(:,1:18) Rate_delta_theta(:,1:18)  Rate_delta_alpha(:,1:18) Rate_theta_alpha(:,1:18)];
