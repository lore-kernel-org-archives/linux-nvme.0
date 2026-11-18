Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF74606A331
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZD9qZnv4;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rb2g+MjX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=awg5QPU7vXvHHD0f/e3t9xfqcZ9CWW58r3v94L1vXwg=; b=ZD9qZnv44GeuV7
	/DRAkmNgtAnb6DdJHylem/9BgB5gUxm0I3oIxfHCBkZxNqT20iI8rjplioZX1cqXT5oJDYXVNpW1H
	lyF82HsmpO+gaCCMUI2aeuApCYE5KcPeG/AqNOF3jSodhMXPzEEyjHfTIHG0o8WnLd0wuc4pV2ucW
	JnlFhnEyclh/uK4++7JCSEtQYCo4jPUisWlkmR2ZEGlAjtBxxcM8lcfqrE8i9jpinEvcmMGJJOfEI
	hlYv/wHTAMIp9QUsnAONMQK3BSt+iVYcRhbE+grj/YnqPvxWtCFAD32IODng7WAVRMpluinwhOx39
	LJ8xdo2YxyzL9a49qCZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTdt1-00000008iIR-2AR8;
	Wed, 18 Nov 2026 11:31:35 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTdsw-00000008iEr-0KUI
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 11:31:34 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261118113122epoutp01f29a076b98a419c126aac5a74113748a~pIFZ_sn6u1340313403epoutp01X
	for <linux-nvme@lists.infradead.org>; Wed, 18 Nov 2026 11:31:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261118113122epoutp01f29a076b98a419c126aac5a74113748a~pIFZ_sn6u1340313403epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795001482;
	bh=awg5QPU7vXvHHD0f/e3t9xfqcZ9CWW58r3v94L1vXwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rb2g+MjXrypvPTEP4CwC0my0BbPfSdDP4nVFUqm8wCVBqi4JuboNg0xy+wjnzC96G
	 RIt1tHks83QeKe2nhWTh2maNfZYB4cnGTSgAeYk1IWrN8EjggJBJF6h9qz/rUPNXAu
	 gsXEY17BqM/rC1TBb1q0+D06r/9UoMpLX/iXUqiU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261118113121epcas5p436c075dc5f0f036052b0d07e616aef20~pIFY0R88h2687826878epcas5p4j;
	Wed, 18 Nov 2026 11:31:21 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jTzvD2n9tz2SSKX; Wed, 18 Nov
	2026 11:31:20 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261118103455epcas5p22384b4ed044dbf65efe94d6a910e4325~pHUHfd2FN0491304913epcas5p2a;
	Wed, 18 Nov 2026 10:34:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261118103453epsmtip2fc6fdb19580aa329f96b44b3ceeef734~pHUF1-VdB0208902089epsmtip2E;
	Wed, 18 Nov 2026 10:34:53 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	jgg@ziepe.ca, leon@kernel.org, asml.silence@gmail.com
Cc: nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [RFC 3/4] RDMA/core: Add ib_dma_buf_dynamic_attach()
Date: Wed, 18 Nov 2026 16:03:26 +0530
Message-Id: <20261118103327.1788667-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261118103327.1788667-1-anuj20.g@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261118103455epcas5p22384b4ed044dbf65efe94d6a910e4325
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261118103455epcas5p22384b4ed044dbf65efe94d6a910e4325
References: <20261118103327.1788667-1-anuj20.g@samsung.com>
	<CGME20261118103455epcas5p22384b4ed044dbf65efe94d6a910e4325@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_033130_437516_D3C2CA60 
X-CRM114-Status: GOOD (  17.98  )
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

ULPs must not use the DMA device of an ib_device directly, but a ULP
importing a dma-buf has to attach it to that device.

Add a helper that attaches a dma-buf to the DMA device of an ib_device.
Devices using virtual DMA, such as rxe and siw, have no DMA device and
are rejected with -EOPNOTSUPP.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/infiniband/core/verbs.c | 28 ++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h         |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index c4eb1de44155..eb3036d6f7e1 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -38,6 +38,7 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/dma-buf.h>
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -3217,3 +3218,30 @@ void rdma_free_hw_stats_struct(struct rdma_hw_stats *stats)
 	kfree(stats);
 }
 EXPORT_SYMBOL(rdma_free_hw_stats_struct);
+
+/**
+ * ib_dma_buf_dynamic_attach - attach a dma-buf for DMA by an RDMA device
+ * @dev: RDMA device that will access the dma-buf
+ * @dmabuf: dma-buf to attach
+ * @importer_ops: importer callbacks, see dma_buf_dynamic_attach()
+ * @importer_priv: importer private data, see dma_buf_dynamic_attach()
+ *
+ * Attach @dmabuf to the device that does DMA for @dev. Devices using
+ * virtual DMA have no such device and are not supported.
+ *
+ * Return: the attachment, or an ERR_PTR() on failure.
+ */
+struct dma_buf_attachment *
+ib_dma_buf_dynamic_attach(struct ib_device *dev, struct dma_buf *dmabuf,
+			  const struct dma_buf_attach_ops *importer_ops,
+			  void *importer_priv)
+{
+	if (ib_uses_virt_dma(dev))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return dma_buf_dynamic_attach(dmabuf, dev->dma_device, importer_ops,
+				      importer_priv);
+}
+EXPORT_SYMBOL_GPL(ib_dma_buf_dynamic_attach);
+
+MODULE_IMPORT_NS("DMA_BUF");
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index d6eaa3fee66e..c287bee1dd09 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4323,6 +4323,13 @@ static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
 	return dma_pci_p2pdma_supported(dev->dma_device);
 }
 
+struct dma_buf;
+struct dma_buf_attach_ops;
+struct dma_buf_attachment *
+ib_dma_buf_dynamic_attach(struct ib_device *dev, struct dma_buf *dmabuf,
+			  const struct dma_buf_attach_ops *importer_ops,
+			  void *importer_priv);
+
 /**
  * ib_virt_dma_to_ptr - Convert a dma_addr to a kernel pointer
  * @dma_addr: The DMA address
-- 
2.25.1


