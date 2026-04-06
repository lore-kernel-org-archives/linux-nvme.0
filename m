Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D98EF4EC9
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BDX1PhWlT04ihT2rWEm0Zx1VkEl3UrtVSdzsbOx4DV8=; b=bUl2waXJbMu6BVztlNAP8TATQe
	3vWYWLN7yOAdSRSV8akYj7HNcWZV4FkPOIr1/RpznUBYj0dvpAPDI9XPJfI40Wwl5NLTxjZQ1NKsu
	z4STVpD4j9zVH10MghXaGK9pXvSYz0otxooz+2DEDzsTFU+4qQ/LOPn6kKVAjlXWI/Qj3Y1nDB4bb
	MfcYnSCeL1+963sWu1DRqzgXVW5//Xls6ndJhMP43QnNZXjYt24xOhdwWq1mMgmuOM1qdP94Qko6m
	encHCrO8c6J8M78ERdD2OvFVcQYffFvOL8tFd3aLXvT5IgKeHoMz8FL1BpKClQ9oSIgggz+kAS6iw
	m/F4aVyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9g9P-00000004xPM-18Lz;
	Mon, 06 Apr 2026 09:21:43 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9g9N-00000004xOm-0JLe
	for linux-nvme@lists.infradead.org;
	Mon, 06 Apr 2026 09:21:42 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-3568090851aso9751906a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2026 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775467299; x=1776072099; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BDX1PhWlT04ihT2rWEm0Zx1VkEl3UrtVSdzsbOx4DV8=;
        b=aZKWg/qZfkyqffHUwfqeB+RsjoGyAPiifQCUf3OXUSAO2SlKHt6WRIh+Wyy45twaBw
         obqxiRTMEtT1P/tJfBxdFQw1N6DpX5uIr/01z3GVwhdjpMTIdpY8mJWMjX3/pGPkkCij
         mrkepUWLW8Bjlf2FBVGx9yVp8I2QZ8CIbN7UNyXKb5LAerbYZoOjPdmdQis7/UkefCN9
         zQbQ6FCEnOfItbgIPCBVdV+rrNPjmhredpmfERgM/wmB612KiXtY5QUlVfkyYLkW9KUc
         ueDxe06PJPewEv5bBe/GXXC53eEi5VFtX+7CfgvJR7mXI2jZrwHz8S3RsdXlXndv3cfE
         ob+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775467299; x=1776072099;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDX1PhWlT04ihT2rWEm0Zx1VkEl3UrtVSdzsbOx4DV8=;
        b=AFekbY7yQ1myZAGgCEzLN9pFsM4WSyR9KliL9Xo5+IXw5cDtndl/EDGbtqVuq1iJ4T
         BgTz1aqOMNi1rjzGKGmGmTDW4CflRA2mfYw9pHDRGSbzwQuBEjvHfVR5VRmKeqK/XWGC
         4ZgDYRByJ0+4OWHSJkfjXiLbe+p4KiykJXBLeealNYHXYfjaet/FCYbEI73xhbXT72eO
         HNClVH1+fHUFue4cpVYmxL6dWcAdiXSvfI3a5p3gPhUQ/cjwpCZaNctGhrw54Ad8TP29
         1CzCJIT/dp6YwdzkR6kp28WyaMGM15nB+iYKvIqh9OnodJlCs1rkotTfQGWyVdk/fndf
         nRBA==
X-Gm-Message-State: AOJu0Yxzs8Xo3St1BqNz0Vn71NYh8CnIQwyLxYVQkNS0k0IbJLAUDYYM
	yYjcAMQjnhN0ZsTDpp0liozuYhr8QGu0jPP7EwCztel12s3dBpO17sM2Il+XBcLr4VsZSxaSgTe
	J2FhwRc7z+eW+Kl+qgX5g8d1P4g==
X-Received: from pgkp23.prod.google.com ([2002:a63:f457:0:b0:c73:987f:4708])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210d:b0:38b:d9b5:5de2 with SMTP id adf61e73a8af0-39f2f1080f2mr11734892637.50.1775467298997;
 Mon, 06 Apr 2026 02:21:38 -0700 (PDT)
Date: Mon,  6 Apr 2026 09:21:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406092132.1333458-1-shivajikant@google.com>
Subject: [PATCH v3] nvme: enable PCI P2PDMA support for RDMA transport
From: Shivaji Kant <shivajikant@google.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	henrique.carvalho@suse.com
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_022141_119673_2A396D46 
X-CRM114-Status: GOOD (  11.66  )
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

Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
RDMA controller supports it.

Suggested-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>

---
v2: https://lore.kernel.org/all/20260402073001.2039625-1-shivajikant@google.com/

Changes in v3:
Dropped the reference to multiplath patch from git log as commented
by Christoph Hellwig.
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..09eefd7c3ff4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2189,6 +2189,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
+{
+	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
+
+	return ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
+}
+
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
@@ -2203,6 +2210,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 	.stop_ctrl		= nvme_rdma_stop_ctrl,
 	.get_virt_boundary	= nvme_get_virt_boundary,
+	.supports_pci_p2pdma	= nvme_rdma_supports_pci_p2pdma,
 };
 
 /*
-- 
2.53.0.1213.gd9a14994de-goog


