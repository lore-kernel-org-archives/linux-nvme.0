Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F2C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:08:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD58820823
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZT1IADVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD58820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AMEWPNZsmENrTTHEJtXhVb7IVPCuhv41JHgrvv8TfNQ=; b=ZT1IADVt8Qm0ZO
	L5Mvjas38Y+n2KjgjyX52dfMkvbSQ+47Fe4oXgQCGyS1tHdyEjVQOHLwOahLcGtU9B2NKS0ekgyYw
	4OPP7bV0yB9x2+Rgm3IFNLYOtQVQpSVOobKa6aBfAeCc+cAoZ58Jhh327j3/TxTIvsldpsTDhf0pb
	BjNeN2qa+2kshJHHs2pGwO9qlVhTOaY1U016L7g/8deCdddf7i16AdZHmymETYrD2rztl7aI+mBo4
	MWr/0vH2g8/F/o+SaKFGwnWEjBXHAe2WOuV42y6G1f5AATO9lGedsEBECCB7j0LZfCaXYmfyGvpKC
	Z8FY4VlOFq3DNQAJBCxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb2uU-0002wd-PK; Tue, 19 May 2020 14:07:58 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2so-0001QB-RJ
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 14:06:24 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 19 May 2020 17:06:04 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04JE63xl006590;
 Tue, 19 May 2020 17:06:03 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, jsmart2021@gmail.com,
 axboe@kernel.dk
Subject: [PATCH 04/16] nvme: make nvme_ns_has_pi accessible to transports
Date: Tue, 19 May 2020 17:05:51 +0300
Message-Id: <20200519140603.166576-5-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519140603.166576-1-maxg@mellanox.com>
References: <20200519140603.166576-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_070615_331384_B72E98B4 
X-CRM114-Status: UNSURE (   8.24  )
X-CRM114-Notice: Please train this message.
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 idanb@mellanox.com, oren@mellanox.com, Max Gurtovoy <maxg@mellanox.com>,
 nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: James Smart <jsmart2021@gmail.com>

Move the nvme_ns_has_pi() inline from core.c to the nvme.h header.
This allows use by the transports.

Signed-off-by: James Smart <jsmart2021@gmail.com>
[maxg: added a comment for nvme_ns_has_pi()]
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/host/core.c | 6 ------
 drivers/nvme/host/nvme.h | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cbab79d..99a877a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -19,7 +19,6 @@
 #include <linux/pr.h>
 #include <linux/ptrace.h>
 #include <linux/nvme_ioctl.h>
-#include <linux/t10-pi.h>
 #include <linux/pm_qos.h>
 #include <asm/unaligned.h>
 
@@ -204,11 +203,6 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	nvme_put_ctrl(ctrl);
 }
 
-static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
-{
-	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
-}
-
 static blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0dda145..0f5fa85 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -16,6 +16,7 @@
 #include <linux/fault-inject.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
+#include <linux/t10-pi.h>
 
 #include <trace/events/block.h>
 
@@ -399,6 +400,12 @@ struct nvme_ns {
 
 };
 
+/* NVMe ns supports metadata actions by the controller (generate/strip) */
+static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
+{
+	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
+}
+
 struct nvme_ctrl_ops {
 	const char *name;
 	struct module *module;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
