Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4871CC55ABD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:15:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC00222C4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pcvGQq1j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ADKc3XSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC00222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xPf1twgfk3SeKytsoyXeizJo4S5CZOmbzTdOFMOAO64=; b=pcvGQq1jY1J2U/xxwsbfPow7Of
	CmJ51RrU6+/bllfpx49l0upFTq2F7SXRUZmPryDm2mttxpmMv/EhR0EZWMjXXJeJbuGks7baeZbb6
	UJAw3+BS3Jk17iXB/cPgUHGh8Fs2ZlzooJyYCUUfUvZgAK5JlW+cXw0RIDtnHqCnubLwC2BptM5Jq
	tdC/vjpVeuw4HTiUpNPsc1hXiUwOhRp5Be3H55W2xnmDNlWgsp8CNeWx7dC9v/27qg7gjj+98WUw9
	z+Q+id/mAlWGuUtTP5yPcIASu32a9FBo//mbKOvEWD3vAGsJ0UHXv+thE5CMNgz6oe9fXmBwGaLQk
	DECCrZvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZfL-0005eP-PK; Mon, 16 Nov 2020 08:15:11 +0000
Received: from m12-18.163.com ([220.181.12.18])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZfH-0005c1-T8
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 08:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=6bJg3ejTvq9DaiVDjf
 gwpQMA4ibvyR5v08cg9A9UN64=; b=ADKc3XSu1C9+3zzQDt8iyXavYVVnpbJbp9
 gNHDFZRSK0FnKO71rShaCFSBPR7JZ+MaVnpu652FoDAB9X1bE9WZVsUpfL9fEAT7
 V4VV93x75U4GJC7TVcz3OBf3xgqFuU/jY3k1/nX3s6PP9Q4HaAA+pPI9dzsDjzLe
 vjOqogkPU=
Received: from localhost.localdomain (unknown [223.104.212.42])
 by smtp14 (Coremail) with SMTP id EsCowACnrQn_NLJfzqOBEQ--.14367S2;
 Mon, 16 Nov 2020 16:14:56 +0800 (CST)
From: jackygam2001 <jacky_gam_2001@163.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] NVME:target:rdma fix bug nonemtpy wait list of queue causing
 kernel panic
Date: Mon, 16 Nov 2020 08:14:53 +0000
Message-Id: <20201116081453.74644-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowACnrQn_NLJfzqOBEQ--.14367S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17Aw45tw4DKFy7GF15Jwb_yoW8KFyrpF
 WrGr13ua97tr4Ik3y3Aa4UWFWSqw4rur47AryxGwn8JF4jyrWrXanxG3srZry8GF97Jr4r
 CF1Dtrsaka1rJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRWq2iUUUUU=
X-Originating-IP: [223.104.212.42]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBXgHeKVaD4iYWGQAAs2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_031508_528050_18187E90 
X-CRM114-Status: GOOD (  11.77  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 jackygam2001 <jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

in our lab, when target is processing queue's connection
(queue->state==NVMET_RDMA_Q_CONNECTING), and the host sends
a command which will be put into wait list to target,
Before the command was processed, the host sent a discconnect
command to target, then the target will process disconnect command,
it will schedule a kworker to free the pre allocatedrsps array, and
it will cause kernel panic, because some items of rsps are in wait list.

Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>
---
 drivers/nvme/target/rdma.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ae6620489457..c6c892a43f68 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1335,6 +1335,35 @@ static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 		       queue->send_queue_size + 1);
 }
 
+static void nvmet_rdma_destroy_queue_wait_list(struct nvmet_rdma_queue *queue)
+{
+	unsigned long flags;
+	struct nvmet_rdma_rsp *rsp;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	while (!list_empty(&queue->rsp_wait_list)) {
+		rsp = list_first_entry(&queue->rsp_wait_list,
+				struct nvmet_rdma_rsp, wait_list);
+		list_del(&rsp->wait_list);
+		nvmet_rdma_put_rsp(rsp);
+	}
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+}
+
+static void nvmet_rdma_destroy_queue_wr_wait_list(struct nvmet_rdma_queue *queue)
+{
+	struct nvmet_rdma_rsp *rsp;
+
+	spin_lock(&queue->rsp_wr_wait_lock);
+	while (!list_empty(&queue->rsp_wr_wait_list)) {
+		rsp = list_first_entry(&queue->rsp_wr_wait_list,
+				struct nvmet_rdma_rsp, wait_list);
+		list_del(&rsp->wait_list);
+		nvmet_rdma_put_rsp(rsp);
+	}
+	spin_unlock(&queue->rsp_wr_wait_lock);
+}
+
 static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 {
 	pr_debug("freeing queue %d\n", queue->idx);
@@ -1347,6 +1376,8 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 				queue->recv_queue_size,
 				!queue->host_qid);
 	}
+	nvmet_rdma_destroy_queue_wr_wait_list(queue);
+	nvmet_rdma_destroy_queue_wait_list(queue);
 	nvmet_rdma_free_rsps(queue);
 	ida_simple_remove(&nvmet_rdma_queue_ida, queue->idx);
 	kfree(queue);
-- 
2.17.1



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
