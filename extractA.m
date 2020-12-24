function [ tha,re_A,extdataA ] = extractA( re_B,payload,Z1A,Z2A,PK1A,PK2A )
%re_A�ָ����B���֣�extdataA;A������ȡ��������Ϣ��tha�����Ӷ�ֵ�����ڶԱ�Ƕ��ʱ��Ӧ��ֵ

[ ~,ex_local_complexity_IA,x_posA,y_posA] = complexityA( re_B );%��������ͼ���A���ֵĸ��Ӷ�
[ ~,err_IA1,~,~,~,~,~,~,~ ] = predictionA( re_B );%������ͼ��A���ֵ�Ԥ�����
[sequence_xpos]=zigzagA(x_posA);%�Եõ���������zigzagɨ��õ�һ������
[sequence_ypos]=zigzagA(y_posA);
[ sequence_c ] = zigzagA( ex_local_complexity_IA );%�õ��ֲ����Ӷȵ�����
[sort_sequence_c1,a]=sort(sequence_c,'ascend');%���õ��ľֲ����Ӷ���������������
[sequence_err1] = zigzagA( err_IA1 );%�����ص�Ԥ�����ɨ��õ�һ������
m=length(sequence_err1);
x_pos1=sequence_xpos(a(1:m));%���������갴�ո��Ӷȵ�����˳������
y_pos1=sequence_ypos(a(1:m));
sort_sequence_errA=sequence_err1(a(1:m));%��Ԥ�����ո��Ӷȵ�����˳������
%% ��ȡA���ֵ�������Ϣ
extdataA=zeros();%������ȡ��������Ϣ
re_A=re_B;%�ָ�ͼ��
numdataa=0;
for i=1:m
    if numdataa>=floor(payload/2)
        break;
    end
    if sort_sequence_errA(i)==(max(PK1A,PK2A)+1)%���ո��Ӷ���������Ԥ��Ԥ���������ұߵķ�ֵ��+1.����ȡ������Ϣ1����������ұߵķ�ֵ�㣬����ȡ������Ϣ0
        numdataa=numdataa+1;
        extdataA(numdataa)=1;
        re_A(x_pos1(i),y_pos1(i))=re_B(x_pos1(i),y_pos1(i))-1;
    elseif sort_sequence_errA(i)==max(PK1A,PK2A)
        numdataa=numdataa+1;
        extdataA(numdataa)=0;
        re_A(x_pos1(i),y_pos1(i))=re_B(x_pos1(i),y_pos1(i));
    elseif sort_sequence_errA(i)==(min(PK1A,PK2A)-1)%���ո��Ӷ���������Ԥ��Ԥ����������ߵķ�ֵ��-1.����ȡ������Ϣ1�����������ߵķ�ֵ�㣬����ȡ������Ϣ0
        numdataa=numdataa+1;
        extdataA(numdataa)=1;
        re_A(x_pos1(i),y_pos1(i))=re_B(x_pos1(i),y_pos1(i))+1;
    elseif sort_sequence_errA(i)==min(PK1A,PK2A)
        numdataa=numdataa+1;
        extdataA(numdataa)=0;
        re_A(x_pos1(i),y_pos1(i))=re_B(x_pos1(i),y_pos1(i));
    elseif sort_sequence_errA(i)>(max(PK1A,PK2A)+1)&&sort_sequence_errA(i)<=max(Z1A,Z2A)%Ԥ��������ұ߷�ֵ��+2���ұ���ֵ�������ֵ������
        re_A(x_pos1(i),y_pos1(i))=re_B(x_pos1(i),y_pos1(i))-1;
    elseif sort_sequence_errA(i)<(min(PK1A,PK2A)-1)&&sort_sequence_errA(i)>=min(Z1A,Z2A)%Ԥ������������ֵ������߷�ֵ��-2������ֵ������
        re_A(x_pos1(i),y_pos1(i))=re_B(x_pos1(i),y_pos1(i))+1;
    end
    j=i;
end
tha=sort_sequence_c1(j);
end
