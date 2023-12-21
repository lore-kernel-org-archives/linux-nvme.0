Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05971C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OdLnyo/U7EGxSqPL2rN2th6Ox+unwZIt5XkJiOU+NVg=; b=mzWxHtx3d4zIIcuRqpyuJy1Ypi
	A/sEr7RXw06d6aMFy7IzWPULWU5WPvNFVcz4akrh2jktThAYYT10OrJsM7h496b3WvGjJ8vhhX4X2
	FEwo4B8NA2j20gR2Dy/14oRtF/IXwUwq+xB4naQFBEIjSDrC4VJ3Hnhe3KaGBcJvfwdBYdnsNUxi/
	4z1E6x9GFTtvqAecjASf0EeK7ZvRIgtVdUMV9Jb1MpxDWEa+xt0LtZJGhIIU9H8b+3agcsT8FlUGg
	K7WJQtrnHYgoooKjO31CInFelB0lexQn64oAzAC60SeKn021w5q8TOHe0Xcq1QSJmDGD2xEIbxqFS
	zoQYLFXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlU-003dp1-2s;
	Thu, 21 Dec 2023 17:23:20 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlR-003djT-2Q
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:23:19 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso811082a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 09:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1703179394; x=1703784194; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdLnyo/U7EGxSqPL2rN2th6Ox+unwZIt5XkJiOU+NVg=;
        b=Ccv+yus8WozJ4s4sgYgBOYRKrYaqXHg6+hgJLYKJWL28sZxrG6xxdRqBHjTlgTpHkG
         7q7k+mFLj2lDbNVjbNfdxp26vta+Y1O61b/ZAmvZflr4rXKuYfj6rNtRWt3nNCNVSn/z
         IBQSTQohAPfGb19eXTU7pHRtivi7uGNzWHyQAtjshiqMwIND9FpZQwGsF7dmXCx550+c
         Ha5wL5ReYAr3SpQeenKLwHV5/oh2cXnm/fdkqssxa0swfSrEB+dOH4zT2biFoOg7hFVq
         toOxaP2oWNOVpAoprXB0UYjNlPIbiJVJcka4JPIkHmVscTRwCbhNTxIbpl5VW5hHM/oP
         98mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179394; x=1703784194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdLnyo/U7EGxSqPL2rN2th6Ox+unwZIt5XkJiOU+NVg=;
        b=T2wmkkZQJGGI0RN5yXkyOJPYgT4anL1ZpuVMeDDczBTsV1K0swpU5OlgtRWiTe4OlH
         DUmF30rT6vOHUVBqtOUQ7qQUsxbdLN8E6zQ7fOZXymii1V/U82FVSw01McUmT94U/CGo
         kwJ+D1283meFZJznPNUNBUbcoGDBWk9GZCIKZkWtmxDFCB+pe9VHqRgI+3QoJ5C5NWSd
         owccAUQ1DFyc8AQj/E9CTcUqBMGYDF0/1Y89KMN1Q2tTJKOXu+OJ0T6f/ULCt7VE4haL
         0/fXnizqrifNOMTa8QF201bFoYY2L8xVW8LBS1e4O/rbYxzdjSRMFjJdk5qIVH0asd5w
         5nhQ==
X-Gm-Message-State: AOJu0YyoRpLj8anRVt9VOehoOTY07zi8tuOkbw/Q6nngj66mHUpgC+Tm
	BuTnODEw1hY2MPdq9DscUSOXQKoy6kuwyZwk1HvEb/I8eX8=
X-Google-Smtp-Source: AGHT+IEmFByN4MfMtV/eewhCM1wDkwv7dadaB4o8wCYBRQd+zZqkqor27qss6Jig86Z/syEt2JFSvg==
X-Received: by 2002:a05:6a20:3d90:b0:194:dafc:d7d3 with SMTP id s16-20020a056a203d9000b00194dafcd7d3mr4434pzi.63.1703179394295;
        Thu, 21 Dec 2023 09:23:14 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id t67-20020a625f46000000b006d6b91c6eb6sm1990744pfb.13.2023.12.21.09.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:23:13 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: Add two-pass shutdown support
Date: Thu, 21 Dec 2023 09:22:57 -0800
Message-Id: <20231221172257.2234320-5-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231221172257.2234320-1-jallison@ciq.com>
References: <20231221172257.2234320-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_092317_879470_08EA4740 
X-CRM114-Status: GOOD (  22.11  )
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

nvme_shutdown_wait() is added to call an internal
nvme_wait_for_shutdown_cmpl() function to synchronously
wait for the device to wait for the NVME_CSTS_SHST_CMPLT bit.

This change speeds up the shutdown in a system which hosts
many controllers.

Signed-off-by: Jeremy Allison <jallison@ciq.com>
Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/nvme/host/core.c | 29 +++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  4 +++-
 drivers/nvme/host/pci.c  | 24 ++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bc7040da8e74..2ebcd40106b7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2216,7 +2216,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC)
+	if (shutdown_type != NVME_DISABLE_RESET)
 		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 	else
 		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
@@ -2225,10 +2225,24 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
 	if (ret)
 		return ret;
 
-	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC) {
+	switch (shutdown_type) {
+	case NVME_DISABLE_SHUTDOWN_ASYNC:
+		/*
+		 * nvme_wait_for_shutdown_cmpl() will read the reply for this.
+		*/
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
@@ -2237,6 +2251,17 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
 }
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
+{
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
+	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
+			       NVME_CSTS_SHST_CMPLT,
+			       ctrl->shutdown_timeout, "shutdown");
+}
+EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);
+
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 {
 	unsigned dev_page_min;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d880f1ee08d4..adbff23532de 100644
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
@@ -756,6 +757,7 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type);
+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77b015affb0b..9cb4436710dd 100644
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
 
@@ -3100,7 +3100,26 @@ static void nvme_shutdown(struct pci_dev *pdev)
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
+	nvme_wait_for_shutdown_cmpl(&dev->ctrl);
+
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
@@ -3492,6 +3511,7 @@ static struct pci_driver nvme_driver = {
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
+	.shutdown_wait  = nvme_shutdown_wait,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
-- 
2.39.3


