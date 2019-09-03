Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC59C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 15:14:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1576E215EA
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 15:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IMpSJSQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1576E215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9Wwdm1fcZfSMb+FWX43/KrV7WWeg66/QS5UCZ0GsgTk=; b=IMpSJSQQZhbz2/QYYLDjI2PPCf
	RY+Rt7gtoqkOoOBO8PweXvs9Mo7wrS0hcPNFe2xoBdX8IT5mdStM0XGvK5qHAhRvrt0wmDSORpgle
	wPxF5LPeeF8VWO9ENh//roRFNTuXbylLoAIUy7RG0oViuoC3pxnNvsImvsqvwfeSbtk1p/hLsJnsK
	EpC+FdpQbbtvisRTa4YVMRfNEAAvJ04yBkKXlErCr9rYbd5NKT1KnhNxQ5k79iXpH90lBOOTyg8qb
	nkRhQvT3GySPH1donDNav233ZmvNJiWVmKtzVmW3XunJ3GSU+SuZmiVGEKhNCH+CUbfWXlvWTizDR
	M1S0dgdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5AWF-0000nv-7u; Tue, 03 Sep 2019 15:14:55 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i5AVi-0000PX-Qn
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 15:14:25 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 3 Sep 2019 18:14:15 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x83FEFl3016624;
 Tue, 3 Sep 2019 18:14:15 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com, 
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 3/4] nvme-tcp: introduce nvme_tcp_complete_rq callback
Date: Tue,  3 Sep 2019 18:14:14 +0300
Message-Id: <1567523655-23989-3-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_081423_257539_29D764F6 
X-CRM114-Status: UNSURE (   8.64  )
X-CRM114-Notice: Please train this message.
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
Cc: Max Gurtovoy <maxg@mellanox.com>, shlomin@mellanox.com,
 israelr@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme_cleanup_cmd function should be called to avoid resource leakage
(it's the opposite to nvme_setup_cmd). Fix the error flow during command
submission and also fix the missing call in command completion.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606b13d..91b500a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2093,6 +2093,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 
 	ret = nvme_tcp_map_data(queue, rq);
 	if (unlikely(ret)) {
+		nvme_cleanup_cmd(rq);
 		dev_err(queue->ctrl->ctrl.device,
 			"Failed to map data (%d)\n", ret);
 		return ret;
@@ -2101,6 +2102,12 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	return 0;
 }
 
+static void nvme_tcp_complete_rq(struct request *rq)
+{
+	nvme_cleanup_cmd(rq);
+	nvme_complete_rq(rq);
+}
+
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -2161,7 +2168,7 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 
 static struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
-	.complete	= nvme_complete_rq,
+	.complete	= nvme_tcp_complete_rq,
 	.init_request	= nvme_tcp_init_request,
 	.exit_request	= nvme_tcp_exit_request,
 	.init_hctx	= nvme_tcp_init_hctx,
@@ -2171,7 +2178,7 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 
 static struct blk_mq_ops nvme_tcp_admin_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
-	.complete	= nvme_complete_rq,
+	.complete	= nvme_tcp_complete_rq,
 	.init_request	= nvme_tcp_init_request,
 	.exit_request	= nvme_tcp_exit_request,
 	.init_hctx	= nvme_tcp_init_admin_hctx,
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
