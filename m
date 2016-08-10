From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 10 Aug 2016 10:46:09 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
Message-ID: <010e01d1f31e$50b80260$f2280720$@opengridcomputing.com>

Hey guys, I've rebased the nvmf-4.8-rc branch on top of 4.8-rc2 so I have the
latest/gratest, and continued debugging this crash.  I see:

0) 10 ram disks attached via nvmf/iw_cxgb4, and fio started on all 10 disks.
This node has 8 cores, so that is 80 connections.
1) the cxgb4 interface brought down a few seconds later
2) kato fires on all connections
3) the interface is brought back up 8 seconds after #1
4) 10 seconds after #2 all the qps are destroyed
5) reconnects start happening
6) a blk request is executed and the nvme_rdma_request struct still has a
pointer to one of the qps destroyed in 3 and whamo...

I'm digging into the request cancel logic.  Any ideas/help is greatly
appreciated...

Thanks,

Steve.
