From: keith.busch@intel.com (Keith Busch)
Date: Wed,  6 Jun 2018 08:13:09 -0600
Subject: [PATCH 6/6] nvme-pci: Make CMB SQ mod-param read-only
In-Reply-To: <20180606141309.19389-1-keith.busch@intel.com>
References: <20180606141309.19389-1-keith.busch@intel.com>
Message-ID: <20180606141309.19389-7-keith.busch@intel.com>

A controller reset after a run time change of the CMB module parameter
breaks the driver. An 'on -> off' will have the driver use NULL for the
host memory queue, and 'off -> on' will use mismatched queue depth between
the device and the host.

We could fix both, but there isn't really a good reason to change this
at run time anyway, compared to at module load time, so this patch makes
parameter read-only after after modprobe.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e18753f1ef19..c8dae140db06 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -42,7 +42,7 @@ static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
 static bool use_cmb_sqes = true;
-module_param(use_cmb_sqes, bool, 0644);
+module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
 static unsigned int max_host_mem_size_mb = 128;
-- 
2.14.3
