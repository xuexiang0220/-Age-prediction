%%%%%%%%%%%%%%%%%%relative_power
clear all ;
freqs=[
1.1718
1.5624
1.953
2.3436
2.7342
3.1248
3.5154
3.906
4.2966
4.6872
5.0778
5.4684
5.859
6.2496
6.6402
7.0308
7.4214
7.812
8.2026
8.5932
8.9838
9.3744
9.765
10.1556
10.5462
10.9368
11.3274
11.718
12.1086
12.4992
12.8898
13.2804
13.671
14.0616
14.4522
14.8428
15.2334
15.624
16.0146
16.4052
16.7958
17.1864
17.577
17.9676
18.3582
18.7488
19.1394
];
delta_range = freqs>=0.5 & freqs<=4;
theta_range = freqs>4 & freqs<=8;
alpha_range = freqs>8 & freqs<=12;
beta_range = freqs>12 & freqs<=20;

load('*\all.mat'); 
dt=data;

Data.age=round([dt.age]);
Data.power=[{dt.hls}];
data00=Data;
hls=data00.power;

    data=hls';

measures1=[];measures2=[];measures3=[];measures4=[];
measures=zeros(4,length(data)); 
for k=1:1:18
    measures=[];
for i=1:length(data)
    power_data=data(i);
    power_data=cell2mat(power_data);
   power_data=(2.7148).^power_data;

   power_data=power_data(:,k);
   relative_power=zeros(4,1);
   j=1;
        
        delta_power=sum(power_data(delta_range,j));
        theta_power=sum(power_data(theta_range,j));
        alpha_power=sum(power_data(alpha_range,j));
        beta_power=sum(power_data(beta_range,j));
        total_power=delta_power+theta_power+alpha_power+beta_power;
        relative_power(1,j)=delta_power/total_power;
        relative_power(2,j)=theta_power/total_power;
        relative_power(3,j)=alpha_power/total_power;
        relative_power(4,j)=beta_power/total_power;
    measures(:,i)=relative_power(:,:);
   
end
 measures=measures';
 measures1(:,k)=measures(:,1);
measures2(:,k)=measures(:,2);
measures3(:,k)=measures(:,3);
measures4(:,k)=measures(:,4);
end


E=[measures1(:,1:18) measures2(:,1:18) measures3(:,1:18) measures4(:,1:18) ];

