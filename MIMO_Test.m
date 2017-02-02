clear all
[Phase Time]=Antenna_Separation_To_Phase_Time(2.4,12); Phase_Delta=((2*pi)/360)*4;
A_Channel=[power(10,-22/10)*exp(-j*(Phase+Phase_Delta)) power(10,-19/10)*exp(-j*(Phase-Phase_Delta));...
   power(10,-21/10)*exp(-j*(Phase-Phase_Delta)) power(10,-20/10)*exp(-j*(Phase+Phase_Delta));...
   power(10,-19/10)*exp(-j*(Phase-Phase_Delta))' -power(10,-22/10)*exp(-j*(Phase+Phase_Delta))';...
   power(10,-20/10)*exp(-j*(Phase+Phase_Delta))' -power(10,-21/10)*exp(-j*(Phase-Phase_Delta))'];
A=[1 1;1 1;1 -1;1 -1];

input_data_stream=randsrc(1,512,exp(-j*[pi/4 3*pi/4 5*pi/4 7*pi/4]));
[encoded_output]=Alamouti_OSTBC_Encoder(input_data_stream);
mu=0.0001; NITTERS=100; errorout=[];
for nn=1:1:NITTERS
    for n=1:1:size(encoded_output,3)
       current=A*encoded_output(1,:,n).';
       desired=A_Channel*encoded_output(1,:,n).';
       error=desired-current;
       A=A+mu*error'.'*encoded_output(1,:,n);
       errorout=[errorout 10*log10(error'*error)];
    end
end
plot((errorout))