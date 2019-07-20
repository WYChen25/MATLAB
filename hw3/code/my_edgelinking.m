function output = my_edgelinking(binary_image, row, col)
%in this function, you should finish the edge linking utility.
%the input parameters are a matrix of a binary image containing the edge
%information and coordinates of one of the edge points of a obeject
%boundary, you should run this function multiple times to find different
%object boundaries
%the output parameter is a Q-by-2 matrix, where Q is the number of boundary 
%pixels. B holds the row and column coordinates of the boundary pixels.
%you can use different methods to complete the edge linking function
%the better the quality of object boundary and the more the object boundaries, you will get higher scores 
image = binary_image;
if(image(row,col) == 0)
    output = 0;
    return;
end
M = [row,col];
image(row,col) = 0;
get_edge(row,col+1);
get_edge(row+1,col+1);
get_edge(row+1,col);
get_edge(row+1,col-1);
get_edge(row,col-1);
get_edge(row-1,col+1);
get_edge(row-1,col);
get_edge(row-1,col-1);

    function get_edge(row1,col1)
        if(image(row1,col1) == 0)
            return;
        else
            M = cat(1,M,[row1,col1]);
            image(row1,col1) = 0;
            get_edge(row1,col1+1);
            get_edge(row1+1,col1+1);
            get_edge(row1+1,col1);
            get_edge(row1+1,col1-1);
            get_edge(row1,col1-1);
            get_edge(row1-1,col1+1);
            get_edge(row1-1,col1);
            get_edge(row1-1,col1-1);
        end
    end
    function show_edge_with_point(b_image)
        [m,n] = size(b_image);
        N = zeros(m,n);
        [p,q] = size(M);
        for i = 1:p
            N(M(i,1),M(i,2)) = 255;
        end
        figure,imshow(N);
        title('edgeWithPoint')
    end
    show_edge_with_point(image);
    output = M;
end
	