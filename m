Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF63C433E9
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 12:59:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470102310F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 12:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470102310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kTR84bVuTng8PXtyIFY/rwd3k+iw1YoJ8jw092Xp08A=; b=Hp3Sak5R3z1gRsCqTsd+f9nol
	enHpvumcrHwkiRjZvP+OHbkat5mqbCc1Dj6wFqRgVtnM4sWVxG1GzJlKk73RI4vSkpjmwvhPS2jK/
	qT1AzoGsKsCnapBzkO/oKeElBZyzRurJnXb1WACR+TV01LKMVVNKFupDAgIu/qsQJo+NfAXdPv2mp
	PXe0nmpvIVM3+IBp2UnLZ0W0SwzSnERDA+A0ARIkMkrWUYzXDuSY8kR3ymBVRBgisOHiu4EdFnyEq
	8oMVpaSTaj0AFM+XkjPV9yS4Sgr8Q/bqpB8LKTi448QBOshYyzq7GALDi3hCKpnSwZi5cnQoC9Km8
	mkcScg34A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzJGP-0001jY-Jb; Tue, 12 Jan 2021 12:59:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzJEc-0000hs-1K
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 12:57:19 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C610239D3;
 Tue, 12 Jan 2021 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610456237;
 bh=PNvCOCoAo5+jSAER09jlgMZlmQEfKisVJhvtTf9R3O0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hfuN/le5/vlA/DvHpg8tQ3aQa4Bvlf1G2iYBMSKgVQmx+b4ttW8xltECdcWxVh9kR
 VD1WvOimuSVdMwd87PiHdJLrD8uO7Rh/uNBJV7pd+r3p8K6bIxg2NGRplz9QctcSw/
 RHvDblns/xRMa9q5lSNohgZh8UkmG1lTF0WxRG80ckskdGvUFLK+901ZR5AymgWYAl
 IjwtazINfb73QVkPJVfhOorWSWQ0ccweCpuu1isu2q88elPg8xv1zSpod8XJ4PGmuq
 db59yqHEy27zG5LKjDDiBBnyAnnN6Mf7jbPOE6x/zfS86tYmzL/tIppoi6BxvwPnXk
 Evkgpl6vr7KAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 23/28] nvmet-rdma: Fix list_del corruption on
 queue establishment failure
Date: Tue, 12 Jan 2021 07:56:39 -0500
Message-Id: <20210112125645.70739-23-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125645.70739-1-sashal@kernel.org>
References: <20210112125645.70739-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_075718_258023_5689FB32 
X-CRM114-Status: GOOD (  11.70  )
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
Cc: Israel Rukshin <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@nvidia.com>

[ Upstream commit 9ceb7863537748c67fa43ac4f2f565819bbd36e4 ]

When a queue is in NVMET_RDMA_Q_CONNECTING state, it may has some
requests at rsp_wait_list. In case a disconnect occurs at this
state, no one will empty this list and will return the requests to
free_rsps list. Normally nvmet_rdma_queue_established() free those
requests after moving the queue to NVMET_RDMA_Q_LIVE state, but in
this case __nvmet_rdma_queue_disconnect() is called before. The
crash happens at nvmet_rdma_free_rsps() when calling
list_del(&rsp->free_list), because the request exists only at
the wait list. To fix the issue, simply clear rsp_wait_list when
destroying the queue.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/rdma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b5314164479e9..50e2007092bc0 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1351,6 +1351,16 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 	spin_lock_irqsave(&queue->state_lock, flags);
 	switch (queue->state) {
 	case NVMET_RDMA_Q_CONNECTING:
+		while (!list_empty(&queue->rsp_wait_list)) {
+			struct nvmet_rdma_rsp *rsp;
+
+			rsp = list_first_entry(&queue->rsp_wait_list,
+					       struct nvmet_rdma_rsp,
+					       wait_list);
+			list_del(&rsp->wait_list);
+			nvmet_rdma_put_rsp(rsp);
+		}
+		fallthrough;
 	case NVMET_RDMA_Q_LIVE:
 		queue->state = NVMET_RDMA_Q_DISCONNECTING;
 		disconnect = true;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
