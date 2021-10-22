% FOR EXTRACTION, NO. OF CHARS IN THE SECRET MESSAGE AND THE STEGO IMAGE
% ARE TO BE FED TO THIS CODE



% Clear the existing workspace 
clear all;

% Clear the command window 
clc; 

% Getting the input image 
input = imread("D:\CN_Steg\stegoImage.png","png");

% Split the image into R,G,B channels
redChannel = input(:,:,1);
greenChannel = input(:,:,2);
blueChannel = input(:,:,3);

% Get height and width for traversing through the image to embed the data
heightrC = size(redChannel, 1); 
widthrC = size(redChannel, 2); 

% Number of characters of the hidden text 
chars = 6; 

% Number of bits in the message 
message_length = chars * 8; 

% counter to keep track of number of bits extracted 
counter = 1; 

ipG = 0; jpG = 0; ipB = 0; jpB = 0; 

% Traverse through the image 
for irC = 1 : heightrC
	for jrC = 1 : widthrC
		
		% If more bits remain to be extracted 
		if (counter <= message_length)
            
            % Finding the Least Significant Bit of the current pixel 
			LSB0 = mod(double(redChannel(irC, jrC)), 2); 
            
            % Finding second LSB
            temp = mod(double(redChannel(irC, jrC)), 4);
            
            if temp == 2||3 
                LSB1 = 1;
            else
                LSB1 = 0;
            end
            
            if LSB1 == 0 && LSB0 == 0
                
                % This means there are two bits in green and one bit in
                % blue channels resp.
               
               for i = (ipG+1)
                   for j = (jpG+1) : (jpG+2)
                       
                       if counter > message_length
                           break
                       else
                           % Store the LSB of the pixel in extracted_bits 
                           extracted_bits(counter, 1) = mod(double(greenChannel(i, j)), 2);
                           counter = counter + 1;
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
                   for j = (jpB+1)
                       
                       if counter > message_length
                           break
                       else
                           % Store the LSB of the pixel in extracted_bits 
                           extracted_bits(counter, 1) = mod(double(blueChannel(i, j)), 2);
                           counter = counter + 1;
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
               
               % This means there are three bits in green and two bits in
                % blue channels resp.
               
               for i = (ipG+1)
                   for j = (jpG+1) : (jpG+3)
                       
                       if counter > message_length
                           break
                       else
                           % Store the LSB of the pixel in extracted_bits
                           extracted_bits(counter, 1) = mod(double(greenChannel(i, j)), 2);
                           counter = counter + 1;
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
                   for j = (jpB+1) : (ipB+2)
                       
                       if counter > message_length
                           break
                       else
                           % Store the LSB of the pixel in extracted_bits
                           extracted_bits(counter, 1) = mod(double(blueChannel(i, j)), 2);
                           counter = counter + 1;
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
           
           if LSB1 == 0 && LSB0 == 1
               
               % This means there are two bits in green and two bits in
                % blue channels resp.
               
               for i = (ipG+1)
                   for j = (jpG+1) : (jpG+2)
                       
                       if counter > message_length
                           break
                       else
                           % Store the LSB of the pixel in extracted_bits
                           extracted_bits(counter, 1) = mod(double(greenChannel(i, j)), 2);
                           counter = counter + 1;
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
                   for j = (jpB+1) : (ipB+2)
                       
                       if counter > message_length
                           break
                       else
                           % Store the LSB of the pixel in extracted_bits
                           extracted_bits(counter, 1) = mod(double(blueChannel(i, j)), 2);
                           counter = counter + 1;
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
           
           if LSB1 == 1 && LSB0 == 1
               
               % This means there are three bits in green and three bits in
                % blue channels resp.
               
               for i = (ipG+1)
                   for j = (jpG+1) : (jpG+3)
                       
                       if counter > message_length
                           break
                       else
                           % Store the LSB of the pixel in extracted_bits
                           extracted_bits(counter, 1) = mod(double(greenChannel(i, j)), 2);
                           counter = counter + 1;
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
                   for j = (jpB+1) : (ipB+3)
                       
                       if counter > message_length
                           break
                       else
                           % Store the LSB of the pixel in extracted_bits
                           extracted_bits(counter, 1) = mod(double(blueChannel(i, j)), 2);
                           counter = counter + 1;
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

		end
	end
end

% Powers of 2 to get the ASCII value from binary 
binValues = [128 64 32 16 8 4 2 1]; 

% Get all the bits in 8 columned table 
% Each row is the bits of the character 
% in the hidden text 

binMatrix = reshape(extracted_bits, 8,(message_length/8)); 
  
% Convert the extracted bits to characters 
% by multiplying with powers of 2 
binMatrix;
textString = char(binValues*binMatrix);  

% Print the hidden text
disp("MESSAGE : ");disp(textString);





im0=imread("D:\CN_Steg\originalImage.png");
im1=imread("D:\CN_Steg\stegoImage.png");
peaksnr=psnr(im0,im1);
disp("PSNR : ");
disp(peaksnr);
mse=immse(im0,im1);
disp("MSE : ");
disp(mse);

figure(1);
subplot(2,2,1);
histogram(im0);
subplot(2,2,2);
histogram(im1);


subplot(2,2,3);
h1=histogram(im0);
hold on
h2=histogram(im1);

