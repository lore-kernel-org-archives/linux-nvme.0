Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFBCC04AA5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 06:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WJ7GBNHN6AoVv9ZeH0urLLa0hH2huW2RwMDCHhQJQUs=; b=G2aH2RoMJBd3Ub65fa4wC55NON
	dx3ttYLjMG80XJxCfINi7f4NseCY1j6oM9owDgdZrjiUFPG7ool6sQI6MVZGo3HgX+u1GCy/yI3yB
	ZWrN8fc+5JSnolFe/0XivTZZLC/SIrC3mDD4ePsfC5sIuY/1Fly/aasd58R9IGZQlit2p4U2JpAkR
	CahBIZf2VNhRhD+GWnN98XCnJ6SDG3iNpDIYS9ri5hEcKlc4Y356NRbBpfspHDysaYs3S9DVGnWJk
	GkqxEtsryjKQ7lfzlr+TE12mhRYr6SodwucrHKS/DFuK/o+sWo6hdygmV6d3SuIWlLnb9d5DDEa8o
	h+gObsiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR6eo-0080gZ-2A; Thu, 25 Aug 2022 06:48:02 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR6eh-0080aq-6t
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 06:47:57 +0000
Received: by mail-ed1-x536.google.com with SMTP id e21so19977636edc.7
        for <linux-nvme@lists.infradead.org>; Wed, 24 Aug 2022 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WJ7GBNHN6AoVv9ZeH0urLLa0hH2huW2RwMDCHhQJQUs=;
        b=d6bUCj/UvDMnRfnKyskgkByJo1qmZAo616iARuRQkWWCLeIP4Z9rfvc3DCBpbZsHlP
         KTxjAxUjNKC0ca6HElPoVtJtqBqYS8+W795nbrRnRSgRys8RpXduYkix1MZcnu6/HioI
         ocG6YqnD1sOrtdVpTp+mhQXlLHNtQHjayJXjAde8V2kn2GdvtFjivTfNgjaG0kLdRUaH
         wx0G+FeDpnQLnjj4/YOMxiUMRhzAEL3tpaPXcoRwd5ZoXwAZ9E9qCDfWaZlGBjwmit3B
         gcCR9kyatFVXcMPA7VQQ61iyOWutwdAvxJgbVLSU6lJ0l9kmlAqQlc3SLcMBTlRMHLOX
         PpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WJ7GBNHN6AoVv9ZeH0urLLa0hH2huW2RwMDCHhQJQUs=;
        b=GsGTKcfmEgwwATMaVnT1JyaO7cY4rN5SQzveYj2ZGduB/RFfhs/ZZc6zqAQ3SeujR9
         9li9H4KFv7VPcnoA1DzaOG01KzRBKLfbxoU93JaMpKjMm2jwzocveS2Y3q+6EjiPlZFC
         etObsM1271ykraUxxHxXr14iq8+5rMhPaV+yu2Hl20lMOvcdvHL2pJkWhxBHmUJNLeWb
         c97V19JWRv61uttpfnM761JpNeeL8B79Q7Ns4Tl4PhxRlPkYNb4M1ub4pBmRbt0LNDDe
         xI4DzqPbLqtRssbq5z+IGr0c9a8Kem6FeAURJDJOreqSts0Q7O07r3wjZ0cq6AFRsdNQ
         0eGg==
X-Gm-Message-State: ACgBeo0cg/iXXhMFJK3gIVJQF5Hsh2KO7JtcdBGIBzhFE4u2ackdghTE
	GyMrKCsT0C/SIuZQQu6ok0g9Iw==
X-Google-Smtp-Source: AA6agR47CytgekKsTgSt+j2KQwkdMlmF15xtMtjBIFjJrYQS67CvpLZ+4Bs7+CZRQ9qANAJv7tB9KQ==
X-Received: by 2002:a05:6402:26d6:b0:447:391:5d32 with SMTP id x22-20020a05640226d600b0044703915d32mr1913796edd.424.1661410070906;
        Wed, 24 Aug 2022 23:47:50 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906a40500b0073100dfa7b0sm2063564ejz.8.2022.08.24.23.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:47:50 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: hch@infradead.org,
	axboe@kernel.dk,
	linux-nvme@lists.infradead.org
Cc: James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme-fc: Fix the error check for dma_map_sg
Date: Thu, 25 Aug 2022 08:47:47 +0200
Message-Id: <20220825064747.22521-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825064747.22521-1-jinpu.wang@ionos.com>
References: <20220825064747.22521-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_234755_264980_BD6EFC4C 
X-CRM114-Status: GOOD (  17.96  )
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

dma_map_sg return 0 on error, add missing check.

Cc: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: e399441de911 ("nvme-fabrics: Add host support for FC transport")

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/nvme/host/fc.c   | 2 +-
 drivers/nvme/target/fc.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5d..95050f2e0a06 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2616,7 +2616,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 	WARN_ON(op->nents > blk_rq_nr_phys_segments(rq));
 	freq->sg_cnt = fc_dma_map_sg(ctrl->lport->dev, freq->sg_table.sgl,
 				op->nents, rq_dma_dir(rq));
-	if (unlikely(freq->sg_cnt <= 0)) {
+	if (unlikely(!freq->sg_cnt)) {
 		sg_free_table_chained(&freq->sg_table, NVME_INLINE_SG_CNT);
 		freq->sg_cnt = 0;
 		return -EFAULT;
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ab2627e17bb9..3749ca28860b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2089,6 +2089,11 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 				((fod->io_dir == NVMET_FCP_WRITE) ?
 					DMA_FROM_DEVICE : DMA_TO_DEVICE));
 				/* note: write from initiator perspective */
+	if (!fod->data_sg_cnt) {
+		sgl_free(fod->data_sg);
+		fod->data_sg = NULL;
+		goto out;
+	}
 	fod->next_sg = fod->data_sg;
 
 	return 0;
-- 
2.34.1


