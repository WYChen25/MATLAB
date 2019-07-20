function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    
    r=input_image(:,:,1);
    n=input_image(:,:,2);
    b=input_image(:,:,3);
    r1 = hist_equal(r);
    n1 = hist_equal(n);
    b1 = hist_equal(b);
    output = cat(3,r1,n1,b1); 
    
else
    [output] = hist_equal(input_image);
    
end

%     function [output2] = hist_equal(input_channel)
%         input_channel = im2double(input_channel);
%         [M,N] = size(input_channel);
%         [nums,x] = imhist(input_channel);
%         real = find(nums~=0);
%         for j = 1:length(real)
%             CDF = sum(nums(real(1:j)));
%             location = input_channel==x(real(j));
%             input_channel(location) = CDF/(M*N);
%         end
%         [output2] = input_channel;
%     end
end