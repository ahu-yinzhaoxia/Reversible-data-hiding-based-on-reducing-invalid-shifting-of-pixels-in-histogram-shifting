function [ B ] = zigzagA( local_complexity_I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%�������룺ԭʼͼ���Rͨ��
%���������zigzagɨ��õ�������
[m,n]=size(local_complexity_I);
R1=zeros(m-2,n-2);
R1=local_complexity_I(2:511,2:511);
% % R1=local_complexity_I(2:9,2:9);
% R1=local_complexity_I(2:95,2:95);
[N N]=size(R1);
len=N*N;
B=zeros(1,len/2);%zigzag����������
B(1)=R1(1);
k=1; 
i=1;j=1;%��ʼ����
d=1;%����ķ����ʾ��ֵΪ1��ʾ��һ��Ԫ�������Ϸ���ֵΪ-1��ʾ��һ��Ԫ�������·���
flag=1;%�������Ǳ�ʾ��ֵΪ1��ʾ��ǰԪ���������ǣ�ֵΪ0��ʾ��ǰԪ����������
l=2;
while k<len
   if flag==1%��ǰԪ��Ϊ������
        if i~=1&&j~=1%�Ǳ߽�Ԫ��
            if d==1%��һ��Ԫ�������Ϸ���
                i=i-1;j=j+1;
            else%��һ��Ԫ�������·���
                i=i+1;j=j-1;
            end
        else
            if i==1%�ϱ߽�                
                if d==1%��Ҫ����
                    j=j+1;d=-1;
                else%����Ҫ����
                    i=i+1;j=j-1;
                end
                
            else
                if j==1%��߽�
                    
                    if d==1%����Ҫ����
                        i=i-1;j=j+1;
                    else%��Ҫ����
                        i=i+1;d=1;
                    end
                    
                end
            end
        end
    else%��ǰԪ��Ϊ�����ǵ�ʱ��
        if i~=N&&j~=N
            if d==1
                i=i-1;j=j+1;
            else
                i=i+1;j=j-1;
            end
        else
            if i==N
                if d==1
                    i=i-1;j=j+1;
                else
                    j=j+1;d=1;
                end
            else
                if j==N
                    if d==1
                        i=i+1;d=-1;
                    else
                        i=i+1;j=j-1;
                    end
                end
            end
        end
    end
    %disp([i j]);
    if j==N%��Ԫ�ص������ұ߽磬˵��������Ԫ���Ѿ������꣬��ʼ����������Ԫ��
        flag=0;
    end    
    k=k+1;
    if (mod(i+j,2)==0)
        B(l)=R1(i,j);
        l=l+1;
    end
end
%disp(B);


end

