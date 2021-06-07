Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1E7C48BCD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:56:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF94611AD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF94611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1qlZbf6h6FYksk5f3m0ENqglctPvdkBGA9sQHOFkXg4=; b=WsKFnKFkb3Z3ec
	YJ+ASt+LOmDgUVVBZ1wNVKtHPRUZkTEV3zU/jpNY7aGGy8FyIFxgDh14J3jnSDRxvkly58gIxz3Hh
	JQE8gbUhi90FS/6Mn1YBbYxnnY5uoAfgNl7vVt2GdQXbFFTCOg8LzfJcpUMNR4xzr+g2FaFsOeBY6
	WX9gqNJd5sL0EoB3P/JIhbOrBsngBIMvfLckfJyOpwfoJmjV6LHMOhHI6biLHwJ1hiIiHRI4HQ4lI
	BMGvOLninnWMdIthb6jtD4GLlZK8e1b/jGT4GZ/+rH19TTcJPNQg2E3jQ3U57476PWNXERZzbNWZv
	FRj4d0fY5pIuEGOzmNXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqLLr-005DTt-60; Mon, 07 Jun 2021 19:55:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqLLP-005DLG-GT
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 19:55:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623095731; x=1654631731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xqqg40po/AaGH07x8ExSS8XVTxoNWMTcmfhCj0rzYA8=;
 b=FHKPJzFiS8TbcQPwFXeVqLYL/LFm0B2Gn6DTezAJRm57yI65i4EHZGk9
 RjH3WcZpXYFIWs7NZH8GVqDFPu7BpxDHa6HXLrFWI/+yBrFMiWuNtQLmN
 eQb1dK7ysQXDxuW4OlIfWgKxfAuAK0DSCY45SlnlT+pLjN/pQVoiA91j8
 u2LRP3sLimYaTX6X6Z5NF2PrXuzdvsZW1r07pPAqVfAW8+PQ62mNC/hRu
 cvjpHTVV/7CzesGiveAsBRN1LvK4/FZvpQhBgFN+AqP2GdU8kDIefJygo
 HMeheRhZB6M8wJ7thWbTW7Rr1wS1O9ylClJYIIo4AeA2s7atog8buYSL7 A==;
IronPort-SDR: 54vv4W1yTirF+sLH9CE45307PVaH8+BrTg84fiwaV3A8xYyyRCQW81BSSvdynST1nAXy8mHF//
 yl6eudZSOG5X0mjmsxopVF2CqyNkx9Elz2vMnmM4qMMiwMn4Alnbo+Q+8h44b+rs0msAsMoTOn
 yjCgnnfskRacLNQGdDVi9s2m5dF81MDKLz/Eg4YBs+dLqBEAMf5WQRIF9wV35xoQAjIoi4UK6k
 8mfnolzK1h7HUNBnUM0Q69fbsnnLgM5i/LANOGgcre/wdi3IdtN1MeEJwh+3tm41s6twcAOAgl
 QhQ=
X-IronPort-AV: E=Sophos;i="5.83,255,1616428800"; d="scan'208";a="170344000"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 03:55:30 +0800
IronPort-SDR: yaFWSsUVz4LwtDPVQeX34i9fUBm1Az0SKD8azv0We/d8Xf6u2bBpQuSGB31OisQpTyEvruoPhb
 P3WRL690L7DCmEzYwYbVLCAR+G+i5yA8c9Xgck127duzdKhIAcOvZWJKpGyFGorKRTi4QKeLKn
 ZfUdqhW3bwYiwJ9OAVgX0aYNSxGNt/hI3nErLH8/qScVdT8MQwMiQXUvUZOsb8JJPvv6vqksBN
 lyKGCmGafoFUSQbHPMvlkyyG+6Qe9WHTcLS2TP6IcG/UTXhB8MhY+OMk1k/HXvcjuZFBsQlQEx
 g3M3bUQ+M9TywlywPdTojYS+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 12:33:12 -0700
IronPort-SDR: cXosEpsoJSxj74HWVXu2775/+mdnNJ+q94jNMeC5UVou4g9xhy0QE+evNJdV3ku13kQU7pb02S
 2JtpSk74cBv/6weRopGk/hh6HK4mF0WImN253771GQ5yk671GbuEtQAfIVbyftfLNP5kGp+lTj
 7aZTkJ9lCvnAiiQkC/URbeQ4WAq7RhSUFH2r5kWBpSOPEa1Hk5iDmXXOrtXqQutShMhdN18jbp
 9zmcGlovDnd5toEXa929fXT1JkfvKA2on34xGdA9Z7VvkErL2x7W7Gu4H9zQ6nPuCKZY7pI9Gj
 oeE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2021 12:55:31 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 4/5] nvme-pci: use helper for ctrl sgl check
Date: Mon,  7 Jun 2021 12:54:53 -0700
Message-Id: <20210607195454.16829-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
References: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_125531_627803_977D74CD 
X-CRM114-Status: GOOD (  11.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use helper to check the controller's SGL support instead of open coding.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aa7245a505f..f86ad4b7a9b6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -536,7 +536,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 
 	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
 
-	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
+	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
 	if (!iod->nvmeq->qid)
 		return false;
@@ -855,7 +855,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 							     &cmnd->rw, &bv);
 
 			if (iod->nvmeq->qid && sgl_threshold &&
-			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
+			    nvme_ctrl_sgl_supported(&dev->ctrl))
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
 		}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
