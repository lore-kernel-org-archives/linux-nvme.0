Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB54C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:00:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4155611BD
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4155611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fNuE9/VvjaydYpfpL6nGEFVy5hSJSDDOlx66pLq1hkE=; b=e/9SCI2EfkTB7tJzsojBvpyXu
	ntDrCgQn9og9Zvs/0iQlf+Ys6PmFbljvudCYughZ+VKO2IqvwnRYS9+BAKkX49k+lAItVZ3axzBcu
	3jO6a4Owtv0BFat8E3jgyQDPqFuCyJBlcoGZBst/e+kKw86+VpfzVWMkcn0xjWB4JwifymSEKyZHe
	K+sHn5rnL/F9axaLaCEKC7kvRj3R61iHOn+zZwQzT7WyOjepeB+GTg0Df/b1k+Q3UrYds6oybxoJ/
	aUy8fLSyhJciH4WEihvqEDV18Pdfx8at85SbtA3+MCnuXhNtoN8No9B9wC0DRYLC9muq3HeiY93eO
	7gzFODcQw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihXe-00Fjtl-U8; Mon, 17 May 2021 18:00:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihX9-00FjqM-IF
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 18:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=yOl2HRTmKMS6UwpC2evN43E/CdKbpEuxjV3HaoxqK5Y=; b=5CNNVYwNav83IP6jGIXQG1M1VR
 31Wys4vItnxXR+qyxo1/qK3HHhEn+N4zWlsxfsxRqw2Ak6alNB+T+VUw/NA2YDzGClBn8zkTmNoBg
 RHZ+XRgPJ9K1jiZkL0TrFfpapC/V2nT0PN9WV3Xf/MPzFxF2aA7B7ETdaVSbHdHUWMWIGajsID3VP
 V71ttuJT0Rkm5PM6zsQ65CmJlJgDblBYzu7wp8EeSoZ9A7KZfqiox57AXALDEeribS56Zy8emLPoX
 f3foA6uBuOn0J4Q5P6CcCJTjduYNKgCEZQowmdL02427EuIWvgzp5ybQQIX+ajcj+f7ehb+K7bNSo
 Q5lVmfzA==;
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihX7-00E2NY-5r
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 18:00:02 +0000
Received: by mail-pf1-f170.google.com with SMTP id 22so5110297pfv.11
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 11:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yOl2HRTmKMS6UwpC2evN43E/CdKbpEuxjV3HaoxqK5Y=;
 b=sGdmr7BwdL8xm7vMq+0dTvJ6vAuauyJNui2ceXj7qV+vKIv232QTcdb40/Amt/fscf
 xeTSdhk3WuUfWHiV3rUAdPpdcRiBhCpxsAm2FVA2qvnfX4hmi5iN5FzoLaM2O8RA7kc4
 eZszktn9CESDLZEljSZl3SMAgP1dx4Dwjeftxw3hDQY6boch+lxZ0VVLFNNbTyK8yKu7
 1Zls6m+ovK5t5emmYKPQiMaaeHo6pyec2Euy9hsgb5TU2AgXQN0Pi+4IQBxFtns4EF53
 rxpIvWDphhUQWN/lvQz7JZ/FOVNywLkd2Bl+ifYbMCROQOvjhPZWTsynpGOeHs6mW1SP
 cqpw==
X-Gm-Message-State: AOAM5317/weL4r5yziALK8QaN+f749fv8HhJT1Yd3/nOrXNWmkmFWZCE
 k1dWQK4er9BPms/wVfcxVxktKNyqeaQ=
X-Google-Smtp-Source: ABdhPJzsqhmZGaUnLV9NoLH5aFQsqT8moroW54PS295IVp/KvtDRnrprBENOtPQ0oZKZf0suK/w71g==
X-Received: by 2002:a63:db17:: with SMTP id e23mr749837pgg.274.1621274400120; 
 Mon, 17 May 2021 11:00:00 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id mp21sm97196pjb.50.2021.05.17.10.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 10:59:59 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 2/3] nvme-pci: limit maximum queue depth to 4095
Date: Mon, 17 May 2021 10:59:54 -0700
Message-Id: <20210517175955.602725-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517175955.602725-1-sagi@grimberg.me>
References: <20210517175955.602725-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_110001_234322_F0C34F53 
X-CRM114-Status: GOOD (  13.86  )
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

We are going to use the upper 4-bits of the command_id for a generation
counter, so enforce the new queue depth upper limit.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..bc64282b2301 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,6 +60,7 @@ MODULE_PARM_DESC(sgl_threshold,
 		"Use SGLs when average request segment size is larger or equal to "
 		"this size. Use 0 to disable SGLs.");
 
+#define NVME_PCI_MAX_QUEUE_SIZE 4095
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops io_queue_depth_ops = {
 	.set = io_queue_depth_set,
@@ -68,7 +69,7 @@ static const struct kernel_param_ops io_queue_depth_ops = {
 
 static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
-MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
+MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2 and < 4096");
 
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
@@ -161,7 +162,7 @@ static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 	u32 n;
 
 	ret = kstrtou32(val, 10, &n);
-	if (ret != 0 || n < 2)
+	if (ret != 0 || n < 2 || n > NVME_PCI_MAX_QUEUE_SIZE)
 		return -EINVAL;
 
 	return param_set_uint(val, kp);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
