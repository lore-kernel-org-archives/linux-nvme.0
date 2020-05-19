Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E109C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:07:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D12820829
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K58N4CMZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WHCEXdbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D12820829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M5kphLUDGUgDRYzSaxcm8yHQHGna6C8A4Ed2yZnJXEY=; b=K58N4CMZBQu/47
	Nl9dpUFUlboi/s5IThTnSSUt6B3lRlyojcvy48Cav83gplKzgECN3akvtpn7bO0EXpInDZxCD4wex
	opyup4j9bvQK9NY18uvsC1iJihV9Fyii6ZaUoaDzok2TL9Hn7IIP+Xrp3g1oMbb3bISOIxTYcnZCR
	uLuUOYXpFZZM4XENgl/36Uq8dUt9teKeiW7zINGNmIDvX2N6voeQYnAegPqckIk50Z6xhBNLw8Zhd
	Y/2gvfR7j5YA7bWaaP6m34RIycqOQEj12/l+X6QcCzoTpbEU9QvK6kEhu/lqQHYAAB08Va9ChWwLh
	Q2eAgvfdA9jUstImKcMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb2uI-0002lL-RL; Tue, 19 May 2020 14:07:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2t0-0001cr-HH
 for linux-nvme@bombadil.infradead.org; Tue, 19 May 2020 14:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=K7dNSDMcYIrVV7R7vfQvAHP0pUQsZVq8us3tweGeUnw=; b=WHCEXdbe9nnTRJ/RbIxPdMF/Xl
 lcGIUR6bLorHJaS1tWSzJICQOSx+vHPOu/qECwTZWg0W7Lq5U+gyq6+FbgBY00M5+TWULKEV3I+AZ
 O2pF2uZ5iiAFRw8CV8yzlG8BlxkWAvnSjOvToArS0JtvosJcPM84sj8NWs1VOd9/d4HriIQd0beyK
 1Bk6DZLpS04SRSkxMZx/W+j6wWnFkQtErwCe+rwpEw16tOzdm1o+vbYOSpv8qzX2yH26q1xLPLiAF
 zu4wVRyXea33dlGD+AC88wwsvaS+DEsrU2sfpMR0somIRsZbjXVyoJta1p1utVLS7SOhpk40Rd32v
 55FhqnDg==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2so-0004WX-G5
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 14:06:25 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 19 May 2020 17:06:03 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04JE63xj006590;
 Tue, 19 May 2020 17:06:03 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, jsmart2021@gmail.com,
 axboe@kernel.dk
Subject: [PATCH 02/16] nvme: introduce namespace features flag
Date: Tue, 19 May 2020 17:05:49 +0300
Message-Id: <20200519140603.166576-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519140603.166576-1-maxg@mellanox.com>
References: <20200519140603.166576-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_150616_190272_B0FBC9D2 
X-CRM114-Status: GOOD (  13.84  )
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
 James Smart <james.smart@broadcom.com>, idanb@mellanox.com, oren@mellanox.com,
 Max Gurtovoy <maxg@mellanox.com>, nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Replace the specific ext boolean (that implies on extended LBA format)
with a feature in the new namespace features flag. This is a preparation
for adding more namespace features (such as metadata specific features).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/host/core.c     | 8 +++++---
 drivers/nvme/host/lightnvm.c | 5 ++++-
 drivers/nvme/host/nvme.h     | 6 +++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 805d289..e6487bf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1302,7 +1302,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = nvme_to_user_ptr(io.metadata);
 
-	if (ns->ext) {
+	if (ns->features & NVME_NS_EXT_LBAS) {
 		length += meta_len;
 		meta_len = 0;
 	} else if (meta_len) {
@@ -1882,7 +1882,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	if (ns->ms && !ns->ext &&
+	if (ns->ms && !(ns->features & NVME_NS_EXT_LBAS) &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
 	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
@@ -1921,8 +1921,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	else
 		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
 
+	ns->features = 0;
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+	if (ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT))
+		ns->features |= NVME_NS_EXT_LBAS;
 	/* the PI implementation requires metadata equal t10 pi tuple size */
 	if (ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index ec46693..98fffac 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -961,7 +961,10 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	geo = &dev->geo;
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
-	geo->ext = ns->ext;
+	if (ns->features & NVME_NS_EXT_LBAS)
+		geo->ext = true;
+	else
+		geo->ext = false;
 	geo->mdts = ns->ctrl->max_hw_sectors;
 
 	dev->q = q;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3ab177..110577c7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -364,6 +364,10 @@ struct nvme_ns_head {
 #endif
 };
 
+enum nvme_ns_features {
+	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
+};
+
 struct nvme_ns {
 	struct list_head list;
 
@@ -383,8 +387,8 @@ struct nvme_ns {
 	u16 ms;
 	u16 sgs;
 	u32 sws;
-	bool ext;
 	u8 pi_type;
+	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
