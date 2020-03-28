Return-Path: <SRS0=GXcx=5N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8471C43331
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2020 05:10:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9741620716
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2020 05:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RBtdTjQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9741620716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ORFPKjWtFyZCcLx1GHaKctWV0hJvsMYxTw75sTUPLQ8=; b=RBtdTjQ7SqpuOK
	kl0RZFQ8DUHGp1lhpl+LyoUliRyMiG80DFoVXXCle5AjqEBeXAjj0v/D/WcijvQvGBAPYvzQFjHus
	YQOhphmu01he8SXawmswfD8w5qOeounb44RR5pcRJ/4hqZ0MzZfJqVtxM3ZB8NcaKpwQWSnd6roAK
	wVlDz0m3X+eElm/fKk94hcmaN+4/YrN4kE4qRHX9KWvo61AfSLac2eNmpUz7YeofPva8KAw0C0p6b
	WgJb/8RVLdjL6Tz7sRGHS+q+vg+3GiFjDwldBbOG4kij5VyG04tr2TPA/xODmQHhEVrrH1yHndj0/
	XOo6WmdlFfFH4qqOm73Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jI3kB-0002jy-SA; Sat, 28 Mar 2020 05:10:51 +0000
Received: from mta01.start.ca ([162.250.196.97])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jI3jx-0002V4-G5
 for linux-nvme@lists.infradead.org; Sat, 28 Mar 2020 05:10:40 +0000
Received: from mta01.start.ca (localhost [127.0.0.1])
 by mta01.start.ca (Postfix) with ESMTP id A946E4292B;
 Sat, 28 Mar 2020 01:10:33 -0400 (EDT)
Received: from localhost (dhcp-24-53-240-163.cable.user.start.ca
 [24.53.240.163])
 by mta01.start.ca (Postfix) with ESMTPS id ADCD142928;
 Sat, 28 Mar 2020 01:10:31 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] nvme: Fix compat address handling in several ioctls
Date: Sat, 28 Mar 2020 01:09:09 -0400
Message-Id: <20200328050909.30639-3-nbowler@draconx.ca>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200328050909.30639-1-nbowler@draconx.ca>
References: <20200328050909.30639-1-nbowler@draconx.ca>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_221037_667963_7196AD05 
X-CRM114-Status: GOOD (  13.85  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On a 32-bit kernel, the upper bits of userspace addresses passed
via various ioctls are silently ignored by the nvme driver.

However on a 64-bit kernel running a compat task, these upper bits are
not ignored and are in fact required to be zero for the ioctls to work.

Unfortunately, this difference matters.  32-bit smartctl submits the
NVME_IOCTL_ADMIN_CMD ioctl with garbage in these upper bits because
it seems the pointer value it puts into the nvme_passthru_cmd structure
is sign extended.  This works fine on 32-bit kernels but fails on a
64-bit one because (at least on my setup) the addresses smartctl uses
are consistently above 2G.  For example:

  # smartctl -x /dev/nvme0n1
  smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.5.11] (local build)
  Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

  Read NVMe Identify Controller failed: NVME_IOCTL_ADMIN_CMD: Bad address

Since changing 32-bit kernels to actually check all of the submitted
address bits now would break existing userspace, this patch fixes the
compat problem by explicitly zeroing the upper bits in the compat case.
This enables 32-bit smartctl to work on a 64-bit kernel.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 drivers/nvme/host/core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9eccf56494de..f265ccd69dd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -6,6 +6,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/hdreg.h>
@@ -1248,6 +1249,19 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 
+/*
+ * Convert integer values from ioctl structures to user pointers, silently
+ * ignoring the upper bits in the compat case to match behaviour of 32-bit
+ * kernels.
+ */
+static void __user *nvme_to_user_ptr(uintptr_t ptrval)
+{
+	if (in_compat_syscall())
+		ptrval = (compat_uptr_t)ptrval;
+
+	return (void __user *)ptrval;
+}
+
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio,
 			  size_t uio_size)
 {
@@ -1276,7 +1290,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio,
 
 	length = (io.nblocks + 1) << ns->lba_shift;
 	meta_len = (io.nblocks + 1) * ns->ms;
-	metadata = (void __user *)(uintptr_t)io.metadata;
+	metadata = nvme_to_user_ptr(io.metadata);
 
 	if (ns->ext) {
 		length += meta_len;
@@ -1299,7 +1313,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio,
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
 	return nvme_submit_user_cmd(ns->queue, &c,
-			(void __user *)(uintptr_t)io.addr, length,
+			nvme_to_user_ptr(io.addr), length,
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
 }
 
@@ -1419,9 +1433,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-			(void __user *)(uintptr_t)cmd.metadata,
-			cmd.metadata_len, 0, &result, timeout);
+			nvme_to_user_ptr(cmd.addr), cmd.data_len,
+			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
+			0, &result, timeout);
 	nvme_passthru_end(ctrl, effects);
 
 	if (status >= 0) {
@@ -1466,8 +1480,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata_len,
+			nvme_to_user_ptr(cmd.addr), cmd.data_len,
+			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
 			0, &cmd.result, timeout);
 	nvme_passthru_end(ctrl, effects);
 
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
