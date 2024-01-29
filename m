Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93619C47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B6IPohOVVDxLjkMtBpb+WLToJyu9RjYnqhqX9rfEPYs=; b=WwlX+hPvY1Z+IXRb8ERtsSpSMc
	dAimHIyWkqjGvxMBoe/6fewm0ee1rj+twUVbatvqRnUz/0LV7snz+to98Snn1hROvDMeyFzel1t+m
	jm66nIESRZ4NuoRM/o9wwBxSHacuVf+AhcvNFQGH8LzMFr0Afj5PbgQaaQ8Sxzh7vl7TGRDYvCxX4
	6FX2xpTlS+xyP2O+jmmf8GeG1o8VtqfeFHPIomLlF+P/LExnGfDJT/W37eX4uvOa6psWGVSZc16jY
	K1+bskVSZ3f99N7e7vGbKEoxaRlwaynQfSV/nwHIuR8viWjcLJDNBeZOa20VT211P9Sa7yIdcdxUI
	RsjeVXkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEt-0000000DuVA-0ruP;
	Mon, 29 Jan 2024 18:20:11 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEo-0000000DuRb-129w
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 18:20:07 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5d8df34835aso239605a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1706552404; x=1707157204; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6IPohOVVDxLjkMtBpb+WLToJyu9RjYnqhqX9rfEPYs=;
        b=ZdWLlmO6/qciYYglrESBp5CIB9b18+CZHIlTPAvKfEBwVLJDSIaPzozgilv0VqesvZ
         X4fMQMysqabES0k5fwU0NXe3rRRPc2yYlcQ82V56ebPlwvtDdeIIezmpSB5TYk5oYO24
         a69Bpt7WNwCmoIG2nTO7x6eAQ1wopTY/lz/gShAK+uy9zwW77qSeRfbNu6A/1tSMi+op
         zgaQbETLXe0gz+hCT3zS8Gm/kwdf6b+F5ACZBq4/A4q8esnjtxyRWj6aqf6PVg5LbW+y
         ybgZ4YDamVjbGVyczin7Q9usp7p0e7PUu0+X7Xvz/HhRkyUZwnb6uChag+1Kp+jLh7iU
         c/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552404; x=1707157204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6IPohOVVDxLjkMtBpb+WLToJyu9RjYnqhqX9rfEPYs=;
        b=Ou7v1WTTwVHEgB8fWU0Qvz4XfY5IuodNuQdvbR3TvrmPJg3RasH26reZhcD0HKTlf6
         0aak1+PvIqoMuP3WhoIEcGZhXLQsIrW3PBRgP/TUE2wdQDSUDT8T/a6XJeelCqeMw1C4
         uXtrvwRz0LUWSocyO0i5yRHZrV4DR8R1glYWDdoSGUqAFnKP40xF8vUL5HpnKQBcU3+y
         Yw16v5zBQjqU8FVDaeBRjPe0FLQUgPVjWtQ3zt0EinzGbw/UXM3/gobcirOY7tATbR6N
         n81wLXmNfFV+LNhqECfQtR59leei0mXreoA70qrOZcpLc8R2Qg/IT39Bm6DgzEPZvuQF
         cYTg==
X-Gm-Message-State: AOJu0Yx/hPl7aAeRMR5Ne4uwK1tZufflK8Ag8pni7is5boAQ5gLqnKlk
	iI8TK9loIjoWy5klhLsJJ0LMsVKKjJPtga7ej1RCGFYYujjVG6uJqOL4HD1zuME=
X-Google-Smtp-Source: AGHT+IEe8j4OWO98uYy2CQV5MZZdUfd3RuFQOF8GSn6+2n+WfIsGFTYaKrMnm1bVMIPKJpOTxvHwOA==
X-Received: by 2002:a05:6a20:559f:b0:19c:9f51:a8db with SMTP id kk31-20020a056a20559f00b0019c9f51a8dbmr4403168pzb.7.1706552404390;
        Mon, 29 Jan 2024 10:20:04 -0800 (PST)
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id bv123-20020a632e81000000b005c1ce3c960bsm6617750pgb.50.2024.01.29.10.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:20:04 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 5/5] nvme: Add two-pass shutdown support.
Date: Mon, 29 Jan 2024 10:19:53 -0800
Message-Id: <20240129181953.1183084-6-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129181953.1183084-1-jallison@ciq.com>
References: <20240129181953.1183084-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_102006_322238_86854195 
X-CRM114-Status: GOOD (  20.05  )
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
to call nvme_request_shutdown() instead of nvme_disable_ctrl()
in this case.

nvme_request_shutdown() sets the shutdown bit,
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
index 8ee77f755d9d..bbd89eecf05a 100644
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
+			nvme_request_shutdown(&dev->ctrl);
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


