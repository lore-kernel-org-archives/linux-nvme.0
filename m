From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Fri, 19 Feb 2016 19:14:10 +0000
Subject: [PATCH-4.6 3/3] NVMe: Don't allow unsupported flags
In-Reply-To: <1455837677-23248-3-git-send-email-keith.busch@intel.com>
References: <1455837677-23248-1-git-send-email-keith.busch@intel.com>
 <1455837677-23248-3-git-send-email-keith.busch@intel.com>
Message-ID: <8D943B239464E04C9184454D8B3F5CFF0AC93EE1@ORSMSX101.amr.corp.intel.com>

I haven't seen a great argument for SGL other than that the devices support it. If anyone can prove it faster, I'd like to see it.

Otherwise the set looks good

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Thursday, February 18, 2016 4:21 PM
To: linux-nvme at lists.infradead.org; Jens Axboe <axboe at fb.com>; Christoph Hellwig <hch at infradead.org>
Cc: Busch, Keith <keith.busch at intel.com>
Subject: [PATCH-4.6 3/3] NVMe: Don't allow unsupported flags

The command flags can change the meaning of other fields in the command that the driver is not prepared to handle. Specifically, the user could passthrough an SGL flag, causing the controller to misinterpret the PRP list the driver created, potentially corrupting memory or data.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Alternatively I have a different patch that builds SGL's if the flags has it set and the device supports SGL. Any interest?

I didn't post it since the fast path only gets PRP-able scatter lists, and the additional logic to handle SGL's complicates handling the NVMe IO descriptor.

 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index 33ad10d..d8c3a55 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -398,7 +398,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	memset(&c, 0, sizeof(c));
 	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
+	c.rw.flags = 0;
 	c.rw.nsid = cpu_to_le32(ns->ns_id);
 	c.rw.slba = cpu_to_le64(io.slba);
 	c.rw.length = cpu_to_le16(io.nblocks); @@ -428,7 +428,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
+	c.common.flags = 0;
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
 	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
--
2.6.2.307.g37023ba


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
