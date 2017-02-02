function [Code_Matrix]=Generate_Walsh_Codes(N,BIN)
    %Set BIN=1 for binary and BIN=0 for integer
    Code_Matrix=[1];
    for n=1:1:N
        Code_Matrix=[Code_Matrix Code_Matrix;Code_Matrix ~Code_Matrix];
    end
    Code_Matrix=Code_Matrix*BIN+(Code_Matrix-~Code_Matrix)*~BIN;
end