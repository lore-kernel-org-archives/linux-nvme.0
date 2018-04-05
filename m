From: echang@sk.com (Eric H. Chang)
Date: Thu, 5 Apr 2018 10:11:59 +0000
Subject: [PATCH] nvme-multipath: implement active-active round-robin	path
 selector
In-Reply-To: <20180404143027.GE4485@localhost.localdomain>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
 <20180328194741.GJ13039@localhost.localdomain>
 <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>
 <20180330070651.GA17095@lst.de>
 <e22676055aca4e8d936b7479d6301d85@skt-tnetpmx2.SKT.AD>
 <20180404143027.GE4485@localhost.localdomain>
Message-ID: <4b5f3f8681b843a59572737874a775c4@skt-tnetpmx2.SKT.AD>

> While your experiment is setup to benefit from round-robin, my only concern is it has odd performance in a real world scenario with IO threads executing in different nodes. Christoph's proposal will naturally utilize both paths >optimally there, where round-robin will saturate node interlinks.
>
>Not that I'm against having the choice; your setup probably does represent real use. But if we're going to have multiple choice, user documentation on nvme path selectors will be useful here.


Apologies for the confusion. 
My understanding is that your concern is about efficient CPU-node utilization on NUMA. 
If we come down a bit to the PCIe-retimer with multiple ports (or RDMA NICs with multiple ports) level, our concern is there. 


<Host structure with dual retimers>
CPU node A ------------------- CPU node B 
  |                                    |
PCIe retimer A                     PCIe retimer B
  |                                    |
Port A | Port B                    Port A | Port B


<Host structure with a single retimer>
CPU node A ------------------- CPU node B 
  |                                
PCIe retimer A                  
  |                                
Port A | Port B                 


In any structure above, we'd like to make all available ports efficiently utilized to maximize the performance and this case could also apply to the hosts which are using NVMeOF enabled storages. For NVMeoF setup, the PCIe retimer would be replaced by RDMA NICs though. So, we'd like to discuss the acceptable implementation for the multi-path on multi-ports of the PCIe retimers or R-NICs as well. Since your concern on unbalanced IO threads execution on multi-nodes is valid too,  when your proposal on NUMA and our proposal(or any other's proposal) on multi-ports are combined, it could be most effective solution, I believe. 
In our setup, the system architecture under all ports are symmetrical, round-robin approach still make sense, but if there's any other better consideration, it'd be good to discuss. 
