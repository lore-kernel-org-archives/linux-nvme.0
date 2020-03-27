Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA69C2D0ED
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:18:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB5A20578
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eWQ1eTbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB5A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8mJoR+vkP2+4+KxL+EIJx5vInL2Vu3bxO9kZdQUYZuo=; b=eWQ1eTbxssYgEm
	3DEVom6gX6PdfTimcrWAHrUS7GatLjq7Bo9rVG0bBS85J68nvwfbQss4M5oyjkAsJFirI0vuPiQim
	LQVtAW9I27tpB7BMMdA8fZPNf+MZBkzr0MQPsiH1vOhBFZkcUUnX6VCISwexCFXv/H12LjmzDpIrQ
	5S7ur2V/B2qyEM7LpYpAx8U6yAcAjjxwmWyfOD43wDkKUEh1eHHdgkvIR3edlQHyoC5f0TGed4BVK
	k54iIvQmYRbSCdO/cv4CQJsoLUaEbdxRZmqobZQbX7ccDfWe/6S6xNUwooOjCU61DmS0k9ttYNtd3
	QS5FNQXDYb7BIhjOD0pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHsc9-00018J-Pp; Fri, 27 Mar 2020 17:17:49 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaI-0007rZ-Um
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 17:16:03 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:48 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjjI004869;
 Fri, 27 Mar 2020 20:15:48 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
 linux-rdma@vger.kernel.org
Subject: [PATCH 15/17] nvmet: Add metadata support for block devices
Date: Fri, 27 Mar 2020 20:15:43 +0300
Message-Id: <20200327171545.98970-17-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_101555_487083_70D5C758 
X-CRM114-Status: GOOD (  10.81  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
 maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Create a block IO request for the metadata from the protection SG list.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 87 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2e9e309..018acd7 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -164,6 +164,61 @@ static void nvmet_bio_done(struct bio *bio)
 		bio_put(bio);
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
+				struct sg_mapping_iter *miter)
+{
+	struct blk_integrity *bi;
+	struct bio_integrity_payload *bip;
+	struct block_device *bdev = req->ns->bdev;
+	int rc;
+	size_t resid, len;
+
+	bi = bdev_get_integrity(bdev);
+	if (unlikely(!bi)) {
+		pr_err("Unable to locate bio_integrity\n");
+		return -ENODEV;
+	}
+
+	bip = bio_integrity_alloc(bio, GFP_NOIO,
+			min_t(unsigned int, req->md_sg_cnt, BIO_MAX_PAGES));
+	if (IS_ERR(bip)) {
+		pr_err("Unable to allocate bio_integrity_payload\n");
+		return PTR_ERR(bip);
+	}
+
+	bip->bip_iter.bi_size = bio_integrity_bytes(bi, bio_sectors(bio));
+	/* virtual start sector must be in integrity interval units */
+	bip_set_seed(bip, bio->bi_iter.bi_sector >>
+		     (bi->interval_exp - SECTOR_SHIFT));
+
+	resid = bip->bip_iter.bi_size;
+	while (resid > 0 && sg_miter_next(miter)) {
+		len = min_t(size_t, miter->length, resid);
+		rc = bio_integrity_add_page(bio, miter->page, len,
+					    offset_in_page(miter->addr));
+		if (unlikely(rc != len)) {
+			pr_err("bio_integrity_add_page() failed; %d\n", rc);
+			sg_miter_stop(miter);
+			return -ENOMEM;
+		}
+
+		resid -= len;
+		if (len < miter->length)
+			miter->consumed -= miter->length - len;
+	}
+	sg_miter_stop(miter);
+
+	return 0;
+}
+#else
+static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
+				struct sg_mapping_iter *miter)
+{
+	return 0;
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+
 static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
@@ -171,9 +226,11 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	struct scatterlist *sg;
 	struct blk_plug plug;
 	sector_t sector;
-	int op, i;
+	int op, i, rc;
+	struct sg_mapping_iter prot_miter;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req,
+				      nvmet_rw_data_len(req) + req->md_len))
 		return;
 
 	if (!req->sg_cnt) {
@@ -208,11 +265,25 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_opf = op;
 
 	blk_start_plug(&plug);
+	if (req->use_md)
+		sg_miter_start(&prot_miter, req->md_sg, req->md_sg_cnt,
+			       op == REQ_OP_READ ? SG_MITER_FROM_SG :
+						   SG_MITER_TO_SG);
+
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
 				!= sg->length) {
 			struct bio *prev = bio;
 
+			if (req->use_md) {
+				rc = nvmet_bdev_alloc_bip(req, bio,
+							  &prot_miter);
+				if (unlikely(rc)) {
+					bio_io_error(bio);
+					return;
+				}
+			}
+
 			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 			bio_set_dev(bio, req->ns->bdev);
 			bio->bi_iter.bi_sector = sector;
@@ -226,6 +297,14 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		sg_cnt--;
 	}
 
+	if (req->use_md) {
+		rc = nvmet_bdev_alloc_bip(req, bio, &prot_miter);
+		if (unlikely(rc)) {
+			bio_io_error(bio);
+			return;
+		}
+	}
+
 	submit_bio(bio);
 	blk_finish_plug(&plug);
 }
@@ -353,6 +432,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		req->execute = nvmet_bdev_execute_rw;
+		if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
+			req->use_md = true;
+			req->md_len = nvmet_rw_md_len(req);
+		}
 		return 0;
 	case nvme_cmd_flush:
 		req->execute = nvmet_bdev_execute_flush;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
