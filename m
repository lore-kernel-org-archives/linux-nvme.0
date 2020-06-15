Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4527B2068E
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rRZEMKlp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEIrhRJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4527B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=jgDbHJmpYA69JU8vs48tZSztEH8XkifzVj7ORT7cEVk=; b=rRZ
	EMKlp4l9rFM0YM8yfz6DF9gyo8V8c3VshE/Bu42ki1RUeQpLYVd16l8RcSlumXbLUZuC+7vVC09QJ
	fR8TknyVzsDqNTsTWGWISsXQa6FKAXrOn755Ta/MI/0ZC+wAngFT79/kPQrLJvOQfhc/yZ6wUl8W3
	lo7k1pF7AxadAU72XemHr8DLL9YvdjvUsDsRy5ri2ouWo3zZwQzqjHBBfVpzpd6yePrk4kyaCzvsh
	H0jd1NBQYBWf1bEpRqXetq0CipaIddzsiDvXUHXuPpaGQdlIMFoO4Wxy665TVkNkGCHhVlWysfl7Y
	4tihCYr+xAylrBuUUxQFczIKBiXkD/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkyHM-0007PC-Lz; Mon, 15 Jun 2020 23:12:36 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkyHJ-0007O7-Pt
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 23:12:35 +0000
Received: by mail-io1-xd41.google.com with SMTP id s18so318570ioe.2
 for <linux-nvme@lists.infradead.org>; Mon, 15 Jun 2020 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=W0m3oFYfEdmQXtbNnJ57bvEwrecGkzyuNTxMF29GlxY=;
 b=EEIrhRJzanXHWvhId0pPtmRA6Hkf7qBxxZJ0xmDrm3n/TGAElDCvZQB7DHF+uuHeX0
 d6jFJPMjyTY0x/8cVarf8FU6O4HdD16l1h4+atPcLKCIS5F3cxT9OO8TVeHZzl4XakyF
 3VIHwoH0svXl5dsrtE7Z0u2qdgc0X61/Ey8PePlqD3IXidQC430K9dqSTBExaYmWi4GE
 EL8kRKtmQ99eo0TobH5Ez9b6AOp/pLo5EovyE+55vnchBEqD4w9+Q5k8cYy1geI/anYu
 mWMZppZwzfOWlzo+EvRT6MSd+SCTbc0VilbrNdJxmoo8Hr8yyWFs+ToFIW7/IRyQ1NS2
 0REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=W0m3oFYfEdmQXtbNnJ57bvEwrecGkzyuNTxMF29GlxY=;
 b=W/sx4/QEEH77w6hQaRkEOIiB0f/DB70x2/O+hgXqHndI57L0B0cFmDETOCCNzvK1eq
 u1UKQBmFQ7tGNDeQXLClHk3z4uQzEj5XyP/gMBDr+rnjOdH9P6iGtWU3KNiWkwmDBezF
 9OKRUjhiyldu2i7mTrVqgSlbV33o+mohQAfmPl1oOtpGX/R/0od9EDdBtNDlSMR22R3y
 0agmZpc2APwPFvxXsLJfbhd0GZ6asYmUCi2Bw/cyA5KXIQaJwp/cTyxpji0r5JD6vSCc
 WhlUrAj1Zo5XoNfPJa8/2/cz55WjKSWG7OyS1HcYNEJA0rQMsqkgobKulG9lz/yeFbKu
 8rJQ==
X-Gm-Message-State: AOAM530YRDB4reDyhsCGPynb89Eg3VVaT8YVX835l3qQA0W3sXifpwOK
 gtzTEJzDolR7q1w/bUgJNJY=
X-Google-Smtp-Source: ABdhPJy5wua0gBwdh7y4cxqEsckHqpBfCM8zWi8GCnP+vGYiRsb+2R5qDrDiWtHbTHWiMwwH8lMaIQ==
X-Received: by 2002:a02:ac01:: with SMTP id a1mr24122656jao.33.1592262748514; 
 Mon, 15 Jun 2020 16:12:28 -0700 (PDT)
Received: from s-lmo-gaz25a.dev.cray.com ([63.239.150.218])
 by smtp.gmail.com with ESMTPSA id 129sm8616712iou.2.2020.06.15.16.12.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 16:12:27 -0700 (PDT)
From: christopher.walker@gmail.com
To: 
Subject: [PATCH] nvme: Quirk for Samsung PM1733 controllers
Date: Mon, 15 Jun 2020 17:12:22 -0600
Message-Id: <1592262742-103431-1-git-send-email-christopher.walker@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_161233_841195_3B158D89 
X-CRM114-Status: GOOD (  12.13  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, axboe@fb.com,
 christopher.walker@gmail.com, kbusch@kernel.org, hch@lst.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Christopher Walker <christopher.walker@gmail.com>

Accommodate the drive-ready times of Samsung 1733 controllers, which
range from 2s for the 2TB model up to 4s for the 16TB model.

Signed-off-by: Christopher Walker <christopher.walker@gmail.com>
---
 drivers/nvme/host/core.c |  3 +++
 drivers/nvme/host/nvme.h | 16 ++++++++++++++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c5bc4..9a5ebbe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2234,6 +2234,9 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
 
+	if (ctrl->quirks & NVME_QUIRK_LONG_DELAY_BEFORE_CHK_RDY)
+		msleep(NVME_QUIRK_LONG_DELAY_AMOUNT);
+
 	return nvme_wait_ready(ctrl, ctrl->cap, false);
 }
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226..8174032 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -129,6 +129,12 @@ enum nvme_quirks {
 	 * Don't change the value of the temperature threshold feature
 	 */
 	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	= (1 << 14),
+
+	/*
+	 * Samsung 1733 controllers need a longer delay before checking device
+	 * readiness
+	 */
+	NVME_QUIRK_LONG_DELAY_BEFORE_CHK_RDY	= (1 << 15),
 };
 
 /*
@@ -173,6 +179,16 @@ static inline u16 nvme_req_qid(struct request *req)
  */
 #define NVME_QUIRK_DELAY_AMOUNT		2300
 
+/* Samsung 1733 drives have long drive ready times.  From the spec:
+ * 15.36TB: 4s
+ *  7.68TB: 3s
+ *  3.84TB: 2s
+ *  1.92TB: 2s
+ * The delay below accommodates the 15.36TB drive at the expense of the
+ * smaller drives.
+ */
+#define NVME_QUIRK_LONG_DELAY_AMOUNT	4300
+
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e2bacd3..7ef4867 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3109,6 +3109,8 @@ static void nvme_error_resume(struct pci_dev *pdev)
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+	{ PCI_DEVICE(0x144d, 0xa824),   /* Samsung PM1733 */
+		.driver_data = NVME_QUIRK_LONG_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1d1d, 0x1f1f),	/* LighNVM qemu device */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
