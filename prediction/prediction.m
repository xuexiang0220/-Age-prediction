
clear, clc;
load('*\*.mat');
DATA1015=F;
rsl1=[2.^-1,2.^-2,2.^-3,2.^-4,2.^-5,2.^-6,2.^-7,2.^-8,2.^-9,2.^-10];
rsl2=[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9];
for RSL1=1:1:10
      Rho1=rsl1(RSL1);
  
    for RSL2=1:1:10
        Rho2=rsl2(RSL2);  
        rho=[Rho1,Rho2];
        data=DATA1015(:,2:235);
        y = DATA1015(:, 1);
        A=[];    k=1; 
        Allnetwork=[];
        for J=1:1:length(data) 
            for t=1:1:18
              for j=t:18:234
                SubjectAall(k,t)=data(J,j);
                k=k+1;
              end
               k=1;
            end

             cor= abs(corrcoef(SubjectAall', 'Rows', 'complete'));
           
opts=[];

% Starting point
opts.init=2;        % starting from a zero point

% Termination 
opts.tFlag=5;       % run .maxIter iterations
opts.maxIter=100;   % maximum number of iterations

% regularization
opts.rFlag=1;       % use ratio
% Normalization
opts.nFlag=0;       % without normalization

                Network=[];
                network=[];
                for I=1:1:13
                    subjectAall=SubjectAall';
                    Y=subjectAall(:,I);
                    subjectAall(:,[I])=[];
                    A=subjectAall;
                
                      if I==1
                         opts.ind=[ [1, 1, cor(I,2)]', [2, 4, sum(cor(I,3:5))]',[5, 8, sum(cor(I,6:9))]', [9, 12, sum(cor(I,10:13))]' ];
                      elseif I==2
                         opts.ind=[ [1, 1, cor(I,1)]', [2, 4, sum(cor(I,3:5))]',[5, 8, sum(cor(I,6:9))]', [9, 12, sum(cor(I,10:13))]' ];
                      elseif  I==3
                         sum3=cor(I,4)+cor(I,5);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum3]',[5, 8, sum(cor(I,6:9))]', [9, 12, sum(cor(I,10:13))]'];
                       elseif  I==4
                         sum4=cor(I,3)+cor(I,5);
                         opts.ind=[ [1, 2,sum(cor(I,1:2))]', [3, 4, sum4]',[5, 8, sum(cor(I,6:9))]', [9, 12, sum(cor(I,10:13))]'];
                      elseif  I==5
                         sum5=cor(I,3)+cor(I,4);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum5]',[5, 8, sum(cor(I,6:9))]', [9, 12, sum(cor(I,10:13))]'];
                      elseif  I==6
                         sum6=cor(I,7)+cor(I,8)+cor(I,9);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum(cor(I,3:5))]',[5, 8, sum6]', [9, 12, sum(cor(I,10:13))]'];
                      elseif  I==7
                         sum7=cor(I,6)+cor(I,8)+cor(I,9);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum(cor(I,3:5))]',[5, 8, sum7]', [9, 12, sum(cor(I,10:13))]'];
                      elseif  I==8
                         sum8=cor(I,6)+cor(I,7)+cor(I,9);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum(cor(I,3:5))]',[5, 8, sum8]', [9, 12, sum(cor(I,10:13))]'];
                      elseif  I==9
                         sum9=cor(I,6)+cor(I,7)+cor(I,8);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum(cor(I,3:5))]',[5, 8, sum9]', [9, 12, sum(cor(I,10:13))]'];
                      elseif  I==10
                         sum10=cor(I,11)+cor(I,12)+cor(I,13);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum(cor(I,3:5))]',[5, 8,sum(cor(I,6:9))]', [9, 12, sum10]'];
                      elseif  I==11
                         sum11=cor(I,10)+cor(I,12)+cor(I,13);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum(cor(I,3:5))]',[5, 8,sum(cor(I,6:9))]', [9, 12, sum11]'];
                      elseif  I==12
                         sum12=cor(I,11)+cor(I,10)+cor(I,13);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum(cor(I,3:5))]',[5, 8,sum(cor(I,6:9))]', [9, 12, sum12]'];
                      else 
                         sum13=cor(I,11)+cor(I,12)+cor(I,10);
                         opts.ind=[ [1, 2,sum(cor(I,1:2)) ]', [3, 4, sum(cor(I,3:5))]',[5, 8,sum(cor(I,6:9))]', [9, 12, sum13]'];
                      end

                        [x1, funVal1, ValueL]= sgLeastR(A, Y, rho, opts);
                  
                     network(:,I)=x1;
                     
                 
                   Network=[Network network(:,I)']
                end
               
               
                  Allnetwork(J,:)=Network;
                  
                end
            
                 [rho1,pval1] = corr(Allnetwork,y)
                             
                 selected_columns1 = find(pval1 <0.05);
   
            filtered_Allnetwork = Allnetwork(:, selected_columns1);
          
            X_OscF= DATA1015(:,2:235);
                  [rho2,pval] = corr(X_OscF,y);
                  selected_columns = find(pval <0.05);
           
            filtered_X_OscF =X_OscF(:, selected_columns);
            
            X_ALL_1=[X_OscF filtered_Allnetwork];
            X_ALL_2=[filtered_X_OscF filtered_Allnetwork];
            X_ALL_3=[X_OscF Allnetwork];
     
            X1=X_OscF ;
            X2=filtered_X_OscF;
            X3=filtered_Allnetwork;
            X33=Allnetwork;
            X4=X_ALL_1;
            X5=X_ALL_2;
            X6=X_ALL_3;
            
            X=X6;
            y = DATA1015(:, 1);   
            
            MAE_values = [];
            MAPE_values = [];
            MSE_values =[];
            RMSE_values = [];
            R2_values =[];
            adjR2_values =[];
            
            
            for exp_num=1:1:10
           
            net = fitnet([10,10,10]);
            
            numFolds = 10; 
            cv = cvpartition(size(X, 1), 'KFold', numFolds);
          
            YY_pred=[];
            X_age_row=[];
           
            for fold = 1:numFolds
               
                trainIdx = training(cv, fold);
                testIdx = test(cv, fold);
                X_train = X(trainIdx, :);
                y_train = y(trainIdx);
                X_test = X(testIdx, :);
                y_test = y(testIdx);
                net.trainParam.showWindow = false;
                net.trainParam.showCommandLine = false; 
                
                net = train(net, X_train', y_train');
       
                y_pred = net(X_test')';
       
                MAE_values(fold,exp_num) = mean(abs(y_test - y_pred));
                MAPE_values(fold,exp_num) = mean(abs(y_test - y_pred) ./ y_test) * 100;
                MSE_values(fold,exp_num) = mean((y_test - y_pred).^2);
                RMSE_values(fold,exp_num) = sqrt(mean((y_test - y_pred).^2));
                R2_values(fold,exp_num) = corr(y_test, y_pred)^2;
                adjR2_values(fold,exp_num) = 1 - (1 - R2_values(fold)) * ((length(y_test) - 1) / (length(y_test) - size(X_train, 2) - 1));
            end
            
           
            
                MAE_values(11,exp_num) = mean(MAE_values(:,exp_num))
                MAPE_values(11,exp_num) = mean(MAPE_values(:,exp_num))
                MSE_values(11,exp_num) =  mean(MSE_values(:,exp_num));
                RMSE_values(11,exp_num) =  mean(RMSE_values(:,exp_num));
                R2_values(11,exp_num) =  mean(R2_values(:,exp_num));
               adjR2_values(11,exp_num) = mean(adjR2_values(:,exp_num))
            end

    allMAE(RSL1,RSL2)=mat2cell(MAE_values,11,10);
    allMAPE(RSL1,RSL2)=mat2cell(MAPE_values,11,10);
    allMSE(RSL1,RSL2)=mat2cell(MSE_values,11,10);
    allRMSE(RSL1,RSL2)=mat2cell(RMSE_values,11,10);
    allR2(RSL1,RSL2)=mat2cell(R2_values,11,10);
    alladjR2(RSL1,RSL2)=mat2cell(adjR2_values,11,10);

    results_MAE_values(RSL1,RSL2) = mean(MAE_values(11,:))
    results_MAPE_values(RSL1,RSL2) = mean(MAPE_values(11,:))
    results_MSE_values(RSL1,RSL2) =  mean(MSE_values(11,:));
    results_RMSE_values(RSL1,RSL2) =  mean(RMSE_values(11,:));
    results_R2_values(RSL1,RSL2) =  mean(R2_values(11,:));
    results_adjR2_values(RSL1,RSL2) = mean(adjR2_values(11,:));

    end
end

save('results.mat')  