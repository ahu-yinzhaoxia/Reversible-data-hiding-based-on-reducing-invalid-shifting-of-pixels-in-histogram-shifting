function [PK,Z,num]=findpz2(x)
%�ҳ�����x�ķ�ֵ��PK���ڷ�ֵ���Ҳ����ֵ��Z
y=tabulate(x(:));
[m,~]=size(y);
num=max(y(:,2));
n=find(y==num);
k=n-m;
PK=y(k,1);
Z=y(m,1)+1;
for i=k:m-1
    f=y(i+1,1)-y(i,1);
    if f~=1
        Z=y(i,1)+1;
        break; %�ҵ���һ��������
    end
end