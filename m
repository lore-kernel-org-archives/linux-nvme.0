From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 17 May 2017 14:22:23 -0500
Subject: nvmet with cxgb4 is broken in v4.12-rc1
In-Reply-To: <66da3b58-f722-28f0-1ed9-70f1e47276a4@deltatee.com>
References: <66da3b58-f722-28f0-1ed9-70f1e47276a4@deltatee.com>
Message-ID: <046701d2cf42$e918bf30$bb4a3d90$@opengridcomputing.com>

> Hello,
> 
> Another cxgb4 bug report for you. Testing nvmet over our T62100-LP-CR
> stopped working in v4.12-rc1. We are seeing two oopses: a general
> protection fault in nvmet_rdma_free_rsps and a WQ_MEM_RECLAIM warning.
> These occur after a suspect cxgb4 message. Please see the full dmesg log
> which is attached.
> 
> > [   41.093555] cxgb4 0000:07:00.4: AE qpid 1034 opcode 0 status 0x1 type 1 len
> 0x0 wrid.hi 0x0 wrid.lo 0x0
> > [   41.093673] nvmet_rdma: received IB QP event: QP access error (3)
> 
> I've bisected to find this commit is the culprit:
> 
> bb58d079: cxgb4: Update IngPad and IngPack values
> 
> A bisect log is also attached. Reverting that commit also fixes the issue.
> 

Hey Logan, this is with 1.16.43.0 firmware? 

Hey Casey/Manoj, is there some other sw or fw change missing for the ingpad change?  Or maybe something needed in the firmware config file?

Thanks,

Steve.
