Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47EFC982E0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oy2h80BFMwGiM7nqEwALNuYmImDNZDmz38YPaRdaUi0=; b=Y36h//JS189VcEBS37P8mHxLqm
	L1kgXRQ4hsv4bPbVhC6r7NV1VfUzXZ/ezHuI9MYfqovkXq58BwMAiX10L+h4zzFpxvGcE9Nda22/M
	aDP7MQ60y/jYYe6kLDPqgHbzqREMDoamjnsyrJajHnfFxUqJc7Mv7yUSKofmp2NyOrWHsusR0xx3x
	CA2QGUEupMGWNcsmpvmVMo9cPVYoVFmew11aPyaZI824TosK43QY4Er8WWDW1qN2WNFCjMnGrFZou
	cQaaNLhyJ2j/wowpNCG7D6T+LThAKyeZPXi6jREFsFb7qV9A3IiEjag1zBAK3EfhYhfc8Ojnm5Lam
	o/Acw2KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d97-0000000FH9L-1XB9;
	Fri, 18 Sep 2026 18:17:13 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d94-0000000FH4o-1xUg
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:11 +0000
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso1026472a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755430; x=1790360230; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oy2h80BFMwGiM7nqEwALNuYmImDNZDmz38YPaRdaUi0=;
        b=IC2Zbn3tbuC9fL7xLIMXMRFb9qgZU+y5SpAKID90llkZyToBGGM8RjvuXiC32kTo2Z
         E8qx9F7Dqs8sDOsJd9wC0Md4MMyjJkrX9kj/1Ca+0C6qd8zps2lgMGZVA0ZgMUCbFLNV
         +ni9OR9VyUDNluYbRZSrFUUjWLNrACeFbx5pP4ATzvo5ocj9kVvPhnFPEC+JS0umohYv
         98qGfU+TTNq5vkE/037bV8BdaVWENWPNPdJrtpTCalJ1uY0pHJJ9RNwUkMPYuHaujjKr
         CuZyA4DsoTa5j9TVvwJaSzse2Z02Lg0iO6WbxwYnVFQadQlMJW0w8yOHtqoj8a9PUg0o
         qvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755430; x=1790360230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oy2h80BFMwGiM7nqEwALNuYmImDNZDmz38YPaRdaUi0=;
        b=S08WE/aNraQ7dlpW0SzuE8Mr/yW+fL3b42/3rBDznYAEc5U0TdrNgXLm8wHUxvtd3G
         1dtIiN6P56xpFG6covRAD+TRUR54F52QB+P/YDC90wl7ZoeLoWhVG3k1EMpU1GYauQmS
         3iAdneIe/sgoanXCYOeGTNnh8CFBpRD9mRZV00JAO7h3QtpMTwKno1w1lJQJuiyJkBhC
         burNJg91hBhwzhQg2D5KEOTK/s9djhsq4WNfFyb4IHu+aWmdaRKnnHZ187P1nmjN40/V
         iBleqbzWAc7shm6gBkxVP7Wlen48250d4zr9FnFcM7Ic2SJ7sO4I77G5Zy0aWuzcfR4q
         r3VQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHiuvVoaVLY7Iw+GxiMA6/EvUB2Zrj6lHEw5heDgWw1/kfucw8b8s6wcKcEJUuN8AQR7qc44SbTx8F@lists.infradead.org
X-Gm-Message-State: AFuF++kY0zfcnW90YejzC3Zccx2Ltd/xomCIUcBIb9jgH5oAqCAmYdmc
	Uw+dyGbaxrO0NJctyPGOGKSE7FUVPHjrWYjW4bT7G2H4l3HYwB6+etDx4o4cWRhG9K8=
X-Gm-Gg: AYBFou1527lfhJIgSphB+dRCy5/zG8K6fyuZoBeeHgGLS1KKcrBFK3ZVufMO8hCAvLv
	rDc5PpA1s00wJJRJgdR6MxqvXC3IhpO6rd3a9T0Z6xaChFbgqrRQSV0fM4AXhqey43LFFHUL6gC
	pH09FfhiTlvUZ4lnTGhD18VBZNSmGE0GBDU86NR3ihG3oOToNGWT57PoQp/t08D6/VTpue6Cgut
	a4vdKSE7FYfIBuumIt12qlTzeIcuv3r9VPqbggmIYJVX3k0ea3GsosxqBaUFSyfnFQ56pKiIleG
	c7ko3efxi+cNK30ZRnPwsGFunCCX0rjx81Qy+6zE98ezHU5g9h2QH2LB/0WFLcYjlUnypFq3E39
	zCJWHio9SfI+ruadoVpZ4qOpZwdgsvHXED22NH+9F0VH1sSu33ojJUvCwXiEVNHY7I+nowKGqr9
	V3/c9sKj0k42CMIRTz/ZYyBvR+oQSlbCpPvfmqQJAumooaTVL0roFTX/6q1bkLrvcZ//aHtsuVb
	Da3PoQhLnrmLlg5ImYhJA==
X-Received: by 2002:a17:90b:57e8:b0:39e:6c69:7774 with SMTP id 98e67ed59e1d1-39e6c697961mr1142954a91.29.1789755429684;
        Fri, 18 Sep 2026 11:17:09 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:09 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] nvme: Implement cross-controller reset completion
Date: Fri, 18 Sep 2026 11:14:09 -0700
Message-ID: <20260918181614.3947933-10-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111710_548224_D3D0670A 
X-CRM114-Status: GOOD (  18.24  )
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
ctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup threads waiting
on CCR completion.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 50 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c8e3129d84a8..5509b58b51db 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1959,7 +1959,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
-	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
+	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -5023,6 +5024,48 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
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
@@ -5099,6 +5142,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_DISC_CHANGED:
 		ctrl->aen_result = result;
 		break;
+	case NVME_AER_NOTICE_CCR_COMPLETED:
+		queue_work(nvme_wq, &ctrl->ccr_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -5287,6 +5333,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	cancel_work_sync(&ctrl->ccr_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
 }
@@ -5412,6 +5459,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	ctrl->numa_node = NUMA_NO_NODE;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
+	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8da75a15ac04..7096f1e4f84e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -431,6 +431,7 @@ struct nvme_ctrl {
 	struct nvme_effects_log *effects;
 	struct xarray cels;
 	struct work_struct scan_work;
+	struct work_struct ccr_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
-- 
2.55.0


