Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A01C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDJWR3QAlOeDWB2C3Wc7QnxTFmRKXkzhr2RX0LXVxDg=; b=v/E61NbNPS+aWsrGkFYUjJnQVc
	Ca5OEsPyGtliXWCYrw7tK6wR8j+E8VzsSrmLOpr8vb2N7EMpeokivt6dQxs8mxWbUcT3aUfHiVH3p
	GMK8Q2q6ymXWrmqhtgfFsEnFjYYoU+/NkzY8yeGFxRwPi+Qqamf6BEkyRnhR8HWhovSoopXHk74x9
	GCSTEBb1nWMkOA1yXr6Xv9rfzWSsdMP9P+eporSdJyIvm3lGg6pYHJkJRTbUi02wEjhcFeJiZXPSz
	/o7BhjuKzvBA1EqAA9DRNrJtVhL8H5Gx1VFCcX/HBeCpjRenuWflJQWX7rbAwn+Za0T0ePpOxdnZl
	OwW2lKDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJXah-00EDuK-43; Mon, 14 Feb 2022 09:24:15 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXKf-00EAKp-SO
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:07:43 +0000
Received: by mail-wr1-f50.google.com with SMTP id v12so25692231wrv.2
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nDJWR3QAlOeDWB2C3Wc7QnxTFmRKXkzhr2RX0LXVxDg=;
 b=XAjan9f3YwsDxET2NzJ2G8g0NSjtEwPKrtoIMPoL3NZ0xh/ZoSgXNcU/W2hbhKOdFk
 IFVOrcdvfqfYoJVMlGBDAEXqAwTp9Nc54ty6wh9nQ7vI76oLyldje2u0Fw0ng2rCuG2c
 wvuZu+Uw83PgdMBORTiqktvP2/2x9f9SwVNFeOGdJVykMyjda9YLxYzSi2zRF4QIopqI
 D8GrcTIagByLxQEv5filsGMIYS4ccKqtKR4v93PYhl3t/xgrTZCV2mX7pGsxjiUIgQuc
 HhwwRJaQPdS0FWdA9efDBUJtwbmYlpumEiZJJosM05Vk7mXIAOf/22uz+7o1Vw4FqFLm
 mwXQ==
X-Gm-Message-State: AOAM530IW4RTAMlsMicdqHQGI42se0D0b8OXiPRUrFAP4kRqP926kKo9
 Uk+XFE225tm7LeNHCxJ8yEfWjg2HbHs=
X-Google-Smtp-Source: ABdhPJwVhiEPafk8KK/BMgtcm4HStaj4zHfTlOlhd9KShYtIUTIOmSZa0n531uSjSzOaiXxb6+MouQ==
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr10795722wrc.284.1644829659664; 
 Mon, 14 Feb 2022 01:07:39 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h4sm34595498wre.0.2022.02.14.01.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 01:07:39 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 6/7] nvmet-rdma: replace ida_simple[get|remove] with the
 simler ida_[alloc|free]
Date: Mon, 14 Feb 2022 11:07:31 +0200
Message-Id: <20220214090732.479193-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214090732.479193-1-sagi@grimberg.me>
References: <20220214090732.479193-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_010741_956045_16A593E3 
X-CRM114-Status: GOOD (  12.26  )
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

ida_simple_[get|remove] are wrappers anyways.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1deb4043e242..00656754e331 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1356,7 +1356,7 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 				!queue->host_qid);
 	}
 	nvmet_rdma_free_rsps(queue);
-	ida_simple_remove(&nvmet_rdma_queue_ida, queue->idx);
+	ida_free(&nvmet_rdma_queue_ida, queue->idx);
 	kfree(queue);
 }
 
@@ -1459,7 +1459,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	spin_lock_init(&queue->rsps_lock);
 	INIT_LIST_HEAD(&queue->queue_list);
 
-	queue->idx = ida_simple_get(&nvmet_rdma_queue_ida, 0, 0, GFP_KERNEL);
+	queue->idx = ida_alloc(&nvmet_rdma_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = NVME_RDMA_CM_NO_RSC;
 		goto out_destroy_sq;
@@ -1510,7 +1510,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 out_free_responses:
 	nvmet_rdma_free_rsps(queue);
 out_ida_remove:
-	ida_simple_remove(&nvmet_rdma_queue_ida, queue->idx);
+	ida_free(&nvmet_rdma_queue_ida, queue->idx);
 out_destroy_sq:
 	nvmet_sq_destroy(&queue->nvme_sq);
 out_free_queue:
-- 
2.30.2


