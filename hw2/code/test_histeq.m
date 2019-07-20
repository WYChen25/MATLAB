%test histeq
I = imread('test3.jpeg');
[J] = Histogram_equalization(I);
if numel(size(I)) == 3
    [K] = Histogram_equalization_2(I);
    figure, imshow(K)
    [L] = Histogram_equalization_3(I);
    figure, imshow(L)
end
figure, imshow(I)
figure, imshow(J)
