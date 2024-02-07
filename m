Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5927DC4829A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LO+5fxbwSbjOoIxZwT+ozMmknoHyQ55yqFrve9wKRQU=; b=umQkoTUtduspphNVnfXD2tVMGN
	5gMaIeHMFyRKPWMyvVrDPkP69QP1kwW7NHeciFvJ3A51HDfVUrFpG1MrmrRFEFmQ1cRn0HMULdq8x
	eNm0wL3V/YeuFj5Od0oH7zVDcUfGLNBOtN4m1oly3Y8+z1/E9FzSqsiCr/T3ozAWOYY5FghAHEVX2
	NthNCON+xvsoqhIHWiBkn8TgKC2c2f0aBJZ5NC/QqbYYMmX8Ij5UDBMHJxxp5/NBvO7wwbkaGpK3f
	Y7np9ULa+2Rudq16gK3iP/9oKkSWrSD+Bm7M0y3oDhgfHmFPOB2Bqdb8IP9Su/uJDnP4jxXO6Hr87
	Ire29nig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf8-0000000Bx93-3ljc;
	Wed, 07 Feb 2024 21:40:58 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf4-0000000Bx51-17Eh
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:40:55 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d7858a469aso9544195ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 07 Feb 2024 13:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1707342052; x=1707946852; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO+5fxbwSbjOoIxZwT+ozMmknoHyQ55yqFrve9wKRQU=;
        b=Rc1YSi2To8Oo5vipz4G4kCGKEjnTC82pXXm2AGLVHYQhCuf2xR7zw/SkV6GhetW+FB
         W7SAWAW54OaoX/66io28djf95p/qO5BgRkmjRjM8U5O9lrcaflL5LrL+1rHYQj4aK86+
         x6C3j6zT1d30lysHfT39myUU4u4Adg0V6DstREgJLBhwsBSDV58M2/imxoOUUneJHnni
         sKJFmoiUNVUP714Xiwi77ghNv+5eWQFDIlYyPq/24XfJF60NHrJh4qn5wLV8b4ggXk0y
         vE4vSQc2ihjchyYtie83jHr2aFyVknegD2hBJkmXEV8pfbHZ3oNREvLRHfnc0ChcrE7P
         6Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342052; x=1707946852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO+5fxbwSbjOoIxZwT+ozMmknoHyQ55yqFrve9wKRQU=;
        b=LiolzF8P2ddXOvhG8lFQMgTdgXfCN2DRzBePaU/sWVzwjpHCJw4yPCu+tuWfJNfY3N
         n2Z8GjeiYqXGyyAcu5oaS/q9nAqMqEDEw6NVr7GWzlMPaw2JenKFTJSmvoXokeTls8tY
         C7WGipcffDXPOUJJJRZL4FolGku7D4jehUA+C32VIM8CdIOM39pBwBNCIz3+XrrDF0L+
         mUgGvFizT1MLVadjLz2b3Ob2gFZvGV4Cj1426MggXRZ8kFKNRkeSVkkrdScvCGolETkN
         xYkE56EvH1j03RA+HKTTlTIttgTxZZ6M/zNoCewHxb++KThS9yevm+PWkerdlEbQz1aj
         VGfg==
X-Gm-Message-State: AOJu0YyGqzBPRrvnIRRzPfYo6slD5+4WlLbi3DtNChXBuEd7ygH1wLXy
	ahp3NCpOATwsjWw0dr8AE6K5gp0rX7lM+dSRtpSnhkbQFBISUxUPSauQ5FCIt7g=
X-Google-Smtp-Source: AGHT+IFs7Xw4YqSllXza3LlmLwXs40aud1UwkAQaaEcaVOpus5DOkxGBaZT0Wy7UCxVA2RLQQxrrHQ==
X-Received: by 2002:a17:902:a516:b0:1d7:78df:b1d4 with SMTP id s22-20020a170902a51600b001d778dfb1d4mr5325904plq.39.1707342052538;
        Wed, 07 Feb 2024 13:40:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyO2j22l9pQgjmbyXykdbzRKE6mm+d1hplI6FEUbpN9z8mG3Jq7GFC6to6B5jc/sG8x2yxYBBQUo5sK6NuGTBsVZccAdcbnXXisL6E+3+N1WsmMj9paEmsAFvzVfi860FIVeOcxBr7wqfOxzDBx50GLp+hshLuofkNPZz+Z11WgMLeD2oMn8h9rKE9p8fggXm7d5bzdwKLVweQ769rTQDNObBhb3mM4Kqa7Ww5MX14oS+5KhrB1l5sI9Tn4/tA/ordYbU33/JNdSfB
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id ml7-20020a17090334c700b001d7274cbd33sm1939005plb.121.2024.02.07.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:40:52 -0800 (PST)
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
Subject: [PATCH 3/5] nvme: Change 'bool shutdown' to an enum shutdown_type in nvme_dev_disable()
Date: Wed,  7 Feb 2024 13:40:42 -0800
Message-Id: <20240207214044.2374295-4-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207214044.2374295-1-jallison@ciq.com>
References: <20240207214044.2374295-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_134054_338958_D204A0AA 
X-CRM114-Status: GOOD (  14.56  )
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
index e6267a6aa380..4dfc6258de07 100644
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


