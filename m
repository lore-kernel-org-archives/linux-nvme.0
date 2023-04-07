Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADAFC76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3YOa2vUCRMOuffAmJfHUcI/nyFeZjIGfxyzUSsr5wms=; b=EMN5OGDCdNq2tAUnFsOwuJAdCF
	d1DwIgesxBpiIpwjj5W9iHIJQOdvQd3uAQsevg2SXla43V5usbOGKlh7UjjGG2NXJsM6NN9FYRmv7
	zwl6j3KlW/suHtB7MV2uZCir+nA1QauKBMVKHfGHWl8Goxx8Q5A7L40kmMPIIbBVmarrhn4tnhnaK
	w7yH6fDQYoHdYn1aAiJNRqxvSfDITtOxO4F/OQtHycXh7jdJ59lo4f1RRXBE1IsUHVqRBZR67GqPV
	YwQb/2WEtYptd+NUOUSSyf3tBOzkDUE79rcN97jvAy4qe1nrbcznJLUmROJuANYbGMrQnljbKiOK/
	1GDRkYMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkiES-009dTD-2Y;
	Fri, 07 Apr 2023 09:18:08 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkiEO-009dR8-0W
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 09:18:06 +0000
Received: by mail-pl1-x630.google.com with SMTP id kx12so693211plb.12
        for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680859067; x=1683451067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YOa2vUCRMOuffAmJfHUcI/nyFeZjIGfxyzUSsr5wms=;
        b=f2ObIdvghcQZ58Jh4FlzZuWxh98X+QEoaktvor0bhiL7xxCgYzKcy6y1eb8cnBmRqU
         sEE8ZdIi2gUsl1ov8+mCqPbUH39yuOEn5LIa1RNVM88zwxg47l3Z/xQFR6TQmvDvgi5k
         vgEnC1laaSANXGf/jIs51h7GRuknu6HzSqouMqXn4H93FXi/BYgHemrlCeMb2CRGZxpm
         f4tPd+xarwVD0eSpRADYqCUqZkGIz8GmHJaWEKZRHvX0aOTJOWc1csmjvIIxq6qi+vJl
         LUdk+Txrpr0E826Sa6qRP6XhqjGxWYwFmtd+EMl2ZcuirZ/DaM5zyqMvr7vk2AWjtpDm
         juLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680859067; x=1683451067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YOa2vUCRMOuffAmJfHUcI/nyFeZjIGfxyzUSsr5wms=;
        b=HAhz5cKVpFX6aRBXdjQ7Br3Y7GbXwMywoyj3fe8kVp3W1QlZt3RIUKyGVh9N3UafQU
         h5QgiUDqoKVBghQZLZr8IHEv8hLTgH66nudMhM64Ys3llCDgqcFCDOdayBcIi8CSzkvA
         di2UEOkMBXveA4Ht6ubjg7ctgUpRxbdPtusLyqz6nDzFESVn2H2DTWhFUjoSb3oFCum3
         CZjxmnGOf3c0N/Q+9nVrdXW9PQ3yXq+1gL7vZT6XFTL7JPbjQuDSubpijgHr28+hMqVf
         t88fadXbTxG/G+CWt9+7IiDjSgghczxv2ccS8/HGL3XSLHofZuA70inE9R/nRICKUjOb
         CI0g==
X-Gm-Message-State: AAQBX9dwozc8xAVK3IMIVtAv4zfWLOgaY+j9Vt7jwvpAJ+fkwXjYIXgB
	WwuBWLAp7Yg7vQXSvYS9rtVReQ==
X-Google-Smtp-Source: AKy350YTD13aaCgWFmupbApPH/XKOQWdgWB0aLonyUVnosRbljdkKhA1SsrY65fu4IIMGGyaGQTa9w==
X-Received: by 2002:a17:902:fa4b:b0:19e:4bc3:b1ef with SMTP id lb11-20020a170902fa4b00b0019e4bc3b1efmr1859969plb.64.1680859067669;
        Fri, 07 Apr 2023 02:17:47 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b001a199972508sm2546745pln.124.2023.04.07.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:17:47 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	zhenwei pi <pizhenwei@bytedance.com>,
	Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH] nvme-rdma: minor cleanup in nvme_rdma_create_cq()
Date: Fri,  7 Apr 2023 17:15:57 +0800
Message-Id: <20230407091557.258669-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_021804_502777_C4900235 
X-CRM114-Status: GOOD (  10.40  )
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

Before cleanup:
enum ib_poll_context poll_ctx;

if (nvme_rdma_poll_queue(queue)) {
        poll_ctx = IB_POLL_DIRECT;
        queue->ib_cq = ib_alloc_cq(ibdev, queue, queue->cq_size,
                                   comp_vector, poll_ctx);
} else {
        poll_ctx = IB_POLL_SOFTIRQ;
        queue->ib_cq = ib_cq_pool_get(ibdev, queue->cq_size,
                                      comp_vector, poll_ctx);
}

After cleanup:
if (nvme_rdma_poll_queue(queue))
        queue->ib_cq = ib_alloc_cq(ibdev, queue, queue->cq_size,
                                   comp_vector, IB_POLL_DIRECT);
else
        queue->ib_cq = ib_cq_pool_get(ibdev, queue->cq_size,
                                      comp_vector, IB_POLL_SOFTIRQ);

IB_POLL_SOFTIRQ/IB_POLL_SOFTIRQ gets used directly in function, this
seems more accessible.

Cc: Yamin Friedman <yaminf@mellanox.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/rdma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbad26b82b56..4767ae19178c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -464,7 +464,6 @@ static int nvme_rdma_create_cq(struct ib_device *ibdev,
 		struct nvme_rdma_queue *queue)
 {
 	int ret, comp_vector, idx = nvme_rdma_queue_idx(queue);
-	enum ib_poll_context poll_ctx;
 
 	/*
 	 * Spread I/O queues completion vectors according their queue index.
@@ -473,15 +472,12 @@ static int nvme_rdma_create_cq(struct ib_device *ibdev,
 	comp_vector = (idx == 0 ? idx : idx - 1) % ibdev->num_comp_vectors;
 
 	/* Polling queues need direct cq polling context */
-	if (nvme_rdma_poll_queue(queue)) {
-		poll_ctx = IB_POLL_DIRECT;
+	if (nvme_rdma_poll_queue(queue))
 		queue->ib_cq = ib_alloc_cq(ibdev, queue, queue->cq_size,
-					   comp_vector, poll_ctx);
-	} else {
-		poll_ctx = IB_POLL_SOFTIRQ;
+					   comp_vector, IB_POLL_DIRECT);
+	else
 		queue->ib_cq = ib_cq_pool_get(ibdev, queue->cq_size,
-					      comp_vector, poll_ctx);
-	}
+					      comp_vector, IB_POLL_SOFTIRQ);
 
 	if (IS_ERR(queue->ib_cq)) {
 		ret = PTR_ERR(queue->ib_cq);
-- 
2.20.1


