Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33398C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED02D610E8
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED02D610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hsYRy5mW2eSZFEqOw8JTWcpX/S1jq2Dljgzx3k3VBB0=; b=RPftnZxfbvD3dLxBM84VHFHMzn
	sxgTm8qjmgPQdt2ZcXi9HJ5NoxMSp2PB3jClkzPFnyJG0uqbgfxz8GvEYshYpfcifJVbPXbgVAQM6
	bZCG7HhjDmJeDtHyFhhxIo1SOKPv9KpHCovbLJvlCbQju0YJkzk7VQCsE35eCmuOTqKbixiALgjw4
	TOIeSvyHzyKDht409F2hwOcMMO2ur/TAyqqa/CTGYP4UWvdn6QnW9+VC1+H4qxnDgQfLsfeHxOZFM
	peq/EYLn7VnuDkpvMdvDgaghY2OgrT9I03PggFp9vm65b0XsTKWE1m0/BDkc2aG3QSa7vL7YyxIOV
	4TwAxsEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbXN5-009KJr-Fc; Sat, 16 Oct 2021 00:16:19 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mbWzt-009C35-5A; Fri, 15 Oct 2021 23:52:21 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
 richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 06/13] nvdimm/blk: avoid calling del_gendisk() on early
 failures
Date: Fri, 15 Oct 2021 16:52:12 -0700
Message-Id: <20211015235219.2191207-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If nd_integrity_init() fails we'd get del_gendisk() called,
but that's not correct as we should only call that if we're
done with device_add_disk(). Fix this by providing unwinding
prior to the devm call being registered and moving the devm
registration to the very end.

This should fix calling del_gendisk() if nd_integrity_init()
fails. I only spotted this issue through code inspection. It
does not fix any real world bug.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvdimm/blk.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 088d3dd6f6fa..591fa1f86f1e 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -240,6 +240,7 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	resource_size_t available_disk_size;
 	struct gendisk *disk;
 	u64 internal_nlba;
+	int rc;
 
 	internal_nlba = div_u64(nsblk->size, nsblk_internal_lbasize(nsblk));
 	available_disk_size = internal_nlba * nsblk_sector_size(nsblk);
@@ -256,20 +257,26 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	blk_queue_logical_block_size(disk->queue, nsblk_sector_size(nsblk));
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 
-	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
-		return -ENOMEM;
-
 	if (nsblk_meta_size(nsblk)) {
-		int rc = nd_integrity_init(disk, nsblk_meta_size(nsblk));
+		rc = nd_integrity_init(disk, nsblk_meta_size(nsblk));
 
 		if (rc)
-			return rc;
+			goto out_before_devm_err;
 	}
 
 	set_capacity(disk, available_disk_size >> SECTOR_SHIFT);
 	device_add_disk(dev, disk, NULL);
+
+	/* nd_blk_release_disk() is called if this fails */
+	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
+		return -ENOMEM;
+
 	nvdimm_check_and_set_ro(disk);
 	return 0;
+
+out_before_devm_err:
+	blk_cleanup_disk(disk);
+	return rc;
 }
 
 static int nd_blk_probe(struct device *dev)
-- 
2.30.2


