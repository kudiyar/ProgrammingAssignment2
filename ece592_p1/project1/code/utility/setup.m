%{
N. Casale
ncasale@ncsu.edu

Kudiyar (Cody) Orazymbetov
korazym@ncsu.edu

ECE 592 Project 1
2017/9/20
%}

function setup()

   global imagesFolder
   imagesFolder = '../images/';
   addpath(imagesFolder);

   global seed
   seed = 475859;
   rng(seed);
end