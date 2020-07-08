Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ABCC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 14:42:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4803920786
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 14:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFG3VeDz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsfjWXjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4803920786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IXylllybyr5BUyjywYm+Yf2o6YTXhEQ7R5TrckuB6X4=; b=rFG3VeDzPE1QUXmwQidDYZPspe
	5WTwPUxfePnE2xPCDgXrDBwBu1oGHO3QRdP/OeaqBbpFE3gkIv13IG80Sm/1XmzKbLTb/vRSTfU2d
	XYxYbVQ0zu6eJzPfSLPM3q8svwEAcE8eIJt6hdClN1sbD29rGmj5B3ueuu9llD3m/VTkEiXsEDMhw
	QFEHSv2Ffva324JYYJXCKY0H4YoqYLs3XHP3uXZPECupEvJqSr6OauzNg+d5y2kaZPIbur7UyEpa5
	Z7bFsPrEu/hMSGx4wNOyTnxi1crDPlI0NaMwiqJI0sqr3/B0BG3GSIgN48/d/RMpAW0Ss+m0PMZ8x
	bDN3TGsA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtBHa-0008IX-WF; Wed, 08 Jul 2020 14:42:47 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtBHZ-0008II-IR
 for linux-nvme@merlin.infradead.org; Wed, 08 Jul 2020 14:42:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=ubE+NIFcPbjJVh6IDuLRCuB1ypSjZjXWDenD8BFrGHQ=; b=dsfjWXjlucrLuLspesbPyGvMF/
 pL+SMESxk1ViBAZLJcDYLSAiGyLO3+AARz0ELKDS3XuZYzkXYihSpL/fZ3XpQGzFpoierf840m2cC
 8QpKtVvDCYfhCTI5gK31UXEsx10rS7KfVOkGhQ12nVuJ7kbeGQ+XxUJ17I21t4R/Y4P/V/iRb76P7
 zRMD2BWQDyTlP+uA9t5wXMgqp9pm7K5eUuy4ooCe3fCaGfCO7ePdfBctwoPe62tjQxP/myl4cujUR
 Fc7TlcLXmpTbxWhoQqE1uEFbiFFmpVKvqUBDkqYtfD1lSVkdCZT+lq8iSeeAtHoL3J0/y+3DuJJ7Q
 dlIl+gxw==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtBHG-00006y-B3; Wed, 08 Jul 2020 14:42:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Subject: [PATCH] nvme: remove ns->disk checks
Date: Wed,  8 Jul 2020 16:40:15 +0200
Message-Id: <20200708144015.315108-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

By the time a namespace is added to ctrl->namespaces list and thus
can be looked up ns->disk has been assigned, and it it never cleared.

Remove all the checks for ns->disk being NULL.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4aaffc4fa150b0..3d00ea4e7146ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -100,7 +100,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	 * Revalidating a dead namespace sets capacity to 0. This will end
 	 * buffered writers dirtying pages that can't be synced.
 	 */
-	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
 	blk_set_queue_dying(ns->queue);
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
@@ -1429,7 +1429,7 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		if (ns->disk && _nvme_revalidate_disk(ns->disk))
+		if (_nvme_revalidate_disk(ns->disk))
 			nvme_set_queue_dying(ns);
 		else if (blk_queue_is_zoned(ns->disk->queue)) {
 			/*
@@ -3933,7 +3933,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_mpath_clear_current_path(ns);
 	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
 
-	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
+	if (ns->disk->flags & GENHD_FL_UP) {
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 		if (blk_get_integrity(ns->disk))
@@ -3964,7 +3964,7 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		if (ns->disk && revalidate_disk(ns->disk))
+		if (revalidate_disk(ns->disk))
 			nvme_ns_remove(ns);
 		nvme_put_ns(ns);
 	} else
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
