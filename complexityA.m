function [ complexity_I,local_complexity_I,x_posA,y_posA ] = complexityA( I )
%��ÿ��λ�õļ����ܱߵķ�Χ�ĸ��Ӷ����ϵõ�һ���ֲ����Ӷ�
%�������룺complexity_I��ÿ�����ظ����������صõ��ľֲ����Ӷ�
%���������complexity_I:�����ĸ����صĸ��Ӷ�
         %local_complexity_I���ֲ����صĸ��Ӷ�
         %threshold������Ƕ������ѡ����Ӧ�ĸ��Ӷ�ֵ
[m,n]=size(I);
x_posA=zeros(m,n);%�����ȡ���Ӷȵ�����ֵ�ĺ�����λ��
y_posA=zeros(m,n);%�����ȡ���Ӷȵ�����ֵ��������λ��
complexity_I=zeros(m,n);
local_complexity_I=zeros(m,n);
for i=2:m-1
    for j=2:n-1
        if mod(i+j,2)==0
            a=I(i-1,j);%a,b,c,d�ֱ�Ϊ��������λ�õ�����ֵ
            b=I(i,j+1);
            c=I(i+1,j);
            d=I(i,j-1);
            complexity_I(i,j)=abs(a-c)+abs(b-d)+abs(a+b-c-d)+abs(b+c-a-d);%complexity_I���I1��ÿ��Ԥ�����λ�ö�Ӧ�ĸ��Ӷ�
        end
    end
end
for i=2:m-1
    for j=2:n-1
        if mod(i+j,2)==0
            if (i>=3&&i<=510)&&(j>=3&&j<=510)
                a1=complexity_I(i-1,j-1);%����
                b1=complexity_I(i-1,j+1);%����
                c1=complexity_I(i+1,j-1);%����
                d1=complexity_I(i+1,j+1);%����
                local_complexity_I(i,j)=complexity_I(i,j)+floor((a1+b1+c1+d1)/4);
            elseif i==2&&j==2%����
                local_complexity_I(i,j)=complexity_I(i,j)+complexity_I(i+1,j+1);
            elseif i==511&&j==511%����
                local_complexity_I(i,j)=complexity_I(i,j)+complexity_I(i-1,j-1);
            elseif i==2&&(j>=4&&j<=510)%���¡�����
                local_complexity_I(i,j)=complexity_I(i,j)+floor((complexity_I(i+1,j-1)+complexity_I(i+1,j+1))/2);
            elseif j==2&&(i>=4&&i<=510)%���ϡ�����
                local_complexity_I(i,j)=complexity_I(i,j)+floor((complexity_I(i-1,j+1)+complexity_I(i+1,j+1))/2);
            elseif j==511&&(i>=3&&i<=509)%���ϡ�����
                local_complexity_I(i,j)=complexity_I(i,j)+floor((complexity_I(i-1,j-1)+complexity_I(i+1,j-1))/2);
            elseif i==511&&(j>=3&&j<=509)%���ϡ�����
                local_complexity_I(i,j)=complexity_I(i,j)+floor((complexity_I(i-1,j-1)+complexity_I(i-1,j+1))/2);
            end
            x_posA(i,j)=i;
            y_posA(i,j)=j;
        end
    end
end
end

