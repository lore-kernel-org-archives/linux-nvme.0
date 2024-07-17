Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12396C3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e62nITpAz+fELQO3Wpxu5xtovyKXRrI0UgadVew2J8g=; b=1epNI6X7g8DtoSoHArQQF8h9S5
	y8OqDQBntPcahJcvGDcBrXEJDwAjD0ePEwCZvRWFdeugHpb6cTf/9p+9Cg2/+cn7Bnlwc95heZMXO
	+MfsGHy1U2139pJ2pHwyAbvTjzDu+Gwcfj1xWNAR9grTDkEYOUh5Vl+ZgcV9fTCf3GXv2/r76wW+O
	2wsqfUD1glhMZoTq2Td1eChynOF1GyGMs1CsAYMfGFI5A3Rz4z0R2mHb9V+C8DuzuKY6RAguu0Ojz
	VNf6W1TPCNHgOj9mboAQAZe1N0hQ0z+2HhjFacu7Q7H71V2E25MuEc+PTm4uaMCUsBr7x+IvKwV0s
	f8uD7Juw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0lk-0000000DHaL-2LMm;
	Wed, 17 Jul 2024 09:16:16 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0lg-0000000DHXz-1fkl
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e62nI
	TpAz+fELQO3Wpxu5xtovyKXRrI0UgadVew2J8g=; b=dXPKbUMUiCVOCRLDlbUhL
	JTkKGnwl6fN0EKLUKceZoZ3MaE6CYb4X3Kob0RczYUzD2Dg0HI06oE+DmBuwzf91
	RPf5Ez0iaqoSIopLecFb09zJASaHzP7O02mtAPsb7vVCsAIuV8LoOlidyxEe40gq
	TuyMDX1n7uC+mGLNrSFgFA=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Py3Ki5dmGNFmDQ--.41698S4;
	Wed, 17 Jul 2024 17:16:03 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v2 2/2] nvmet-rdma:  add unbound_wq support for nvmet-rdma
Date: Wed, 17 Jul 2024 17:14:51 +0800
Message-Id: <20240717091451.111158-3-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717091451.111158-1-jacky_gam_2001@163.com>
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3Py3Ki5dmGNFmDQ--.41698S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryfGFyUAr4UKFy8tF4Utwb_yoW8WrWDp3
	93CF17Z397KrW2ya98KFsrXan3u3yfu3yUCas3t34jgFn5trZ3X3WDtry29rW8GF97Jr4x
	Ja1UXr4kZF4Y9wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zirWrJUUUUU=
X-Originating-IP: [223.166.237.119]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBMfKWXAmTj9MwABsG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021612_784178_F972D3A7 
X-CRM114-Status: UNSURE (   9.47  )
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

To define a module parameter use_unbound_wq to enable unbound
workqueue to handle RDMA's IO of CQ.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/rdma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1eff8ca6a5f1..bfd7106316bc 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -155,6 +155,10 @@ static int nvmet_rdma_srq_size = 1024;
 module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
 MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
 
+static bool use_unbound_wq;
+module_param(use_unbound_wq, bool, 0444);
+MODULE_PARM_DESC(use_unbound_wq, "use unbound workqueue to handle IO request: Default false");
+
 static DEFINE_IDA(nvmet_rdma_queue_ida);
 static LIST_HEAD(nvmet_rdma_queue_list);
 static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
@@ -1259,7 +1263,11 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	 */
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
-	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
+	if (use_unbound_wq)
+		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
+				   queue->comp_vector, IB_POLL_UNBOUND_WORKQUEUE);
+	else
+		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
 				   queue->comp_vector, IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
-- 
2.26.2


