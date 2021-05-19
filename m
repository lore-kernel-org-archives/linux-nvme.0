Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2FBC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:44:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3C4610A2
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3C4610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FppRY6q/DjJbbhHY2ifNx4fG3MqYVSbU+atQXzs2W9I=; b=AUysZujhwS1HRfjO0AIIe8BmP
	BM26+yBMceEbcIggQypHiQT+it6e1kozh3haVMCqZ7fnYxLRdP/53oNI7cdnfBPZvhC1n1bo0iAfO
	X33iR1sWbEVUt5vndvHo8iaUu6QAI4T3H6Y4U5knu0aqUPLJr0dYjHi/RZXSXRfXYc2GWNoFRv/dT
	WQYIICHlJFRJrgY2aV1cmOCVSzf6/hD334jMFhk0Hrgn+mhrOC2999MAxjqNckph9DJMxJ4nukpTx
	SLwvcpNQtSMtGKA5g2g5ShXVry7u/PUnBvi02MNeAAF3faJGv4tLVgEG6V6eygwvD4DJP5li2T8UT
	j2wCwlIUA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljQEx-004gIR-EK; Wed, 19 May 2021 17:44:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQEX-004gBG-GF
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 17:43:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=8mL/WSHCANRx6CfWAwj8SLPtm/lOi2Q8moxnSgW7Dg4=; b=iWzgVvNo218zbOSUBDwqHhYzo2
 wPofDi7OTr3o9LOjg3+j+ZkYBEpJe3MSCMgathqvPekloKTT3xKfNcqSlbgif0CpVG3ReTJtJJ0TL
 8NhOmNCkNViKxrSg7Yb3fyMcheQUR+nLePoDwSwLmn/8yh7kYYivjP956IR7QlgeDTopbwFPZTU1D
 vkAu3Sg9DnqWGxbNMzUExH3R+h6EU6y1nbXGt+hhwwMiN3GW4wJs40+CMmPVxinxM4VPlpIRKLTjG
 S1f5m3kIM0TKDPjbP7+fRRoUaojwNaBVFQdt3YAIDVWJ7nBG1JkM2WC8dAx6f2X0WmufHHeUNWIs1
 bHIIx7mQ==;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQEU-00FfTO-Oq
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 17:43:48 +0000
Received: by mail-pj1-f46.google.com with SMTP id t11so7730961pjm.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 May 2021 10:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8mL/WSHCANRx6CfWAwj8SLPtm/lOi2Q8moxnSgW7Dg4=;
 b=VZeo4rQXYIEbuyIDfXN/daTLVQtJ92zePtKuzHNNz0OZICZvcn7KSHPrzmWVby8J5Q
 BBtO/+SCEqX+dpfBVCz+Daeus2mKx3zOhOv2jaPk7d9QqNXouQT4NDabFyhvGoLv9+1n
 XDe8k6yf/PZaxFopSzDib+rIIjrHND7BpmH9B4rlfWHeOhF0uETsimmaCrrINPdGte3u
 jyZsboogkxfs63F2CU8Gkmo9/MqcMdyNCzIxanhDyX1PkjdVIBZBEOPMC+YxFCmFI8QD
 fBNM7fHXn84usL1KcL29AAmYVjMPQxW6MAszHuT1F6xlfwDR8oMX99G/8CBbggEkznGV
 TdsQ==
X-Gm-Message-State: AOAM533h0sG4n92ERBA3GRdJU2HGFjftdTbvRLcBkJV7oXBjJWrV7uL+
 wyOtvp6CrPQeBVTQcOLNO1XVi/Ujn8c=
X-Google-Smtp-Source: ABdhPJy7hprje2Tn+kpfluKLHUD0TkNPD4FCmXqqpxc2RjZvMNEyVJ6aMSOD+1RaGulpxU+/g81s7g==
X-Received: by 2002:a17:90a:ee89:: with SMTP id i9mr471567pjz.57.1621446225345; 
 Wed, 19 May 2021 10:43:45 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:a498:37ce:5a01:2259])
 by smtp.gmail.com with ESMTPSA id l10sm46639pfc.125.2021.05.19.10.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 10:43:44 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/4] nvme-pci: limit maximum queue depth to 4095
Date: Wed, 19 May 2021 10:43:38 -0700
Message-Id: <20210519174340.1144806-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519174340.1144806-1-sagi@grimberg.me>
References: <20210519174340.1144806-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_104346_824696_9EE2A56E 
X-CRM114-Status: GOOD (  15.12  )
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
counter, so enforce the new queue depth upper limit. As we enforce
both min and max queue depth, use param_set_uint_minmax istead of
open coding it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..ac26d242b630 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,6 +60,8 @@ MODULE_PARM_DESC(sgl_threshold,
 		"Use SGLs when average request segment size is larger or equal to "
 		"this size. Use 0 to disable SGLs.");
 
+#define NVME_PCI_MIN_QUEUE_SIZE 2
+#define NVME_PCI_MAX_QUEUE_SIZE 4095
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops io_queue_depth_ops = {
 	.set = io_queue_depth_set,
@@ -68,7 +70,7 @@ static const struct kernel_param_ops io_queue_depth_ops = {
 
 static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
-MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
+MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2 and < 4096");
 
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
@@ -157,14 +159,9 @@ struct nvme_dev {
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
-	int ret;
-	u32 n;
-
-	ret = kstrtou32(val, 10, &n);
-	if (ret != 0 || n < 2)
-		return -EINVAL;
-
-	return param_set_uint(val, kp);
+	return param_set_uint_minmax(val, kp,
+			NVME_PCI_MIN_QUEUE_SIZE,
+			NVME_PCI_MAX_QUEUE_SIZE);
 }
 
 static inline unsigned int sq_idx(unsigned int qid, u32 stride)
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
