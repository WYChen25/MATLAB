function [output] = Histogram_equalization_3(input_rgb_image)
    %change the rgb image to hsi image
    HSI = rgb2hsi(input_rgb_image);
    h = HSI(:,:,1);
    s = HSI(:,:,2);
    i = HSI(:,:,3);
    i2 = hist_equal(i);
    hsi_c = cat(3,h,s,i2);
    output = hsi2rgb(hsi_c);
    
    %ע*1��
    %����rgb2hsi�뺯��hsi2rgb����Դ��csdn���ͣ�
    %�����ڲ���rgbͼ��תΪhsiͼ��ʱ��I����ֱ��ͼ���⻯��Ч��
    %����Ϊ����ʵ�����ĸ������ݡ�
    
    %ע*2��
    %�������ϴ����ǵ�˵����rgbתΪhsv��hsi���V��I����ֱ��ͼ���⻯�����õ���Ӧ����Ч�����ƵĽ����
    %���˴�ʹ��hsi������˽ϴ��ʧ�棬ͼƬ��ǿ�ҵ�����С�
    %���Խ�hist_equal����д��������֤��rgb��hsi��hsv����ͼ����ͬ���Ĵ����ת��Ϊhsi��һ��ʽ�����нϴ�ʧ��
    %������������rgbתhsi��hsiתrgb�ĺ��������⡣Ŀǰ��δ�����
    function hsi = rgb2hsi(rgb)
        rgb = im2double(rgb);
        r = rgb(:,:,1);
        g = rgb(:,:,2);
        b = rgb(:,:,3);
        
        numerator = 0.5*((r-g)+(r-b));
        deno = sqrt((r-g).^2 + (r-b).*(g-b));
        theta = acos(numerator./(deno+eps));
        H = theta;
        
        %H��b>gʱȡ2pi-H����b<gʱȡH��H����һ���ǵĽǶȣ�ȡֵΪ[0,2pi]
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