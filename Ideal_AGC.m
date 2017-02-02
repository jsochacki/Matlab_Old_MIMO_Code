function [receive_post_AGC]=Ideal_AGC(receive_pre_AGC,Constallation)
    receive_post_AGC=max(abs(Constallation)).*receive_pre_AGC./max(abs(receive_pre_AGC));
end