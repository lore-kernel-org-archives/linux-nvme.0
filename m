Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49DFC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 21:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BnQ4PVNKLAL3WeTs1JIIKZwKgMP/n9ZoD+X1taROD74=; b=MjN+eB5ntimqawzKEakdOAs5Dn
	2lijc3FFVtWeEUGkyLPZTTKfIXsNI+EN9QEFY04OgL7aNE0QzTuPS50/od1dRISSWoevcbAbBL2AE
	PSXAiWJ1AtMP8tgcIZJugHWqfsNxu6Vl84ZO52IY/GnanPhvvkm1MudloyWB/XpVbsdOlOMGBsC5W
	EDIzI0dBkjA0reesmjeJm1vbzksCv6xyyq77SOBSQ7JhIMWdP2UcfyMVEfTdjG4iRTrCUGvMCWJGQ
	uv0LQ8BQsEZroh1LgohOljrc9B/5+pmbuWIk9pVxp4bO1K3ppYmWHQmvYUu0Z6dFTeVV+Ii2wYt7/
	6UrpoaPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PX-00C6q8-1b;
	Wed, 03 Jan 2024 21:04:23 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PT-00C6nr-1b
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 21:04:21 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d3f29fea66so45864815ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jan 2024 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1704315859; x=1704920659; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnQ4PVNKLAL3WeTs1JIIKZwKgMP/n9ZoD+X1taROD74=;
        b=GHkj7P6bpkAKrypf+kuaEiYe1RzI3y5fKO1OHuolbjzzrNtdnyIBl84e3JszlT/Vzd
         xHryCnnG3tH9a2CngmnhWQZEFL1mJxRESwr4c8JQEZMwIVP57i/a2LPdgkrwjyhFen/A
         JJHFXEFOh6mQwfuluv/SE85mrKOmCg1/lyeFOjxtAliEjMrGqB3GDfoGEBuC+O9kX6On
         WX4/SrSPZsrMVldf5PgSxXArQ6ISq15HCO0sdajRZCLyKq9n2flOipKTsbsyD4R4+GpU
         bDvJEv4eHudD1wo1Dgh1EhrqRcmcdRSvqDAj7SWBrw8GJQv4W4hBZL1+lOEOvtW1ALD9
         17rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315859; x=1704920659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnQ4PVNKLAL3WeTs1JIIKZwKgMP/n9ZoD+X1taROD74=;
        b=Y+BLaMWXPOPAQhzJt56fVKYM/9GWY/+koJRI2H8i0TKS/Lv59851KvB0baCR2lFTXt
         WlQ5dzJ5Rz/9fNnx4FwN4Ff0LeQpSHAzhM6sll8RFlgSF2pfg4nzh+Yxiywo8CjyHSco
         oi1OCr6mGgCboQhAzZ5OqIWvrBKKwOEc9Icai2HtUZGeaXCG/eznL/S+rRvvBn8iUYSr
         Cc5gMGNl1qA3887AzZxz6NF6SEYDM/ocyp/UwG8/pbjglhIcYgn87T/CIaCnMQFaGwq3
         Y6qDEwbeEyIxsaBqDZ48VFWxlIVZRCh7tpz7tZa6MQMz+bljpx7eQrbKI3SvDBeDG+P2
         vswA==
X-Gm-Message-State: AOJu0Yy1CY0SOJkk9mb18RNcd6VZUmhaI7GgO9t1kLF5owxiBFfowaGo
	GaxFWVeSBU6FGkZGCVkXFV+swFita070+Q==
X-Google-Smtp-Source: AGHT+IGj36QO6ROWHRUSLohyr5bnnRIOWN+TQCjG6doWpRg8GzzoK8Km4+k26hBye2kQDHPKNNyKHw==
X-Received: by 2002:a17:902:b58b:b0:1d3:442e:f0a2 with SMTP id a11-20020a170902b58b00b001d3442ef0a2mr9926471pls.139.1704315858993;
        Wed, 03 Jan 2024 13:04:18 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d414a00fd9sm22505837plb.29.2024.01.03.13.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 13:04:18 -0800 (PST)
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
Date: Wed,  3 Jan 2024 13:04:05 -0800
Message-Id: <20240103210405.3593499-6-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103210405.3593499-1-jallison@ciq.com>
References: <20240103210405.3593499-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_130419_532429_AAD47DB3 
X-CRM114-Status: GOOD (  20.63  )
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

Adds the new NVME_DISABLE_SHUTDOWN_ASYNC to enum shutdown_type.
Changes the nvme shutdown() method to set the
NVME_CC_SHN_NORMAL bit and then return to the caller when
requested by NVME_DISABLE_SHUTDOWN_ASYNC.

nvme_shutdown_wait() is added to synchronously wait for
the NVME_CSTS_SHST_CMPLT bit.

This change speeds up the shutdown in a system which hosts
many controllers.

Signed-off-by: Jeremy Allison <jallison@ciq.com>
Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/nvme/host/core.c | 18 ++++++++++++++++--
 drivers/nvme/host/nvme.h |  3 ++-
 drivers/nvme/host/pci.c  | 30 ++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c7d448f186fb..7000adea1e41 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2225,7 +2225,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC)
+	if (shutdown_type != NVME_DISABLE_RESET)
 		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 	else
 		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
@@ -2234,10 +2234,24 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
 	if (ret)
 		return ret;
 
-	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC) {
+	switch (shutdown_type) {
+	case NVME_DISABLE_SHUTDOWN_ASYNC:
+		/*
+		 * nvme_shutdown_wait() will read the reply for this.
+		 */
+		return ret;
+	case NVME_DISABLE_SHUTDOWN_SYNC:
+		/*
+		 * Spin on the read of the control register.
+		 */
 		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
 				       NVME_CSTS_SHST_CMPLT,
 				       ctrl->shutdown_timeout, "shutdown");
+	case NVME_DISABLE_RESET:
+		/*
+		 * Doing a reset here. Handle below.
+		 */
+		break;
 	}
 	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8c30f9856621..43667d7a471a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -189,7 +189,8 @@ enum {
 
 enum shutdown_type {
 	NVME_DISABLE_RESET = 0,
-	NVME_DISABLE_SHUTDOWN_SYNC = 1
+	NVME_DISABLE_SHUTDOWN_SYNC = 1,
+	NVME_DISABLE_SHUTDOWN_ASYNC = 2
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 367e322dc818..9052dcf0f70c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2586,7 +2586,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, enum shutdown_type shutdown_t
 		 * Give the controller a chance to complete all entered requests
 		 * if doing a safe shutdown.
 		 */
-		if (!dead && (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC))
+		if (!dead && (shutdown_type != NVME_DISABLE_RESET))
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
@@ -3100,7 +3100,32 @@ static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_disable_prepare_reset(dev, NVME_DISABLE_SHUTDOWN_SYNC);
+	nvme_disable_prepare_reset(dev, NVME_DISABLE_SHUTDOWN_ASYNC);
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
+	 * NVME_DISABLE_SHUTDOWN_ASYNC.
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
@@ -3494,6 +3519,7 @@ static struct pci_driver nvme_driver = {
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
+	.shutdown_wait  = nvme_shutdown_wait,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
-- 
2.39.3


