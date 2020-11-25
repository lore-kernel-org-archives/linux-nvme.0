Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EFBC6379D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 15:38:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7733121D81
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 15:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2PjMO4bI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcM2tgG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7733121D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7UMJHQprL8PXj7IZAJdo8tD8TRRpVeuXqmb0F0ycq60=; b=2PjMO4bIiflP7PsnhH4TIKuok
	nT+Z2bq8b/axNX3ppwArtci8JeWtkfRqYlYrRNEZz6qdBh/5j+7EwaZNjvANKfWVWziHD4aQgj/2S
	ReBdznIX3yHIERve/DU9WQDKei9GjZ3IXKlEkrNnHWmfGNilR0XjSbtmwNAHKMZQKBw8vO47vl4CF
	rb/mLLDXMY8sq+xTX1jZr6iwqHfoKtJc3lA9FinCEtxjx3rC9tFRJlL98FRXUrrvb3JeSrUnCgryf
	04oDPjryhVKYsB+8p7c2nAjfobX4axvEuvVPsn+JnmeTOg7r5ZQEfK82S6dv3UdZ3s41ZTN18384V
	semTwEi8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khwro-0001eR-Ft; Wed, 25 Nov 2020 15:38:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khwrb-0001ZF-Fw
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 15:37:48 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA2A0221EB;
 Wed, 25 Nov 2020 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606318666;
 bh=0n8jfaMWrlyg/5o+SmqrjEegfZzl9GLztMgGWzfjofw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YcM2tgG86EGN/P37MEVl9OfZ8HzZd52R973vwWl/gbegrfz8b6VhgORJmwiyALKDV
 KSNpwtdSfKhJYyI7fRxlhuMu41/N7yN9GEsz9o7WZ+VvnHe7bUKHkfhc6c6lcxG7ml
 zrYJHQpxwV/FGCMvW4ftQuoVqlrV1Sepst+glAnY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/12] nvme: free sq/cq dbbuf pointers when dbbuf
 set fails
Date: Wed, 25 Nov 2020 10:37:30 -0500
Message-Id: <20201125153734.810826-8-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201125153734.810826-1-sashal@kernel.org>
References: <20201125153734.810826-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_103747_689478_72064DF0 
X-CRM114-Status: GOOD (  14.88  )
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
Cc: Sasha Levin <sashal@kernel.org>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

[ Upstream commit 0f0d2c876c96d4908a9ef40959a44bec21bdd6cf ]

If Doorbell Buffer Config command fails even 'dev->dbbuf_dbs != NULL'
which means OACS indicates that NVME_CTRL_OACS_DBBUF_SUPP is set,
nvme_dbbuf_update_and_check_event() will check event even it's not been
successfully set.

This patch fixes mismatch among dbbuf for sq/cqs in case that dbbuf
command fails.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3788c053a0b19..540fab9f850dd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -266,9 +266,21 @@ static void nvme_dbbuf_init(struct nvme_dev *dev,
 	nvmeq->dbbuf_cq_ei = &dev->dbbuf_eis[cq_idx(qid, dev->db_stride)];
 }
 
+static void nvme_dbbuf_free(struct nvme_queue *nvmeq)
+{
+	if (!nvmeq->qid)
+		return;
+
+	nvmeq->dbbuf_sq_db = NULL;
+	nvmeq->dbbuf_cq_db = NULL;
+	nvmeq->dbbuf_sq_ei = NULL;
+	nvmeq->dbbuf_cq_ei = NULL;
+}
+
 static void nvme_dbbuf_set(struct nvme_dev *dev)
 {
 	struct nvme_command c;
+	unsigned int i;
 
 	if (!dev->dbbuf_dbs)
 		return;
@@ -282,6 +294,9 @@ static void nvme_dbbuf_set(struct nvme_dev *dev)
 		dev_warn(dev->ctrl.device, "unable to set dbbuf\n");
 		/* Free memory and continue on */
 		nvme_dbbuf_dma_free(dev);
+
+		for (i = 1; i <= dev->online_queues; i++)
+			nvme_dbbuf_free(&dev->queues[i]);
 	}
 }
 
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
