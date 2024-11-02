Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20949E677EC
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Nov 2024 06:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4epiw3ui9HD6taTZFIBUVIzwxVQK2JBCcmQ9ZscPasI=; b=KriEebpphwF3IfbxJ09CmjLteV
	XtqhBNDBFQKNGbZYqMbRK2m9KH0i0jdYMkGQ0L7+DdvLTk0MRfGLrGpWGTV5nnD5BWxhyB/AFHoF7
	+X2IReg2zLPN5X1Yr69vapFVI4pvfClLs2v8/S6EYjsP4BlMFo0WfQIOSAvHXrGVBpfmpkT3vPQk+
	NHIT/w/tOXVdiyGGZtw2346CWO9BWUa3wVVvIqOctE8VilCFuZ3hmSBIkyY/I34kc9DWtY/2vBcR9
	PkgzVyJ7lZPZ0DoAbKVr9tRi5548VXssC65lIni37+VxQLYBc6029nZyzqrnj+e4vNDcNDzAbC6/c
	baThmpGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t77oF-000000099cy-149c;
	Sat, 02 Nov 2024 06:40:31 +0000
Received: from m16.mail.163.com ([117.135.210.4])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t77oB-000000099bt-4B87
	for linux-nvme@lists.infradead.org;
	Sat, 02 Nov 2024 06:40:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=4epiw
	3ui9HD6taTZFIBUVIzwxVQK2JBCcmQ9ZscPasI=; b=MALtmqx1aMjyoaPSxsqns
	76WTVXlgGdo6RK4xFT9L1y4bcE1qDCy7qYPrEuAQ1KHJfzAiABIleY5ACaBmsM3N
	G/BFIit7LsuVUDmrPVDnvIUKSou9D3cW+T9yf/7rggIzxG2NfP/unAbp04c567cQ
	VRaWSkaWMXCB6ImpHdHYMQ=
Received: from fc39.. (unknown [125.33.14.1])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnnw9IySVnWEkjCQ--.19355S4;
	Sat, 02 Nov 2024 14:40:10 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH] nvmet-rdma: WARN_ON when nvmet_rdma_rsp::n_rdma equal zero
Date: Sat,  2 Nov 2024 14:39:53 +0800
Message-ID: <20241102063953.228107-1-honggangli@163.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAnnw9IySVnWEkjCQ--.19355S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW3WFyfuF43Gw13Jw43ZFb_yoWDWrcEkw
	1IyF1fu3WDur1xKr129w1YyryqkFnruF1xKF4ft3y2yrWUWr90kw1ktr93Zr1xZa18CrWx
	CFsrJrWagFWxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNJ5o7UUUUU==
X-Originating-IP: [125.33.14.1]
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDwKLRWclu+jbJgAAsv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_234028_755139_4F435293 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
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

nvmet_rdma_rsp::n_rdma is an u8, which can't be negative.

Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/nvme/target/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1afd93026f9b..cdeb275a388b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -750,7 +750,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct nvmet_rdma_queue *queue = wc->qp->qp_context;
 	u16 status = 0;
 
-	WARN_ON(rsp->n_rdma <= 0);
+	WARN_ON(rsp->n_rdma == 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
 	rsp->n_rdma = 0;
 
@@ -787,7 +787,7 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
 		return;
 
-	WARN_ON(rsp->n_rdma <= 0);
+	WARN_ON(rsp->n_rdma == 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
 	rsp->n_rdma = 0;
 
-- 
2.47.0


