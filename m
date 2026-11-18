Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7151606A330
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4Xwc1SZC;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=N+posujH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eheZv0Bqqe1P3/H2B3k9R4/IG4AFsFlcH3JrS6tN1+c=; b=4Xwc1SZCHwMysB
	A/mATg+N39fgavbvHttFSxpKz6KsBqnVsbadeaeYbRrqAS0kyUfSH6HqwmhmCZXQtiuAUHiGIb4ml
	cMQsxrh/FlZl4IEzdKFwXgh0/jAd86Bc6tAFQPH7Tbt6LOJsMIKW0f7dmKNn20pdN2o3jXS1FnYw/
	2CrBL6YsO81fMB9SKkJsy6/mdNtkvXYTyxNLkLRdGzkzkohSBEcORxy9nHp766d4HqhH+0WijYJiu
	YkQwjH551UrBT5xC8pPL16oq7NmsyrK6D9NW7iumSbOjfU+dRTTujsF8HwLxs8j6ermceB6/mjnZr
	QB10Y26JFwGkftM1AnvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTdt1-00000008iIA-1ZRN;
	Wed, 18 Nov 2026 11:31:35 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTdsq-00000008iER-2Na6
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 11:31:32 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261118113118epoutp04ca8d81b290cc50d055e26da50611416e~pIFWcmq9r1293312933epoutp04B
	for <linux-nvme@lists.infradead.org>; Wed, 18 Nov 2026 11:31:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261118113118epoutp04ca8d81b290cc50d055e26da50611416e~pIFWcmq9r1293312933epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795001478;
	bh=eheZv0Bqqe1P3/H2B3k9R4/IG4AFsFlcH3JrS6tN1+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+posujHDr5gHJVLD3opNPDnlmK9uGN4DW6mu8Lf5XAmnfp8DEGvbD5sLW2d8+5Rf
	 VmSsyAY4OC/uxJ9mr+vm5oUb7v5y4EHjVnCdX6fILJFoMk+CECFQoKF569kmnqwOjs
	 TrI4xCqOcMK7wc/hRxSmxiwxVMcc8IHAUf1A1MEw=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261118113118epcas5p2dc5d04351992108aed2a219b2c1a27d5~pIFV-NmX00429904299epcas5p2N;
	Wed, 18 Nov 2026 11:31:18 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4jTzv90pl2z3hhT8; Wed, 18 Nov
	2026 11:31:17 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261118103453epcas5p38649877d029a06c4b519578f5cfccc4d~pHUGDpfpI0683606836epcas5p3r;
	Wed, 18 Nov 2026 10:34:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261118103451epsmtip226a49e820d488726cec48d3042c9d1fb~pHUDvJ_Yo2865628656epsmtip21;
	Wed, 18 Nov 2026 10:34:51 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	jgg@ziepe.ca, leon@kernel.org, asml.silence@gmail.com
Cc: nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [RFC 2/4] nvme: let transports provide the dma-buf attachment
Date: Wed, 18 Nov 2026 16:03:25 +0530
Message-Id: <20261118103327.1788667-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261118103327.1788667-1-anuj20.g@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261118103453epcas5p38649877d029a06c4b519578f5cfccc4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261118103453epcas5p38649877d029a06c4b519578f5cfccc4d
References: <20261118103327.1788667-1-anuj20.g@samsung.com>
	<CGME20261118103453epcas5p38649877d029a06c4b519578f5cfccc4d@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_033125_980515_4BEC1759 
X-CRM114-Status: GOOD (  18.90  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nitesh Shetty <nj.shetty@samsung.com>

dma-bufs are currently attached to ctrl->dev by nvme-core. This works
for nvme-pci, but fabrics transports can use a different device for
data DMA.

Let transports create the attachment and pass it to nvme-core, which
takes ownership of it. nvme-pci continues to attach to its PCI device.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/dmabuf.c | 35 ++++++++++++++++++++++-------------
 drivers/nvme/host/dmabuf.h |  6 +++++-
 drivers/nvme/host/pci.c    | 11 ++++++++++-
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/dmabuf.c b/drivers/nvme/host/dmabuf.c
index 1f9104a5d75e..f68ffa89e56f 100644
--- a/drivers/nvme/host/dmabuf.c
+++ b/drivers/nvme/host/dmabuf.c
@@ -15,10 +15,11 @@ static void nvme_dmabuf_invalidate_mappings(struct dma_buf_attachment *attach)
 	dma_buf_io_invalidate_mappings(ctx);
 }
 
-static const struct dma_buf_attach_ops nvme_dmabuf_importer_ops = {
+const struct dma_buf_attach_ops nvme_dmabuf_importer_ops = {
 	.invalidate_mappings	= nvme_dmabuf_invalidate_mappings,
 	.allow_peer2peer	= true,
 };
+EXPORT_SYMBOL_GPL(nvme_dmabuf_importer_ops);
 
 static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx *ctx)
 {
@@ -127,23 +128,21 @@ static const struct dma_buf_io_ops nvme_dma_buf_io_ops = {
 
 static int nvme_init_io_ctx_locked(struct nvme_ctrl *ctrl,
 		struct nvme_dma_buf_list *buf_list,
+		struct dma_buf_attachment *attach,
 		struct dma_buf_io_ctx *ctx)
 {
 	struct nvme_dma_buf_io_ctx *nvme_ctx;
-	struct dma_buf_attachment *attach;
+	int ret;
 
-	if (buf_list->dead)
-		return -ENODEV;
+	if (buf_list->dead) {
+		ret = -ENODEV;
+		goto err_detach;
+	}
 
 	nvme_ctx = kzalloc_obj(*nvme_ctx);
-	if (!nvme_ctx)
-		return -ENOMEM;
-
-	attach = dma_buf_dynamic_attach(ctx->dmabuf, ctrl->dev,
-					&nvme_dmabuf_importer_ops, ctx);
-	if (IS_ERR(attach)) {
-		kfree(nvme_ctx);
-		return PTR_ERR(attach);
+	if (!nvme_ctx) {
+		ret = -ENOMEM;
+		goto err_detach;
 	}
 
 	nvme_get_ctrl(ctrl);
@@ -155,16 +154,26 @@ static int nvme_init_io_ctx_locked(struct nvme_ctrl *ctrl,
 	ctx->dev_priv = nvme_ctx;
 	ctx->dev_ops = &nvme_dma_buf_io_ops;
 	return 0;
+
+err_detach:
+	dma_buf_detach(ctx->dmabuf, attach);
+	return ret;
 }
 
+/*
+ * @attach must have been created with nvme_dmabuf_importer_ops and @ctx as
+ * the importer private data. The context takes ownership of it, and it is
+ * detached on failure or when the context is released.
+ */
 int __nvme_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
 		struct nvme_dma_buf_list *buf_list,
+		struct dma_buf_attachment *attach,
 		struct dma_buf_io_ctx *ctx)
 {
 	int ret;
 
 	mutex_lock(&buf_list->lock);
-	ret = nvme_init_io_ctx_locked(ctrl, buf_list, ctx);
+	ret = nvme_init_io_ctx_locked(ctrl, buf_list, attach, ctx);
 	mutex_unlock(&buf_list->lock);
 	return ret;
 }
diff --git a/drivers/nvme/host/dmabuf.h b/drivers/nvme/host/dmabuf.h
index 08a5b8e5d771..0c12ee6d3584 100644
--- a/drivers/nvme/host/dmabuf.h
+++ b/drivers/nvme/host/dmabuf.h
@@ -44,9 +44,12 @@ static inline struct nvme_dmabuf_map *nvme_req_to_map(struct request *req)
 	return to_nvme_dmabuf_map(map);
 }
 
+extern const struct dma_buf_attach_ops nvme_dmabuf_importer_ops;
+
 void __nvme_remove_dmabufs(struct nvme_dma_buf_list *list);
 int __nvme_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
 		struct nvme_dma_buf_list *buf_list,
+		struct dma_buf_attachment *attach,
 		struct dma_buf_io_ctx *ctx);
 
 static inline void nvme_remove_dmabufs(struct nvme_dma_buf_list *list)
@@ -57,11 +60,12 @@ static inline void nvme_remove_dmabufs(struct nvme_dma_buf_list *list)
 
 static inline int nvme_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
 		struct nvme_dma_buf_list *buf_list,
+		struct dma_buf_attachment *attach,
 		struct dma_buf_io_ctx *ctx)
 {
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-	return __nvme_init_dma_buf_io_ctx(ctrl, buf_list, ctx);
+	return __nvme_init_dma_buf_io_ctx(ctrl, buf_list, attach, ctx);
 }
 
 static inline void nvme_init_buf_list(struct nvme_dma_buf_list *buf_list)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1af356abde0b..412fbc3d9544 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3771,8 +3771,16 @@ static int nvme_pci_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
 		struct dma_buf_io_ctx *ctx)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	struct dma_buf_attachment *attach;
 
-	return nvme_init_dma_buf_io_ctx(ctrl, &dev->dmabufs, ctx);
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return -EOPNOTSUPP;
+
+	attach = dma_buf_dynamic_attach(ctx->dmabuf, dev->dev,
+					&nvme_dmabuf_importer_ops, ctx);
+	if (IS_ERR(attach))
+		return PTR_ERR(attach);
+	return nvme_init_dma_buf_io_ctx(ctrl, &dev->dmabufs, attach, ctx);
 }
 
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
@@ -4571,5 +4579,6 @@ MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
 MODULE_DESCRIPTION("NVMe host PCIe transport driver");
+MODULE_IMPORT_NS("DMA_BUF");
 module_init(nvme_init);
 module_exit(nvme_exit);
-- 
2.25.1


