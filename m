Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A2606D4FE
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vkK2Xfem;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=F5aHGmgG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wSUXvDC3JpdgMCqnkPNeUW4Ct+22Vkllsjv4sxasVtM=; b=vkK2XfemDXRUQM
	lghljnBKm+VNsgILTFn0z/4B2kEruQq3MaZ5++uzCcobWIG3z0HZQeDqFYSGzYxw1c11WcrSN17eK
	AlO2smUBBVb8zCCwuxngNQpLYgBySIt+jtzDUQsxcAY5Hu4EiJ2SGNg2E3c9XWzXFSMgxk1zCGgzU
	s/jW+b7zdf0WD4/ak0/kWV+8mUx7SGcjM3umKRBN+uz+FSaw0bdYXNL/kQkB0XPYjWRjItvi2GgtK
	LRte5jN9xGHwJ2SYaslzo6+41Ku6Jf37TdAG5wn1oSo0o/SxecL74jvfZfgujxX8jvD5i43NZ+BWK
	K0FC92e2YiS4+nEIFXzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45j-0000000FACL-09lM;
	Sat, 14 Nov 2026 03:06:11 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45X-0000000F9tR-3wBo
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:06:07 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-1b3ada81853so1560141c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625559; x=1795230359; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wSUXvDC3JpdgMCqnkPNeUW4Ct+22Vkllsjv4sxasVtM=;
        b=F5aHGmgGAhjoV9MsdthJOAFc9tKBTm1FbcnMxRRE07Bxh1T8tOWaQ4N/VwTcdxOzY0
         LPX7ZVvQUsSzrP/zPhYwXVsx+VEz3PFoTfXfmxprkcoPOqcIOtH/xG8qgPrOKweuwclG
         5WBtQDndSK5Fbu2E7EstrqmnR7qv2ghk0M7mWdJBElcV5Q5eoOkjqkIXfmSgbIVOss+L
         z8Vx52RP8yrmUJLyBVW4nDU8WZDp0HyDF+DCAm+d4/CiuICXZV7Da2gO4/jLfEWKx8ah
         8u0Ll1t35jBCQhUQ3DsTrcNGPwvI34BiB1nDMPoE5rrWcNy/ItMuv4HfLwzN5zJWKYsO
         VsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625559; x=1795230359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wSUXvDC3JpdgMCqnkPNeUW4Ct+22Vkllsjv4sxasVtM=;
        b=RUr+GpqlFb5JDlpqoXyefyjthbCsQjYkppfpx5jneZOMCAUNPQBn2oCr815RZgf2xN
         OetZhABj+3W4Wv0HcGf/uiOMNsm88Q/wqlH/NN172aVRSsCb9G/J7LICCIWz1UfWt3I7
         mbtDW8YfsgNfmM7s/gTpHgIb+Jx0DclALh100s+r/FWd0b0wf31V5ZTI/wdjLkseIcGF
         o/BkTsxu0f51jzHYZPsKpOAhQHZnvfrGrtWkM565zJ3lDYcqYl1LiWE/XteZH/rYRP1R
         50QyXR461lg+zEz8HdZydECV2iiBEpb5smCtjnykkIIZBfmhkeL/0/z9+ijrnE9nFKJ6
         P6bA==
X-Forwarded-Encrypted: i=1; AL+hErH5UtRsFMIMThTwt3J3dYA6JXepbkerZorYf/+uHT1U9e2f7ZQKWKdb4scsbumGNrrBxnsGQCdxWYJw@lists.infradead.org
X-Gm-Message-State: APuU4Z/sLZmdFYx2t/pKMZKcNKZzWJ6bTRN8t45SEYbJF3gx/S0JRcGR
	dijoOVj6baTk6QT7ylLboXiAZiSgr82e01A7kjmeNf8CqgZ0o1sSuYPxq8MRkUV38D0=
X-Gm-Gg: AYBFou2geDRB3dQf/1pCWoBVbOFwqKe31JgmUBQ6KtPjij7/gRcf+TdLlEjBN3+xDVM
	eWOVuMkzsztM7tB4McxHL7ioYNYjRmmDZDc5KCu5nTg4o8mj5araeKYse4E6j9hujd7Su5cjT7L
	a+v2VIkJJHuSYil05xZBpdovn8LCOeZzIRC5KMrn6AAxlyNIfyPnov7jA4T6yX2M8+0k/jjzZ7p
	3Ps5wJFOm/pvnrea2jbW0lgCRRFIHS9xNKjSlG8Xf1wHbddGpJUKUPVwKnuJbLSg8LOeIUYP1P9
	wC2own8Yldowr8wF8kdPziVV/qu9iJmGEWhc4C+IVWepaEOYeaVKiRNQwPARDGbNE/Ypn06YUQ8
	QGyvyNcrqXvB7ap4gVp65MDpHmiirptuLAetKjH2sKmzAmksVoHQ8s38nsR3E+VciEvJy+RKhI8
	6RcUgVrki+QGUdhiQS9O5U4+9pkpujCNiYQd8B8ESbKeXfYk5uKja5l5ARhE17jEQKuRUIgO1cd
	Itg+lPgZ7cIEY46waMJzYWMuse2u/eKk6MFuteKmeDuahp0Ws/dATjZ5PrmeMSjYZ/sQTE9eBKp
	Ci2xxQs9qv5c31TduBIe4uY+OAF/6LKZ2sLsseYXcryk6MI0vHyM
X-Received: by 2002:a05:7022:ea8a:b0:1b5:1a7a:2ebc with SMTP id a92af1059eb24-1b51a7a2ff9mr432861c88.16.1794625558632;
        Fri, 13 Nov 2026 19:05:58 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:58 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/17] nvme: Implement cross-controller reset completion
Date: Fri, 13 Nov 2026 19:04:23 -0800
Message-ID: <20261114030454.2836543-10-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190600_077100_DD897EA8 
X-CRM114-Status: GOOD (  17.45  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An nvme source controller that issues CCR command expects to receive an
NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
ctrl->ccr_work to read NVME_LOG_CCR logpage and wake up threads waiting
on CCR completion.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 51 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27c33dc49175..54b83092a9e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1961,7 +1961,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
-	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
+	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -5060,6 +5061,48 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 	kfree(log);
 }
 
+static void nvme_ccr_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
+	struct nvme_ccr_entry *ccr;
+	struct nvme_ccr_log_entry *entry;
+	struct nvme_ccr_log *log;
+	int num_entries, ret, i;
+	unsigned long flags;
+
+	log = kmalloc_obj(*log);
+	if (!log)
+		return;
+
+	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
+			   0x00, log, sizeof(*log), 0);
+	if (ret)
+		goto out;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	num_entries = min(le16_to_cpu(log->ne), NVMF_CCR_PER_PAGE);
+	for (i = 0; i < num_entries; i++) {
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
@@ -5136,6 +5179,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_DISC_CHANGED:
 		ctrl->aen_result = result;
 		break;
+	case NVME_AER_NOTICE_CCR_COMPLETED:
+		queue_work(nvme_wq, &ctrl->ccr_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -5324,6 +5370,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	cancel_work_sync(&ctrl->ccr_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
 }
@@ -5362,6 +5409,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	cancel_work_sync(&ctrl->ccr_work);
 	nvme_stop_keep_alive(ctrl);
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
@@ -5434,6 +5482,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	ctrl->numa_node = NUMA_NO_NODE;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
+	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 261955538efe..884541644240 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -438,6 +438,7 @@ struct nvme_ctrl {
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
 	struct work_struct scan_work;
+	struct work_struct ccr_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
-- 
2.56.0


