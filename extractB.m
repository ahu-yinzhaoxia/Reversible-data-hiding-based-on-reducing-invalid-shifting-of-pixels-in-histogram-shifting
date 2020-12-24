function [ re_B,extdataB,thb] = extractB( stego_I2,payload,Z1B,Z2B,PK1B,PK2B )
%re_B�ָ����B���֣�extdataB:B������ȡ��������Ϣ��thb�����Ӷ�ֵ�����ڶԱ�Ƕ��ʱ��Ӧ��ֵ  

[ ~,ex_local_complexity_IB,x_posB,y_posB  ] = complexityB( stego_I2 );%��������ͼ���B���ֵĸ��Ӷ�
[ ~,err_IB1,~,~,~,~,~,~,~ ] = predictionB( stego_I2 );%������ͼ��B���ֵ�Ԥ�����
[sequence_xpos]=zigzagB(x_posB);%�Եõ���������zigzagɨ��õ�һ������
[sequence_ypos]=zigzagB(y_posB);
[ sequence_c ] = zigzagB( ex_local_complexity_IB );%�õ��ֲ����Ӷȵ�����
[sort_sequence_c1,a]=sort(sequence_c,'ascend');%���õ��ľֲ����Ӷ���������������
[sequence_err1] = zigzagB( err_IB1 );%�����ص�Ԥ�����ɨ��õ�һ������
m=length(sequence_err1);
x_pos1=sequence_xpos(a(1:m));%���������갴�ո��Ӷȵ�����˳������
y_pos1=sequence_ypos(a(1:m));
sort_sequence_errB=sequence_err1(a(1:m));%��Ԥ�����ո��Ӷȵ�����˳������
extdataB=zeros();%������ȡ��������Ϣ
re_B=stego_I2;%�ָ�ͼ��
numdatab=0;
for i=1:m
    if numdatab>=ceil(payload/2)
        break;
    end
    if sort_sequence_errB(i)==(max(PK1B,PK2B)+1)%���ո��Ӷ���������Ԥ��Ԥ���������ұߵķ�ֵ��+1.����ȡ������Ϣ1����������ұߵķ�ֵ�㣬����ȡ������Ϣ0
        numdatab=numdatab+1;
        extdataB(numdatab)=1;
        re_B(x_pos1(i),y_pos1(i))=stego_I2(x_pos1(i),y_pos1(i))-1;
    elseif sort_sequence_errB(i)==max(PK1B,PK2B)
        numdatab=numdatab+1;
        extdataB(numdatab)=0;
        re_B(x_pos1(i),y_pos1(i))=stego_I2(x_pos1(i),y_pos1(i));
    elseif sort_sequence_errB(i)==(min(PK1B,PK2B)-1)%���ո��Ӷ���������Ԥ��Ԥ����������ߵķ�ֵ��-1.����ȡ������Ϣ1�����������ߵķ�ֵ�㣬����ȡ������Ϣ0
        numdatab=numdatab+1;
        extdataB(numdatab)=1;
        re_B(x_pos1(i),y_pos1(i))=stego_I2(x_pos1(i),y_pos1(i))+1;
    elseif sort_sequence_errB(i)==min(PK1B,PK2B)
        numdatab=numdatab+1;
        extdataB(numdatab)=0;
        re_B(x_pos1(i),y_pos1(i))=stego_I2(x_pos1(i),y_pos1(i));
    elseif sort_sequence_errB(i)>(max(PK1B,PK2B)+1)&&sort_sequence_errB(i)<=max(Z1B,Z2B)%Ԥ��������ұ߷�ֵ��+2���ұ���ֵ�������ֵ������
        re_B(x_pos1(i),y_pos1(i))=stego_I2(x_pos1(i),y_pos1(i))-1;
    elseif sort_sequence_errB(i)<(min(PK1B,PK2B)-1)&&sort_sequence_errB(i)>=min(Z1B,Z2B)%Ԥ������������ֵ������߷�ֵ��-2������ֵ������
        re_B(x_pos1(i),y_pos1(i))=stego_I2(x_pos1(i),y_pos1(i))+1;
    end
    j=i;
end
thb=sort_sequence_c1(j);
end


