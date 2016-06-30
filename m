From: famz@redhat.com (Fam Zheng)
Date: Thu, 30 Jun 2016 09:59:45 +0800
Subject: [PATCH v2 04/12] axonrom: Generate uevent after attribute available
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Message-ID: <20160630015953.6888-5-famz@redhat.com>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 arch/powerpc/sysdev/axonram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 4efd69b..27e7175 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -238,7 +238,7 @@ static int axon_ram_probe(struct platform_device *device)
 	set_capacity(bank->disk, bank->size >> AXON_RAM_SECTOR_SHIFT);
 	blk_queue_make_request(bank->disk->queue, axon_ram_make_request);
 	blk_queue_logical_block_size(bank->disk->queue, AXON_RAM_SECTOR_SIZE);
-	add_disk(bank->disk, true);
+	add_disk(bank->disk, false);
 
 	bank->irq_id = irq_of_parse_and_map(device->dev.of_node, 0);
 	if (bank->irq_id == NO_IRQ) {
@@ -262,6 +262,7 @@ static int axon_ram_probe(struct platform_device *device)
 		rc = -EFAULT;
 		goto failed;
 	}
+	disk_gen_uevents(bank->disk);
 
 	azfs_minor += bank->disk->minors;
 
-- 
2.9.0
