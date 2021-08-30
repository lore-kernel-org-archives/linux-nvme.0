Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F1BC432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E057460C3F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E057460C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DBR075HHtGOo74nhHpV310L8v59ZgykwBzkXtgQWTC8=; b=iU/U4jDQaonQsm
	CWVlZnVh+Q5mlclU+GnF+VleZb/NPoI1S/C9969cwxBp7wSHc/q090BqnU0byN1+qHqsFpQMlnhVZ
	ll3ffnwUM0dj6TpBVZjCYih6ONCpT03WLYXjn0/TLI7UjxwIp+lAG88Sv5WkoBLYnxau+Yp6jpK+C
	XwI9Qau/vS8EaZ8uvwhIBq/KAEcuu6LoYkO4N+u3rvUo387RKH+KKCRmTE/KqBDeK9rcSViYdXmDk
	cwDdPAsKPLfZAO1NwK5pzoLDoLpT9/EBdQ3DliZOQ2TbQyYgQDPxA9iL+JAmg0aXmDC234AkmfGRD
	XPg7GU6wQwBN3d5huSBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKooI-000dRx-Mz; Mon, 30 Aug 2021 21:27:18 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mKomk-000ciC-Ls; Mon, 30 Aug 2021 21:25:42 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com
Cc: hch@infradead.org, hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 4/8] mmc/core/block: add error handling support for
 add_disk()
Date: Mon, 30 Aug 2021 14:25:34 -0700
Message-Id: <20210830212538.148729-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830212538.148729-1-mcgrof@kernel.org>
References: <20210830212538.148729-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

The caller only cleanups the disk if we pass on an allocated md
but on error we return return ERR_PTR(ret), and so we must do all
the unwinding ourselves.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/mmc/core/block.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 6a15fdf6e5f2..9b2856aa6231 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2453,9 +2453,14 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	/* used in ->open, must be set before add_disk: */
 	if (area_type == MMC_BLK_DATA_AREA_MAIN)
 		dev_set_drvdata(&card->dev, md);
-	device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
+	ret = device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
+	if (ret)
+		goto err_cleanup_queue;
 	return md;
 
+ err_cleanup_queue:
+	blk_cleanup_queue(md->disk->queue);
+	blk_mq_free_tag_set(&md->queue.tag_set);
  err_kfree:
 	kfree(md);
  out:
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
