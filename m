Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD1BC982D8
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oy2h80BFMwGiM7nqEwALNuYmImDNZDmz38YPaRdaUi0=; b=cZtODHmQFivkWJxLA/+I232pW3
	24vwf3DyF7fAYEjxMou1VAi0Q2iMDkA3NWohlOp6REgjZbtojbfrM+VKxeuIUFwIjaGvkPyc88DPL
	dpW1IjuS0stwRgsNtoAItIMW/S4FIFRMM6/jQ4Cm1jFcttvxEiZR4p5vS/D63v7iiFg1KELhPITdh
	XDmzGd8JqFHbdGsVb6QBGgCGoP0NyhN+mR0PHRz2QaVDNLj3iQNFSo9N9WXKyVHUbpI+LfWA+eC4E
	tnTyD3+jQtGBdVUMR2Vz3TmWAnlxMiE3+5qbbAGEiV7BwHxUvy06CqEBoupsAscEtnjxi/kzmW0hN
	UAUpNRew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ7-00000000DuR-3XMo;
	Sun, 20 Sep 2026 18:30:33 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ3-00000000Dq0-2sHp
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:30 +0000
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so1943482a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929029; x=1790533829; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oy2h80BFMwGiM7nqEwALNuYmImDNZDmz38YPaRdaUi0=;
        b=SJrbdhGJc8HzjbL8gbFeLlvAXV1mSxVIDdEiV4OqMNPB98M/1sIbzM+UFdVu5MwNEW
         RribetGZjvNy9Uq0ksXLid/84tDuQKTOW3/+YUE7lXMmmgHHfmt+rvdddYA8j1UJHcKc
         bcvUGBRKbYo91WZ9+YtlX0N9mNZ5HfKppmuqT0rrYllcQ+Ix2pjd5RRpgEh3oR09/Qvz
         /PrueX6NfD0hYAhPqlnghVOtl8wXJJWVoZL/A00tLcx1UvEw5T3VD9JXc1mDNvW9+xf/
         Sb8glNothk4asvb/pCpGKahYbt1Zqq8PdETZiaq6N6eQAu/Ue+laecw4HDJ+rHDcTmyZ
         SnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929029; x=1790533829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oy2h80BFMwGiM7nqEwALNuYmImDNZDmz38YPaRdaUi0=;
        b=PRKPsBceVGnJZDbFaSe+RbgriwzjvJHLTCEz1tg0eWPID3nKa3smFkhnPZKgve736h
         ug0HNxcBw7dpEAGDtfpbsbKr28hjSZv0Zx11JPoh8FKBv0uz4oY8CWzO9yLuKvybdfAX
         /MkeZA6Uf/feaoWeEsQ4YxRlptRyLZ30lD4TWtxxNHDU3sMi+BisnYHCwKt6E/cwpsqm
         GWq/Q3TsQtm1pP9YOiYCGDr+zPxkqrAtEn/Pt3DkezCFibGr8UU2mlbUP6lzlf10YEyj
         51QMZRlVEsC3BVz6UeTisZCH/NdYzZoCLv5bfCk+FTppWgphgorVJa+e0E8Yj8KjToc8
         i2IQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbjgFCoj+TyMuF26bkF0BqHMg9+DHE1DPdLAiedWQvMbd/L15+FoCyzAmJJvBs0GFk3i/+0Spav/R+@lists.infradead.org
X-Gm-Message-State: AFuF++nQfA4i+bRGjYY2AkXJDpGRYZQBXhNznRoSDbHQ8Jepnsl72a9X
	3bqWZUQbv/yqDRV+3Bs0ERzKZU1lD/pbB5fTwyMg3WkkrTKlAYv9d8aQvs7lIBXWPKY=
X-Gm-Gg: AYBFou0PwE2UJTuG4yTYP9T3MUhWJjUf0Gx/CblNvwk5nX56LCz3XuQijDN9DOgZSDB
	ZuR4ZCzVut5pw5bpOcLUrZia+E1V49xmTiyDofMG/s7OcUCAfxuVnEhcqOrO0+dWb2NdIraMbrA
	5qsCAOd/w8qAJ5BJFG3A/NTjk6nGNX0H8Vl5nBWExJ47sbeZysx5PwmQP59zoaXbY3L773tORJL
	+YI47rglmsGNfn84wqswjo+UVZ/6/7OVRxn8qpo4BU4U+e3aC4wVsnyF5ED7XVkEV8/WVJRAn1o
	udvXwu81GIO6IgUmy+Fe8jYF7rOyLlEdDgNgYiJ8GkSv/O2E7tHNT4ZDv5FOJmbVXUuwsC2Hu+t
	bYWAM6g8Z0k+Pou2KEc2yWKSceKGHHI+e+R4c9z40klkg7tf1EYCmoUCWFDtLU1LYSEDv5Ll4OL
	YEyAVI/P42ON4YkyOfu5I1+hCQkOp9usNisN3p1SOqHPf+hwGngbxY0wzb
X-Received: by 2002:a17:90b:57e8:b0:39e:4c7f:8b19 with SMTP id 98e67ed59e1d1-39e54d458b7mr14289543a91.30.1789929028929;
        Sun, 20 Sep 2026 11:30:28 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:28 -0700 (PDT)
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
Subject: [PATCH v6 09/18] nvme: Implement cross-controller reset completion
Date: Sun, 20 Sep 2026 11:28:07 -0700
Message-ID: <20260920182936.2317916-10-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113029_740221_2E12D3BD 
X-CRM114-Status: GOOD (  18.52  )
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


