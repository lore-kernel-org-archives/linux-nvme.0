Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6174CA6015
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 05:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdC4dJY/4vazVcvf5m0/8SEiRw+z1O4P8w3T6xgJfP4=; b=vfci16x/iDYnXzJQ4woZ6Kdr16
	QxXDoKDtQWxrj4DiMHtxlZx2qRZnrlpscXUlxADnnNEejL2TIkCNWwh2/uuBSBoFpDNFpx5pKmTO7
	/CIeTB3MXR8Mt12XFIvVD8XfHu+2K/mCHnE5tyK/ayUAmb5W4+EaLBPumJwUc0VvLCJYt1qChoAhj
	MHmwKyju0z1pX7f1DY9Xhv3oK8cn+BTz6LteBc3aQMWx9qZXLLxifZXFD5RzF/h736H8TwNgFFJLp
	47d9DtcXD9PASZpaL3ivnWJjW+RnXD9eXyv5h6M03j6IMGi1eNiK8w/50Tq2enKeAoiWRD7lkkiCk
	SM7Z8Ywg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF2o8-00000005VQA-1tUt;
	Fri, 09 Oct 2026 05:06:12 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF2o6-00000005VOa-0ExJ
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 05:06:11 +0000
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5205420B7167;
	Thu,  8 Oct 2026 22:06:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5205420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791522368;
	bh=WdC4dJY/4vazVcvf5m0/8SEiRw+z1O4P8w3T6xgJfP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMMiWL4Zq5oI8MeJURknwQaGOskkhOq8/PYImArYPOEnWpY9mZKEygOh3ktngbDy+
	 6bfvlYTaF3j1d0YJzxkhDNqoNIJsX+XxyYEoPvtDBe8SeIC7X2bliDk0zpi+/xcsvv
	 khK2rFtVIg2NBNNSzAAE8rdnpUqwBRXR947mDya8=
From: Naman Jain <namjain@linux.microsoft.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] nvme-pci: make completion queue polling softirq-safe
Date: Fri,  9 Oct 2026 05:05:55 +0000
Message-ID: <20261009050556.2817978-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009050556.2817978-1-namjain@linux.microsoft.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_220610_131530_13DE4940 
X-CRM114-Status: GOOD (  11.57  )
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

A following patch processes interrupt-driven completion queues from
IRQ_POLL_SOFTIRQ. Ensure every task-context user disables bottom halves
while holding cq_poll_lock so the softirq cannot interrupt the local
owner.

This includes explicit blk-mq polling. Those queues do not use irq_poll,
but all cq_poll_lock instances share one lockdep class because they are
initialized at the same call site. Keep that class consistently
softirq-safe rather than reclassifying reused queue objects across reset.

Assisted-by: LLM
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/nvme/host/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dbcfc7ddb78aa..bd4a6461b620f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1673,9 +1673,9 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 
 	irq = pci_irq_vector(pdev, nvmeq->cq_vector);
 	disable_irq(irq);
-	spin_lock(&nvmeq->cq_poll_lock);
+	spin_lock_bh(&nvmeq->cq_poll_lock);
 	nvme_poll_cq(nvmeq, NULL);
-	spin_unlock(&nvmeq->cq_poll_lock);
+	spin_unlock_bh(&nvmeq->cq_poll_lock);
 	enable_irq(irq);
 }
 
@@ -1688,9 +1688,9 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	    !nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock(&nvmeq->cq_poll_lock);
+	spin_lock_bh(&nvmeq->cq_poll_lock);
 	found = nvme_poll_cq(nvmeq, iob);
-	spin_unlock(&nvmeq->cq_poll_lock);
+	spin_unlock_bh(&nvmeq->cq_poll_lock);
 
 	return found;
 }
@@ -2086,9 +2086,9 @@ static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 	int i;
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
-		spin_lock(&dev->queues[i].cq_poll_lock);
+		spin_lock_bh(&dev->queues[i].cq_poll_lock);
 		nvme_poll_cq(&dev->queues[i], NULL);
-		spin_unlock(&dev->queues[i].cq_poll_lock);
+		spin_unlock_bh(&dev->queues[i].cq_poll_lock);
 	}
 }
 

