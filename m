From: ychen@greenliant.com (Yung-Chin Chen)
Date: Thu, 3 Apr 2014 17:18:10 -0700
Subject: [PATCH] NVMe: Increase shutdown complete time
In-Reply-To: <alpine.LRH.2.03.1404031709520.4731@AMR>
References: <1396283044-31926-1-git-send-email-keith.busch@intel.com>
 <alpine.WNT.2.00.1403311256420.4656@DMCLERAN-MOBL.amr.corp.intel.com>
 <49158E750348AA499168FD41D8898360626A03D9@FMSMSX105.amr.corp.intel.com>
 <alpine.WNT.2.00.1403311755300.4656@DMCLERAN-MOBL.amr.corp.intel.com>
 <90064137F935C142B4B98BA318BB81A301DA530C@GREEN-CLEX.greenliant.com>
 <alpine.LRH.2.03.1404031709520.4731@AMR>
Message-ID: <90064137F935C142B4B98BA318BB81A301DA531F@GREEN-CLEX.greenliant.com>

Thanks, Keith, for your prompt response. I do not know Linux driver that
well. If you use MODULE_PARM_DESC(), how do I specify the parameter for
bootable NVMe device? 

For example, RedHat 7.0 has built-in NVMe driver and supports bootable
from an NVMe device. The driver is buil-in to the kernel, and is not a
loadable module. Where can I specify the parameters for built-in driver?
Thanks.

Yung-Chin Chen
Greenliant Systems

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Thursday, April 03, 2014 4:13 PM
To: Yung-Chin Chen
Cc: Dan McLeran; Robles, Raymond C; Busch, Keith;
linux-nvme at lists.infradead.org
Subject: RE: [PATCH] NVMe: Increase shutdown complete time

On Thu, 3 Apr 2014, Yung-Chin Chen wrote:
> Why do we choose 5 seconds? Are we able to make this parameter 
> configurable? Thanks.

This is the second time I've been asked this in two days. :)

Any thoughts on something like the following?

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c index
59e2adcc..6ade8de 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -51,6 +51,10 @@
  #define ADMIN_TIMEOUT	(60 * HZ)

+int nvme_io_timeout = 5;
+module_param(nvme_io_timeout, int, 0);
+MODULE_PARM_DESC(nvme_io_timeout, "timeout in seconds for io submitted 
+to queue");
+
  static int nvme_major;
  module_param(nvme_major, int, 0);

diff --git a/include/linux/nvme.h b/include/linux/nvme.h index
5993455..490488e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -66,7 +66,8 @@ enum {

  #define NVME_VS(major, minor)	(major << 16 | minor)

-#define NVME_IO_TIMEOUT	(5 * HZ)
+extern int nvme_io_timeout;
+#define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)

  /*
   * Represents an NVM Express device.  Each nvme_dev is a PCI function.
