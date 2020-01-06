Return-Path: <SRS0=Zaot=23=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7222AC33C8C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:40:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E272072E
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZCbvD86D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E272072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SuUjMuILBeiQ21mytvlkyA94mWhIJknnJVz9VNO0E0M=; b=ZCbvD86D2EceGs
	SUfLUc6L5uKW7kSfYg2Gwzjn6xbmuzsF6RBUDW2qjXUrRyqsfFcr7BCs9Vp1y4ujmLxwvWFF9PEvh
	dLsPizKfldec8F/5Fl3ECQVr4R0j1nbctKtxECo2afVA/6pL90QWQIl5yBxsawQlkoT93hOaFZUay
	bcNoEkpyx0tTl2D72j34eLZeU8gYzLNgWd/1LlKsyDCjAq1BCykm/mKux56JsMgPCxJmGpW4QbZMR
	aU9Ns+IjXY/IomJ4LhhOE6RoGSL9EKJWRsQZE1Ex1LUJZkOkcEMKgwmPCyal/CQJ3DkM+X0DUqMX/
	dDOx5ba2q0IRRI0EUoTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioScm-0000qO-Ry; Mon, 06 Jan 2020 13:40:52 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioSZp-0005aS-K3
 for linux-nvme@lists.infradead.org; Mon, 06 Jan 2020 13:37:59 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 6 Jan 2020 15:37:37 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 006DbaFJ029740;
 Mon, 6 Jan 2020 15:37:37 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com
Subject: [PATCH 08/15] nvmet: Prepare metadata request
Date: Mon,  6 Jan 2020 15:37:29 +0200
Message-Id: <20200106133736.123038-10-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200106133736.123038-1-maxg@mellanox.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200106_053750_142566_F9EC6C30 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Allocate the metadata SGL buffers and add metadata fields for the
request. This is a preparation for adding metadata support over the
fabrics.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/core.c  | 48 ++++++++++++++++++++++++++++++++++++++-------
 drivers/nvme/target/nvmet.h |  5 +++++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b8..ab3ffc6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -863,13 +863,17 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sq = sq;
 	req->ops = ops;
 	req->sg = NULL;
+	req->prot_sg = NULL;
 	req->sg_cnt = 0;
+	req->prot_sg_cnt = 0;
 	req->transfer_len = 0;
+	req->prot_len = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
+	req->use_pi = false;
 
 	trace_nvmet_req_init(req, req->cmd);
 
@@ -941,6 +945,7 @@ bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
 int nvmet_req_alloc_sgl(struct nvmet_req *req)
 {
 	struct pci_dev *p2p_dev = NULL;
+	int data_len = req->transfer_len - req->prot_len;
 
 	if (IS_ENABLED(CONFIG_PCI_P2PDMA)) {
 		if (req->sq->ctrl && req->ns)
@@ -950,11 +955,23 @@ int nvmet_req_alloc_sgl(struct nvmet_req *req)
 		req->p2p_dev = NULL;
 		if (req->sq->qid && p2p_dev) {
 			req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt,
-						       req->transfer_len);
-			if (req->sg) {
-				req->p2p_dev = p2p_dev;
-				return 0;
+						       data_len);
+			if (!req->sg)
+				goto fallback;
+
+			if (req->prot_len) {
+				req->prot_sg =
+					pci_p2pmem_alloc_sgl(p2p_dev,
+							     &req->prot_sg_cnt,
+							     req->prot_len);
+				if (!req->prot_sg) {
+					pci_p2pmem_free_sgl(req->p2p_dev,
+							    req->sg);
+					goto fallback;
+				}
 			}
+			req->p2p_dev = p2p_dev;
+			return 0;
 		}
 
 		/*
@@ -963,23 +980,40 @@ int nvmet_req_alloc_sgl(struct nvmet_req *req)
 		 */
 	}
 
-	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
+fallback:
+	req->sg = sgl_alloc(data_len, GFP_KERNEL, &req->sg_cnt);
 	if (unlikely(!req->sg))
 		return -ENOMEM;
 
+	if (req->prot_len) {
+		req->prot_sg = sgl_alloc(req->prot_len, GFP_KERNEL,
+					 &req->prot_sg_cnt);
+		if (unlikely(!req->prot_sg)) {
+			sgl_free(req->sg);
+			return -ENOMEM;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
 
 void nvmet_req_free_sgl(struct nvmet_req *req)
 {
-	if (req->p2p_dev)
+	if (req->p2p_dev) {
 		pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
-	else
+		if (req->prot_sg)
+			pci_p2pmem_free_sgl(req->p2p_dev, req->prot_sg);
+	} else {
 		sgl_free(req->sg);
+		if (req->prot_sg)
+			sgl_free(req->prot_sg);
+	}
 
 	req->sg = NULL;
+	req->prot_sg = NULL;
 	req->sg_cnt = 0;
+	req->prot_sg_cnt = 0;
 }
 EXPORT_SYMBOL_GPL(nvmet_req_free_sgl);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e..60011f3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -291,6 +291,7 @@ struct nvmet_req {
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
+	struct scatterlist	*prot_sg;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
 	union {
 		struct {
@@ -304,8 +305,10 @@ struct nvmet_req {
 		} f;
 	};
 	int			sg_cnt;
+	int			prot_sg_cnt;
 	/* data length as parsed from the SGL descriptor: */
 	size_t			transfer_len;
+	size_t			prot_len;
 
 	struct nvmet_port	*port;
 
@@ -316,6 +319,8 @@ struct nvmet_req {
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+	/* Metadata (T10-PI) support */
+	bool			use_pi;
 };
 
 extern struct workqueue_struct *buffered_io_wq;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
