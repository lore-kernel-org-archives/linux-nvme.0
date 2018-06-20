From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 20 Jun 2018 13:10:57 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
Message-ID: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>

The iod can get quite large, requiring higher order allocations that
we know can fail. Don't warn about them, as that just tends to flod
the log with information we don't care about.

Signed-off-by: Jens Axboe <axboe at kernel.dk>

---

This begs the question is we should limit the size in general. The
command overhead is low enough that I think we should default to
something sane that doesn't require _any_ > 0 order allocations.

Our default 1280kb will require 10248 bytes of iod, which is an
order 2 allocation.... That's not helping tail latencies in
data centers, where memory is always full and fragmented.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804662e7..1c97d6356484 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -480,7 +480,7 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 		size_t alloc_size = nvme_pci_iod_alloc_size(dev, size, nseg,
 				iod->use_sgl);
 
-		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
+		iod->sg = kmalloc(alloc_size, GFP_ATOMIC | __GFP_NOWARN);
 		if (!iod->sg)
 			return BLK_STS_RESOURCE;
 	} else {

-- 
Jens Axboe
