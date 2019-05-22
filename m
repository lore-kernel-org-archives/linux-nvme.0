From: kbusch@kernel.org (Keith Busch)
Date: Wed, 22 May 2019 13:26:57 -0600
Subject: [RFC PATCH] nvme: Ignore timeouts while a PCIe reset is pending
In-Reply-To: <20190522003741.26755-1-kenneth.heitke@intel.com>
References: <20190522003741.26755-1-kenneth.heitke@intel.com>
Message-ID: <20190522192656.GB5486@localhost.localdomain>

On Tue, May 21, 2019@06:37:41PM -0600, Kenneth Heitke wrote:
> If an admin command timeout occurs while a PCIe reset (FLR) is
> pending, the CSTS bits may not be valid which could result in
> the controller being removed.
> 
> [372337.996566] nvme nvme0: I/O 0 QID 0 timeout, reset controller
> [372339.984662] nvme 0000:1c:00.0: enabling device (0000 -> 0002)
> [372339.984951] nvme nvme0: Removing after probe failure status: -19

The disable reclaims all commands, including the ones it dispatches, so
it sounds like you're talking about a race between the ones it dispatched
and its timeout work. If so, we can just make sure commands sent during
nvme_dev_disable never timeout, which are just the delete queue commands:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f562154551ce..4678704c2138 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2210,7 +2210,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = ADMIN_TIMEOUT;
+	req->timeout = UINT_MAX;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
--
