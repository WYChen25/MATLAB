function [output] = Histogram_equalization_2(input_rgb_image)
    %change the rgb image to hsv image
    hsv = rgb2hsv(input_rgb_image);
    h = hsv(:,:,1);
    s = hsv(:,:,2);
    v = hsv(:,:,3);
    V = hist_equal(v);
    hsv_c = cat(3,h,s,V);
    output = hsv2rgb(hsv_c);
end