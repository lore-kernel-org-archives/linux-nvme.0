Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E841E6BF3F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZjQY91Zj2Uen3s+F0p7lNd7qUdF+rUOyKxsGPKTZUoQ=; b=QXPFCMhWDw/4OE8p1sdtEWspTV
	DZ+T+ODZmthX/JzbYevBym9vcRh+7FJ1AWtGbcLGtJwwnDb+LcY28Ii2kg4pG8HY0Gbxi46jLFgnD
	O/EXrO4mVj7IMHx/mEib6nRlXZVz36gEr5rTOj1uh9VOdJo4tG1YLu6M/5mS7z+Qu1ZGVnGaWNCMX
	2GrkR4njR+XhHGTXl2waFiot33egpaPEn5qpEerhV1IZrSnmQ8RTxa/TMFGsBLfyxHCL5SteMCLto
	TRdUQH4fFNVRPK+5Ulk0/NvmO3UDC12HbuKR0yjxNtkrOOro4KBTrhxhOQWPPJpXrn+UZ7eS/oI9k
	Hcnov35w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6V-000000022wI-0VSI;
	Fri, 30 Jan 2026 22:36:39 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6P-000000022mS-0XDB
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:34 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-11f1fb91996so1773793c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812592; x=1770417392; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjQY91Zj2Uen3s+F0p7lNd7qUdF+rUOyKxsGPKTZUoQ=;
        b=UsX2Zhgd43SrK2K8xBMI7gqiWnA55keG+wnslXBSwJOhNQgtNxRdWC2K7ms7j04IrN
         eRu0WHJ5loffXcUWmICw+uXSyS7C1bh5yZz+h2MTlkg9DhyD6nK4sTxsBr1px9kSCW96
         tuHqkmEv6ww1lh/QkyLz7RkOVmbRRl0xsqU+uulkrixRV9cGMleHLJ9R5ClHk8oK+2Oz
         T+1aDD5r9/WP+T7VEONKpcU6fka0onV99YO++3W4kjJXoORBcBNEb/wo33NSAY3I7WBc
         rL0j9UzW0wbmkzeikdWB6gPL0mnbmC/FE7W6E7kgTXZ8cKwlRTL2TUmThVC+yeBZ936b
         dRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812592; x=1770417392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZjQY91Zj2Uen3s+F0p7lNd7qUdF+rUOyKxsGPKTZUoQ=;
        b=WFD8wixOeCK+tmVA5XvmUPc3/pq+kLVZEqWSDGoVzmjoCsdRrIoqnygrtG9ec6sXCx
         k6gWCvP5dWyBEEcgqxgSZ+GrAETUlncIcaBzv1vonbHzzJJ1SqXXTRIFuFCyItBzvXRb
         tKbrP43+izA6KrnnAFR0Ocq1gGCpOh3tlQpqaXzXqRRQ3bDCuQjj+dmFWqeVz695grmf
         Jv9eTJrVKEyzDPZ41d9bp5ZfG5ztVZNo6tYNIlXbfLzc1znxRwCKmDebSYj2P6+xVwme
         HTWXdNheQ5NBATXWHGPnwOP60crUfmagSJhRoCAYSXK3cEHF2DSuKFzG7nlla0s33Chv
         XH/w==
X-Forwarded-Encrypted: i=1; AJvYcCXE6A8z1NeEbw6bCXJPLCARrH67WN7ttYbJrKrZgSwOAk2O+6VipdFgfsdgllBjbsmQZ5BEYyEkiSl1@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7NxiHwDg2DGULB2YPyxzdf9iOMewKK8lxf+p3hR7Zy6jF3TGo
	unetZ36DiX1XfT/Zu8KMJ0+xT+MNuY2P2yualt5j/pZGGS5EcwLHwmKU8BLci/GwpIk=
X-Gm-Gg: AZuq6aJ4HZ5kSUvLVVDpOEKLhLrAS6Zlqfe8vwk/FL42exUSBDJjNUZ+/hEDohW+jXG
	Eq6CHVCIxmEE5ZXHUxdoBDa7LmPHN1VtkudbZn9zpum+OXw7IuDKJm+iIk2S0m4eTIyd8K0WzAe
	096o9vaaKB7EJQ5MgLS6G2orqTUBqR4BXQTY4yvRPUDsAX540R7sNyaarS71psCBerdBPBMGqEe
	dZWAmxugEzicCwl4RjmTncihfdm4pzbeMAX5Y+cYBd7jFEuB9mNbdBuCU6v9YbNpEw/RzT0h5Zv
	9RpffAqO5RlpU3CtMYryX2KfcBUxRZ9pwoQBEiSCcSsQGyl18KNIu5w73ddgKgf48Yusu+KiBLK
	hYSVzqJC4oRA3JYTlFll/8H3laC806DH++pW2k7TpCR1kI8G74LiBXFgARyLNV/hEyScw1WcINt
	tW1Iu02YHveJtzDXWLO2RWvQV5ttuTpmpZjw==
X-Received: by 2002:a05:7022:e02:b0:11b:9386:a3be with SMTP id a92af1059eb24-125c103f66dmr2278348c88.41.1769812592008;
        Fri, 30 Jan 2026 14:36:32 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:31 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 09/14] nvme: Implement cross-controller reset completion
Date: Fri, 30 Jan 2026 14:34:13 -0800
Message-ID: <20260130223531.2478849-10-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143633_172207_DCC2FEDC 
X-CRM114-Status: GOOD (  17.38  )
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

An nvme source controller that issues CCR command expects to receive an
NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
sctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup any thread
waiting on CCR completion.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 13e0775d56b4..0f90feb46369 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1901,7 +1901,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
-	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
+	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -4866,6 +4867,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 	kfree(log);
 }
 
+static void nvme_ccr_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
+	struct nvme_ccr_entry *ccr;
+	struct nvme_ccr_log_entry *entry;
+	struct nvme_ccr_log *log;
+	unsigned long flags;
+	int ret, i;
+
+	log = kmalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return;
+
+	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
+			   0x00, log, sizeof(*log), 0);
+	if (ret)
+		goto out;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	for (i = 0; i < le16_to_cpu(log->ne); i++) {
+		entry = &log->entries[i];
+		if (entry->ccrs == NVME_CCR_STATUS_IN_PROGRESS)
+			continue;
+
+		list_for_each_entry(ccr, &ctrl->ccr_list, list) {
+			struct nvme_ctrl *ictrl = ccr->ictrl;
+
+			if (ictrl->cntlid != le16_to_cpu(entry->icid) ||
+			    ictrl->ciu != entry->ciu)
+				continue;
+
+			/* Complete matching entry */
+			ccr->ccrs = entry->ccrs;
+			complete(&ccr->complete);
+		}
+	}
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+out:
+	kfree(log);
+}
+
 static void nvme_fw_act_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work,
@@ -4942,6 +4984,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_DISC_CHANGED:
 		ctrl->aen_result = result;
 		break;
+	case NVME_AER_NOTICE_CCR_COMPLETED:
+		queue_work(nvme_wq, &ctrl->ccr_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -5131,6 +5176,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	cancel_work_sync(&ctrl->ccr_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
 }
@@ -5254,6 +5300,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	ctrl->numa_node = NUMA_NO_NODE;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
+	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fa18f580d76a..a7f382e35821 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -366,6 +366,7 @@ struct nvme_ctrl {
 	struct nvme_effects_log *effects;
 	struct xarray cels;
 	struct work_struct scan_work;
+	struct work_struct ccr_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
-- 
2.52.0


