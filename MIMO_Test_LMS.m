clear all
[Phase Time]=Antenna_Separation_To_Phase_Time(2.4,12); Phase_Delta=((2*pi)/360)*4;
A_Channel=[power(10,-22/10)*exp(-j*(Phase+Phase_Delta)) power(10,-19/10)*exp(-j*(Phase-Phase_Delta));...
   power(10,-21/10)*exp(-j*(Phase-Phase_Delta)) power(10,-20/10)*exp(-j*(Phase+Phase_Delta))];
A=[1 1;1 1];

input_data_stream=randsrc(1,64,exp(-j*[pi/4 3*pi/4 5*pi/4 7*pi/4]));
h=firrcos(16,0.5/2,0.05,1,'rolloff','sqrt');
input_basband_stream=conv(h,input_data_stream)
[encoded_block_output]=Alamouti_OSTBC_Encoder(input_basband_stream);

encoded_stream_output=[];
for n=1:1:size(encoded_block_output,3)
   encoded_stream_output=[encoded_stream_output encoded_block_output(:,:,n).']; 
end

noise=randsrc(2,size(encoded_stream_output,2),[exp(-j*[0:2*pi/360:2*pi])*0.001]);

mu=0.05; NITTERS=10; errorout=[];
for nn=1:1:NITTERS
    for n=1:1:size(encoded_stream_output,2)
        current=A*encoded_stream_output(:,n);
        desired=A_Channel*encoded_stream_output(:,n)+noise(:,n);
        error=desired-current;
        A=A+2*mu*error*encoded_stream_output(:,n)';
        errorout=[errorout 10*log10(error.*error'.')];
    end
end

plot((errorout(1,:)))
hold on
plot((errorout(2,:)),'r')