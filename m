Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2ACC4727F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2732D21974
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n2S154aC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+pFQgbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2732D21974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fu84gpbo5sgNL7FqFhVVPkGz4CBKafguGKjzBtzCWDo=; b=n2S154aC1G+QQa1sCxApJc5nf
	HrqOiIJsueK9KZ+g1mtJtYwZf8vzHWo/tV1eBtqlJId+IeqM6hQYGyqDbvLkiL3rVosZpAArIbkwB
	LrvVgDTNI480iDCEaTH5IuBbPpGRDSAEZvv2bgHW0cEzhuI5w1m50efifoGJb7CxOJV94dH2OGy1y
	nw2Cgo8Hr+UVSfwEAGUEzpm/+osoH2bTcNOxM9PYWnKQ4ACCBxFpB/L8mK8hmqpkLITvzVnZ7qgIR
	yX+GZv7/Wu9cSUBU6qxUkySXtpCRbDDA3iyPMsKxtHZHGfCWpTDH55eoN9gj0xzxWWzzrs4GCfxe/
	BIfLbqHAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNC-0002NY-TJ; Mon, 28 Sep 2020 12:35:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN7-0002LP-Se
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=DhRQxAh8/nzLB1gilm9CNLyzkDme0r95DID2oSGGKo0=; b=S+pFQgbX/Bx0Nv/cXNdxh32yau
 /nYdqp7u/VAlfH4DdyYrICM0shCkKYOT7THE5aqpUl6lM7kB7qjEfe6j9Nnk83ginYennuhBAcYWU
 +5cJT0R6LjGsxzwsLHikTv2nlhq+kL/e1VUsIFERNlBo+MfEBIWxZkTw4vj7dAMbVAH89ai+NZQYj
 ocazTS+h/K89DhAdmRsxZIxlIk9zG5zD2RhdmYXUuqte9FUbTynA6ZzWX85x3jgPOqUmJg/ZAYm3O
 rQk2TK5AlvIdONiY+WLyeFiFFlr3MdnaSn00G5f0lvcQoogVBMkdTXtq/sHGhAkp9duNAdZ5h5r2z
 XUGhP5IA==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN6-0004iO-Hi; Mon, 28 Sep 2020 12:35:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 06/20] nvme: rename __nvme_revalidate_disk
Date: Mon, 28 Sep 2020 14:34:48 +0200
Message-Id: <20200928123502.435373-7-hch@lst.de>
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

Rename __nvme_revalidate_disk to nvme_update_ns_info and pass a
namespace instead of the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c04043a94e6496..fede487f6e043f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2076,10 +2076,9 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 	blk_queue_chunk_sectors(ns->queue, iob);
 }
 
-static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
+static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
-	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
 
@@ -2141,7 +2140,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	}
 
 	nvme_set_chunk_sectors(ns, id);
-	nvme_update_disk_info(disk, ns, id);
+	nvme_update_disk_info(ns->disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
@@ -2186,7 +2185,7 @@ static int nvme_validate_ns(struct nvme_ns *ns)
 		goto free_id;
 	}
 
-	ret = __nvme_revalidate_disk(ns->disk, id);
+	ret = nvme_update_ns_info(ns, id);
 free_id:
 	kfree(id);
 out:
@@ -3933,7 +3932,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	if (__nvme_revalidate_disk(disk, id))
+	if (nvme_update_ns_info(ns, id))
 		goto out_put_disk;
 	if (blk_queue_is_zoned(ns->queue) && nvme_revalidate_zones(ns))
 		goto out_put_disk;
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
