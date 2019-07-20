%DIP19 Assignment 3
%Character Recongnition

clc; clear all;
imgInput = imread('example.png');
 imgOutput = my_calculator(imgInput);
%imageOutput = my_digit(imgInput);

subplot(1, 2, 1);
imshow(imgInput);
subplot(1, 2, 2);
imshow(imgOutput);