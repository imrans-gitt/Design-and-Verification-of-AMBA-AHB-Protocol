
`include "environment.sv"

program Test(APB_if pif);
  
  environment env;
  
  initial 
    begin
      
      env=new(pif);
      
fork
      env.build();
      env.rst();
      env.start();
join
    end
endprogram

  
      
    
  
  