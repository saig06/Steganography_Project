# Steganography Project using MATLAB

## **Problem Statement :**

Concealing secret text data behind cover image using Color guided Steganography in MATLAB


## **Methodology :**


### Encryption Algorithm :
  - Convert the given secret data into binary format.
  - Split the cover image C into Red, Green and Blue Planes.(R,G and B respectively).
  - For each pixel in R, do the following :
    - Let b[0]=LSB of the current pixel in R
    - Let b[1]=Next LSB of the current pixel in R
    -  Let n= (Decimal value of b) + 3  i.e., (Excess 3 value of b)
    - If (n mod 2 = 0) then,  Embed (n/2) bits of secret data in current pixels of G and B.
    - Else  Embed [(n-1)/2] bits and [(n+1)/2] bits of secret data in current pixels of G and B
    - If all secret data is embedded, then  Go to step-4
  - Store the resulting image as Stego Image (S)
  
### Recovery Algorithm :
Input: Stego Image(S) , Length of secret data (n)
Output: Secret Data (D)

  - Split the stego image S into Red, Green and Blue Planes.(R,G and B respectively)
  - For each pixel in R, do the following :
    - Let b[0]=LSB of the current pixel in R
    - Let b[1]=Next LSB of the current pixel in R
    - Let n= (Decimal value of b) + 3  i.e., (Excess 3 value of b)
    - If (n mod 2 = 0) then,  Read (n/2) LSBs of current pixels of G and B and concatenate to D.
    - Else  Read [(n-1)/2] bits and [(n+1)/2] LSBs of current pixels of G and B respectively and concatenate to D.
  - Store the resulting recovered secret data (D).
  
  
  
  
Please go through the 122004080.pdf file for complete presentation.
