function [output2] = hist_equal(input_channel)
    input_channel = im2double(input_channel);
    [M,N] = size(input_channel);
    %ʹ�ú���imhist���ͼ��ĳһͨ����ֱ��ͼ��
    [nums,x] = imhist(input_channel);
    %ȥ��ֱ��ͼ�и���Ϊ��ĻҶȼ�
    real = find(nums~=0);
    for j = 1:length(real)
        %����ۻ�ֱ��ͼ
        CDF = sum(nums(real(1:j)));
        location = input_channel==x(real(j));
        input_channel(location) = CDF/(M*N);
     end
     [output2] = input_channel;
end