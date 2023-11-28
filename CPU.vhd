library ieee;
use ieee.std_logic_1164.all;
entity cpu is
port(
	clk: in std_logic;
	pcOut: out std_logic_vector(7 downto 0);
	marOut: out std_logic_vector (7 downto 0);
	irOutput: out std_logic_vector (7 downto 0);
	mdriOutput: out std_logic_vector (7 downto 0);
	mdroOutput: out std_logic_vector (7 downto 0);
	aOut: out std_logic_vector (7 downto 0);
	incrementOut: out std_logic );
end;

architecture behavior of cpu is
component memory_8_by_32 --memory component
port(
	clk: in std_logic;
	Write_Enable: in std_logic;
	Read_Addr: in std_logic_vector(4 downto 0);
	Data_in: in std_logic_vector(7 downto 0);
	Data_out: out std_logic_vector(7 downto 0)	
);
end component;

component alu --arithmetic logic unit
port(
	A: in std_logic_vector(7 downto 0);
	B: in std_logic_vector(7 downto 0);
	AluOp: in std_logic_vector(2 downto 0);
	output: out std_logic_vector(7 downto 0)
);
end component;	

component reg --register
port(
	input : in std_logic_vector(7 downto 0);
	output : out std_logic_vector(7 downto 0);
	clk : in std_logic;
	load : in std_logic
);
end component;

component ProgramCounter --program counter
port(
	increment: in std_logic;
	clk: in std_logic;
	output: out std_logic_vector(7 downto 0)
);
end component;

component TwoToOneMux --mux
port(
	A: in std_logic_vector (7 downto 0);
	B: in std_logic_vector (7 downto 0);
	address: in std_logic;
	output: out std_logic_vector (7 downto 0)
);
end component;

component sevenseg --seven segment decoder
port(
	i: in std_logic_vector(3 downto 0);
	o: out std_logic_vector(7 downto 0)
);
end component;

component ControlUnit
port(
	OpCode : in std_logic_vector(2 downto 0);
	clk : in std_logic;
	ToALoad : out std_logic;
	ToMarLoad : out std_logic;
	ToIrLoad : out std_logic;
	ToMdriLoad : out std_logic;
	ToMdroLoad : out std_logic;
	ToPcIncrement : out std_logic;
	ToMarMux : out std_logic;
	ToRamWriteEnable : out std_logic;
	ToAluOp : out std_logic_vector(2 downto 0)
);
end component;

-- Connections
signal ramDataOutToMdri : std_logic_vector(7 downto 0);
-- MAR Multiplexer connections
signal pcToMarMux : std_logic_vector(7 downto 0);
signal muxToMar : std_logic_vector	(7 downto 0);
-- RAM connections
signal marToRamReadAddr : std_logic_vector(4 downto 0);
signal mdroToRamDataIn : std_logic_vector(7 downto 0);
-- MDRI connections
signal mdriOut : std_logic_vector(7 downto 0);
-- IR connection
signal irOut : std_logic_vector(7 downto 0);
-- ALU / Accumulator connections
signal aluOut: std_logic_vector(7 downto 0);
signal aToAluB : std_logic_vector(7 downto 0);
-- Control Unit connections
signal cuToALoad : std_logic;
signal cuToMarLoad : std_logic;
signal cuToIrLoad : std_logic;
signal cuToMdriLoad : std_logic;
signal cuToMdroLoad : std_logic;
signal cuToPcIncrement : std_logic;
signal cuToMarMux : std_logic;
signal cuToRamWriteEnable : std_logic;
signal cuToAluOp : std_logic_vector(2 downto 0);

begin
Map_Memory: memory_8_by_32 port map(clk=>clk,
	Read_Addr=>marToRamReadAddr,
	Data_in=>mdroToRamDataIn,
	Data_Out=>ramDataOutToMdri,
	Write_Enable=>cuToRamWriteEnable );




-- Accumulator
--INSERT CODE HERE
-- ALU
--INSERT CODE HERE
-- Program Counter
--INSERT CODE HERE
-- Instruction Register
--INSERT CODE HERE
-- MAR mux
--INSERT CODE HERE

-- Memory Access Register
--INSERT CODE HERE
-- Memory Data Register Input
Map_MDRI: reg port map(clk=>clk,
	input=>ramDataOutToMdri,
	output=>mdriOut,
	load=>cuToMdriLoad );

-- Memory Data Register Output
--INSERT CODE HERE
-- Control Unit
--INSERT CODE HERE


--REMAINING CODE GOES HERE
pcOut <= pcToMarMux;
irOutput <= irOut;
aOut <= aToAluB;
marOut <= irOut(7 downto 5)&marToRamReadAddr;
mdriOutput <= mdriOut;
mdroOutput <= mdroToRamDataIn;
end behavior;
