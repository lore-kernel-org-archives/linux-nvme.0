Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD46C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8785D2158C
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S5zOBop0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BOkB+bhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785D2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rhyWLKFC+wn/YEm309HSPzpEEtWZzdT5qU/nPkdEXRk=; b=S5zOBop01GM2Oux90kqCub6AP
	VsiDycFXikEKuifZTJ54C0J0H861huPb55KpQ4TwOZDhbyDmGEdbCgtYK69G0h6qIdyioXvps04Ps
	fWVFC9F+o2TxAsV/wOno2zyyMARfuevagaGsNJ2gNXVeWKiIROC40Eh1SC4rfhBMM1c3NgaiKvmvj
	+mbF2VSDTo6oQOG+wu6QIt5aOT2i6F1KbJCr0thTV3v1h5pk/FwYWH+hnP7IFX0zqgj0ythBk8Aqt
	qUIyBu26oLIftQkKX0fPNpYHqB5N5IZU72ayZNm4tmG1ZWVLwzjcYTQk0oqTWN4owmjQtMeRMSoPS
	bBALkfJug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNw-0002jW-Kd; Mon, 28 Sep 2020 12:36:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNO-0002SL-4g
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=vUlomKZl4OWnDg4MlqoAURc4w8LFwDfACaldClVUS/8=; b=BOkB+bhJFnAeMVhlPBME4WEWzj
 GoPSzQ22kG4yhPFaBjDxpByVvCO9r2+x91cJeOHhUXYeLOwRnRSr1264f/NdCeaQFDH+AJja2oZyj
 xByqh0o1kMKKc4bqUry0Sy7xm4fa24mFmBjvTtvNOHRon2O88gJ9/6yjL760aCVXXPG2ma37VqM7u
 x7W6EYC/HYh762jvx6dTpDlmDPvhMe1Vi2SgYwf6Tm70TdlNVH6C17BuGx0XYpOWvyzdIWcHxrYzH
 S/BSJiteFZ6AgPI/2CTc2xr5vPuH9p+xuUujfTAWLxYL7e9jiPlSVv0+jsrTXIv8mBwt968SwoH8u
 0XmlnGsg==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNM-0004mU-MZ; Mon, 28 Sep 2020 12:35:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Date: Mon, 28 Sep 2020 14:34:59 +0200
Message-Id: <20200928123502.435373-18-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Check the namespace identifier list first thing when scanning namespaces.
This keeps the code to query the CSI common between the alloc and validate
path, and helps to structure the code better for multiple command set
support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 116 ++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 63 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9c137d8819f756..ad18c32b36e7b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1281,6 +1281,8 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	int status, pos, len;
 	void *data;
 
+	if (ctrl->vs < NVME_VS(1, 3, 0) && !nvme_multi_css(ctrl))
+		return 0;
 	if (ctrl->quirks & NVME_QUIRK_NO_NS_DESC_LIST)
 		return 0;
 
@@ -1335,8 +1337,8 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 				    NVME_IDENTIFY_DATA_SIZE);
 }
 
-static int nvme_identify_ns(struct nvme_ctrl *ctrl,
-		unsigned nsid, struct nvme_id_ns **id)
+static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+			struct nvme_ns_ids *ids, struct nvme_id_ns **id)
 {
 	struct nvme_command c = { };
 	int error;
@@ -1359,6 +1361,14 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
 	error = -ENODEV;
 	if ((*id)->ncap == 0) /* namespace not allocated or attached */
 		goto out_free_id;
+
+	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
+	    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
+		memcpy(ids->eui64, (*id)->eui64, sizeof(ids->eui64));
+	if (ctrl->vs >= NVME_VS(1, 2, 0) &&
+	    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+		memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
+
 	return 0;
 
 out_free_id:
@@ -1884,20 +1894,6 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 					   nvme_lba_to_sect(ns, max_blocks));
 }
 
-static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
-		struct nvme_id_ns *id, struct nvme_ns_ids *ids)
-{
-	memset(ids, 0, sizeof(*ids));
-
-	if (ctrl->vs >= NVME_VS(1, 1, 0))
-		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
-	if (ctrl->vs >= NVME_VS(1, 2, 0))
-		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
-	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
-		return nvme_identify_ns_descs(ctrl, nsid, ids);
-	return 0;
-}
-
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
 {
 	return !uuid_is_null(&ids->uuid) ||
@@ -2117,30 +2113,16 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->lba_shift = id->lbaf[lbaf].ds;
-	nvme_set_queue_limits(ctrl, ns->queue);
+	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	switch (ns->head->ids.csi) {
-	case NVME_CSI_NVM:
-		break;
-	case NVME_CSI_ZNS:
+	if (ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf);
-		if (ret) {
-			dev_warn(ctrl->device,
-				"failed to add zoned namespace:%u ret:%d\n",
-				ns->head->ns_id, ret);
+		if (ret)
 			goto out_unfreeze;
-		}
-		break;
-	default:
-		dev_warn(ctrl->device, "unknown csi:%u ns:%u\n",
-			ns->head->ids.csi, ns->head->ns_id);
-		ret = -ENODEV;
-		goto out_unfreeze;
 	}
 
 	ret = nvme_configure_metadata(ns, id);
@@ -2174,11 +2156,10 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return ret;
 }
 
-static int nvme_validate_ns(struct nvme_ns *ns)
+static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_id_ns *id;
-	struct nvme_ns_ids ids;
 	int ret = 0;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
@@ -2186,15 +2167,11 @@ static int nvme_validate_ns(struct nvme_ns *ns)
 		return -ENODEV;
 	}
 
-	ret = nvme_identify_ns(ctrl, ns->head->ns_id, &id);
+	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
 	if (ret)
 		goto out;
 
-	ret = nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
-	if (ret)
-		goto free_id;
-
-	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
+	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
 		dev_err(ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
 		ret = -ENODEV;
@@ -3794,25 +3771,16 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
-		struct nvme_id_ns *id)
+		struct nvme_ns_ids *ids, bool is_shared)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	bool is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 	struct nvme_ns_head *head = NULL;
-	struct nvme_ns_ids ids;
 	int ret = 0;
 
-	ret = nvme_report_ns_ids(ctrl, nsid, id, &ids);
-	if (ret) {
-		if (ret < 0)
-			return ret;
-		return blk_status_to_errno(nvme_error_status(ret));
-	}
-
 	mutex_lock(&ctrl->subsys->lock);
 	head = nvme_find_ns_head(ctrl->subsys, nsid);
 	if (!head) {
-		head = nvme_alloc_ns_head(ctrl, nsid, &ids);
+		head = nvme_alloc_ns_head(ctrl, nsid, ids);
 		if (IS_ERR(head)) {
 			ret = PTR_ERR(head);
 			goto out_unlock;
@@ -3825,7 +3793,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 				"Duplicate unshared namespace %d\n", nsid);
 			goto out_put_ns_head;
 		}
-		if (!nvme_ns_ids_equal(&head->ids, &ids)) {
+		if (!nvme_ns_ids_equal(&head->ids, ids)) {
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
 					nsid);
@@ -3873,7 +3841,8 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
-static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+		struct nvme_ns_ids *ids)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
@@ -3881,7 +3850,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	char disk_name[DISK_NAME_LEN];
 	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret;
 
-	if (nvme_identify_ns(ctrl, nsid, &id))
+	if (nvme_identify_ns(ctrl, nsid, ids, &id))
 		return;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
@@ -3903,7 +3872,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	ret = nvme_init_ns_head(ns, nsid, id);
+	ret = nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED);
 	if (ret)
 		goto out_free_queue;
 	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
@@ -4006,20 +3975,41 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 
 static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
+	struct nvme_ns_ids ids = { };
 	struct nvme_ns *ns;
 	int ret;
 
+	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
+		return;
+
 	ns = nvme_find_get_ns(ctrl, nsid);
-	if (!ns) {
-		nvme_alloc_ns(ctrl, nsid);
+	if (ns) {
+		ret = nvme_validate_ns(ns, &ids);
+		revalidate_disk_size(ns->disk, ret == 0);
+		if (ret)
+			nvme_ns_remove(ns);
+		nvme_put_ns(ns);
 		return;
 	}
 
-	ret = nvme_validate_ns(ns);
-	revalidate_disk_size(ns->disk, ret == 0);
-	if (ret)
-		nvme_ns_remove(ns);
-	nvme_put_ns(ns);
+	switch (ids.csi) {
+	case NVME_CSI_NVM:
+		nvme_alloc_ns(ctrl, nsid, &ids);
+		break;
+	case NVME_CSI_ZNS:
+		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+			dev_warn(ctrl->device,
+				"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
+				nsid);
+			break;
+		}
+		nvme_alloc_ns(ctrl, nsid, &ids);
+		break;
+	default:
+		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
+			ids.csi, nsid);
+		break;
+	}
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
