----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/29/2024 06:36:23 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_env is
    Port (clk: in std_logic;
    btn: in std_logic_vector(4 downto 0);
    sw: in std_logic_vector(15 downto 0);
    led: out std_logic_vector(15 downto 0);
    an: out std_logic_vector(7 downto 0);
    cat: out std_logic_vector(6 downto 0));
end test_env;

architecture Behavioral of test_env is

component ifetch is
Port (jump: in std_logic;
jumpadress: in std_logic_vector(31 downto 0);
pcsrc: in std_logic;
branchadress: in std_logic_vector(31 downto 0);
en: in std_logic;
rst: in std_logic;
clk: in std_logic;
pcplus4: out std_logic_vector(31 downto 0);
instruction: out std_logic_vector(31 downto 0));
end component;

component id is
Port (
clk: in std_logic;
regwrite: in std_logic;
instr: in std_logic_vector(25 downto 0);
en: in std_logic;
extop: in std_logic;
rd1: out std_logic_vector(31 downto 0);
rd2: out std_logic_vector(31 downto 0);
wd: in std_logic_vector(31 downto 0);
ext_imm: out std_logic_vector(31 downto 0);
func: out std_logic_vector(5 downto 0);
sa: out std_logic_vector(4 downto 0);


--semnale PIPELINE


wa: in std_logic_vector(4 downto 0);
rt: out std_logic_vector(4 downto 0);
rd: out std_logic_vector(4 downto 0)
 );
end component;

component mpg is
Port ( enable : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;

component ssd is 
Port ( clk : in STD_LOGIC;
           digits : in STD_LOGIC_VECTOR(31 downto 0);
           an : out STD_LOGIC_VECTOR(7 downto 0);
           cat : out STD_LOGIC_VECTOR(6 downto 0));
end component;

component ex is 
Port (
rd1: in std_logic_vector(31 downto 0);
alusrc: in std_logic;
rd2: in std_logic_vector(31 downto 0);
ext_imm: in std_logic_vector(31 downto 0);
sa: in std_logic_vector(4 downto 0);
func: in std_logic_vector(5 downto 0);
aluop: in std_logic_vector(2 downto 0);
pcplus4: in std_logic_vector(31 downto 0);
zero: out std_logic;
alures: out std_logic_vector(31 downto 0);
branchadress: out std_logic_vector(31 downto 0);

--Semnale PIPELINE

rt: in std_logic_vector(4 downto 0);
rd: in std_logic_vector(4 downto 0);
regdst: in std_logic;
rwa: out std_logic_vector(4 downto 0)
 );
end component;

component mem is 
Port ( 
memwrite: in std_logic;
aluresin: in std_logic_vector(31 downto 0);
rd2: in std_logic_vector(31 downto 0);
clk: in std_logic;
en: in std_logic;
memdata: out std_logic_vector(31 downto 0);
aluresout: out std_logic_vector(31 downto 0)
);
end component;

component uc is 
Port (
opcode: in std_logic_vector(5 downto 0);
aluop: out std_logic_vector(2 downto 0);
memtoreg: out std_logic;
memwrite: out std_logic;
jump: out std_logic;
branch: out std_logic;
alusrc: out std_logic;
regwrite: out std_logic;
regdst: out std_logic;
extop: out std_logic
);
end component;

signal rst, en, jump, pcsrc, regwrite, regdst, extop, alusrc, zero, memwrite,memtoreg, branch: std_logic:='0';
signal jumpadress, branchadress, pcplus4, instruction, rd1, rd2, wd, ext_imm, alures, memdata, aluresout, digits: std_logic_vector(31 downto 0);
signal func: std_logic_vector(5 downto 0);
signal sa, wa, rt, rd, rwa: std_logic_vector(4 downto 0);
signal aluop: std_logic_vector(2 downto 0);

--declar semnale pentru pipeline

signal instruction_aux, pcplus4_aux, pcplus4_aux1, rd1_aux, rd2_aux, rd2_aux1, ext_imm_aux, branchadress_aux, alures_aux, alures_aux1, branchadress_aux1, memdata_aux: std_logic_vector(31 downto 0);
signal regdst_aux, alusrc_aux, branch_aux, memwrite_aux, memtoreg_aux, regwr_aux, zero_aux, branch_aux1, memwrite_aux1, memtoreg_aux1, regwr_aux1, memtoreg_aux2, regwr_aux2: std_logic;
signal aluop_aux: std_logic_vector(2 downto 0);
signal func_aux: std_logic_vector(5 downto 0);
signal sa_aux, rd_aux, rt_aux, wa_aux, wa_aux1: std_logic_vector(4 downto 0);


begin


--Introduc procesele pentru PIPELINE

--Registrul 1
process(clk, en)
begin
    if rising_edge(clk) then
        if en='1' then
            instruction_aux<=instruction;
            pcplus4_aux<=pcplus4;
        end if;
    end if;
end process;

--Registrul 2
process(clk, en)
begin
    if rising_edge(clk) then
        if en='1' then
            regdst_aux<=regdst;
            alusrc_aux<=alusrc;
            branch_aux<=branch;
            aluop_aux<=aluop;
            memwrite_aux<=memwrite;
            memtoreg_aux<=memtoreg;
            regwr_aux<=regwrite;
            rd1_aux<=rd1;
            rd2_aux<=rd2;
            ext_imm_aux<=ext_imm;
            func_aux<=func;
            sa_aux<=sa;
            rd_aux<=rd;
            rt_aux<=rt;
            pcplus4_aux1<=pcplus4_aux;
        end if;
    end if;
end process;

--Registrul 3
process(clk, en)
begin
    if rising_edge(clk) then
        if en = '1' then
            branch_aux1<=branch_aux;
            memwrite_aux1<=memwrite_aux;
            memtoreg_aux1<=memtoreg_aux;
            regwr_aux1<=regwr_aux;
            zero_aux<=zero;
            branchadress_aux<=branchadress;
            alures_aux<=alures;
            wa_aux<=rwa;
            rd2_aux1<=rd2_aux;
        end if;
    end if;
end process;

--Registrul 4
process(clk, en)
begin
    if rising_edge(clk) then
        if en='1' then
            memtoreg_aux2<=memtoreg_aux1;
            regwr_aux2<=regwr_aux1;
            alures_aux1<=alures_aux;
            memdata_aux<=memdata;
            wa_aux1<=wa_aux;
        end if;
    end if;
end process;

--Facem schimbarile pentru PIPELINE

pcsrc<=zero_aux and branch_aux1;
rst<=btn(1);
jumpadress<=pcplus4_aux(31 downto 28)&instruction_aux(25 downto 0)&"00";
wd <= alures_aux1 when memtoreg_aux2='0' else memdata_aux;

mpg_component: mpg port map(enable=>en, btn=>btn(0), clk=>clk);

ifetch_component: ifetch port map(
    jump=>jump,
    jumpadress=>jumpadress,
    pcsrc=>pcsrc, 
    --Schimbat pentru PIPELINE
    branchadress=>branchadress_aux,
    en=>en, 
    rst=>rst,
    clk=>clk,
    pcplus4=>pcplus4,
    instruction=>instruction
 );

id_component: id port map(
    clk     => clk,
    --Schimbat pentru PIPELINE
    regwrite => regwr_aux2,
    --Schimbat pentru PIPELINE
    instr   => instruction_aux(25 downto 0),
    en      => en,
    extop   => extop,
    rd1     => rd1,
    rd2     => rd2,
    wd      => wd,
    ext_imm => ext_imm,
    func    => func,
    sa      => sa,
    --Schimbat pentru PIPELINE
    wa      => wa_aux1,
    rt      =>rt,
    rd      => rd
);

ex_inst : ex
port map (
    --Schimbat pentru PIPELINE
    rd1          => rd1_aux,
    alusrc       => alusrc_aux,
    --Schimbat pentru PIPELINE
    rd2          => rd2_aux,
    --Schimbat pentru PIPELINE
    ext_imm      => ext_imm_aux,
    --Schimbat pentru PIPELINE
    sa           => sa_aux,
    --Schimbat pentru PIPELINE
    func         => func_aux,
    --Schimbat pentru PIPELINE
    aluop        => aluop_aux,
    --Schimbat pentru PIPELINE
    pcplus4      => pcplus4_aux1,
    zero         => zero,
    alures       => alures,
    branchadress => branchadress,
    
    --Semnale PIPELINE
    
    rt           => rt_aux,
    rd           => rd_aux,
    regdst       => regdst_aux,
    rwa          => rwa
);

mem_inst : mem
port map (
    --Schimbat pentru PIPELINE
    memwrite   => memwrite_aux,
    --Schimbat pentru PIPELINE
    aluresin   => alures_aux,
    --Schimbat pentru PIPELINE
    rd2        => rd2_aux1,
    clk        => clk,
    en         => en,
    memdata    => memdata,
    aluresout  => aluresout
);

uc_inst : uc
port map (
    --Schimbat pentru PIPELINE
    opcode    => instruction_aux(31 downto 26),
    aluop     => aluop,
    memtoreg  => memtoreg,
    memwrite  => memwrite,
    jump      => jump,
    branch    => branch,
    alusrc    => alusrc,
    regwrite  => regwrite,
    regdst    => regdst,
    extop     => extop
);

ssd_inst : ssd
port map (
    clk    => clk,
    digits => digits, 
    an     => an,
    cat    => cat
);

process(sw(7 downto 5))
begin
    case sw(7 downto 5) is 
        when "000" => digits<=instruction;
        when "001" => digits<=pcplus4;
        when "010" => digits<=rd1_aux;
        when "011" => digits<=rd2_aux;
        when "100" => digits<=ext_imm;
        when "101" => digits<=alures;
        when "110" => digits<=memdata;
        when "111" => digits<=wd;
        when others => digits<=wd;
    end case;
end process;

led(0)<=regwrite;
led(1)<=memtoreg;
led(2)<=memwrite;
led(3)<=jump;
led(4)<=branch;
led(5)<=alusrc;
led(6)<=extop;
led(7)<=regdst;

end Behavioral;







