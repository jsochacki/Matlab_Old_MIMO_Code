function [output_data_stream]=Ideal_DSSS_xor(input_data_stream,code,BIN,ENC)
    %Set BIN=1 for binary and BIN=0 for integer
    %Set ENC=1 for encoding and ENC=0 for decoding
    trn=0;
    if size(input_data_stream,1) < size(input_data_stream,2), trn=1; input_data_stream=input_data_stream.';, end;
    if size(code,1) < size(code,2), code=code.';, end;
    
    output_data_stream=[]; STEP=(ENC+(~ENC*length(code)));
    for n=1:STEP:size(input_data_stream,1)
        output_data_stream=[output_data_stream;(ones(1,STEP))*(input_data_stream(n:n+STEP-1).*~code+~input_data_stream(n:n+STEP-1).*code)];
    end
    
    output_data_stream=output_data_stream./(ENC+~ENC*length(code));
    %output_data_stream=output_data_stream./(ENC+~ENC*(code.'*code));
    
    if trn, output_data_stream=output_data_stream.';, end;

    output_data_stream=output_data_stream*BIN+(output_data_stream-~output_data_stream)*~BIN;

end