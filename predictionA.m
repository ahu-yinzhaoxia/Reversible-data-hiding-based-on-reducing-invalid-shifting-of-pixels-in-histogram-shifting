function [ pre_I,err_I,num_0,num_1,num_11,Z1,Z2,PK1,PK2 ] = predictionA( I )
%������Ԥ����������������Ԥ�⣬�ټ���Ȩ��
%  �������룺IΪԭʼͼ��
%  ���������pre_IΪԤ��ֵ,err_IԤ�����,num_0Ԥ�����Ϊ0�ĸ���,num_1Ԥ�����Ϊ1�ĸ���,num_11Ԥ�����Ϊ-1�ĸ���,
%  Z1��ֵ����ߵ���ֵ��,Z2��ֵ���ұߵ���ֵ��,PK1Ϊ��ֵ��,PK2�η�ֵ��
[m,n]=size(I);
rhombus_I=I;
pre_I=I;
err_I=zeros(m,n);
for i=2:m-1
    for j=2:n-1
        if mod(i+j,2)==0
            a=I(i-1,j);%a,b,c,d�ֱ�Ϊ��������λ�õ�����ֵ
            b=I(i,j+1);
            c=I(i+1,j);
            d=I(i,j-1);
            rhombus_I(i,j)=floor((a+b+c+d)/4);%����Ԥ��
            e1=abs(a-rhombus_I(i,j));%
            e2=abs(b-rhombus_I(i,j));
            e3=abs(c-rhombus_I(i,j));
            e4=abs(d-rhombus_I(i,j));
            sum_e=e1+e2+e3+e4;
            if sum_e==0
                pre_I(i,j)=rhombus_I(i,j);
            else
                r1=sum_e/(e1+1);
                r2=sum_e/(e2+1);
                r3=sum_e/(e3+1);
                r4=sum_e/(e4+1);
                sum_r=r1+r2+r3+r4;
                w1=r1/sum_r;
                w2=r2/sum_r;
                w3=r3/sum_r;
                w4=r4/sum_r;
                pre_I(i,j)=floor(w1*a+w2*b+w3*c+w4*d);
            end
            err_I(i,j)=I(i,j)-pre_I(i,j);
        end
    end
end
num_0=0;
num_1=0;
num_11=0;
for i=2:m-1
    for j=2:n-1
        if mod(i+j,2)==0
            if err_I(i,j)==0
                num_0=num_0+1;
            elseif err_I(i,j)==1
                num_1=num_1+1;
            elseif err_I(i,j)==-1
                num_11=num_11+1;
            end 
        end
    end
end
%����Ԥ�����ֱ��ͼ
err1=[err_I(2:+2:m-1,2:+2:n-1);err_I(3:+2:m-1,3:+2:n-1)];%ȡ������mod��i+j,2��==0��ֵ
hist_error_I=tabulate(err1(:));%��Ԥ������������ֵ����ͳ��
[PK1,PK2,Z1,num]=findpz1(err1); %�ҳ�����ķ�ֵ��PK���ڷ�ֵ��������ֵ��Z
[PK3,Z2,num]=findpz2(err1); %�ҳ�����ķ�ֵ��PK���ڷ�ֵ���Ҳ����ֵ��Z
% figure(1)
% bar(hist_error_I(:,1),hist_error_I(:,2),0.1);%����Ԥ�����ֱ��ͼ��2-�ڶ���
% title('Ԥ�����ֱ��ͼ');
end

