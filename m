Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E32C25B0E
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Aug 2022 06:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dgh0mRNVGiAT981rc+BiMLlWYrkrNgUD8IdfprQkqA=; b=t0gSAb+bwxEICltZrEf8/FR4t3
	ceSLwLTI3cH5YH9Wt+iX89tqD8zUBY6XXE3Pe+VqZbf6fZmgUlm5SaGX11MBZHHpME49uL5INrNzf
	iP5EbkNoCGg/pDdygw0dYDV8+Sc96IQG/9AQoCpuAQ+cN4tO3aj0ZZRXf8h1KTnv9GD4T9ba6FFFz
	xbjfIqLIqBpQrbDVXF0w2XjobemAmh7D3qYiKDsTOfkYunQm4Y7I7n15gZx5HcsHoPL9fkWIkEJvM
	NWtpwnvF2Y4XuDrBlrBt2uGO5B98JJiOlAULKLzoXwD9ULsrcttUiEle5EfMiG8TMI6o0o0S23YfT
	H/HS0NiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOvCB-002BLR-Tq; Fri, 19 Aug 2022 06:09:27 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOvBC-0029S7-JF
	for linux-nvme@lists.infradead.org; Fri, 19 Aug 2022 06:08:28 +0000
Received: by mail-ej1-x635.google.com with SMTP id gi31so488815ejc.5
        for <linux-nvme@lists.infradead.org>; Thu, 18 Aug 2022 23:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5dgh0mRNVGiAT981rc+BiMLlWYrkrNgUD8IdfprQkqA=;
        b=W5WMmy+an0THIibSKrr3bcWg4gjuYgGgd72fP/ALycZ+7+Pa0SfJykH8cr7EcbmFhQ
         azhFHI6OBwkWgPK6ZpMfr9Om11xd/5LqmEKxVhg6en5ryfV3ZPV0QgnB/7UKMtO/gzan
         Z//ONWSeVL4TaZpjD7YmjJpps5VFk3z3CfxYVx6wMJO+M1Zh3Z8STOFwIoBCOpMHiSjD
         zkZxUsCZuHqQ59thjGYOvNcdcAZ2nY00mRORym3v7Fjb2NKri7WM4bq1wuFPX9Tcg/3l
         EkQaSVW96Onm/Rz+9wbCm9GDcPL9ONsaT1bt5Ymm4kl/5J+miqTeNDeNblYHym9NerAd
         ghVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5dgh0mRNVGiAT981rc+BiMLlWYrkrNgUD8IdfprQkqA=;
        b=lbZFzI9QS7pjJc2eCtBif3Ke2DchJskzTmrHbmT7XWrWB07Izt4SujH84Fmwi/MeBB
         PT1E9iYGRC6tAjLeBMEMRs+jdoTDX6yJWtyUne8bBrqTvMYP3x+KDpliVNIP/HLbweHb
         aGRTUZ1y1cG48nCQ89+KpLKEofTDIVy4fGl0sdJxCqnlyi9zm5rDufjqNSKnRFSbLjT/
         q2UyCMeBaoEUfbS2xa28ntCwkTI5HFizKZ7Ngtomx7kkaVSZG0yYfLblxUfOM1CJuaiU
         IkxFfmANbrAFaUb3RuFwNTBApD/6jh/ThwIRCBoppYyMB1M7ITz5oMyPMQRh73crdQEs
         y9CA==
X-Gm-Message-State: ACgBeo28bidxjygAkKgJP9GJk3kW41KbQDRqd8YBSFdC0q01ZtBeK/KD
	MMPUdS5ARUL0tqqatS/yZc+pPw==
X-Google-Smtp-Source: AA6agR4w+Ar1X7e4t7akiH3do+1BZFgD+ksEGLVKvjAc15jlYgFPvVhkpqkmoIXMBHOiP6bq4bnzGQ==
X-Received: by 2002:a17:906:730c:b0:730:da74:3453 with SMTP id di12-20020a170906730c00b00730da743453mr3837859ejc.270.1660889306078;
        Thu, 18 Aug 2022 23:08:26 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:25 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v1 15/19] nvme-fc: Fix the error check for dma_map_sg
Date: Fri, 19 Aug 2022 08:07:57 +0200
Message-Id: <20220819060801.10443-16-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220818_230827_629415_B1BD5F57 
X-CRM114-Status: GOOD (  17.16  )
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


