Return-Path: <SRS0=7Vx6=6C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59413C38A29
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2020 14:42:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8ED62220A
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2020 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="idJAy2Pp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1bfIXMn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8ED62220A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iijcTzCpef2xFHW3g8WAF2MQSo3hrqFDPNpuLIdHwl4=; b=idJAy2Pp9Yy7Tt
	dkb4Nv2fVWNXB2Dqt0KFI6bjjxOy93YNOUgLjQsU1We7hWr1TG+hqLGrykvHRSTQ2h+7caN2Q7jSI
	rDzUz8EUftAPs96r5d0X1S2esFcenSe8wMSuzXQhBEETrmZPtppj9Q05dhymI1edikHSWdWDuZp/3
	v4EwGs19Q9UNdCTga1zUkMUM1JuREfk9tv7LuPFQZNxA0IjCBgTadc41R+m8Scqh3l+64ZRugKChT
	hDJfA/3Eo/q5yZi51pAWj0uO1dI60hyO4aGmhv3iYlbfXOWTvj+TJZWpIHcGOFSL44AbGEEDvCONW
	qp/Beiya2z15Mzlb186A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPofr-00009o-DD; Sat, 18 Apr 2020 14:42:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jPof3-0007xI-OW
 for linux-nvme@lists.infradead.org; Sat, 18 Apr 2020 14:41:46 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1A2E21974;
 Sat, 18 Apr 2020 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587220896;
 bh=00ddRN8yKxFktcawj18Tti3yNrlFwEtVI74FidDtGrE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1bfIXMn4sCYcuaXcIlV30SmUhwZ7Qv8XeZ/XQjWPgE8jwBm2x/D6llPpVjJoKh+XZ
 Jxgr/C4VgeJNhZ9NUuTr4oq7n6U7yY/pfJ5TitYIjmvgBpJNpq7O/LKlHbWKxoWPJ7
 nDcFtWHXj09bBLDfw0aKGlZ+wx3k91vKKm79FF+E=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 38/78] nvme: fix compat address handling in
 several ioctls
Date: Sat, 18 Apr 2020 10:40:07 -0400
Message-Id: <20200418144047.9013-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200418_074137_878292_9836AB47 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: Nick Bowler <nbowler@draconx.ca>, Sasha Levin <sashal@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Nick Bowler <nbowler@draconx.ca>

[ Upstream commit c95b708d5fa65b4e51f088ee077d127fd5a57b70 ]

On a 32-bit kernel, the upper bits of userspace addresses passed via
various ioctls are silently ignored by the nvme driver.

However on a 64-bit kernel running a compat task, these upper bits are
not ignored and are in fact required to be zero for the ioctls to work.

Unfortunately, this difference matters.  32-bit smartctl submits the
NVME_IOCTL_ADMIN_CMD ioctl with garbage in these upper bits because it
seems the pointer value it puts into the nvme_passthru_cmd structure is
sign extended.  This works fine on 32-bit kernels but fails on a 64-bit
one because (at least on my setup) the addresses smartctl uses are
consistently above 2G.  For example:

  # smartctl -x /dev/nvme0n1
  smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.5.11] (local build)
  Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.org

  Read NVMe Identify Controller failed: NVME_IOCTL_ADMIN_CMD: Bad address

Since changing 32-bit kernels to actually check all of the submitted
address bits now would break existing userspace, this patch fixes the
compat problem by explicitly zeroing the upper bits in the compat case.
This enables 32-bit smartctl to work on a 64-bit kernel.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b8fe42f4b3c5b..f97c48fd3edae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -6,6 +6,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/hdreg.h>
@@ -1244,6 +1245,18 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
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
+	return (void __user *)ptrval;
+}
+
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
@@ -1267,7 +1280,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	length = (io.nblocks + 1) << ns->lba_shift;
 	meta_len = (io.nblocks + 1) * ns->ms;
-	metadata = (void __user *)(uintptr_t)io.metadata;
+	metadata = nvme_to_user_ptr(io.metadata);
 
 	if (ns->ext) {
 		length += meta_len;
@@ -1290,7 +1303,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
 	return nvme_submit_user_cmd(ns->queue, &c,
-			(void __user *)(uintptr_t)io.addr, length,
+			nvme_to_user_ptr(io.addr), length,
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
 }
 
@@ -1410,9 +1423,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
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
@@ -1457,8 +1470,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata_len,
+			nvme_to_user_ptr(cmd.addr), cmd.data_len,
+			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
 			0, &cmd.result, timeout);
 	nvme_passthru_end(ctrl, effects);
 
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
