function output = my_calculator(input_image)
%in this function, you should finish the character recognition task.
%the input parameter is a matrix of an image which contains several expressions
%the output parameter is a matrix of an image which contains the results of expressions 

%先转化为灰度图
bw = imbinarize(input_image);
imgSize = size(bw);

imgWidth = imgSize(1);
rows = ones(1,imgWidth);
imgHeight = imgSize(2);
cols = ones(1,imgHeight);

%获取各行列的像素值之和
for i=1:imgWidth
    for j=1:imgHeight
        x=rows(1,i);
        y=bw(i,j);
        A=uint32(x)+uint32(y);
        rows(1,i)=A;
        uint32 B;
        B=uint32(cols(1,j))+uint32(bw(i,j));
        cols(1,j)=B;
    end
end


%像素值之和小于一定数值表示该行或列为黑色直线，将其标注出
R = zeros(11,1);
C = zeros(4,1);
k = 1;
for i=1:imgWidth
    if((rows(i) < 100) && (k==1||((i-R(k-1))>10)))
        R(k) = i;
        k=k+1;
    end
end
k=1;
for i=1:imgHeight
    if(cols(i) < 100 && (k==1 || (i-C(k-1)>10)))
        C(k) = i;
        k=k+1;
    end
end

%此时以R,C中的值为分割位置，对原图进行分割。
for i=1:10
    for j=1:3
        %按照原图的线条得到30个小的图像，并分别对这30个小图进行处理。
        image = zeros(R(i+1)-R(i)+1,C(j+1)-C(j)+1);
        for ii=R(i):R(i+1)
            for jj=C(j):C(j+1)
                image(ii-R(i)+1,jj-C(j)+1) = bw(ii,jj);
            end
        end
        
        newImg=franImage(image);
        
        for ii=R(i):R(i+1)
            for jj=C(j):C(j+1)
                bw(ii,jj) = newImg(ii-R(i)+1,jj-C(j)+1);
            end
        end       
    end
end
for i=1:imgWidth
    for j=1:imgHeight
        if(bw(i,j)==1)
            outImg(i,j)=255;
        end
    end
end
output=outImg;

    function output = franImage(f_image)
        
        dig1 = ones(70,60);
        for i1=11:80
            for j1=31:90
              dig1(i1-10,j1-30) = f_image(i1,j1);
            end
        end
        d1 = my_digit(dig1);
        %imshow(d1);
        
        oper = ones(70,60);
        for i1=11:80
            for j1=91:140
                oper(i1-10,j1-90) = f_image(i1,j1);
            end
        end
        op1 = my_operator(oper);
        
        dig2 = ones(70,60);
        for i1=11:80
            for j1=151:200
                dig2(i1-10,j1-150) = f_image(i1,j1);
            end
        end
        d2 = my_digit(dig2);
        
        x1=str2int(d1); y1=str2int(d2);
        result=0;
        switch op1
            case'+'
                result=x1+y1;
            case'-'
                result=x1-y1;
            otherwise
                result=0;
        end
        numImg=getimage(result);
        for i1=11:80
            for j1=251:310
                f_image(i1,j1)=numImg(i1-10,j1-250);
            end
        end
        output = f_image;       
    end
   
    function output = str2int(input)
        switch input
            case '1' 
                output=1;
            case '2' 
                output=2;
            case '3'
                output=3;
            case '4'
                output=4;
            case'5'
                output=5;
            case'6'
                output=6;
            case'7'
                output=7;
            case'8'
                output=8;
            case'9'
                output=9;
            case'0'
                output=0;
            otherwise
                output=0;
        end
    end

    function output = getimage(input)
        switch input
            case 1
                imgNum=imread('1.jpg');
            case 2
                imgNum=imread('2.jpg');
            case 3
                imgNum=imread('3.jpg');
            case 4
                imgNum=imread('4.jpg');
            case 5
                imgNum=imread('5.jpg');
            case 6
                imgNum=imread('6.jpg');
            case 7
                imgNum=imread('7.jpg');
            case 8
                imgNum=imread('8.jpg');
            case 9
                imgNum=imread('9.jpg');
            case 0
                imgNum=imread('0.jpg');
            otherwise
                imgNum=imread('0.jpg');
        end
        imgNum=rgb2gray(imgNum);
        imgNum=imbinarize(imgNum);
        output=imresize(imgNum,[70,60],'bicubic');      
    end
        
end

