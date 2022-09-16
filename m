Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05182C54EE9
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Sep 2022 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xzWKuuxgAObxo1o/j8lQUoy1MWGw1odxgbzDPo/F0KQ=; b=Q2pQRfdBUFel3VOGiG96eT83f8
	aBG6g+FvMnrwKmgR0TEdg6o01Vb4CGIkJFGTkVz1YusGgg11D3YQZk++JbYS2Zcriw1JDQ9mb3HuO
	bw+RDgUQ1j8mZXfXiNJnyuky2A+vV0C5M+z3C4XgsgwLb416K6vOhTOQ2QPvCMOPtuSLGPbyxxECP
	/a1zP0CyvHML2qz2QEXpvff5cH5VQVCIIDqg1mGltr6btTYOW3TqshTrM+Q9SX320Hr8LA+ogs4ii
	isEHqmfWcymw7TVc0DITPT5i8rM/0Fj/FdeeCtHmnareWQs88ouqZrxejjjD+oXT7I6fZhmF3o8DF
	rv9hatVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZ6l5-00B7L7-Ex; Fri, 16 Sep 2022 08:31:35 +0000
Received: from m15112.mail.126.com ([220.181.15.112])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZ6l1-00B71A-SV
	for linux-nvme@lists.infradead.org; Fri, 16 Sep 2022 08:31:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xzWKu
	uxgAObxo1o/j8lQUoy1MWGw1odxgbzDPo/F0KQ=; b=DJgWMELzWWnc9nU0Aeyp1
	EYrnvhVObqLiOLJSjItY92SHkYcX+kfyMQK6Wr5b3YXUVYuYq5tVERX3JnlC3IOs
	LtSmLXOUboUsWOu6gOPMgZ3KlkBkS8Yk7eUWEpwn1YvV48djCQegDdRmBirvAcoP
	xRe88k0jVAQMEOgZTsNQC0=
Received: from localhost.localdomain (unknown [124.16.139.61])
	by smtp2 (Coremail) with SMTP id DMmowADHTWIVNCRjIruTBg--.13646S2;
	Fri, 16 Sep 2022 16:30:14 +0800 (CST)
From: Liang He <windhl@126.com>
To: james.smart@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: windhl@126.com
Subject: [PATCH] nvmet-fc: Fix potential Use-after-free bug in nvmet_fc_delete_target_queue()
Date: Fri, 16 Sep 2022 16:29:53 +0800
Message-Id: <20220916082953.4095940-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowADHTWIVNCRjIruTBg--.13646S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JFy5KrWxurykCFWxZrW3Awb_yoW8Jr4DpF
	Z7KFy2kw4xGFWjyw4YyFZ8XF9rXan7WrnrCryIg34Yyr15tryrZF98Ka4xuF15tFyfGFW0
	kF1jyws7tFs8JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeHqxUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hZ+F1uwMv4X3AAAsJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220916_013132_317989_03BD983F 
X-CRM114-Status: UNSURE (   7.76  )
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

In nvmet_fc_delete_target_queue(), the nvmet_fc_tgt_q_put() may free
queue if its refcount hits 0. And the following code will dereference
it to get qclock by 'queue->qlock', so there is a potential UAF bug.

Fixes: 619c62dcc62b ("nvmet-fc: correct ref counting error when deferred rcv used")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ab2627e17bb9..32e1d62017d2 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -881,6 +881,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 	struct nvmet_fc_tgtport *tgtport = queue->assoc->tgtport;
 	struct nvmet_fc_fcp_iod *fod = queue->fod;
 	struct nvmet_fc_defer_fcp_req *deferfcp, *tempptr;
+	spinlock_t *q_lock = &queue->qlock;
 	unsigned long flags;
 	int i;
 	bool disconnect;
@@ -942,7 +943,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 
 		kfree(deferfcp);
 
-		spin_lock_irqsave(&queue->qlock, flags);
+		spin_lock_irqsave(q_lock, flags);
 	}
 	spin_unlock_irqrestore(&queue->qlock, flags);
 
-- 
2.25.1


