From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 21 Jul 2015 15:08:13 -0600
Subject: [PATCH] nvme: Fixes u64 division which breaks i386 builds
Message-ID: <1437512893-24514-1-git-send-email-jonathan.derrick@intel.com>

Uses div_u64 for u64 division and round_down, a bitwise operation,
instead of rounddown, which uses a modulus.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
Hi folks. I accidentally broke i386 builds with my u64 math. This is the
attempt to use safe operators instead of direct operator on u64 variables

I will, of course, be mindful of i386 builds from now on. :)

 drivers/block/nvme-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 82b4ffb..666e994 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1454,8 +1454,9 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 	unsigned q_size_aligned = roundup(q_depth * entry_size, dev->page_size);
 
 	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
-		q_depth = rounddown(dev->cmb_size / nr_io_queues,
-					dev->page_size) / entry_size;
+		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
+		mem_per_q = round_down(mem_per_q, dev->page_size);
+		q_depth = div_u64(mem_per_q, entry_size);
 
 		/*
 		 * Ensure the reduced q_depth is above some threshold where it
-- 
2.1.4
