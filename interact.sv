package interact;

parameter integer ARITY = 5;
parameter integer LINK_WIDTH = 35;


typedef struct {
  logic req;
  logic [LINK_WIDTH-1 : 0] data;
} channel_forward;

typedef struct {
 logic ack;
} channel_backward;

typedef  channel_forward   router_port_f [ARITY-1:0] ;
typedef channel_backward   router_port_b [ARITY-1:0]  ; 


task reset_router_port_f(router_port_f router_port );
	for(int i =0; i<ARITY; i= i+ 1)
	begin
		router_port[i].data = 0;
		router_port[i].req = 0;
	end
endtask

task reset_router_port_b(router_port_b router_port );
	for(int i =0; i<ARITY; i= i+ 1)
		router_port[i].ack = 0;
endtask

endpackage