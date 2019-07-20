function output = my_digit(input_image)
%in this function, you should finish the digit recognition task.
%the input parameter is a matrix of an image which contains a digit.
%the output parameter represents which digit it is.
input_image=minboundary(input_image);
jud=judge(input_image);
%jud
max=0;pos=0;
for index=1:10
    if(max < jud(index))
        max=jud(index);
        pos=index;
    end
end
output = int2str(pos-1);

    function output = minboundary(input)
        input2 = input;
        k=0;
        Size = size(input);
        rows = Size(1);
        cols = Size(2);
        for i=1:rows
            flag=0;
            for j=1:cols
                if(input(i,j)==0)
                    flag=1;
                end
            end
            if(flag==0)
                input2(i-k,:)=[];
                k=k+1;
            end
        end
        k=0;
        for i=1:cols
            flag=0;
            for j=1:rows
                if(input(j,i)== 0)
                    flag=1;
                end
            end
            if(flag==0)
                input2(:,i-k)=[];
                k=k+1;
            end
        end
        output=input2;
    end

    function output = judge(input)
        judge=zeros(1,10);
        
        img0=imread('0.jpg');
        img0=rgb2gray(img0);    img0=imbinarize(img0);
        judge(1,1) = similar(img0,input);
        
        img1=imread('1.jpg');
        img1=rgb2gray(img1);    img1=imbinarize(img1);
        judge(1,2) = similar(img1,input);
        
        img2=imread('2.jpg');
        img2=rgb2gray(img2);    img2=imbinarize(img2);
        judge(1,3) = similar(img2,input);
        
        img3=imread('3.jpg');
        img3=rgb2gray(img3);    img3=imbinarize(img3);
        judge(1,4) = similar(img3,input);
        
        img4=imread('4.jpg');
        img4=rgb2gray(img4);    img4=imbinarize(img4);
        judge(1,5) = similar(img4,input);
        
        img5=imread('5.jpg');
        img5=rgb2gray(img5);    img5=imbinarize(img5);
        judge(1,6) = similar(img5,input);
        
        img6=imread('6.jpg');
        img6=rgb2gray(img6);    img6=imbinarize(img6);
        judge(1,7) = similar(img6,input);
        
        img7=imread('7.jpg');
        img7=rgb2gray(img7);    img7=imbinarize(img7);
        judge(1,8) = similar(img7,input);
        
        img8=imread('8.jpg');
        img8=rgb2gray(img8);    img8=imbinarize(img8);
        judge(1,9) = similar(img8,input);
        
        img9=imread('9.jpg');
        img9=rgb2gray(img9);    img9=imbinarize(img9);
        judge(1,10) = similar(img9,input);
        
        output=judge;
    end

    function output = similar(input1,input2)
        t1=minboundary2(input1);
        %imshow(t1);
        t2=input2;
        [a1,b1]=size(t2);
        t1=imresize(t1,[a1,b1],'bicubic');
        t2=imresize(t2,[a1,b1],'bicubic');
        sum=0;
        for i=1:a1
            for j=1:b1
                if(t1(i,j)== t2(i,j))
                    sum=sum+1;
                end
            end
        end
        output = sum/(a1*b1);
    end

    function output=minboundary2(bw)
        input=bw;
        Size = size(bw);
        rows = Size(1);
        cols = Size(2);
        
        k=0;
        for i=1:rows
            flag=0;
            for j=1:cols
                if(bw(i,j)==0)
                    flag=1;
                end
            end
            if(flag==0)
                input(i-k,:)=[];
                k=k+1;
            end
        end
        k=0;
        for i=1:cols
            flag=0;
            for j=1:rows
                if(bw(j,i)== 0)
                    flag=1;
                end
            end
            if(flag==0)
                input(:,i-k)=[];
                k=k+1;
            end
        end
        output=input;
    end

end
