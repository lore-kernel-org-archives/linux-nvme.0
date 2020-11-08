Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14410C388F2
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 04:09:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B4420760
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 04:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sJgcKhgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B4420760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OtDnXqq8wqCO/kgb67LTqeEBZ0xkuVLIt/+BjuFP3OE=; b=sJgcKhgfWZQOJSdVjgtrgZ0H4G
	MW8lX53OqZHLDMpYm38WdGyPoMzSsBWM7gvX/A77xUsyJCYHQykFltbZzo8CRLpub8EyNhIZE4xYD
	/tVN6X+S7FLIgxJQhRr/WIAtkwzp/r38kkTsAf7PnLvRC4DpW7WcXye6mrnYxFK2q47yitK5Ae5sr
	G7xk9mXjNImelUjgkmIaboqck44cjR87Q/bDUgk/xI0idli9YpB7yxttrzAkZ7hGY3yrXYYXU6nmj
	0FFVM9GTxnvwtgscQ6+gYGycAqr3sJoEsNwlJF3T7FDcEM+J2wesxIVbjA9cW+4QEuTQXYE4eCzwG
	F+g3+bjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbc15-0007bK-My; Sun, 08 Nov 2020 04:09:23 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbc0y-0007az-E0
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 04:09:17 +0000
Received: by mail-pj1-f66.google.com with SMTP id g21so1462177pjv.2
 for <linux-nvme@lists.infradead.org>; Sat, 07 Nov 2020 20:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vtp5qFRkelkGhy9msyygUckdeGUq32kdu+r5OWj8piU=;
 b=j3HgVbzv5+N4VDl0MgROKfWWlt7CyKbmlij4RsEK5qxQuW7e3bjuUqfEdkRHgj9i3Z
 C9CxgVycJ2qEti123OUfwGKUiv1KTwV+4POMAAs+3i3IuDKcrz9a8GozOf4OqCLEimOC
 V64UxkAGug/AdwzN5E/BntGyLHzvlioV5iuZJfPa/MW4y91IJYEEMfbIv+tNZxD++AFG
 zGRNtWPS6KvNV1+FQGYBd5C3cxfWg0BXA3EDHKGJ3Ab9tga9l1NMtOkaytx/kS2z9PrS
 71tEgs510/Wd70IJG8kp2+rjt8FH78y+1sOmxoFi3MLvfvyBGDjvCxsk5F3I3sWxkbVz
 GtWg==
X-Gm-Message-State: AOAM532GBPo/fflCdwtTU/nCBUIx1PoYhXWRixiumnzD7PXM0gYT4FlR
 /AyGyo7avTU5owwHtl8e4VY=
X-Google-Smtp-Source: ABdhPJyt4y47PETluu2ZPde2Ty1F6KtVbJbq3Q7VjFM2A8ufAJjP+Bmi111BO2YsbAnUXLKqSyDKJA==
X-Received: by 2002:a17:902:8b8c:b029:d6:df70:fa21 with SMTP id
 ay12-20020a1709028b8cb02900d6df70fa21mr7825001plb.15.1604808552635; 
 Sat, 07 Nov 2020 20:09:12 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id 7sm3070890pjt.54.2020.11.07.20.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 20:09:11 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: Boot as soon as the boot controller has been probed
Date: Sat,  7 Nov 2020 20:09:03 -0800
Message-Id: <20201108040903.8185-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201107_230916_490460_FC9AE102 
X-CRM114-Status: GOOD (  19.37  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following two issues have been introduced by commit 1811977568e0
("nvme/pci: Use async_schedule for initial reset work"):
- The boot process waits until all NVMe controllers have been probed
  instead of only waiting until the boot controller has been probed.
  This slows down the boot process.
- Some of the controller probing work happens asynchronously without
  the device core being aware of this.

Hence this patch that makes all probing work happen from nvme_probe()
and that tells the device core to probe multiple NVMe controllers
concurrently by setting PROBE_PREFER_ASYNCHRONOUS.

Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/pci.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..703bb3aee817 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -6,7 +6,6 @@
 
 #include <linux/acpi.h>
 #include <linux/aer.h>
-#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
@@ -2821,15 +2820,6 @@ static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
 }
 #endif /* CONFIG_ACPI */
 
-static void nvme_async_probe(void *data, async_cookie_t cookie)
-{
-	struct nvme_dev *dev = data;
-
-	flush_work(&dev->ctrl.reset_work);
-	flush_work(&dev->ctrl.scan_work);
-	nvme_put_ctrl(&dev->ctrl);
-}
-
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -2903,8 +2893,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	nvme_reset_ctrl(&dev->ctrl);
-	async_schedule(nvme_async_probe, dev);
+	if (nvme_reset_ctrl(&dev->ctrl) == 0) {
+		/*
+		 * Since reset_work is scheduled on the context of
+		 * nvme_reset_wq and since that workqueue is not used for
+		 * probing devices, waiting until reset_work from nvme_probe()
+		 * is fine.
+		 */
+		flush_work(&dev->ctrl.reset_work);
+	}
+	nvme_put_ctrl(&dev->ctrl);
 
 	return 0;
 
@@ -3221,11 +3219,12 @@ static struct pci_driver nvme_driver = {
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
-#ifdef CONFIG_PM_SLEEP
 	.driver		= {
+#ifdef CONFIG_PM_SLEEP
 		.pm	= &nvme_dev_pm_ops,
-	},
 #endif
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+	},
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
 };

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
