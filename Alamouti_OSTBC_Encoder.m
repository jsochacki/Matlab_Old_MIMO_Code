function [encoded_output]=Alamouti_OSTBC_Encoder(input_data_stream)

    trn=0;
    if size(input_data_stream,1) < size(input_data_stream,2), trn=1; input_data_stream=input_data_stream.';, end;
    
    encoded_output=[]; block=1;
    for n=1:2:size(input_data_stream,1)
        encoded_output(:,:,block)=[input_data_stream(n) input_data_stream(n+1);-input_data_stream(n+1)' input_data_stream(n)'];
        block=block+1;
    end

end