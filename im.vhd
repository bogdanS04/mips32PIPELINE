----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2024 05:12:12 PM
-- Design Name: 
-- Module Name: im - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity im is
Port (adress: in std_logic_vector(4 downto 0);
data: out std_logic_vector(31 downto 0)
);
end im;

architecture Behavioral of im is

type mem_rom is array (0 to 31) of std_logic_vector(31 downto 0);
signal mem: mem_rom := (
                         --registrul 31 <- lungimea sirului din memorie(6) prin adunarea valorii registrului 0 cu 6
                        B"001000_00000_11111_0000000000000110", --addi  --4
                        B"000000_00000_00000_0000000000000000", --8
                        B"000000_00000_00000_0000000000000000", --c
                        --beq sa sara peste instructiunile din bucla daca valoarea registrului 30 ajunge egala cu 6 prin incrementare 
                        B"000100_11110_11111_0000000000010101", --beq    --8 sare la ultima instructiune dupa 6 iteratii --10 
                        B"000000_00000_00000_0000000000000000", --14
                        B"000000_00000_00000_0000000000000000",  --18
                        B"000000_00000_00000_0000000000000000", --1c
                        --pun in registrul 1 valoarea 0 pentru comparatie
                        B"001000_00000_00001_0000000000000000", --addi --20
                        --pun in registrul 3 valoarea din memorie de la adresa indicata de registrul 2
                        B"100011_00010_00011_0000000000000000", --lw   --24
                        -- pun in registrul 4 valoarea de la adresa registrului 2 ca auxiliar                        
                        B"100011_00010_00100_0000000000000000", --lw  --28
                        B"000000_00000_00000_0000000000000000",   --2c
                        --pun in registrul 3 valoarea din memorie and 000..1
                        B"001100_00011_00011_0000000000000001", --andi   --30
                        B"000000_00000_00000_0000000000000000", --34
                        B"000000_00000_00000_0000000000000000",  --38
                        --face beq daca e par  
                        B"000100_00011_00001_0000000000000110", --beq sare la 58 daca acum am par  --3c
                        
                        B"000000_00000_00000_0000000000000000", --40
                        B"000000_00000_00000_0000000000000000", --44
                        B"000000_00000_00000_0000000000000000", --48
                        
                        --adun numarul impar la registrul 29
                        B"000000_11101_00100_11101_00000_000001", --add --4c    
                        
                        --sare peste incrementarea numerelor pare daca numarul e impar   
                        B"000010_00000000000000000000010110", --jump  --sare la 5c daca impar  --50
                        
                        B"000000_00000_00000_0000000000000000", --54
                        
                         --incrementez numarul de numere pare (registrul 28)
                        B"001000_11100_11100_0000000000000001", --addi --58
                        
                        --incrementam registrul 2 cu 4
                        B"001000_00010_00010_0000000000000100", --addi   --5c
                        --incrementm registrul 30 cu 1 
                        B"001000_11110_11110_0000000000000001",  --addi  --60
                        --sare inapoi la beq   
                        B"000010_00000000000000000000000000", --jump  --sare la 4 daca avem mai putin de 6 iteratii   --64
                        B"000000_00000_00000_0000000000000000",  --68
                        --fac suma dintre numarul de numere pare si suma numerelor impare in registrul 27
                        B"000000_11100_11101_11011_00000_000001",  --6c
                       
                        others => X"00000000"
);

begin
data<=mem(conv_integer(adress));
end Behavioral;
