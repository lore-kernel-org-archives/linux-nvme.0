Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5245C4707F
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 01:26:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF226135C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 01:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF226135C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NIafwz7iDvp9XqoYHq2J9usJl/wu3ne3plE/lUh1HbQ=; b=mcObThB3X1EFdR
	ISE/db+E4TLiIMyfZhizHGLMajD2fGIRh95r6vs4+t7TnTcf0znkUgfPif64HU+Pm+rZwnd8snFyW
	a2vnu/NaAR9OX7W2DZK8UWsmvYBdvnyT03pqwrGG7Dj1HskxB1+zEeCoaRLgEk57YeDYeorLaWo4G
	0GPkGtUZ5zvajnP9go9YnZFcbD4M/4f2r8/R3WVyqpi1bmqOGoR79TIgJ9g8/JhqVg4r4W57/NLww
	AmgvnJ3il9g659pKAy8XGDl6Zdf2u54XXNVfGGB4WTp7pkkMH58ETM1Bm6hx/qHnBjXdphzbY0+H4
	HEGtgiONrfFtploeQ29Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmRFz-00AvxK-Eu; Fri, 28 May 2021 01:25:47 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmR7C-00AsJ6-7r
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 01:16:43 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 lx17-20020a17090b4b11b029015f3b32b8dbso3578038pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 18:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rX+1Zf2icZbQ1TkdE9KCUyRdNawje78LvSbTnbaDnlg=;
 b=qXbgDqdjGDXqL88Vg++i195WKOLbkAmMfsY9Ml61olLfueriB+GVllZmzsfauift4l
 fGjzd/B7/nbhbwRwYZDlL7Zh4QZOBzLbotWyz5fMaDV9ktdi8daehLRcpNr7M3Mj317A
 oA0FvKJaNu8j/v86MpfmB/+I+BsI0pj4zbpx2G4D46xA+WuX4hbE5GfLlYT2SQeS1MEz
 lx05T8T15u9HyHKnKZdq3js/yB9h6PslZbFxl0JFFCOP5tdvIuxdzgSB+FkyHMlOQmaP
 h9OF+l2B64rQQxBBifDiMVjRII9kLx4JeSllc6MI5p0CVS2wvgO4VCxH3jPktE1yedEv
 TDdA==
X-Gm-Message-State: AOAM533Hu4nP2EttMo+2Xlcne3ojb6d6Mqmdxv3deDNY8PViBE3yMIaJ
 MY6MC2eo1yOuYLlBTD3BYXnQmHz6k+o=
X-Google-Smtp-Source: ABdhPJyQ5UGORZ8b10wEBdI7jJC6XD9EIFydHUE/PCa6gCmfJfCOlblLyb10MhnJRA5S6sQwX9xjuA==
X-Received: by 2002:a17:902:ab89:b029:ee:dc90:7008 with SMTP id
 f9-20020a170902ab89b02900eedc907008mr5937489plr.30.1622164600981; 
 Thu, 27 May 2021 18:16:40 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:95ba:990f:ef3a:82bb])
 by smtp.gmail.com with ESMTPSA id z6sm2886497pgp.89.2021.05.27.18.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 18:16:40 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v2] nvme-rdma: fix in-casule data send for chained sgls
Date: Thu, 27 May 2021 18:16:38 -0700
Message-Id: <20210528011638.122507-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_181642_314044_196F0130 
X-CRM114-Status: GOOD (  14.03  )
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
Changes from v1:
- fix silly compilation error

 drivers/nvme/host/rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8d107b201f16..f61bf39c39a0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1320,16 +1320,17 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 		int count)
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
-	struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
 	struct ib_sge *sge = &req->sge[1];
+	struct scatterlist *sgl;
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
