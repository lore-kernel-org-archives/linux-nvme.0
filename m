Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0988C3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mn+4OScY3XRHK3/oW8fy9rYRq32M1Cn4hjrpDWV3OS4=; b=RFimsPMVAltBaIX+GNh/r0gKGM
	Ng5fCnmriuLxI0NcI8ELhdSjBvypp1826ugu8emdv9icwXlK8nBE23cgP4Px7e78rb0sr5XU7AcrM
	L84JJfQSCeZGG4h+c2nuz+rap9Yi6DjMSuWS1wx7zOyZPlvgsWOL5jvx0zxKgUcwKyeKMYU3UHrw7
	xwClaCOMzMR5s756jivDkM3Fy828wbWOtv0ZMRgEm2tKlUx5Ga/uSsp8Nfx55jUssoSHui4BA1b6n
	rEGjAvePEDuy22N624IL3+08JrTORVF9jbSoh5ArinGLozRMZDt+XNNM09imI2Bp3ZNU0crwqozi+
	kly8xVSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzTj-0000000D2TJ-1HYG;
	Wed, 17 Jul 2024 07:53:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzTh-0000000D2Ss-3YDI
	for linux-nvme@bombadil.infradead.org;
	Wed, 17 Jul 2024 07:53:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Mn+4OScY3XRHK3/oW8fy9rYRq32M1Cn4hjrpDWV3OS4=; b=QtB8NZd1oxf8QPUYzOs/PP9B7T
	tcCnI3NMrMv63nyb9rPSNz8cRaWBD7l8WFQ2+enES/cud4uQ6mPjnALzmltM20P3V8zdZO9WeyEZo
	QbuuEJH0mhHBts1KZRzQU1lpnwHM1DVQriFhs/WppKjUFTE4jvZwJhM9UNC/4qFEQibHGt6Herr7S
	wiHMhvIbpYq2UDBD3QyHXjUc279bYq+b6FZeEjkKTunKDX/RS9a5KUN1SquzIeTOUVrNNU69eX5cY
	z+qs9nXAsu6zJO+ZVR5BhMRwprMySJhOutsxzY+571+ko5KPhELcp5dFRDsUXdi4asdLgzBMUiRqh
	wrmiDzTQ==;
Received: from m15.mail.163.com ([45.254.50.219])
	by desiato.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzTe-00000002GHO-1XbK
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 07:53:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Mn+4O
	ScY3XRHK3/oW8fy9rYRq32M1Cn4hjrpDWV3OS4=; b=EMZOkiDjvI4cASb49uHnK
	E3PYiy/9fs7dix163PMbuAG+nu8ogaUxJoOZQyWgSA3nIADEZqczK01SQzF7NmcQ
	mQ58D9GHy82U7UMj2JAXlbAv28panIPCY68n51TehLMcWyde2iZbBt8didDlEWYX
	RRoMca36gnJzkmnqPi4hdU=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3f3ddeJdmTsbxAA--.36565S4;
	Wed, 17 Jul 2024 15:53:17 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 2/2] nvmet-rdma:  add unbound_wq support for nvmet-rdma
Date: Wed, 17 Jul 2024 15:52:08 +0800
Message-Id: <20240717075208.87324-3-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717075208.87324-1-jacky_gam_2001@163.com>
References: <20240717075208.87324-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f3ddeJdmTsbxAA--.36565S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryDAw17XryruF45AFyDAwb_yoW8Wr1rp3
	95CF17Z393KrW2ya98KF4DXan3u3yfuw4UCas3t34UWFnaqrZ3X3WDtry29rW8GF97Jr4x
	Ja1DXr4kuF45WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zirWrJUUUUU=
X-Originating-IP: [223.166.237.119]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEA8fKWXAl+IiRAAAsf
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_085331_107625_914441F8 
X-CRM114-Status: UNSURE (   9.54  )
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

Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>
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


