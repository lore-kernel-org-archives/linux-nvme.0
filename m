Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEF2C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6046A21531
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pRmGALY+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UCrr1SMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6046A21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rbAbc/RlRISuwtwSz/kLq2p6iNo9icji5Q0Ug2W/qjA=; b=pRmGALY+WhILaAJNgqfSEY6DM
	tQyJZtN6O+o+ek6wqJICO0fCp2NEFq/Mg/fREx/cA2/qoBAH02h86taxfUNu7s+qge2DVEk8Qcb6c
	ujTK0ubDszj+yvqY1tQRwC9leWKGTsI4RTPZoXkb2pd124gWw3nbcJsZovgCDJSYAb6DWZcOhm3rB
	AAXG5/EQCMM0lTxRFdEaUJ3uTZUCvscwuzbV882GNF48NO8vb/Khx/qz7zje0tYf5Jtb2TGocCRCU
	YmbFDztyAS9RUAY5mIn1lupkrK0FLVlTjQUhETPlfiBETf2k3KdCpsbqvqB1XO4l+qJP6SvyXrW6+
	MUFZocdWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNA-0002Mc-Kl; Mon, 28 Sep 2020 12:35:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN6-0002L0-Dk
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=pHs8BJ1hphjco9K/nOO43qsCs2Y/JXjuLrYyHJvh5PQ=; b=UCrr1SMGP6lZiCfLBga1I0W3/S
 C4Re21kS548EBLmlSMxGygMCXZWjw8OkQ9o2vyWwCWJmytEIJYZ1AMMow3SItB+xzYPdhHH/yKEuU
 k1s/PcF6bdEgQp9UVDQwePj89cne/NCdMdrvo1Zw5zCMgGyI+s7/oeRpmBdtSBWAhy5SKFstvg6Wk
 3LjsmMorOkkL/HSLY6/d9g1GRzxFaX8+9GK1X1DaSt17IdqEkN4S6FXOIqzWGu+7ymSmofk7bxwpo
 1ET+3IsPieq/+5kov4d5ypPJsMbizDWrWPeawGF1vStdxa3Obe3t0DHDsjQ29YlYKVCK9f1tG+/RE
 BI901C8w==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN5-0004iB-9O; Mon, 28 Sep 2020 12:35:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 05/20] nvme: rename _nvme_revalidate_disk
Date: Mon, 28 Sep 2020 14:34:47 +0200
Message-Id: <20200928123502.435373-6-hch@lst.de>
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

Rename _nvme_revalidate_disk to nvme_validate_ns to better describe
what the function does, and pass the struct nvme_ns instead of the
gendisk to better match the call chain.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5f2615bf58374..c04043a94e6496 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -89,7 +89,7 @@ static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
-static int _nvme_revalidate_disk(struct gendisk *disk);
+static int nvme_validate_ns(struct nvme_ns *ns);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
@@ -1026,7 +1026,7 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		if (_nvme_revalidate_disk(ns->disk))
+		if (nvme_validate_ns(ns))
 			nvme_set_queue_dying(ns);
 		else if (blk_queue_is_zoned(ns->disk->queue)) {
 			/*
@@ -2154,16 +2154,15 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	return 0;
 }
 
-static int _nvme_revalidate_disk(struct gendisk *disk)
+static int nvme_validate_ns(struct nvme_ns *ns)
 {
-	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_id_ns *id;
 	struct nvme_ns_ids ids;
 	int ret = 0;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
-		set_capacity(disk, 0);
+		set_capacity(ns->disk, 0);
 		return -ENODEV;
 	}
 
@@ -2187,7 +2186,7 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
 		goto free_id;
 	}
 
-	ret = __nvme_revalidate_disk(disk, id);
+	ret = __nvme_revalidate_disk(ns->disk, id);
 free_id:
 	kfree(id);
 out:
@@ -4032,7 +4031,7 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		return;
 	}
 
-	ret = _nvme_revalidate_disk(ns->disk);
+	ret = nvme_validate_ns(ns);
 	if (!ret && blk_queue_is_zoned(ns->queue))
 		ret = nvme_revalidate_zones(ns);
 	revalidate_disk_size(ns->disk, ret == 0);
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
