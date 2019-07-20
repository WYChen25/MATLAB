function output = my_edge(input_image)
%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores  
    Threshold = 0.2;    %������ֵ  
     %ʹ��Roberts����
    output = roberts_edge(input_image);   
     %ʹ��Laplacion����
    output = laplace_edge(input_image); 
    %ʹ��Prewitt����
    output = prewitt_edge(input_image);
    %ʹ��Sobel����
    output = sobel_edge(input_image); 
    function output2 = sobel_edge(input_image2)
        [m,n] = size(input_image2);
        gray = input_image2;
        edgeGray = gray;
        for j = 2:m-1
            for k = 2:n-1
                %ÿ�����ص�Sobel����ֵ
                sobelNum=abs(gray(j-1,k+1)+2*gray(j,k+1)+gray(j+1,k+1)-gray(j-1,k-1)-2*gray(j,k-1)-gray(j+1,k-1))+abs(gray(j-1,k-1)+2*gray(j-1,k)+gray(j-1,k+1)-gray(j+1,k-1)-2*gray(j+1,k)-gray(j+1,k+1));
                if(sobelNum > 1-Threshold)
                    edgeGray(j,k)=255;
                else
                    edgeGray(j,k)=0;
                end
            end
        end
        figure,imshow(edgeGray);
        title('sobel')
        output2 = edgeGray;
    end
    function output3 = roberts_edge(input_image3)
        [m,n]=size(input_image3);
        edgeGray = input_image3;
        for j =  1:m-1
            for k = 1:n-1
                %ÿ�����ص�Robert����ֵ
                robertsNum = abs(input_image3(j,k)-input_image3(j+1,k+1))+abs(input_image3(j+1,k)-input_image3(j,k+1));
                if(robertsNum > Threshold)
                    edgeGray(j,k) = 255;
                else
                    edgeGray(j,k) = 0;
                end
            end
        end
        figure,imshow(edgeGray);
        title('reberts')
        output3 = edgeGray;
    end
    function output4 = laplace_edge(input_image4)
        [m,n] = size(input_image4);
        edgeGray=input_image4;
        for j = 2:m-1
            for k = 2:n-1
                %ÿ�����ص�Laplacion����ֵ
                laplacianNum = abs(4*input_image4(j,k)-input_image4(j-1,k)-input_image4(j+1,k)-input_image4(j,k+1)-input_image4(j,k-1));
                if(laplacianNum > Threshold)
                    edgeGray(j,k) = 255;
                else
                    edgeGray(j,k) = 0;
                end
            end
        end
        figure,imshow(edgeGray);
        title('laplace')
        output4 = edgeGray;
    end
    function output5 = prewitt_edge(input_image5)
        in = input_image5;
        [m,n] = size(input_image5);
        edgeGray = input_image5;
        PrewittThreshold = 0.5;     %����prewitt���ӵ���ֵ
        for j = 2:m-1
            for k = 2:n-1
                %ÿ�����ص�prewitt����ֵ
                PrewittNum = abs(in(j-1,k+1)-in(j+1,k+1)+in(j-1,k)-in(j+1,k)+in(j-1,k-1)-in(j+1,k-1))+abs(in(j-1,k+1)+in(j,k+1)+in(j+1,k+1)-in(j-1,k-1)-in(j,k-1)-in(j+1,k-1));
                if(PrewittNum > PrewittThreshold)
                    edgeGray(j,k) = 255;
                else
                    edgeGray(j,k) = 0;
                end
            end
        end
        figure,imshow(edgeGray);
        title('prewitt')
        output5 = edgeGray;
    end
end


