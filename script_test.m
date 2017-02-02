clear all
Code_Order=2; BIN=1;
NBITS=1024;
WC=Generate_Walsh_Codes(Code_Order,BIN);
binary_data_stream=randsrc(1,NBITS,[0 1]);
current_code=WC(2,:);
chipped_binary_data_stream=Ideal_DSSS_xor(binary_data_stream,current_code,BIN,1);

chipped_binary_data_stream=[chipped_binary_data_stream(2:1:end) chipped_binary_data_stream(1)];

current_code=WC(2,:);
unchipped_binary_data_stream=Ideal_DSSS_xor(chipped_binary_data_stream,current_code,BIN,0);
CHECKSUM=single(unchipped_binary_data_stream==1)*single((unchipped_binary_data_stream==1).')+...
    single(unchipped_binary_data_stream==0)*single((unchipped_binary_data_stream==0).');
while CHECKSUM~=length(unchipped_binary_data_stream)
    chipped_binary_data_stream=[chipped_binary_data_stream(end) chipped_binary_data_stream(1:1:(end-1))];
    unchipped_binary_data_stream=Ideal_DSSS_xor(chipped_binary_data_stream,current_code,BIN,0);
    CHECKSUM=single(unchipped_binary_data_stream==1)*single((unchipped_binary_data_stream==1).')+...
    single(unchipped_binary_data_stream==0)*single((unchipped_binary_data_stream==0).');
end

figure(1)
plot(unchipped_binary_data_stream,'r-o'), hold on, plot(binary_data_stream,'b-o')
sum(abs(unchipped_binary_data_stream-binary_data_stream))
