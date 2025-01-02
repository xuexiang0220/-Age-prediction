
clear all ;
load('*/all.mat'); 
dt=data;
Data.age=round([dt.age]);
Data.power=[{dt.hls}];
for m=1:18
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
freqs=freqs';
settings = struct();
f_range = [0 20]; 
psds=[];
Z=Data.power;
Z=cell2mat(Z');
%Z=Z';
Z=Z(:,m);
Z=(2.7148).^Z;
%Z=Z';
L=length(Z);
K=1;
for i=1:47:L
    psds(:,K)=Z(i:i+46,:);
    K=K+1;
end
%psds=psds';
 fooof_results = fooof_group(freqs, psds, f_range, settings);
a={fooof_results.aperiodic_params}';
a1=cell2mat(a(:,1));
peak={fooof_results.peak_params}';
cf_=[];
power_=[];
tw_=[];
%提取参数
for i=1:1949
     p1=cell2mat(peak(i,1));
     cf_{i}(:,1)=p1(:,1); 
     power_{i}(:,1)=p1(:,2); 
     tw_{i}(:,1)=p1(:,3);   
end
cf_=cf_';
power_=power_';
tw_=tw_';

cfrequency=[];
power=[];
tapewidth=[];
for i = 1:1:1949
    cfrequency1= cf_(i);
    cfrequency2=cell2mat(cfrequency1);
    cfrequency(i)=mean(cfrequency2);
    power1= power_(i);
    power2=cell2mat(power1);
    power(i)=mean(power2);
    tapewidth1= tw_(i);
    tapewidth2=cell2mat(tapewidth1);
    tapewidth(i)=mean(tapewidth2);
  
end

cfrequency=cfrequency';
power=power';
tapewidth=tapewidth';
pianyi(:,m)=a1(:,1);
zhisu(:,m)=a1(:,2);
zhongxinpinglv(:,m)=cfrequency;
gonglv(:,m)=power;
daikuan(:,m)=tapewidth;

end

F=[pianyi zhisu zhongxinpinglv gonglv daikuan];




  