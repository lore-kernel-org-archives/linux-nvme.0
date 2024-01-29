Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09010C4828C
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IAfVcU5lObIUjNE1FPAQLuz4GW+LHpExetCJiZZuKxY=; b=eUZ8Xb+frQhX15N5KXCcUxkP0e
	jBL3X6mPti5j0goIaBvEtRJNryMipNjXiZMJddfTrdS93XqXx3VgT5agMybdOHdHTdoNnMgaJTH9O
	Vyz5QE220VVaPMCYF/hhOnaQZuHDysYxxpbO0inILWBHww6XXq9QB1DLrTfvgHogwG4I3ZO4jl7Ih
	mmGUS0sEDot14kd/DT04lFri7cZuVoreyHWtr8BE/XhylNuM//hZTqrvjRyDzQ/uSBNXrbhTit+cw
	05UzC44xo7FsZSb5s5k22DyZE4n1xNsEO1gON2sReqd14IikC3QWfyqf9GktF6MWkfiODPCy/UMDE
	OjGs4htg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEp-0000000DuTL-2ajp;
	Mon, 29 Jan 2024 18:20:07 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEm-0000000DuQr-0Xjx
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 18:20:05 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d8f3acc758so5562225ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 10:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1706552402; x=1707157202; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAfVcU5lObIUjNE1FPAQLuz4GW+LHpExetCJiZZuKxY=;
        b=nEHv+2TPcfw4kyASAWfNoHDh/7vEMKW6QTxEIXUgwiUcp7HZ7/7Z9aQ1BpKFNjCfZZ
         z2Vu4hridP8f2WJkKLOj601SHsnDN1cRJ7q7W3zuxtKnSeOUorTUn+7HkvazBC3oJKLY
         BvKucXrfPAR4H4XTJcfgvY2TfVEZDVvmwSACqXfyUmfY70x0fEC+n5sr/eMjkpYyAOiX
         1LO/QQJYpj/hBGGBa/DFazImGc0D9fJX1qlejx7cc3WMbW/hV2XhLNefUgC08t1K5i/9
         K9r+aDwmMU36TuPmTcQvTlfOl3j0p6pfSGawBU9WWcVJIm5nb9m5bNxvy3py90AEeZvf
         k3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552402; x=1707157202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAfVcU5lObIUjNE1FPAQLuz4GW+LHpExetCJiZZuKxY=;
        b=TpGnTFq1RYl29EX4P8OJ/w/ZDid3tfE72yCgBAkkcYxNYy3K7vAHS+TrXIL+uAnEYC
         jMvCJzrxuRdt8bSxznEGk+MAsF5Uougm5LrJba2WZtwq66y2TbdwJuhU4s+i1N2KS9Yv
         xjwbnsOD8hHXNGf4GSfPW2kuSmzL0Sd5liKdudjBU24G0gtRf4k9aoVy5KwNZdin6Q4M
         C3PJEtvOXC+LusonVnCYN4DuB1fj8MPhdoLOHIqVtOkVuY9tackfBugzzbYYeITaC3j4
         PrK7j/94gJLesz/L7opmI0fG4d+sBN7H/sbwTzpWpJyOhKf63Gz6ONYM4FlROLIJiTPw
         xSEw==
X-Gm-Message-State: AOJu0YxPnG9+1/KUqN47qZ/oZfeNbMt9H6Hq7EMMiAdHZlfadIJltE1+
	XdRSBld6CLWCL3+kB5zQ1uQrnXLwJFp2TvuOp8Df4VQxGLimH1325q/n88Sd7JQ=
X-Google-Smtp-Source: AGHT+IHU51LmozfM9aNcw5hfBqn4Gsil5+MsiNR0epIDKcdFxqsVEFfXZaPAsc5javm702t3TaPnzQ==
X-Received: by 2002:a17:902:f552:b0:1d7:193f:3183 with SMTP id h18-20020a170902f55200b001d7193f3183mr8529179plf.49.1706552402271;
        Mon, 29 Jan 2024 10:20:02 -0800 (PST)
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id bv123-20020a632e81000000b005c1ce3c960bsm6617750pgb.50.2024.01.29.10.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:20:02 -0800 (PST)
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
Subject: [PATCH 3/5] nvme: Change 'bool shutdown' into an enum shutdown_type for nvme_dev_disable().
Date: Mon, 29 Jan 2024 10:19:51 -0800
Message-Id: <20240129181953.1183084-4-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129181953.1183084-1-jallison@ciq.com>
References: <20240129181953.1183084-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_102004_194842_38DA64D9 
X-CRM114-Status: GOOD (  14.37  )
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

Convert nvme_dev_disable() and nvme_disable_prepare_reset()
inside drivers/nvme/host/pci.c to use this:

bool shutdown = false == NVME_PCI_DISABLE_RESET
bool shutdown = true == (NVME_PCI_DISABLE_SHUTDOWN_SYNC ||
			 NVME_PCI_DISABLE_SHUTDOWN_TWOPASS)

The third state NVME_PCI_DISABLE_SHUTDOWN_TWOPASS
will be used later to implement two-pass PCI nvme
shutdown.

Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/nvme/host/pci.c | 47 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 25eb72779541..8ee77f755d9d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -108,7 +108,14 @@ MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+enum shutdown_type {
+	NVME_PCI_DISABLE_RESET = 0,
+	NVME_PCI_DISABLE_SHUTDOWN = 1,
+	NVME_PCI_DISABLE_SHUTDOWN_TWOPASS = 2
+};
+
+static void nvme_dev_disable(struct nvme_dev *dev,
+		enum shutdown_type shutdown_type);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
 
@@ -1331,7 +1338,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 			 "I/O tag %d (%04x) QID %d timeout, disable controller\n",
 			 req->tag, nvme_cid(req), nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, NVME_PCI_DISABLE_SHUTDOWN);
 		return BLK_EH_DONE;
 	case NVME_CTRL_RESETTING:
 		return BLK_EH_RESET_TIMER;
@@ -1393,7 +1400,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
 		return BLK_EH_DONE;
 
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, NVME_PCI_DISABLE_RESET);
 	if (nvme_try_sched_reset(&dev->ctrl))
 		nvme_unquiesce_io_queues(&dev->ctrl);
 	return BLK_EH_DONE;
@@ -2574,11 +2581,14 @@ static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev)
 	return (csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY);
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_dev_disable(struct nvme_dev *dev,
+		enum shutdown_type shutdown_type)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(&dev->ctrl);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	bool dead;
+	bool shutdown = (shutdown_type == NVME_PCI_DISABLE_SHUTDOWN ||
+			 shutdown_type == NVME_PCI_DISABLE_SHUTDOWN_TWOPASS);
 
 	mutex_lock(&dev->shutdown_lock);
 	dead = nvme_pci_ctrl_is_dead(dev);
@@ -2623,11 +2633,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
+static int nvme_disable_prepare_reset(struct nvme_dev *dev,
+		enum shutdown_type shutdown_type)
 {
 	if (!nvme_wait_reset(&dev->ctrl))
 		return -EBUSY;
-	nvme_dev_disable(dev, shutdown);
+	nvme_dev_disable(dev, shutdown_type);
 	return 0;
 }
 
@@ -2705,7 +2716,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * moving on.
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, NVME_PCI_DISABLE_RESET);
 	nvme_sync_queues(&dev->ctrl);
 
 	mutex_lock(&dev->shutdown_lock);
@@ -2783,7 +2794,7 @@ static void nvme_reset_work(struct work_struct *work)
 	dev_warn(dev->ctrl.device, "Disabling device after reset failure: %d\n",
 		 result);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, NVME_PCI_DISABLE_SHUTDOWN);
 	nvme_sync_queues(&dev->ctrl);
 	nvme_mark_namespaces_dead(&dev->ctrl);
 	nvme_unquiesce_io_queues(&dev->ctrl);
@@ -3075,7 +3086,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 out_disable:
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, NVME_PCI_DISABLE_SHUTDOWN);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
@@ -3101,7 +3112,7 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
 	 * state as pci_dev device lock is held, making it impossible to race
 	 * with ->remove().
 	 */
-	nvme_disable_prepare_reset(dev, false);
+	nvme_disable_prepare_reset(dev, NVME_PCI_DISABLE_RESET);
 	nvme_sync_queues(&dev->ctrl);
 }
 
@@ -3117,7 +3128,7 @@ static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_disable_prepare_reset(dev, true);
+	nvme_disable_prepare_reset(dev, NVME_PCI_DISABLE_SHUTDOWN);
 }
 
 /*
@@ -3134,13 +3145,13 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, NVME_PCI_DISABLE_SHUTDOWN);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, NVME_PCI_DISABLE_SHUTDOWN);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
@@ -3203,7 +3214,7 @@ static int nvme_suspend(struct device *dev)
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
-		return nvme_disable_prepare_reset(ndev, true);
+		return nvme_disable_prepare_reset(ndev, NVME_PCI_DISABLE_SHUTDOWN);
 
 	nvme_start_freeze(ctrl);
 	nvme_wait_freeze(ctrl);
@@ -3246,7 +3257,7 @@ static int nvme_suspend(struct device *dev)
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be rediscovered then.
 		 */
-		ret = nvme_disable_prepare_reset(ndev, true);
+		ret = nvme_disable_prepare_reset(ndev, NVME_PCI_DISABLE_SHUTDOWN);
 		ctrl->npss = 0;
 	}
 unfreeze:
@@ -3258,7 +3269,7 @@ static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 
-	return nvme_disable_prepare_reset(ndev, true);
+	return nvme_disable_prepare_reset(ndev, NVME_PCI_DISABLE_SHUTDOWN);
 }
 
 static int nvme_simple_resume(struct device *dev)
@@ -3296,10 +3307,10 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
 		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
-			nvme_dev_disable(dev, true);
+			nvme_dev_disable(dev, NVME_PCI_DISABLE_SHUTDOWN);
 			return PCI_ERS_RESULT_DISCONNECT;
 		}
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, NVME_PCI_DISABLE_RESET);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
-- 
2.39.3


