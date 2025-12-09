library IEEE;
use IEEE.std_logic_1164.all;

entity RxUnit is
  port (
    clk, reset       : in  std_logic;
    enable           : in  std_logic;
    read             : in  std_logic;
    rxd              : in  std_logic;
    data             : out std_logic_vector(7 downto 0);
    Ferr, OErr, DRdy : out std_logic);
end RxUnit;

architecture behavorial of RxUnit is

  signal tmpClk : std_logic;

begin

  process(clk, reset)

    type etats is (REPOS, COMPTAGE);
    signal etat : etats;
    variable compteur := 8;
    variable compteurBit := 0;

    begin
      if (reset = '0') then
        tmpClk <= '1';
        etat <= IDLE; 
      else if (rising_edge (clk)) then
        case etat is
          when REPOS =>
            if (enable = '1') then
              compteur := compteur - 1;
              if (compteur = '0' and rxd = '0') then
                etat <= COMPTAGE;
                compteur := 8;
                tmpClk <= 1;
              end if;
            end if;
          when COMPTAGE =>
            if (enable = '1') then
              compteur := compteur - 1;
              if (compteur = '0') then
                tmpClk <= not tmpClk;
                compteur := 8;
              end if;
            end if;
        end case;
      end if;
  end process;

  process(clk, reset)
    begin
    
  end process;

end behavorial;
