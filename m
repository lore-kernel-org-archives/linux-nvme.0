Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448D1C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0F521531
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="umAKWvNd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PupR57iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0F521531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XjIGGI9HsGjg+VuPTxpew7p7yHCIfLcEGW2mXsPjW7Y=; b=umAKWvNdHbcQik7O+CRdocRTi
	zednLbErF1ZlRj06eM6qUXgKgWVeXiNJ7SYdEcWIeSLS9RNTZPUQzXNIQqjo08E2ltbAq5cKPphAF
	ZEPR/R216hSmUZKU/PMLSEMXUejSlAMgMT/iWbOukFIm+G87k50kIz83MGt9RaxFCBi4KfGntEFGh
	6Ua/hMd5L5AeXPdNuhLA0MUuxXIX3eR9r8viEdZcrusxutacvQ2Ot/Tl2yojtmy9ZarAGoU2b7X4Y
	chPxpTgc7WnaRyFS33yHVyCl6WaG3ZbIvjqPAZPyQBKB2ln60vdFR43qmHOnJEBXtXZ6B28S8aw+I
	0lyBMU1rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNs-0002hE-8S; Mon, 28 Sep 2020 12:36:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNM-0002RL-MY
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=rUN+t35Dwqzu4F0DT4QoXyImEWnQdBoyF9ICCCun3Ts=; b=PupR57izBWBfJW2No8wEeU9LWz
 JQ1+vcasjqL+6Pk+EeMDi8W9FDO20FAp7yFmvWMPUP8Nk8LTG8IKrGm+7e+ZwAb7deqhgDLiYnFpM
 v+CSGUzsKJTgrL5F/h2/J/oxnnQjRG07l1V9BijPRXS/Ru3mhQIQU3huEaWt3EZwyRNhCFGhAw1oz
 xUZDuKTcLQ50j2BI2lVkV9jWzKY7HnQjG+DI9bKfWph/CHf87PBzW6EevKcO8mIajEKnodQYF8iDG
 BN0445ZqY+mbwJQJqHFzSe8u0B0rvq4Cr/URNyNUG31aJJL7OhDs8KlLT4/rUo9KGmZW7ZjHjnjcW
 bNNEzjgQ==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNL-0004mC-FW; Mon, 28 Sep 2020 12:35:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 16/20] nvme: revalidate zone bitmaps in nvme_update_ns_info
Date: Mon, 28 Sep 2020 14:34:58 +0200
Message-Id: <20200928123502.435373-17-hch@lst.de>
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

Consolidate the two calls into a single place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f19f6c7c5b1242..9c137d8819f756 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2150,6 +2150,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	nvme_update_disk_info(ns->disk, ns, id);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
+	if (blk_queue_is_zoned(ns->queue)) {
+		ret = nvme_revalidate_zones(ns);
+		if (ret)
+			return ret;
+	}
+
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
@@ -3915,8 +3921,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	if (nvme_update_ns_info(ns, id))
 		goto out_put_disk;
-	if (blk_queue_is_zoned(ns->queue) && nvme_revalidate_zones(ns))
-		goto out_put_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		ret = nvme_nvm_register(ns, disk_name, node);
@@ -4012,8 +4016,6 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 
 	ret = nvme_validate_ns(ns);
-	if (!ret && blk_queue_is_zoned(ns->queue))
-		ret = nvme_revalidate_zones(ns);
 	revalidate_disk_size(ns->disk, ret == 0);
 	if (ret)
 		nvme_ns_remove(ns);
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
