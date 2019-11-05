Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F0C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 16:21:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1732087E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 16:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d3XlWHjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1732087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uF5yQG/Zlv7at46g7xPeWJ5yIp2u/19kq52Y1LhTwvI=; b=d3XlWHjdsC1cow
	UbHL2Q6vsqhrgoLLhUHZMqFMnQoI6zmmMS508r/3r3pD2ukJij6CiNVuldARcleS5lPxUqdUzC6Cr
	U3pARLaZXrDH2ttQiHtgtacciqJgtXf6kDfwctNk/yR78P9oC1eQPnGvMVVqXoWV+fZa8AzUeHgRQ
	9rM64BjFpFIREpJ3XaND7/kXF+NiBD8jAQsFIqQlor9FMQ/TWOzWX25+AH5oBI2I5snGWyN+xa7fr
	7+ukYDnaPkWWyCjNA6io7RSMoPZU4d7mLedJtWnOhA6EOlWXfwc2q5aWC/YYvnv1PGgL3KLj132Gu
	omV3RGTwngXbTb/86ljw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS1aJ-0004ON-Qx; Tue, 05 Nov 2019 16:21:35 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS1ZO-0003SB-UW
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 16:20:44 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Nov 2019 18:20:28 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xA5GKQm4013132;
 Tue, 5 Nov 2019 18:20:27 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 07/15] nvmet: Prepare metadata request
Date: Tue,  5 Nov 2019 18:20:18 +0200
Message-Id: <20191105162026.183901-9-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105162026.183901-1-maxg@mellanox.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_082039_417633_EEA673F5 
X-CRM114-Status: GOOD (  10.81  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Allocate the metadata SGL buffers and add metadata fields for the
request.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/core.c  | 48 ++++++++++++++++++++++++++++++++++++++-------
 drivers/nvme/target/nvmet.h |  5 +++++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b8..d545ff5 100644
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
+	req->is_protected = false;
 
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
index 46df45e..8433218 100644
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
+	bool			is_protected;
 };
 
 extern struct workqueue_struct *buffered_io_wq;
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
