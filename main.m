clear%�������
clc%�����Ļ
%��ͼ���ÿһ������ֵ�ĸ��Ӷ������򣬴Ӷ�Ƕ����Ϣ
I=double(imread('lena.tiff'));
l=1;
% for i = 1:5
%     n=0.01*i;
% payload =round(n*512*512);%Ƕ����غ���
% K=zeros();
% for payload=3000:3000:36000
payload=10000;
% seed = 0; %��������,��֤�����ȶ��������
% rand('seed',seed); 
data = randi([0,1],1,payload); %������ɵ�01������Ϊ������Ϣ
%% ��Aÿ������λ�õĸ��ӶȲ������Ӷ����������Ƕ������ѡ����Ӧ�ĸ��Ӷ�ֵ
%��ÿ��λ�õļ����ܱߵķ�Χ�ĸ��Ӷ����ϵõ�һ���ֲ����Ӷ�
[ complexity_IA,local_complexity_IA,x_posA,y_posA] = complexityA( I );
%% ��A����ֵ��Ԥ�����
[ pre_IA,err_IA,num_0A,num_1A,num_11A,Z1A,Z2A,PK1A,PK2A ] = predictionA( I );
%[bin_LM bin_LM_len I] = LocationMap(I);
%% �������ݵ�Ƕ��
[ stego_I1,numdata1,emddataA,th,x_pos1,y_pos1,j,l1,err_I1 ] = embedA(I,local_complexity_IA,data,Z1A,Z2A,PK1A,PK2A,err_IA,payload,x_posA,y_posA );
%% ��Bÿ������λ�õĸ��ӶȲ������Ӷ����������Ƕ������ѡ����Ӧ�ĸ��Ӷ�ֵ
[ complexity_IB,local_complexity_IB,x_posB,y_posB  ] = complexityB( stego_I1 );
%% ��B����ֵ��Ԥ�����
[ pre_IB,err_IB,num_0B,num_1B,num_11B,Z1B,Z2B,PK1B,PK2B ] = predictionB( stego_I1 );
% [bin_LM bin_LM_len I] = LocationMap_circle(stego_I1);
%% �������ݵ�Ƕ��
[stego_I2,numdata2,emddataB,thB,sort_sequence_cB,sequence_ypos1,k,l2,err_IB1]=embedB(stego_I1,local_complexity_IB,Z1B,Z2B,PK1B,PK2B,err_IB,numdata1,payload,data,x_posB,y_posB);
 psnr1 = psnr( I,stego_I2 );
%  PSNR(l)=psnr1;
% % %  N(i)=n;
%  l=l+1;
% end
%% ��ȡ������Ϣ��������ȡ��
%������ȡB���ֵ�������Ϣ���ȼ���B���ֵĸ��Ӷȣ�������ȡA ���ֵ�������Ϣ
%��ȡB���ֵ�������Ϣ
[ re_B,extdataB,thb ] = extractB( stego_I2,payload,Z1B,Z2B,PK1B,PK2B );
ans1=isequal(emddataB,extdataB);
ans2=isequal(stego_I1,re_B);
%��ȡA���ֵ�������Ϣ
[ tha,re_A,extdataA ] = extractA( re_B,payload,Z1A,Z2A,PK1A,PK2A );
ans3=isequal(extdataA,emddataA);
ans4=isequal(re_A,I);
