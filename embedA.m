function [ stego_I1,numdata1,emddataA,th,x_pos1,y_pos1,j,l,err_I1 ] = embedA( I,local_complexity_I,data,Z1A,Z2A,PK1A,PK2A,err_I,payload,x_posA,y_posA )
%Ƕ��������Ϣ
%�������룺local_complexity_IΪA����ÿ������ֵ�ľֲ����Ӷ�,threshold����Ƕ������ѡ����Ӧ�ĸ��Ӷ�ֵ,data������Ϣ,Z1��ֵ����ߵ���ֵ��,
%Z2��ֵ���ұߵ���ֵ��,PK1Ԥ�����η�ֵ��,PK2Ԥ������ֵ��,pre_IԤ��ֵ,err_IԤ�����
%���������
[ sequence_c ] = zigzagA( local_complexity_I );%�õ��ֲ����Ӷȵ�����
[sequence_xpos]=zigzagA(x_posA);%�Եõ���������zigzagɨ��õ�һ������
[sequence_ypos]=zigzagA(y_posA);
[sort_sequence_cA,a]=sort(sequence_c,'ascend');%���õ��ľֲ����Ӷ���������������
[sequence_err] = zigzagA( err_I );
m=length(sequence_err);
x_pos1=sequence_xpos(a(1:m));
y_pos1=sequence_ypos(a(1:m));
sort_sequence_errA=sequence_err(a(1:m));
%% A����Ƕ��������Ϣ
stego_I1=I;
numdata1=0;
l=0;
err_I1=err_I;%����Ԥ�����
for i=1:m
    if numdata1>=floor(payload/2)
        break;
    end
    if sort_sequence_errA(i)==min(PK1A,PK2A)%���ո��Ӷ���������Ԥ���������ߵķ�ֵ����ȥ������Ϣ
         numdata1=numdata1+1;
         stego_I1(x_pos1(i),y_pos1(i))=I(x_pos1(i),y_pos1(i))-data(numdata1);
         err_I1(x_pos1(i),y_pos1(i))=err_I(x_pos1(i),y_pos1(i))-data(numdata1);
    elseif sort_sequence_errA(i)==max(PK1A,PK2A)%���ո��Ӷ���������Ԥ��������ұߵķ�ֵ������������Ϣ
        numdata1=numdata1+1;
        stego_I1(x_pos1(i),y_pos1(i))=I(x_pos1(i),y_pos1(i))+data(numdata1);
        err_I1(x_pos1(i),y_pos1(i))=err_I(x_pos1(i),y_pos1(i))+data(numdata1);
    elseif sort_sequence_errA(i)<min(PK1A,PK2A)&&sort_sequence_errA(i)>min(Z1A,Z2A)%���ո��Ӷ�����Ԥ���������ߵķ�ֵ�����ߵ���ֵ��֮�䶼����ƽ��
        stego_I1(x_pos1(i),y_pos1(i))=I(x_pos1(i),y_pos1(i))-1;
        err_I1(x_pos1(i),y_pos1(i))=err_I(x_pos1(i),y_pos1(i))-1;
        l=l+1;
    elseif sort_sequence_errA(i)>max(PK1A,PK2A)&&sort_sequence_errA(i)<max(Z1A,Z2A)%���ո��Ӷ�����Ԥ��������ұߵķ�ֵ����ұߵ���ֵ��֮�䶼����ƽ��
        stego_I1(x_pos1(i),y_pos1(i))=I(x_pos1(i),y_pos1(i))+1;
        err_I1(x_pos1(i),y_pos1(i))=err_I(x_pos1(i),y_pos1(i))-1;
        l=l+1;
    end
    j=i;
end
th=sort_sequence_cA(j);
emddataA=data(1:numdata1);
end
