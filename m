Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A834C4CECD
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 19:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E705720775
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 19:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YYJA8dF2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjgWK/43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E705720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=G+DinzHYVVpPmL83OXFXKIuT9C6yXA72A57hPyiU/iM=; b=YYJA8dF2Snd02w
	YwQUDS7w8GUu6WOhpvMRKAw6YQFob54cCCFjOegFPY8k3qfxokFw+1bZ4M0k0OFWnkb38dNnLGB1S
	eIEOZv9+msGNv7USEuFxzkLD2s6SilBNXpOmynlHEOa4/0l9tKKE7XRLTeuvCV8xUaY57xzzq7grv
	yGbzS8apDumf3pP0lVPdoLos7IaGcqkxhJMLZ/nl0zcQG2PXRTG1uhdT7iSQ7flyeQCR6NnAfipCG
	GHgnSGFj7pEN9UayjjB2LHz9qM5m2cmFBzexXYnrXTwkqNAKUN8BNxtCIPYjdKxNMokleBqtry7dI
	MzyFB/Fx/kmXCVvb/8vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jT9DP-0004Mo-Jt; Mon, 27 Apr 2020 19:14:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jT9DM-0004M1-EK
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 19:14:49 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC8AF20775;
 Mon, 27 Apr 2020 19:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588014888;
 bh=31rG1RZEyCbRlRjmP2QKaN0oUboktt2GkZ4gh1E8iYI=;
 h=From:To:Cc:Subject:Date:From;
 b=AjgWK/43uFyMZ1HIXq0ouDuLdtJplhf6UyWf7LCgBQvJbIVmEdWz2u/7gwsZxy1kX
 dSgUAMprjvIdSSCEljm4s8yj6P+LzFRxxzzSo7VIm1FW8kRSCnXkOZBHdVQJRnNXEx
 /g37v3sYgZ9azB/8VNZr3/c9FYF2Dg+ASFjVMFU0=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme-pci: remove volatile cqes
Date: Mon, 27 Apr 2020 12:14:46 -0700
Message-Id: <20200427191446.2195863-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_121448_499435_17F734C0 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The completion queue entry is not volatile once the phase is confirmed.
Remove the volaitle keywords and check the phase using the appropriate
READ_ONCE() accessor, allowing the compiler to optimize the remaining
completion path.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ebcf40f04fe..cf386c84588b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -166,7 +166,7 @@ struct nvme_queue {
 	void *sq_cmds;
 	 /* only used for poll queues: */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
-	volatile struct nvme_completion *cqes;
+	struct nvme_completion *cqes;
 	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
@@ -908,8 +908,9 @@ static void nvme_pci_complete_rq(struct request *req)
 /* We read the CQE phase first to check if the rest of the entry is valid */
 static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 {
-	return (le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
-			nvmeq->cq_phase;
+	return (le16_to_cpu(
+			READ_ONCE(nvmeq->cqes[nvmeq->cq_head].status)) & 1) ==
+				nvmeq->cq_phase;
 }
 
 static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
@@ -930,7 +931,7 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 {
-	volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
+	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
 
 	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
