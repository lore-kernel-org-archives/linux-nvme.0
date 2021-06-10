Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F44C48BCD
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:29:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABD3613EC
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABD3613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ged0f3bfQFhshUuHieayUOJNnrc3CFjAN42VKycDJVw=; b=yJN3x6vU6J+3C9
	sMN5bFgAT0xLPQB04uiD2A7+es9zagc69EAYGkKgDqC0bav/lr4BxjwoBZdHH01uPDwHC8nhQVU7l
	LQzhLWwNNxMymEy0Z70yB34BBp6qbkwu/zOtpfh6istbcnKHoUvoVlW3XfDc2ik4pw+NTCVflTaCt
	7HX6q76NKYEEGUIJ9W/fQ1Gn4V7AJOWPxyU79+IGeeYDEq4FXQt4urf2QosbK31rBDVQvK5w17dI2
	eyfVIRzXD/1+8stGa4qjo4LNMH0W5X5cTNNLGOvQ4HbpbhyDGPrx2kCGyROuwGIjVWZaZbU7tX0v1
	G7fPc7XGhjvkztsBaxvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9VI-00GG0s-9g; Thu, 10 Jun 2021 01:29:04 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9V8-00GFyl-BK
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:28:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623288533; x=1654824533;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zPAxr6+e+WBvF/NPOeLr6Wik2u1w/7SLnZQfSP90CuA=;
 b=Fk6Cl5UuNUJcILlofBV4pK1wWvd+/HKM/cwoQ9Vj3emQbqUj+IW1sJKB
 w0+67KLLoa8ShR644NBCdbLYuKhbOpS2zZlymtbZUVVgfn1sDK1ED9LXl
 Ue1MjE5vnoqIMeK6GjUT8LHiFO5tHvUjE6iKMFTrp6dDkdI0/PxwKxKPU
 95rfAYGdLBJk8nFxAHqyhDfNQvHye52RqoaT7XfU7gJ/coO996VLO3iAx
 /JHY9i4UQoqyFGF7eB/Xl2sThb8T3FZgfZFydns1k/vgdcCbe9oT6pz9i
 DzGEpAzcJK+/NhsTomBzJ2eE8HbX+U+yCf3JXvEYnvlLq8Yqv1HnlQH61 g==;
IronPort-SDR: gX80ftcd9xhPULU0jAn7pbzGGXEMQiO09pIWE/DY2UjTFfW1N4pDXVkX1c65BFRQHFbX3KXF5H
 U7zuHdzI2y1ayzZLBi+tNEI2iLlGuiOPUqIZKo5FRsHV6scuPWFBldJKKGzAXnb01WoTWPyrwK
 5nwwydt5j+hZNWEcrtIJduioYAXIf4FUKL6j5oxYmbn5+7buwnBs/K2cBm0l2lJBBBRkhaDqKu
 TKMJnwj58rU9k1Q5g8Svt9QlIL9N7lxeAqwauTcd4+DQLYw1To5/cw9+OaHNIpebFElPyEcY7e
 u9U=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="176137575"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:28:50 +0800
IronPort-SDR: IE0ctAUBP7e7QNtqE9dDJPKuVMIz6WvYKgavgrJ47WuaR0k/XrUSUu4Q8KRYDW8JjEC/rA2vY4
 3nxx3XngzP/Wl227ZLhkgDjd/yDV642js8cR3oRMP25yoTNKWb8SVhq4vM3iQjVtdnicHKciVV
 b7tj4PtRSt0SR8IDoP17qIyZ+s5cN4gSFKn0+Cl2y/FiZ8LxVg7fm7wGsFjEdDMe+XOrN/Vw+d
 F4d0r98vg0IWHJ2Vt9PF7Zpwi9mteUMi0Jc1X8Jza6V8/KFPjhZFaWRNPp4Bc23yazgFHJ9LH5
 1DhEZOfc4MUjmggkoCHix0tl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:06:31 -0700
IronPort-SDR: +tpoOXXkXd8pVK/DJrqV2hICy1GmmCag/6oWXYV4TAnafB8un8kkzGbkgJhFTe4ubjo8UpxFPg
 vfRUeh1OwA06xCvcq+qxtpmSvbAWbTMtbfjPgHdzOGpbIkZIGNjeo8To95IbEL3PxfRmzifAUn
 xWvyFMp/8kFVM98byu7zlVYElnOCcAMA+RFZPl16Q4hJAmvdiOkYeY5xZSoGb7pvd9AXOUFtvT
 xZjQZPZ2KY8Sg9LvEGhhITO4F7TethhmH55fwyoaoK0CXTx7zS3nKKZ5yJcv97eEqAElgoFxdD
 m+0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jun 2021 18:28:52 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/4] nvm-pci: use ctrl sgl check helper
Date: Wed,  9 Jun 2021 18:28:25 -0700
Message-Id: <20210610012826.53398-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
References: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_182854_417197_38D7D1DA 
X-CRM114-Status: GOOD (  11.95  )
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

Use the helper to check NVMe controller's SGL support.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c5356028199d..5df1adc5a1db 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -536,7 +536,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 
 	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
 
-	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
+	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
 	if (!iod->nvmeq->qid)
 		return false;
@@ -853,7 +853,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
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
