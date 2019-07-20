function output = my_operator(input_image)
%in this function, you should finish the operator recognition task.
%the input parameter is a matrix of an image which contains an operator.
%the output parameter represents which operator it is. 

input_image = minboundary(input_image);
jud=judge(input_image);
min=200000;  pos=0;
for index=1:3
    if(jud(1,index)<min)
        min=jud(1,index);
        pos=index;
    end
end
if(pos==1)
    output='+';
else
   if(pos==2)
       output='-';
   else
       output='=';
   end
end



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
        judge=zeros(1,3);
        
        img0=imread('+.jpg');
        img0=rgb2gray(img0);    img0=imbinarize(img0);
        judge(1,1) = similar(img0,input);
        
        img1=imread('-.jpg');
        img1=rgb2gray(img1);    img1=imbinarize(img1);
        judge(1,2) = similar(img1,input);
        
        img2=imread('=.jpg');
        img2=rgb2gray(img2);    img2=imbinarize(img2);
        judge(1,3) = similar(img2,input);
        
        output=judge;
    end

    function output = similar(input1,input2)
        t1=minboundary2(input1);
        %imshow(t1);
        t2=input2;
        [a1,b1]=size(t2);
        t1=imresize(t1,[a1,b1],'bicubic');
        t2=imresize(t2,[a1,b1],'bicubic');
        sum=a1*b1;
        for i=1:a1
            for j=1:b1
                if(t1(i,j)== t2(i,j))
                    sum=sum-1;
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