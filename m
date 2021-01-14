Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EEBC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:15:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A6D23A52
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A6D23A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/9YsiIjRkPy6quhuT4JJjSjhuxz/u+sqiR2Mo80NbxA=; b=I/Bp3JwMBqVD8hakqGYOKBK+Yv
	vik0RELYcd2TcQM3t8iMoeq6IYg7T5YjeMADA8PdQ9mGvv3ognkfLaNdKHBu8WceD6vZTVH2cXnDG
	bQtjq7/eQTGsgPe2xHEuu4VBhDdqM4HNGfuXxBFNGduVDXS52Al2EShAqxAsM1ANZBhdQDPmtuRk9
	A6ErFESpDUeJ971QcUA0+d+0ngq0rJsaSvVG4TiVMSThHDMZo09xuIsvczZwGTS8Qpz+7HSBJLe3a
	eztIeLCOjxjKnuvFhm/kjjU6NzkIQ+oa4ezEawWAW94NxI625c1zliSI3qILHq1B9vU4dqVTQM06g
	FClzNGdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l09xz-0004RY-G5; Thu, 14 Jan 2021 21:15:39 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l09xt-0004P5-9z
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:15:34 +0000
Received: by mail-pg1-f182.google.com with SMTP id p18so4601589pgm.11
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iyDF4vIUmQ6nrcMV10fPwc3dcTsfU3M2+doInhUpQq8=;
 b=OSIrmY8PrVk9FWB6uDhY1J0QfCNVzh66QN6jOtDmGdoFmR/RipqT3+XG2XXElGMGed
 gfhgfqVDKTgmDDhYRpQbDr/ZdZ1aQqlWbFiGD37b8mlhBMkIaTzHoXYo5SwqSa6VihrQ
 Fup8vlhOX9/fibuArgd0EYKrRvsMLR4C4I4N65gWdeRlAcTaybLfxu4iEqt4xDLRDbxT
 QfY5tQl6aICdsrra151vRy0vPAE04mQDzsF/OxW2OUdPp4JCWMvvJf3H8MjYthYvVa+4
 oMBt2s25DMcsj+jyko/WdCcAXgJeUcOPrNzhOZmMuRZVruxyjiEv7GlpcYc98/tYj832
 nWxA==
X-Gm-Message-State: AOAM530NMLDuIdgTQijXL29Yip7uivePEkXh+40yT/TxmMcUWsF3/Eja
 pu3si3LnVeP05O+9WuWtap8j3yD+iWE=
X-Google-Smtp-Source: ABdhPJwHXXOnEFKH0BBA01yfvoXtz+YWMUYU4j2Y9Ftq+SxmFE143a+fdMIh8WTXULCRmpquC0UaGg==
X-Received: by 2002:aa7:810a:0:b029:1a6:501b:19ed with SMTP id
 b10-20020aa7810a0000b02901a6501b19edmr9367505pfi.17.1610658932025; 
 Thu, 14 Jan 2021 13:15:32 -0800 (PST)
Received: from sagi-Latitude-7490.attlocal.net
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id s24sm5901165pfh.47.2021.01.14.13.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 13:15:31 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme-tcp: get rid of unused helper function
Date: Thu, 14 Jan 2021 13:15:25 -0800
Message-Id: <20210114211526.86946-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114211526.86946-1-sagi@grimberg.me>
References: <20210114211526.86946-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_161533_461274_BB46B6B9 
X-CRM114-Status: GOOD (  11.27  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index acf41f50a9dd..0a738ba34aca 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -205,11 +205,6 @@ static inline size_t nvme_tcp_req_cur_length(struct nvme_tcp_request *req)
 			req->pdu_len - req->pdu_sent);
 }
 
-static inline size_t nvme_tcp_req_offset(struct nvme_tcp_request *req)
-{
-	return req->iter.iov_offset;
-}
-
 static inline size_t nvme_tcp_pdu_data_left(struct nvme_tcp_request *req)
 {
 	return rq_data_dir(blk_mq_rq_from_pdu(req)) == WRITE ?
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
