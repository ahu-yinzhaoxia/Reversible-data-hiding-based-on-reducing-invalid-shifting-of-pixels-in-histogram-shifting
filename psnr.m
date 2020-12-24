function [ psnrvalue ] = psnr( I,stego_I )
%�õ�ͼ��origin��test ��PSNR
I1=I;
I2=stego_I;
E=I1-I2;
MSE=mean2(E.*E);
if MSE==0
    psnrvalue=-1;
else
    psnrvalue=10*log10(255*255/MSE);

end

