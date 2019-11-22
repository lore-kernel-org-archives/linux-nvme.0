Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C544DC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 05:55:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9995F20659
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 05:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PV4D9rka";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDkCmR+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9995F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MjCcPv0OBdJ6qTRCzqPuPScQV7K9oxT56y7NuLfpInk=; b=PV4D9rkaV8Wjxc
	owdfmhWY8M3s2LKpbBXZL6CVUiB2gpsWup6i9pbidCBIRh0SSZrYfDEt4QPn9u03e+DGmtrooMgTq
	LmS/65M1FIgsQvi0Di03yGUdeszs3xF15rj84uu1VuN9B6FjJFvn2/vX8AM6VvIKV+LrkuLg4a3Od
	PUfUkxeszdqtCSlo4Zn1x72j9in5sQzuzVcwV7iaM8DfdDd/DW+E3f1FIkiC6a2NQx4KDkdBC/iHO
	6pBnpEyYJfCzB1ud7xu87tzviBL5sb8J1cRhNlMyfBLBWH902n+ZNwADuWW8e8aD3rMV7D/jXA7yr
	tUGqXU04em77QUP+QMTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iY1uN-0006cq-AV; Fri, 22 Nov 2019 05:55:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY1pJ-0000aX-PH
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 05:49:56 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D5ED20715;
 Fri, 22 Nov 2019 05:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574401793;
 bh=Smc+SDEVTfEWL5NOxF34mfrKvlk+wJEXkakcFVrRcyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gDkCmR+vbCm7UZzSxZrLHsrHznIZcahCLzKo3PdwG4IDJOaEbYNy5hanbG2VEQsxP
 QZltmQUmfRGZ7knwLHZF8CDI5Q8lwIwLYqTm1qGBwWwpgfY2FMiOeZbOdo6GXC8rJI
 sXQ8RJybBZfzMQjRqpPiYSB1gONL3hRoGXPnwINU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 040/219] nvme: provide fallback for discard alloc
 failure
Date: Fri, 22 Nov 2019 00:46:12 -0500
Message-Id: <20191122054911.1750-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_214953_915008_641F212E 
X-CRM114-Status: GOOD (  17.04  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit cb5b7262b011cfb793519bf97e54dff5282da23c ]

When boxes are run near (or to) OOM, we have a problem with the discard
page allocation in nvme. If we fail allocating the special page, we
return busy, and it'll get retried. But since ordering is honored for
dispatch requests, we can keep retrying this same IO and failing. Behind
that IO could be requests that want to free memory, but they never get
the chance.

Allocate a fixed discard page per controller for a safe fallback, and use
that if the initial allocation fails.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h |  3 +++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5d0f99bcc987f..ced70d37e0f9b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -551,9 +551,19 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	struct nvme_dsm_range *range;
 	struct bio *bio;
 
-	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
-	if (!range)
-		return BLK_STS_RESOURCE;
+	range = kmalloc_array(segments, sizeof(*range),
+				GFP_ATOMIC | __GFP_NOWARN);
+	if (!range) {
+		/*
+		 * If we fail allocation our range, fallback to the controller
+		 * discard page. If that's also busy, it's safe to return
+		 * busy, as we know we can make progress once that's freed.
+		 */
+		if (test_and_set_bit_lock(0, &ns->ctrl->discard_page_busy))
+			return BLK_STS_RESOURCE;
+
+		range = page_address(ns->ctrl->discard_page);
+	}
 
 	__rq_for_each_bio(bio, req) {
 		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
@@ -568,7 +578,10 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	if (WARN_ON_ONCE(n != segments)) {
-		kfree(range);
+		if (virt_to_page(range) == ns->ctrl->discard_page)
+			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
+		else
+			kfree(range);
 		return BLK_STS_IOERR;
 	}
 
@@ -653,8 +666,13 @@ void nvme_cleanup_cmd(struct request *req)
 				blk_rq_bytes(req) >> ns->lba_shift);
 	}
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		kfree(page_address(req->special_vec.bv_page) +
-		      req->special_vec.bv_offset);
+		struct nvme_ns *ns = req->rq_disk->private_data;
+		struct page *page = req->special_vec.bv_page;
+
+		if (page == ns->ctrl->discard_page)
+			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
+		else
+			kfree(page_address(page) + req->special_vec.bv_offset);
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
@@ -3551,6 +3569,7 @@ static void nvme_free_ctrl(struct device *dev)
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
+	kfree(ctrl->discard_page);
 
 	if (subsys) {
 		mutex_lock(&subsys->lock);
@@ -3592,6 +3611,14 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 
+	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
+			PAGE_SIZE);
+	ctrl->discard_page = alloc_page(GFP_KERNEL);
+	if (!ctrl->discard_page) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
@@ -3629,6 +3656,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 out_release_instance:
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 out:
+	if (ctrl->discard_page)
+		__free_page(ctrl->discard_page);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2653e1f4196d5..cc4273f119894 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -238,6 +238,9 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	struct nvmf_ctrl_options *opts;
+
+	struct page *discard_page;
+	unsigned long discard_page_busy;
 };
 
 struct nvme_subsystem {
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
