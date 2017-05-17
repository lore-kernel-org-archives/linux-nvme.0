From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 17 May 2017 11:38:46 -0600
Subject: BUG: nvmet with cxgb4 is broken in v4.12-rc1
Message-ID: <66da3b58-f722-28f0-1ed9-70f1e47276a4@deltatee.com>

Hello,

Another cxgb4 bug report for you. Testing nvmet over our T62100-LP-CR
stopped working in v4.12-rc1. We are seeing two oopses: a general
protection fault in nvmet_rdma_free_rsps and a WQ_MEM_RECLAIM warning.
These occur after a suspect cxgb4 message. Please see the full dmesg log
which is attached.

> [   41.093555] cxgb4 0000:07:00.4: AE qpid 1034 opcode 0 status 0x1 type 1 len 0x0 wrid.hi 0x0 wrid.lo 0x0
> [   41.093673] nvmet_rdma: received IB QP event: QP access error (3)

I've bisected to find this commit is the culprit:

bb58d079: cxgb4: Update IngPad and IngPack values

A bisect log is also attached. Reverting that commit also fixes the issue.

Thanks,

Logan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: bisect.nvmet1.log
Type: text/x-log
Size: 2866 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170517/b37c36e6/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg.log
Type: text/x-log
Size: 89641 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170517/b37c36e6/attachment-0003.bin>
