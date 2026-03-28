Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8C510F3DC0
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/nDAL62O5QKen/7e1sgimEPwC/7mFESAeMSDPIbvcrU=; b=hoLYDQa7grHMY2SNPvPs1gwBim
	YrUZYpULaOom2e8RaxXV41wvNs3qMJY0Yf1WZhJU//SZ9kPNfiG8dVHQuEZQPog5qi+Pqikro+CnW
	2E9UGRMuDW008CDN7dDcEfqFy3dDHBeUAz9Z0jUoF5Kwobwm74O7UKn/EjFfKlTYWEd88W2oz+QGl
	goJlqNdmJfK6fvXDqd01eZiZsoey8Uw51XnoGf8zfpt4zc04inIpFQ5ZVzvbgIk/HjvGo5gEIsaic
	hKSLM9PnhFVg/M+2bugN/XCYkXBEooysC6f2c6A0XKX1f55whlbWn3PBwiVSeZhHi+uRRi3JwWN2d
	M2tssXFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoU-00000008NzM-0vM1;
	Sat, 28 Mar 2026 00:46:06 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoR-00000008NwO-3r9x
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:05 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c741db5d610so1307637a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658763; x=1775263563; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nDAL62O5QKen/7e1sgimEPwC/7mFESAeMSDPIbvcrU=;
        b=DEnAm02yM3E8SufEfhH817ksbCViCEZYJi3bRtoLT2vEm2lND3z031mKX9joUinTC4
         +6BmsiI/fKuvS+syRLqlCyZGm1lOyy8i/v4FSy/g3HYOM1gENlHvEt2Cmfscd9WENKKL
         tz/JuHEFTE3gcELmfpZJKjez3VSeZZeVQ5Yf3cB4uhhX5rOGGmnl3HJ/a37v/LAYeJGk
         y5vuhWSwmQ+zrqHs0J5ZZqUZJzZJYYEnYLxnZpGLL+mbwpP1U+KEoY96PidhHSshhD4j
         kbJJHI2YguzOouvyVIbP4nHi4JYn0zrsjm525YDKLMJkEHFdmdmGj8ZkRO+o1590V+Yg
         P8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658763; x=1775263563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nDAL62O5QKen/7e1sgimEPwC/7mFESAeMSDPIbvcrU=;
        b=lSwWqqCU4H8AQKJY3ZnU4fb1PcR/Ar0PgkXH+MkTaZ/DfHNwr8zMJRYPBn34BeKhjB
         5hsnq4lyA33chvKoW/VktHnwt+3IfPzXGwS9bsPNhNnM0cJD3JyKkyFmnb9pHYFAGCAn
         5HfFp3AW6ePSG7GB3dyzKXF9GLexRDPv15HRonFzeeKohhFbyWsu0PQGN+bHDMHFcexK
         gJsP80w5Wc8bBCDwfMaZTEKRjqYD9HhjNnHOjMRGrzZso0N6X+az5fZZWzTTVioi4WA9
         0zDcmRx1L4cyS7wsAmg+xC0OhM75q5CiRJyyhDOmH9oZuftwYyNQ+buZL7ghVkzeXMyN
         7gbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbSXy+i6WXvghHJfscnLcv/ExYOnY9i2FWaFaKhRFMKVCtlF52IskhVShvzn89VCGQZVYk7KM1lIzk@lists.infradead.org
X-Gm-Message-State: AOJu0Yxd10ELoH7cR4VC/+t9NiIc14YQEXXXdmHV7l1ya6C413cVC1wH
	/tl48Nuvxv3FloV3raYLWaTIuaNOlSdG8e7+calirg0o6OzB2ifzFyNlZJXeGM9fw+Q=
X-Gm-Gg: ATEYQzxXBOx1OYhUQHMRmOK3za4jwhKWj6NVgLohfOClVKoQnQO9WDTosnfEmXH/IVs
	ttJr0c89IllNLPly3WWkeWOCEdAlN7i1EPaYjfMBykbwVKl0d/XQxU5K3wI+tolJVc8EGEnoxJg
	VwbZjwU0n8kmU9HebAXLFh8Ahvmm8YhGdGKGewtwcJI1iaZH+cyKwUEQDfXeXkIkZukoItHe3jL
	FEp6erBHrP+VsrtUynBkhHKFXVcZp3/Zj1F20RrEECeswYS/+70Pj+VbrIWgaAP7pmdac4EU9G7
	ukvZFAMl4rbsG0520Z3sjCW/6vm1Ag+5ATgkomNdbuxGC6L9c0KBDuA/Nfdsr/UobzRPkh8B8Aj
	X0XzKD8uWGKjxyzzTdW+l2RR9ewe+5SPz7xGnJndfG0RzpWbSsdV75yA/ukzca7xzkqiUl8atSh
	affR1murE=
X-Received: by 2002:a17:903:1a2f:b0:2b0:6a3d:36e9 with SMTP id d9443c01a7336-2b0cdcb73d7mr45524475ad.33.1774658762760;
        Fri, 27 Mar 2026 17:46:02 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:46:02 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v4 09/15] nvme: Implement cross-controller reset completion
Date: Fri, 27 Mar 2026 17:43:40 -0700
Message-ID: <20260328004518.1729186-10-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174603_962247_01E54DA0 
X-CRM114-Status: GOOD (  16.81  )
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
index 5603ae36444f..793f203bfc38 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1920,7 +1920,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
-	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
+	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -4873,6 +4874,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
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
@@ -4949,6 +4991,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_DISC_CHANGED:
 		ctrl->aen_result = result;
 		break;
+	case NVME_AER_NOTICE_CCR_COMPLETED:
+		queue_work(nvme_wq, &ctrl->ccr_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -5144,6 +5189,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	cancel_work_sync(&ctrl->ccr_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
 }
@@ -5267,6 +5313,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	ctrl->numa_node = NUMA_NO_NODE;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
+	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f2bcff9ccd25..776ee8aa5a93 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -419,6 +419,7 @@ struct nvme_ctrl {
 	struct nvme_effects_log *effects;
 	struct xarray cels;
 	struct work_struct scan_work;
+	struct work_struct ccr_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
-- 
2.52.0


