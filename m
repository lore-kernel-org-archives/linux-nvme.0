Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163ECC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 09:10:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A460623A01
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 09:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A460623A01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yDCkkHdOGrov/Ao7z02D+PzFfVs6GS/Xn7hMuC2IRVM=; b=usp6zL1Uq0Aqd9XyLqFodV/WI
	HKYk1zCg/Cy7pTOyznVKcr1u1dhYGyhigB6bBGx6vIflWA8dUoc2d20sQqfTSAlOTyARpM5aMN7Fp
	m8nC6zUwR8tdDZjugF9G0efmCY6MpRZhDxDMuyzmxoJasM4ccPaCVppLMt4hT5MHxzalUenkVA9c6
	UkGxJkq59iBkJsHtpo/BNcS1chHKpCMwRoi43HQpzERiQBXz6ILcKTIzbBUpPGJIti956kWjpS7hv
	VuY1lXbQMRzqjqDTLTKwoQW2Jv8jTxFkoAGjjf5TAiZOxXE2BqCdkdiHuSYLoFfUUMYI1eQxiB4se
	9zNGYWVFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzydY-0002Hm-JZ; Thu, 14 Jan 2021 09:09:48 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzydS-0002Er-6K
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 09:09:44 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DGdlf3tPMzj6M1;
 Thu, 14 Jan 2021 17:08:46 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Jan 2021
 17:09:28 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 2/2] nvme-tcp: avoid request double completion for
 concurrent nvme_tcp_timeout
Date: Thu, 14 Jan 2021 17:09:26 +0800
Message-ID: <20210114090926.12109-3-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210114090926.12109-1-lengchao@huawei.com>
References: <20210114090926.12109-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_040942_637277_CEAA58DA 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Each name space has a request queue, if complete request long time,
multi request queues may have time out requests at the same time,
nvme_tcp_timeout will execute concurrently. Multi requests in different
request queues may be queued in the same tcp queue, multi
nvme_tcp_timeout may call nvme_tcp_stop_queue at the same time.
The first nvme_tcp_stop_queue will clear NVME_TCP_Q_LIVE and continue
stopping the tcp queue(cancel io_work), but the others check
NVME_TCP_Q_LIVE is already cleared, and then directly complete the
requests, complete request before the io work is completely canceled may
lead to a use-after-free condition.
Add a multex lock to serialize nvme_tcp_stop_queue.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/tcp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ba659927442..725f80984d54 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -76,6 +76,7 @@ struct nvme_tcp_queue {
 	struct work_struct	io_work;
 	int			io_cpu;
 
+	struct mutex		queue_lock;
 	struct mutex		send_mutex;
 	struct llist_head	req_list;
 	struct list_head	send_list;
@@ -1209,6 +1210,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 
 	sock_release(queue->sock);
 	kfree(queue->pdu);
+	mutex_destroy(&queue->queue_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1370,6 +1372,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	int ret, rcv_pdu_size;
 
+	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
@@ -1388,7 +1391,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
-		return ret;
+		goto err_destroy_mutex;
 	}
 
 	/* Single syn retry */
@@ -1497,6 +1500,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 err_sock:
 	sock_release(queue->sock);
 	queue->sock = NULL;
+err_destroy_mutex:
+	mutex_destroy(&queue->queue_lock);
 	return ret;
 }
 
@@ -1524,9 +1529,10 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
-	if (!test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		return;
-	__nvme_tcp_stop_queue(queue);
+	mutex_lock(&queue->queue_lock);
+	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	mutex_unlock(&queue->queue_lock);
 }
 
 static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
