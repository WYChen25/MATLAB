function [output] = Histogram_equalization_3(input_rgb_image)
    %change the rgb image to hsi image
    HSI = rgb2hsi(input_rgb_image);
    h = HSI(:,:,1);
    s = HSI(:,:,2);
    i = HSI(:,:,3);
    i2 = hist_equal(i);
    hsi_c = cat(3,h,s,i2);
    output = hsi2rgb(hsi_c);
    
    %注*1：
    %函数rgb2hsi与函数hsi2rgb均来源于csdn博客，
    %仅用于测试rgb图像转为hsi图像时对I进行直方图均衡化的效果
    %不作为本人实验代码的个人内容。
    
    %注*2：
    %按照网上大佬们的说法对rgb转为hsv与hsi后对V和I进行直方图均衡化处理，得到的应该是效果相似的结果。
    %但此处使用hsi后产生了较大的失真，图片有强烈的破碎感。
    %尝试将hist_equal单独写出来并保证对rgb，hsi，hsv三种图像做同样的处理后转换为hsi这一方式依旧有较大失真
    %怀疑是这两个rgb转hsi与hsi转rgb的函数有问题。目前尚未解决。
    function hsi = rgb2hsi(rgb)
        rgb = im2double(rgb);
        r = rgb(:,:,1);
        g = rgb(:,:,2);
        b = rgb(:,:,3);
        
        numerator = 0.5*((r-g)+(r-b));
        deno = sqrt((r-g).^2 + (r-b).*(g-b));
        theta = acos(numerator./(deno+eps));
        H = theta;
        
        %H在b>g时取2pi-H而在b<g时取H，H代表一个角的角度，取值为[0,2pi]
        H(b>g) = 2*pi - H(b>g);
        H = H/(2*pi);
        
        numerator = min(min(r,g),b);
        deno = r+g+b;
        deno(deno == 0) = eps;
        S = 1-3.*numerator./deno;
        
        H(S==0) = 0;
        
        I = (r+g+b)/3;
        
        hsi = cat(3,H,S,I);
        
    end
    function rgb = hsi2rgb(hsi)
        H = hsi(:,:,1)*2*pi;
        S = hsi(:,:,2);
        I = hsi(:,:,3);
        
        R = zeros(size(hsi,1),size(hsi,2));
        G = zeros(size(hsi,1),size(hsi,2));
        B = zeros(size(hsi,1),size(hsi,2));
        %RG
        idx = find((0<=H)&(H < 2*pi/3));
        B(idx) = I(idx).*(1-S(idx));
        R(idx) = I(idx).*(1+S(idx).*cos(H(idx))./cos(pi/3-H(idx)));
        G(idx) = 3*I(idx) - (R(idx)+B(idx));
        %BG
        idx = find((2*pi/3 <= H)&(H < 4*pi/3));
        R(idx) = I(idx) .*(1-S(idx));
        G(idx) = I(idx) .*(1+S(idx).*cos(H(idx)-2*pi/3)./cos(pi-H(idx)));
        B(idx) = 3*I(idx)-(R(idx)+G(idx));
        %BR
        idx = find((4*pi/3 <= H) & (H <= 2*pi));
        G(idx) = I(idx).*(1-S(idx));
        B(idx) = I(idx).*(1+S(idx).*cos(H(idx)-4*pi/3)./cos(5*pi/3-H(idx)));
        R(idx) = 3*I(idx)-(G(idx)+B(idx));
        
        rgb = cat(3,R,G,B);
        rgb = max(min(rgb,1),0);
    end
end