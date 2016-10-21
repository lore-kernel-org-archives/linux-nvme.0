From: sjones@kalray.eu (Samuel Jones)
Date: Fri, 21 Oct 2016 15:08:31 +0200 (CEST)
Subject: bug in nvme_rdma module when CAP.MQES is < 128 ?
Message-ID: <1957614832.14672869.1477055311936.JavaMail.zimbra@kalray.eu>

Hi all,

I think there's a small bug in the Linux nvme_rdma module in master. I have a NVMe controller that supports a very small maximum queue depth (16). It exposes a CAP.MQES = 15 (16 - 1).

The problem I observe is that the initiator sends more than 16 commands on the fly which causes an queue overflow on the controller side. My analysis/explanation of the problem is as follows, I'd welcome any help:

The nvme_fabrics module exposes an optional queue_size parameter, which can be used to size the IO queues. In the absence of a user argument, this is set to 128. This argument is passed to nvme_rdma_create_ctrl(), which saves it in the ctrl.sqsize variable (rdma.c:1878). Then once the controller is connected, it reads the disk's capabilities and adjusts its sqsize variable to the minimum of sqsize and MQES (rdma.c:1555). This variable sqsize is what is passed down to the fabrics layer to connect the IO queue (fabrics.c:451).

So far so good. The problem as I see it, is the configuration of block IO which takes place in nvme_rdma_create_io_queues (rdma.c:1780) where the block IO tag set is sized using **the original user argument supplied by the fabrics module, not the sqsize variable adjusted for MQES**. The only adjustment performed on this variable is done in nvme_rdma_create_ctrl (rdma.c:1903), where it is adjusted according to MAXCMD, not MQES. This is what the spec says about MAXCMD:

Maximum Outstanding Commands (MAXCMD): Indicates the maximum number of commands that the controller processes at one time for a particular queue (which may be larger than the size of the corresponding Submission Queue). The host may use this value to size Completion Queues and optimize the number of commands submitted at one time to a particular I/O Queue. This field is mandatory for NVMe over  Fabrics  and  optional for  NVMe  over  PCIe  implementations.  If the field  is  not used, it shall be cleared to 0h.

It seems to me that MQES should be used here rather than MAXCMD, or sqsize should be adjusted for MAXCMD as well as MQES, since as far as I can tell the layer that limits the outstanding commands is block IO and not rdma.c itself. In any case, empirically, I have tried both forcing the use of sqsize as an argument to block IO, and reducing the MAXCMD exposed by my controller; both fix my problem.

Thanks in advance for any help,

Samuel Jones

signature 

	Samuel Jones 

sjones at kalray.eu 

www.kalray.eu 

Follow us on : 	KALRAY SA 


86 rue de Paris, 91400 Orsay FRANCE 
Phone: +33 1 69 29 08 16 
Fax: +33 1 69 29 90 86 

445 rue Lavoisier, 38330 Montbonnot FRANCE 
Phone: +33 4 76 18 90 71 
Fax: +33 4 76 89 80 26
