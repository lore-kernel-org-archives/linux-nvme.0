Return-Path: <SRS0=sPWJ=AQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66672C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:59:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3106C20737
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKoZEy7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3106C20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nOFiBaiVB6WDOH7IToors5HOGJzKpJ29i++2qQaYQzY=; b=lKoZEy7NXsOI8Gp1t/jJi10aD
	1d6IRXAS07BpoPUoExHRan6muMpyk+FQ/rAMW9XxIFtM0J4wIlp2xTn+/QJ9OeO9hQSA5dDlNNQHk
	roQXqnQDTUvluT/LSJ9xGYgYhYdiF0L3OOY8NbTNf0UjHP5REyJhDz1SRQ0MEFKxCV9yl8PguTFxz
	2sxPEwZjoh9zaQYxhhzJgbwp1CMhGmx4r88Yn5VkEj2l5V6BGfI5mbrmSG2n2W23YlQBCRYGQazfV
	hmmSHnyIbEOod559JTtUQ3SgjGcFugaPvGgXWSs8KaMxo9vyvBn8Ds/d0pQCFYqC59VeQsIl/uTiD
	6D0re+4sA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrzYw-0006UB-F9; Sun, 05 Jul 2020 07:59:46 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrzYr-0006RD-6M
 for linux-nvme@lists.infradead.org; Sun, 05 Jul 2020 07:59:42 +0000
Received: by mail-pf1-f196.google.com with SMTP id j20so27584pfe.5
 for <linux-nvme@lists.infradead.org>; Sun, 05 Jul 2020 00:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iU6082Io3KUaPlMGyZVP4uWsn3htMxNBf8jGmQHZKlo=;
 b=QkqT2n7UAianDn6+3CBP7qxyMwujJl4u7oOtfTndCU2ms5FOYs5QdoMf8Sy7l4WpoQ
 8NnwN1fD0gFt9ZmGn/VHMI+Hx7i3hH8BbYsq2fD+HqF1MzUXmi+yhJFkZWNNo+4jAqXn
 +L5/47oBpBpPpRykrt+A6j/gZnV708CWEZwHmnWTWmy9yfcbcSiKnB1Co/Vh6KfJODbg
 BE69ah4cL3E+i6qHwKlPrV3jfE/QoU/Z4aPJMgtbQ5G+rzNxQdAmS6n0b6xrHGMuQxHj
 RegwRf5lI6fx5qgyd9h570SC/L1V9d8DqC6/ACz0uvgZqaz7ykH+AzjrsrggnIJH6IRk
 rdSA==
X-Gm-Message-State: AOAM5326nLv/LRfN4SwOIEi8SKm9r98O50BpcFd2iVgVmFoPnTObgBVu
 NMi7uqd2s4NMk72fbGj80Z5/M+rz
X-Google-Smtp-Source: ABdhPJyWpM0Gs90+h+oV1NTgmPgXujaLfOkRjhu6uyIXTV7JV9mbOag7OpZjCUJKGM7tBTnX1N5l4Q==
X-Received: by 2002:a62:5bc5:: with SMTP id p188mr41514279pfb.56.1593935979823; 
 Sun, 05 Jul 2020 00:59:39 -0700 (PDT)
Received: from localhost.localdomain (068-186-033-250.biz.spectrum.com.
 [68.186.33.250])
 by smtp.gmail.com with ESMTPSA id k26sm16133228pgt.90.2020.07.05.00.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 00:59:39 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 rfc 2/3] nvme: document nvme controller states
Date: Sun,  5 Jul 2020 00:59:34 -0700
Message-Id: <20200705075935.506535-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200705075935.506535-1-sagi@grimberg.me>
References: <20200705075935.506535-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_035941_271492_D28DEE16 
X-CRM114-Status: GOOD (  10.24  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We are starting to see some non-trivial states
so lets start documenting them.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f184ae623f12..0bffa0435e24 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -173,6 +173,20 @@ static inline u16 nvme_req_qid(struct request *req)
  */
 #define NVME_QUIRK_DELAY_AMOUNT		2300
 
+/*
+ * enum nvme_ctrl_state: Controller state
+ *
+ * @NVME_CTRL_NEW:		New controller just allocated, initial state
+ * @NVME_CTRL_LIVE:		Controller is connected and I/O capable
+ * @NVME_CTRL_RESETTING:	Controller is resetting (or scheduled reset)
+ * @NVME_CTRL_CONNECTING:	Controller is disconnected, now connecting the
+ *				transport
+ * @NVME_CTRL_DELETING:		Controller is deleting (or scheduled deletion)
+ * @NVME_CTRL_DEAD:		Controller is non-present/unresponsive during
+ *				shutdown or removal. In this case we forcibly
+ *				kill all inflight I/O as they have no chance to
+ *				complete
+ */
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
