Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9419CC83006
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:12:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED24206A1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mm0Kth00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED24206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zFTEaqDKvtIN2Xn+nbKSWOHEqjGPsi344M9ZkzrCxCc=; b=mm0Kth00ScCT2K
	fJgrtJ5qzxEARdre1IRx5ex1/kPW+9AjeLdPfPi2OGuIMl73ifwootH0WfJgVvprpID1OuajAzoex
	np9KIUow3+gJIjeba58A4LaJNiHPldO58bgFlzbMp7gKFeer7DG/DK71yZueVxsejurTtCQ0Snp6B
	Xy65C1zOgerV7Pq7vItiQoqdMlBhnemWvlijJEyfFsdst8zql4FMs0dZK6TQ1sSKO/hbWNass/CjM
	VmsTghXvV3GdHgv66DPa9yxUF9trjowUzJgKdhpzHylN/auSVy6i193eS7M6tooxLLDEiIl81oVmv
	U9rr2zhz6/NpM0T+egPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTQ2C-0003q1-9p; Tue, 28 Apr 2020 13:12:24 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTQ1Y-0003I1-Rd
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 13:11:48 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 28 Apr 2020 16:11:36 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 03SDBZYu028635;
 Tue, 28 Apr 2020 16:11:36 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 01/15] nvme: introduce namespace features flag
Date: Tue, 28 Apr 2020 16:11:21 +0300
Message-Id: <20200428131135.211521-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200428131135.211521-1-maxg@mellanox.com>
References: <20200428131135.211521-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_061145_299861_DE778135 
X-CRM114-Status: UNSURE (   8.64  )
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
 idanb@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Replace the specific ext boolean (that implies on extended LBA format)
with a feature in the new namespace features flag. This is a preparation
for adding more namespace features (such as metadata specific features).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 8 +++++---
 drivers/nvme/host/nvme.h | 6 +++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfb064b4..02130d3 100644
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
@@ -1880,7 +1880,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	if (ns->ms && !ns->ext &&
+	if (ns->ms && !(ns->features & NVME_NS_EXT_LBAS) &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
 	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
@@ -1919,8 +1919,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
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
