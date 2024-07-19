Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B30C3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 09:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKu0fKvWQXE0pPWAo1bepOPxqYj9sANjynMiSpfTLR8=; b=atpH0g+If+SCPcd3QJRohqVrr2
	99415iHBLCiTkKPSuUZq1z2C68TGaGV+HN1anL3YcV+5Y9T/9o782/iCSp7hgVfvIxjVIom6d1H2M
	KyTVJRmotUdHvx7/DZfcXBrevGateD29731WCEKU3LoNvBoBnwfenieXJQBGmSKkSVI5DLP00ECmE
	+ZuhWmLdY9e08hVB3mGQ9J9JqtjUoDMtNpwSkUAJ9WrZpBFnQGt+mdtUjTDRzDLbRqygwSIg5xpEM
	6LntTAPJtsP7D7d/7v2AbIXc/zvxopwI6jlmlQr7Cwp4hKhlJO+sVHDXhTMdl3LlM9w6tQ3HRcF2L
	AA4dLFQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUjnu-00000002DAI-0mJ8;
	Fri, 19 Jul 2024 09:21:30 +0000
Received: from m15.mail.163.com ([45.254.50.219])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUjnr-00000002D9H-0tr0
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 09:21:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yKu0f
	KvWQXE0pPWAo1bepOPxqYj9sANjynMiSpfTLR8=; b=YfU3zkIG67nAAWsWjgJTM
	wA4dykFFmuav7aEaWRXlVzreqchqqj0Mg88gQpV357kOqSpW3YZmW02iZyZVIefQ
	BAO9ui77fhGszQEuZZHzQSXDg+WIJMNNZ0kvrHc9g+eSPY1SwrjZN8cfIugH1Qh4
	4YObhCkWPD5yaW0y5t0zSg=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3T3X7L5pmYK8DAg--.13202S4;
	Fri, 19 Jul 2024 17:21:11 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v3 2/2] nvmet-rdma: use unbound_wq for nvmet-rdma by default
Date: Fri, 19 Jul 2024 17:19:59 +0800
Message-Id: <20240719091959.17163-3-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240719091959.17163-1-jacky_gam_2001@163.com>
References: <20240719091959.17163-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3T3X7L5pmYK8DAg--.13202S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1rCFWUGFy8WFWDKr4Uurg_yoWDJFbEgr
	1xJF1Iga1kCr1qvr1qk3W3Ca4DKa4FgF1IyFs7tr45Aryru3y5Aw1kZFn3urW8Zw18uFyj
	vr17GwsIyryrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt73vUUUUUU==
X-Originating-IP: [223.166.237.249]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKAshKWXAmWCW5wAAsG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_022127_646189_082129FD 
X-CRM114-Status: UNSURE (   9.67  )
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

To use unbounded workqueue to handle RDMA's IO of CQ by default, which
was discussed in below session.

https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1eff8ca6a5f1..6a54217e3bc5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1260,7 +1260,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
 	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
-				   queue->comp_vector, IB_POLL_WORKQUEUE);
+				   queue->comp_vector, IB_POLL_UNBOUND_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
-- 
2.26.2


