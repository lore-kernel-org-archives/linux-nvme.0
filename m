Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D8AC432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:01:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272FB2084F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aBTW4Auc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272FB2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VNwUYNG+jX1xvPA5uLyvh87Hcxhjb9gflN0m1vSt2uc=; b=aBTW4Aucqk2/hQ
	9lq1m96Rj3txjqMcjkBD23P3SDabVuX1IAu6Ca0DYEz6zSFOmrwfMuXj/ofw+U/4WnS2adYmDSwBL
	7e0hy86d92eZqwQOIHjAwRhMEzr+PKm9xxbmLPEZ6Dd/vud5vTuBM4D+VZKRkKuJPDL/c5bzShX2a
	CZXm9+gjiTrlTLe6m3a2rjEBfJx0JsKD+bNvz2LllpEg2YWD+dX92+OC/KjzxYuaB/RvLgACgAT41
	PqOPJ4K6Rw/5e5khy0lmjX8tLgruG+MkN3DpYQybLjOHIr7kvO8vPJdW5Xn+O8asBR7kYnzOZc4dB
	o8yjhI5xPAK82SSukDLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibo8e-0003w2-G9; Mon, 02 Dec 2019 16:01:28 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibmzx-0005SD-9c
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 14:48:28 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 2 Dec 2019 16:48:13 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xB2EmC1x004689;
 Mon, 2 Dec 2019 16:48:13 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com
Subject: [PATCH 09/16] nvmet: Prepare metadata request
Date: Mon,  2 Dec 2019 16:48:05 +0200
Message-Id: <20191202144812.147686-11-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202144812.147686-1-maxg@mellanox.com>
References: <20191202144812.147686-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_064825_732104_7400237E 
X-CRM114-Status: GOOD (  11.01  )
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
index 28438b833c1b..ab3ffc6f5a4a 100644
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
 
@@ -941,6 +945,7 @@ EXPORT_SYMBOL_GPL(nvmet_check_data_len);
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
index 46df45e837c9..60011f3a50a7 100644
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
2.16.3


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
