function [output2] = hist_equal(input_channel)
    input_channel = im2double(input_channel);
    [M,N] = size(input_channel);
    %使用函数imhist获得图像某一通道的直方图。
    [nums,x] = imhist(input_channel);
    %去除直方图中个数为零的灰度级
    real = find(nums~=0);
    for j = 1:length(real)
        %获得累积直方图
        CDF = sum(nums(real(1:j)));
        location = input_channel==x(real(j));
        input_channel(location) = CDF/(M*N);
     end
     [output2] = input_channel;
end