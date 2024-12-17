Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E84E77184
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qc5INiR9oS6Tzu/IBwcX1DD7n9mjfYeT0K9VFkFf/U8=; b=rX8Qgi6p44fWP2BkYv6n1mG18l
	ejZU5Y5ULyjqHlkNOrtvq4LM6YC38aevYfRfyL4IGa0O4s6ikVJ2upwO8B31nUidLwf1/Myy+1F7K
	rPeW18xTLpKHg5WL5nT9XJiCtutSvXE0DxzED14/iU0tTDst6ghGte31tpIUkJ3dVl+vqTMKqSfMc
	NsWwIgRcZg7pBoScxo8HMv5Mw9iiMDReeyfkIx3PDuLVFx5cX/FgvgLkvrkRE5L81bXVUbQLleUL4
	u6K4KnGQgtVjAJirhBJBhwOPiNrH+P8K4dfk1NrJQITvcws52jY0d4dAaHTv0M1x3wSjOglWiUupI
	/CXANLyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNaXa-0000000EChi-3zuX;
	Tue, 17 Dec 2024 16:35:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNa4M-0000000E590-3lcD
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 16:05:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6B4C7A41A15;
	Tue, 17 Dec 2024 16:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D4DC4CED6;
	Tue, 17 Dec 2024 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451509;
	bh=fyIlZNVelf5SMbRdM6Ux9PY3hbaZfU1cULKHILvSoBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7ywJlHhbGbwviHYvi7RJfsUdIiJW0Z20FQx9HFCIReWRiDBYegxbkfFNvVVhIr+G
	 0UmffETaTGh+3We1956dG8dOZwnUgYj7m4pnv3OYY3oPunw+UCLr0WwldSh8cxsd4h
	 RUCj/NA3PJKO3JBhIFrrv/2r4zF9E8GAB6LQqm+CfHtJ8PxzAiFGfp3l7X3dY32uzI
	 xnWhV1dbSaiRLx0mvzmmqtq0vsY7SeYT+E8msayPSU2ZncFNihIxepnd+sI2NDkmIn
	 n8PryXTsGCDqmg/359y0Nb1KmrvFoVuvtFAZTKXh9b8rxfdIzjFnSc8IFG4FisjR6P
	 xbPJY4vSbnHuA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/3] debug prints - DO NOT MERGE
Date: Tue, 17 Dec 2024 17:04:51 +0100
Message-ID: <20241217160448.199310-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217160448.199310-4-cassel@kernel.org>
References: <Z2Gf9lv6hLROjM8e@ryzen>
 <20241217160448.199310-4-cassel@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=cassel@kernel.org; h=from:subject; bh=fyIlZNVelf5SMbRdM6Ux9PY3hbaZfU1cULKHILvSoBQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNITFyoULRFMnNOzcVtH0f3U/9utrVcucprUeO7RArFHe X6VSsvedJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAipj8Z/mdu4vaszuNsvPdn 9RPjVh+uZ7KaQn/8wqbevMe/LXD9UT6GP3yRvEUlFe+ZVgf12159fdj8aqUx31Tu2QUJTA+2PHS 04QIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_080510_996874_04B7BAF4 
X-CRM114-Status: UNSURE (   9.99  )
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

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 29cbd947df57..eb69a608d087 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -197,6 +197,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
+	trace_printk("start transfer for desc: %px\n", desc);
 	child = list_first_entry_or_null(&desc->chunk->list,
 					 struct dw_edma_chunk, list);
 	if (!child)
@@ -545,6 +546,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		}
 	}
 
+	if (xfer->type == EDMA_XFER_MEMCPY)
+		trace_printk("DMA_MEMCPY tx_prep desc: %px\n", desc);
+
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
 
 err_alloc:
@@ -653,6 +657,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
+			trace_printk("REQ_NONE desc: %px\n", desc);
 			if (!desc->chunks_alloc) {
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
@@ -664,6 +669,8 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 			break;
 
 		case EDMA_REQ_STOP:
+			desc = vd2dw_edma_desc(vd);
+			trace_printk("REQ_STOP desc: %px\n", desc);
 			list_del(&vd->node);
 			vchan_cookie_complete(vd);
 			chan->request = EDMA_REQ_NONE;
-- 
2.47.1


