% FOR EMBEDDING, A MESSAGE AND A COVER IMAGE HAS TO BE FED TO THIS CODE

% Clear the existing workspace 
clear all; 

% Clear the command window 
clc; 

% Read the input cover image
% Proper directory has to be given
input = imread("D:\CN_Steg\Cover_Img.png","png");

% Split the cover image into R,G,B channels
redChannel = input(:,:,1);
greenChannel = input(:,:,2);
blueChannel = input(:,:,3);


% Take the channels and resize them to required size
redChannel = imresize(redChannel,[512,512]);
greenChannel = imresize(greenChannel,[512,512]);
blueChannel = imresize(blueChannel,[512,512]);

finale = cat(3, redChannel, greenChannel, blueChannel);



% finalgreenChannel and finalblueChannel shall contain the channels after
                                                % embedding
fingC = greenChannel;
finbC = blueChannel;

% Message to be embedded 
message='yastra';

% Length of the message where each character is 8 bits 
len = length(message) * 8; 

% Get all the ASCII values of the characters of the message 
ascii_value = uint8(message); 

% Convert the decimal values to binary values
bin_message = transpose(dec2bin(ascii_value, 8)); 

% Get all the binary digits in separate rows of matrix 
bin_message = bin_message(:); 

% Length of the binary message 
N = length(bin_message); 

% Converting the char array to numeric array 
bin_num_message=str2num(bin_message); 

% Get height and width for traversing through the red channel of
                            % the image to embed the data
heightrC = size(redChannel, 1); 
widthrC = size(redChannel, 2); 

% Counter for number of embedded bits for termination after embedding
embed_counter = 1; 

% To exit the outer loop once the whole message is embedded
flag=0;

% (i,j) pointers of G and B channels to traverse while embedding
ipG = 0; jpG = 0; ipB = 0; jpB = 0; 

% Traverse through the image 
for irC = 1 : heightrC
    if flag == 0
        for jrC = 1 : widthrC
            
            % Check if more bits are remaining to embed 
            if(embed_counter <= N)
			
			% Finding the Least Significant Bit of the current pixel 
			LSB0 = mod(double(redChannel(irC, jrC)), 2); 
            
            % Finding second LSB
            temp = mod(double(redChannel(irC, jrC)), 4);
            if temp == 2||3 
                LSB1 = 1;
            else
                LSB1 = 0;
            end            
           
           % LOGIC AS PER THE REFERENCE
           
           if LSB1 == 0 && LSB0 == 0
               
               for i = (ipG+1) 
                   for j = (jpG+1) : (jpG+2) % Embed two bits in greenChannel
                       
                       if embed_counter > len
                           break
                       else
                           % LSB based embedding
                           LSB = mod(double(greenChannel(i,j)), 2);
                           temp = double(xor(LSB, bin_num_message(embed_counter)));
                           % Embedding
                           fingC(i,j) = greenChannel(i,j) + temp;
                           embed_counter = embed_counter + 1;
                           % Shift to next row after all columns are filled 
                           if jpG == 512
                               ipG = ipG + 1;
                               jpG=0;
                           else
                               jpG = jpG + 1;
                           end
                           
                       end
                       
                   end
               end
               
               for i = (ipB+1)
                   for j = (jpB+1) % Embed one bit in blueChannel
                       
                       if embed_counter > len
                           break
                       else
                           LSB = mod(double(blueChannel(i,j)), 2);
                           temp = double(xor(LSB, bin_num_message(embed_counter))); 
                           finbC(i,j) = blueChannel(i,j) + temp;
                           embed_counter = embed_counter + 1;
                           if jpB == 512
                               ipB = ipB + 1;
                               jpB=0;
                           else
                               jpB= jpB + 1;
                           end
                       end
                   end
               end               
           end
           
           if LSB1 == 1 && LSB0 == 0
               
               for i = (ipG+1)
                   for j = (jpG+1) : (jpG+3) % Embed three bits in greenChannel
                       
                       if embed_counter > len
                           break
                       else
                           LSB = mod(double(greenChannel(i,j)), 2);
                           temp = double(xor(LSB, bin_num_message(embed_counter))); 
                           fingC(i,j) = greenChannel(i,j) + temp;
                           embed_counter = embed_counter + 1;
                           if jpG == 512
                               ipG = ipG + 1;
                               jpG=0;
                           else
                               jpG = jpG + 1;
                           end
                       end
                       
                   end
               end
               
               for i = (ipB+1)
                   for j = (jpB+1) : (ipB+2) % Embed two bits in blueChannel
                       
                       if embed_counter > len
                           break
                       else
                           LSB = mod(double(blueChannel(i,j)), 2);
                           temp = double(xor(LSB, bin_num_message(embed_counter))); 
                           finbC(i,j) = blueChannel(i,j) + temp;
                           embed_counter = embed_counter + 1;
                           if jpB == 512
                               ipB = ipB + 1;
                               jpB=0;
                           else
                               jpB = jpB + 1;
                           end
                       end
                      
                   end
               end               
           end
           
           if LSB1 == 0 && LSB0 == 1
               
               for i = (ipG+1)
                   for j = (jpG+1) : (jpG+2) % Embed two bits in greenChannel
                       
                       if embed_counter > len
                           break
                       else
                           LSB = mod(double(greenChannel(i,j)), 2);
                           temp = double(xor(LSB, bin_num_message(embed_counter))); 
                           fingC(i,j) = greenChannel(i,j) + temp;
                           embed_counter = embed_counter + 1;
                           if jpG == 512
                               ipG = ipG + 1;
                               jpG=0;
                           else
                               jpG = jpG + 1;
                           end
                       end
                       
                   end
               end
               for i = (ipB+1)
                   for j = (jpB+1) : (ipB+2) % Embed two bits in blueChannel
                       
                       if embed_counter > len
                           break
                       else
                           LSB = mod(double(blueChannel(i,j)), 2);
                           temp = double(xor(LSB, bin_num_message(embed_counter)));
                           finbC(i,j) = blueChannel(i,j) + temp;
                           embed_counter = embed_counter + 1;
                           if jpB == 512
                               ipB = ipB + 1;
                               jpB=0;
                           else
                               jpB = jpB + 1;
                           end
                       end
                   end
               end               
           end
           
           if LSB1 == 1 && LSB0 == 1
               
               for i = (ipG+1)
                   for j = (jpG+1) : (jpG+3) % Embed three bits in greenChannel
                       
                       if embed_counter > len
                           break
                       else
                           LSB = mod(double(greenChannel(i,j)), 2);
                           temp = double(xor(LSB, bin_num_message(embed_counter))); 
                           fingC(i,j) = greenChannel(i,j) + temp;
                           embed_counter = embed_counter + 1;
                           if jpG == 512
                               ipG = ipG + 1;
                               jpG=0;
                           else
                               jpG = jpG + 1;
                           end
                       end
                       
                   end
               end
               for i = (ipB+1)
                   for j = (jpB+1) : (ipB+3)% Embed three bits in blueChannel
                       
                       if embed_counter > len
                           break
                       else
                           LSB = mod(double(blueChannel(i,j)), 2);
                           temp = double(xor(LSB, bin_num_message(embed_counter)));
                           finbC(i,j) = blueChannel(i,j) + temp;
                           embed_counter = embed_counter + 1;
                           if jpB == 512
                               ipB = ipB + 1;
                               jpB=0;
                           else
                               jpB = jpB + 1;
                           end
                       end
                   end
               end               
           end
           
        
        else
            flag = 1; 
            continue;
            end
        end
    else
        break;
    end
end

% Concatenate the channels
rgbImage = cat(3, redChannel, fingC, finbC);

% Write both the input and output images to local storage 
% Mention the path to a folder here.

imwrite(finale, "D:\CN_Steg\originalImage.png");     
imwrite(rgbImage, "D:\CN_Steg\stegoImage.png");


