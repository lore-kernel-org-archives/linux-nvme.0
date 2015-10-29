From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Thu, 29 Oct 2015 15:38:40 +0100
Subject: [PATCH] nvme: prepare support for Apple NVMe controller
Message-ID: <bd1f730603ee00205657774a362aab10@localhost>

The Apple NVMe controller found in the Macbook8,1 (12 inch retina model)
requires ordered split transfers even on 64bit systems to work.
Otherwise, readq() for instance returns all ones, which explains the
ridiculous page size of 128MiB reported before.

With this patch applied, the Apple NVMe controller can manually be bound
to he NVMe driver. Manual binding is still required since the controller
reports a PCI device class of 018002 (mass storage) instead of 010802
(nvme).


Signed-off-by: Stephan G?nther <guenther at tum.de>
Signed-off-by: Maurice Leclaire <leclaire at in.tum.de>
---

modprobe nvme
echo "106b 2001" > /sys/bus/pci/drivers/nvme/new_id

>From lspci after binding:

| 03:00.0 Mass storage controller: Apple Inc. Device 2001 (rev 01)
|   Subsystem: Apple Inc. Device 2001
|   (...)
|   Kernel driver in use: nvme

Partitions are correctly recognized and i/o operations seem to work so
far.

 drivers/block/nvme-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ccc0c1f93daa..d6c0d2f1df03 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -43,6 +43,9 @@
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
+#define readq lo_hi_readq
+#define writeq lo_hi_writeq
+
 #define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
