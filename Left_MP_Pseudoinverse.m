function [A_Plus]=Left_MP_Pseudoinverse(A)
    A_Plus=inv(A'*A)*A';
end