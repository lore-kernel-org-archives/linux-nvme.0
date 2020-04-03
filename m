Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF4EC2BA15
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 16:41:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2689206F8
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 16:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cgIYNV9h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpgKevrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2689206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vwV6yzltrb9mbV2g/J21KqwQ3P80Ci8cofY0ocSMVv4=; b=cgIYNV9h73Rdiz
	V/6CeMizWZLgmxgPPCnhNaS8Z15cTgtoByL6/CNfIKe7mUT/xXyF6sli4Et+5Iz35h83XOZ4ZNaru
	8VpEike8idckF9XM3oOS6YUiblsdXOKlXDIrghA+a7mM8KEUY8/bC84toMwO4dcX5Yyd79xxJ21b/
	H65jYOQmd7EpTEHl73DQF/t3c6EzMRzlwS1Wn37vN/kRopEGg0C3W5dbiwAjXaCm3E/Ek1yfQ/+Kz
	RXz+aVgbZFp2ENN/aBKbNKiX93ZIQlWNfLWVtQXshikFt6HRBVbqEgoU/32j/Dr7Yh+74b4zQveck
	rgOPaF99aJu+8AfAaHtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKPO0-0006wT-PV; Fri, 03 Apr 2020 16:41:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKPNy-0006w0-En
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 16:41:39 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B19A1206F5;
 Fri,  3 Apr 2020 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585932098;
 bh=26nhQ5pLEgK6/q7bUXwFTit0/q7ha+mcPk14LV+Myb0=;
 h=From:To:Cc:Subject:Date:From;
 b=HpgKevrb66qsw4S8iihxAiRMy5AAivuG5M3RVoYRhPJlDQPe83BXsmMeNdA5c+96q
 kqXPQW43NIE+0xC5slcevdinIX4kolJl83mtHx00+5M7ZJZP631dbAimzhM56sw2sl
 H/CUZAyW4F3yi4BwVS8ezJSwE5ydIkqtgXVx87iI=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme: define identification constant values
Date: Fri,  3 Apr 2020 09:41:35 -0700
Message-Id: <20200403164135.1482330-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200403_094138_515167_720B259D 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Improve code readability by defining the specification's constants the
driver uses to decode identification results.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 10 +++++-----
 include/linux/nvme.h     |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa3525ef06..75d12198833a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1824,7 +1824,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		 * and whether it should be used instead of AWUPF. If NAWUPF ==
 		 * 0 then AWUPF must be used instead.
 		 */
-		if (id->nsfeat & (1 << 1) && id->nawupf)
+		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
 			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
@@ -1833,7 +1833,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	}
 	phys_bs = bs;
 	io_opt = bs;
-	if (id->nsfeat & (1 << 4)) {
+	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs *= 1 + le16_to_cpu(id->npwg);
 		/* NOWS = Namespace Optimal Write Size */
@@ -1862,7 +1862,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
 
-	if (id->nsattr & (1 << 0))
+	if (id->nsattr & NVME_NS_ATTR_RO)
 		set_disk_ro(disk, true);
 	else
 		set_disk_ro(disk, false);
@@ -2655,7 +2655,7 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 			return false;
 		}
 
-		if ((id->cmic & (1 << 1)) ||
+		if ((id->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
 		    (ctrl->opts && ctrl->opts->discovery_nqn))
 			continue;
 
@@ -3468,7 +3468,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	bool is_shared = id->nmic & (1 << 0);
+	bool is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 	struct nvme_ns_head *head = NULL;
 	struct nvme_ns_ids ids;
 	int ret = 0;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d5189f46cb1..23536c3acaae 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -299,6 +299,7 @@ struct nvme_id_ctrl {
 };
 
 enum {
+	NVME_CTRL_CMIC_MULTI_CTRL		= 1 << 1,
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
@@ -394,8 +395,12 @@ enum {
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
+	NVME_NS_FEAT_ATOMICS	= 1 << 1,
+	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
+	NVME_NS_NMIC_SHARED	= 1 << 0,
 	NVME_LBAF_RP_BEST	= 0,
 	NVME_LBAF_RP_BETTER	= 1,
 	NVME_LBAF_RP_GOOD	= 2,
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
