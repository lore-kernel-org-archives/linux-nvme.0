Return-Path: <SRS0=tp6u=3D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AA2C33C9E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2020 18:18:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743772084D
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2020 18:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fYX42iAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743772084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bJZ7O0nSWX1mkslMoj/DJSGQzYR1LW2GjAH74944K+0=; b=fYX42iAubn9NOR
	KTOZTUi+TjXuA8BOjIfZBcY/Sg6BrUhiVkwOl+cAprG8lDwSFRAFysrOKB2rsDFlTHVanHJ8WYWCe
	hqapC/y4bLJ8ollhrez/jGgBFQkC1WVT+h+4kMgSwyXAdeVbkDmmfJ9oLyiZF36W8951lRBwCpeJk
	QBKrpiyCK1CUG49/KR4sgxkQIFC4aQKGJb7TjYTpsNjXpyIXS6a9ovrZPa2cAL1TiUoiyODRZuaUT
	3z6hbAq+CnwD5Tn6CNpGHEN4tqcjSG46GvNjxfLSeBzn11uMoAmRpWNLoQ0tdswI6RILNtodsKhAn
	tn4SdSC1MrS3UP6R9uTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1irQlU-0002np-3a; Tue, 14 Jan 2020 18:18:08 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irQlN-0002l6-FC
 for linux-nvme@lists.infradead.org; Tue, 14 Jan 2020 18:18:06 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 10:18:00 -0800
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; d="scan'208";a="248126148"
Received: from unknown (HELO caliente.lm.intel.com) ([10.232.116.67])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 10:18:00 -0800
From: Edmund Nadolski <edmund.nadolski@intel.com>
To: edmund.nadolski@intel.com, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
Subject: [PATCH] nvme: clear stale nvmeq->tags after tagset free
Date: Tue, 14 Jan 2020 11:17:45 -0700
Message-Id: <20200114181745.2297-1-edmund.nadolski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200114_101801_528393_9024F54F 
X-CRM114-Status: GOOD (  10.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch introduces nvme_exit_hctx() to NULL the nvmeq->tags pointer
after a tagset free, so that a subsequent nvme_init_hctx() can
correctly re-initialize it.

This patch fixes a failure case which occurs during cascaded controller
resets. The tagset is freed after the controller fails commands which
try to create IO SQs. A second reset restores the controller, but the
following nvme_validate_ns/device_add_disk sequence uses the old/stale
nvmeq->tags value, leading to an invalid tag value in nvme_handle_cqe and
kernel panic from nvme_irq.

Signed-off-by: Edmund Nadolski <edmund.nadolski@intel.com>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 365a2ddbeaa7..7daf3888ba8e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -404,6 +404,13 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
+static void nvme_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+
+	nvmeq->tags = NULL;
+}
+
 static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 		unsigned int hctx_idx, unsigned int numa_node)
 {
@@ -1582,6 +1589,7 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
+	.exit_hctx      = nvme_exit_hctx,
 	.init_request	= nvme_init_request,
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
