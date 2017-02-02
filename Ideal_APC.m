function [receive_post_APC]=Ideal_APC(receive_pre_APC,transmit_data)
    phase_offset=real((log(transmit_data)-log((transmit_data))'.')*exp(-j*pi/2)/2)...
        -real((log(receive_pre_APC)-log((receive_pre_APC))'.')*exp(-j*pi/2)/2);
    receive_post_APC=receive_pre_APC.*exp(j*phase_offset);
end