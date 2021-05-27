Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22BC47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 20:40:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81F4613E2
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 20:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81F4613E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F7uYINsD7uJGaP2V7H/hMJKqTccBLW0zSDDg3+sIzUs=; b=AukZ0M1f/+8gyM
	UI4l3ie0oCIvDorN6ifdWI6p8PY/mLM3YGGQEvBj50YXVH6zSNjliKb+7aYpuLiXB/VrkUWE03NFE
	zbEzdmnWIUOCQq1c2Qj6zLXABzCbSDftZm5YAS7yHlpVUvKU3dX7nDGtItXh4uaLPjajtGJD+6S+G
	rS3Q51Zn6DlVihmcnayAby0CQxSP/ljRXnmoEhJZx9zCRIGEX5nu3QYKkVwp7fzRn75vlqDCezvMG
	4+ELQ1LCh4zYD3YoPQ9CByRcFDuLjQk/sRzROi6oUfoRbPZ+4iC4ld8bCuLZ2/uluPjPnJy3Z2EEV
	2bTDG8Ktk7RFIFA93HiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmMns-009OOM-8k; Thu, 27 May 2021 20:40:28 +0000
Received: from mail-qk1-f177.google.com ([209.85.222.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmMnn-009OMy-Ra
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 20:40:25 +0000
Received: by mail-qk1-f177.google.com with SMTP id j189so2047267qkf.2
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 13:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4efrx60r7qosRYAUNe8dCw9wgJOIQp7CUCv1NiklD4I=;
 b=LuDqdxRLRMy7XdU/l63N1VXZHDJV4d1TyVG+LvlifYxMcVWHjKeDryQZ4g3jB0Te+s
 C9rZ6W+pDl3XeEUjIL7dgQIM2IviomaIEoivc/QzzAVdrh9eoNUqOradDMuPpy5ohOoD
 gNA2omaon7j+hdOB7Hoy3yPwEpCvJ6TEJsRgU9c9jbmO0FlmTUMYXNlir0eUav0SD0o3
 mh2cDeklbr7sgskxcZ6jBx0qBYj957/SRdI7otzSK/K5XFAke4KcGqc1b8XeDdyTtggB
 tW5Wkx3PAkZMUzHpHwipKyKvx0GEGAKYTpbc4CpcUOo7H1q2wSzcpJXZoeak/L3FKa4x
 wLDA==
X-Gm-Message-State: AOAM531FUtehPHZnzff5c0YydTUX+0YcK9FmXWURjxFSDU5uyYMLOs14
 HmIQC2k14youCxqJ2i9U/dDC3c/3uPE=
X-Google-Smtp-Source: ABdhPJyBT0DpbfYCUSU8pbT7TR2Q3M/pEYkvRD0KESl2CNYGW2guIKLuoKNqXo5xD2pAPhhRTujuLg==
X-Received: by 2002:a37:5c84:: with SMTP id q126mr399225qkb.21.1622148019831; 
 Thu, 27 May 2021 13:40:19 -0700 (PDT)
Received: from sagi-Latitude-7490.attlocal.net
 ([2600:1700:65a0:78e0:f14e:23ff:ceef:f3f2])
 by smtp.gmail.com with ESMTPSA id d28sm2087230qkl.105.2021.05.27.13.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 13:40:19 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH] nvme-rdma: fix in-casule data send for chained sgls
Date: Thu, 27 May 2021 13:40:16 -0700
Message-Id: <20210527204016.379365-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_134023_914458_73466CA1 
X-CRM114-Status: GOOD (  14.04  )
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

We have only 2 inline sg entries and we allow 4 sg entries for the send
wr sge. Larger sgls entries will be chained. However when we build
in-capsule send wr sge, we iterate without taking into account that the
sgl may be chained and still fit in-capsule (which can happen if the sgl
is bigger than 2, but lower-equal to 4).

Fix in-capsule data mapping to correctly iterate chained sgls.

Reported-by: Walker, Benjamin <benjamin.walker@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8d107b201f16..ed1bf214c544 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1320,16 +1320,16 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 		int count)
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
-	struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
 	struct ib_sge *sge = &req->sge[1];
 	u32 len = 0;
 	int i;
 
-	for (i = 0; i < count; i++, sgl++, sge++) {
+	for_each_sg(req->data_sgl.sg_table.sgl, sgl, count, i) {
 		sge->addr = sg_dma_address(sgl);
 		sge->length = sg_dma_len(sgl);
 		sge->lkey = queue->device->pd->local_dma_lkey;
 		len += sge->length;
+		sge++;
 	}
 
 	sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
