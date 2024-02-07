Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4474CC4829B
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z2uyFMCcyqVglycLsk6yfIZapFLQNNHt2F3Q8zhRCw4=; b=BGqfX5NfqmGzXTXE3mNn6Qjxf1
	GznALvAaZtaNoYGhE8zFPj04MT9SmgTYAQlhGf/iCVUOcAdZPSEIauSmNNjqJM+bQ93ZqVwJ65KXJ
	uIbYCyMFYsJfqinXqKI2Yf2Zp/8qVL40X0LcMmJDHmwWf3LW/E09f5+ZEHl7AwTTzj4RyUCrlFSLv
	3g8nGANayI6j1MqBFXt2btu3lcMYsEBGQzS7V9AMJjZmNXBIU/KqmDkSNpg62hQi6bxsaOzYR12ul
	DtVRmTiHDixVe8gE0EwZz5T7NTh3nb+IyDZatH+PbMrWYF+aeK9kJJL/q9kTK1cjd7Yg5Qj4ddy4D
	tMNlaXIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpfA-0000000BxAN-3ka8;
	Wed, 07 Feb 2024 21:41:00 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf6-0000000Bx6E-2OEE
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:40:57 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso971134a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 07 Feb 2024 13:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1707342055; x=1707946855; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2uyFMCcyqVglycLsk6yfIZapFLQNNHt2F3Q8zhRCw4=;
        b=iG+TACPIG6n5rtLc3j1mso7r523gM20RkPnmtBfu9iYRzufL8IQgrWfWvS26/sqauu
         9urx+dyV9gGZYvO6zqT3gOq7gDWdeY+9Hnd67F/ggKxgyUC27TZIfIlMM7Pe2hR05Lts
         UGpRWlQCyWTAnCASDIfBskJdsiNJMzcCFQXkDwJU3y+8EjCydEMkc1jlDO/x+5DA9T9V
         QwIAq5u6tUEOg1QYGcO2WD9HYRH7cC/dizzZN2DE3Q/mOnH1sn8jQ74sOPN0kFJBThsw
         yQIz6sxW38flXtqH4ZnUybUiy/c68lrvwYL1MDPIPlkdDg3S/s6Te/eFZV3YEye0GR10
         +bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342055; x=1707946855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2uyFMCcyqVglycLsk6yfIZapFLQNNHt2F3Q8zhRCw4=;
        b=wzNcQmVGCSXr8WL4s0bfyKJ6zZbYNZ0b653lvgDxWu7N+o4WnhcNjJYE3gD7MnVtWw
         tRxGW1Qn2JCt5wwFg2bl19CprHC2joKacU63E6VyTPS5gx+68YoIn09ZuRPggLFYJWvg
         E5L0y6fKsYd9l/gRR8emkdh0vorAyg6CUUXIcpsYRHyxgdhhBB0GrT4hOk//cUQhHYHB
         urXbtZXZkgrcHUe+7xIihAKLrAVhgg3i8c1nTzkXzhk4cahBRJUyY8jcAlYKJhMFyGS4
         H04IipLWbMnJVn3RHLHR7vi1gPTwOL+pPqWXDh5ccWunQGAc55SGqPjGyWf9exgx1xDw
         oTlA==
X-Gm-Message-State: AOJu0Yxuh+29gKdGahFDXTWi03NXfs5YBzXdyMJR3xdEO7i/9nnpgT7/
	ya3ksceyjj5q3Bzhc1K8JV98buW9P13PywoPnxTybVX+bmiQFnkrgfT91zrs18Y=
X-Google-Smtp-Source: AGHT+IFcqpmqtq0H0skfWzQwZTlFeZo4oFSP6zGqbcwxur6ln9S5MJ6obkGsxWxfstftdTO/FyLIAA==
X-Received: by 2002:a05:6a20:9012:b0:19c:881d:78e6 with SMTP id d18-20020a056a20901200b0019c881d78e6mr4870472pzc.42.1707342054775;
        Wed, 07 Feb 2024 13:40:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDAkkWpGStH/9Oxxuo+qiLdkFHR2jgg+AvQ3g3tPL4rpO9G52iKrwPZk76HH0k1t+dgNKAUGqLRmlIQvuSHGHz/tLtQpmThDx6NQR9xCs1iIZKR9TCmaMG1774dp9n9GnTNRq4EKJbT6WUqOmcvQmNb7C0wCcqa8n5ugLfBWNvDZ+u0L6BhAHTyjQwtwzioTDiVL389HZrbHW73rtsAlHMRJyvO3QfDaqKIvJ4B4KkixXCIe0ADcnz9m18J9UzEnrMIZT3CEUjP5s/
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id ml7-20020a17090334c700b001d7274cbd33sm1939005plb.121.2024.02.07.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:40:54 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me,
	djeffery@redhat.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5/5] nvme: Add two-pass shutdown support
Date: Wed,  7 Feb 2024 13:40:44 -0800
Message-Id: <20240207214044.2374295-6-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207214044.2374295-1-jallison@ciq.com>
References: <20240207214044.2374295-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_134056_636159_69D80372 
X-CRM114-Status: GOOD (  20.35  )
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

This works with the two-pass shutdown mechanism setup for the PCI
drivers and participates to provide the shutdown_wait
method at the pci_driver structure level.

This patch changes the nvme shutdown() method to pass
down the NVME_PCI_DISABLE_SHUTDOWN_TWOPASS enum value instead
of NVME_PCI_DISABLE_SHUTDOWN. nvme_dev_disable() is changed
to call nvme_ctrl_shutdown_start() instead of nvme_disable_ctrl()
in this case.

nvme_ctrl_shutdown_start() sets the shutdown bit,
but does not wait for completion.

The nvme_shutdown_wait() callback is added to synchronously
wait for the NVME_CSTS_SHST_CMPLT bit meaning the nvme
device has shutdown.

This change speeds up the shutdown in a system which hosts
many controllers.

Based on work by Tanjore Suresh <tansuresh@google.com>

Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/nvme/host/pci.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4dfc6258de07..5cf452651091 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2607,7 +2607,14 @@ static void nvme_dev_disable(struct nvme_dev *dev,
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_delete_io_queues(dev);
-		nvme_disable_ctrl(&dev->ctrl, shutdown);
+		/*
+		 * NVME_PCI_DISABLE_SHUTDOWN_TWOPASS requests shutdown
+		 * but doesn't wait for completion.
+		 */
+		if (shutdown_type == NVME_PCI_DISABLE_SHUTDOWN_TWOPASS)
+			nvme_ctrl_shutdown_start(&dev->ctrl);
+		else
+			nvme_disable_ctrl(&dev->ctrl, shutdown);
 		nvme_poll_irqdisable(&dev->queues[0]);
 	}
 	nvme_suspend_io_queues(dev);
@@ -2625,7 +2632,7 @@ static void nvme_dev_disable(struct nvme_dev *dev,
 	 * must flush all entered requests to their failed completion to avoid
 	 * deadlocking blk-mq hot-cpu notifier.
 	 */
-	if (shutdown) {
+	if (shutdown_type == NVME_PCI_DISABLE_SHUTDOWN) {
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
 			nvme_unquiesce_admin_queue(&dev->ctrl);
@@ -3128,7 +3135,32 @@ static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_disable_prepare_reset(dev, NVME_PCI_DISABLE_SHUTDOWN);
+	nvme_disable_prepare_reset(dev, NVME_PCI_DISABLE_SHUTDOWN_TWOPASS);
+}
+
+static void nvme_shutdown_wait(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	mutex_lock(&dev->shutdown_lock);
+	/*
+	 * Finish waiting for the shutdown request
+	 * initiated in nvme_shutdown() above using
+	 * NVME_PCI_DISABLE_SHUTDOWN_TWOPASS.
+	 */
+	nvme_wait_ready(&dev->ctrl, NVME_CSTS_SHST_MASK,
+			NVME_CSTS_SHST_CMPLT,
+			dev->ctrl.shutdown_timeout, "shutdown");
+	/*
+	 * The driver will not be starting up queues again if shutting down so
+	 * must flush all entered requests to their failed completion to avoid
+	 * deadlocking blk-mq hot-cpu notifier.
+	 */
+	nvme_unquiesce_io_queues(&dev->ctrl);
+	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
+		nvme_unquiesce_admin_queue(&dev->ctrl);
+
+	mutex_unlock(&dev->shutdown_lock);
 }
 
 /*
@@ -3522,6 +3554,7 @@ static struct pci_driver nvme_driver = {
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
+	.shutdown_wait	= nvme_shutdown_wait,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
-- 
2.39.3


