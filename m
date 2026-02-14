Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D37EDF15A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edwDbFdh37sKWpDzCd1wbhpALgQ620l1aL8E/Iy7bHY=; b=E1g3pLkFZC17a6KprgjbS9yecO
	nc9Mm8fYrpFob4Ys20wYYI5ipTEZlYfK8esNpqJ5lKNqPGCn8GV0StHF8aIJ479ueYVb5v30gHpOs
	FOqMLuGFw4n2HCdnMudibdzDOCX6zyOfOUrR5GKMjfo7jpXOlMYdXnJaWBt8+I7iPjazBcrGlKgUc
	DpFixtLXyL5Igy1TrgzTIxtr5QZWIVg+w53F1/cnyLHHDhrFZjVTBwe+u21XXO/57DkEUjfZefZAq
	E0s6MtVZ93YMYKtkLfYx8NXY3jrzewhipE6cAiaduTAj3Gi0VYTsW1WjNuAD3RH5RaNAQBCiuVklx
	KC/XEbLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gk-00000004F85-10mY;
	Sat, 14 Feb 2026 04:28:34 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gf-00000004F0G-3D09
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:31 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-12721cd256bso2118813c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043309; x=1771648109; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edwDbFdh37sKWpDzCd1wbhpALgQ620l1aL8E/Iy7bHY=;
        b=aFEfexlD7eCbmQdh6eDY3bAaRzzy4gpfQVEw7Ysu+bNtNAss5KqNCYZBX0E62k82J7
         ubVO60jo/qoqwazeQyaEO/sNxLWOjfVhLtntlXsMaWPevBQC2JxtAFx9bfGgz3Jkvi8e
         GwZphX+QBf+t1s1jsdI6W+i3DtwjjvQcFwGMk3szgHl4WyCDnqNDyt17hQiL3vzvpbv6
         ByPWyYyYwoDQNm+NzfD9/E0fQBBsnFaBiNy0msTDHMNMt1LHHZwT1ZIQwWeAtSpx89oS
         fvadbcijd+/6IzCxqIcothh5aOZ+tRcXprMygmdafAVp9AjVvrB2FMjBhdONEwHtmWAe
         IfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043309; x=1771648109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edwDbFdh37sKWpDzCd1wbhpALgQ620l1aL8E/Iy7bHY=;
        b=fvqSpgBq9t1qw1F+9C1gcBOZjqBcP18QyOTxNU/rFdCasLAHbaY54AjCjD4nVdt7AK
         uT8TrLTcyqDpVQNuFfkQUX6eN1giPFSjzW/TxjJIQkFlgbedoYHOkV1Kq2Xq7QUmwxZM
         Soqnj4VMj3Al7isBvmjINYdjFDjzNhbZ3PDSyNW4ukXxXnMDsBl/Klm4A/OnWrmQlap0
         uzOmunZTbfG+Jb11iD1N3XUGvzm599cEoTZEJoGq1IyNWie830EKuEMKJCN1mWOJDEgo
         +j2vKk6vRFUNNSbRB7sktKr3nd8aUiuu0QNYmipYG+Kofbq/uxS0ibUXMvcgCnjZtj/o
         WgBw==
X-Forwarded-Encrypted: i=1; AJvYcCXhO7kTGdWw/pRobT84KfoW9Big9iOzbaR7MnV/Aoxwxs6ujL8WCHTwQYcs56ZgmOI065u9QXE9YpJr@lists.infradead.org
X-Gm-Message-State: AOJu0YynUfLCrTE1czIad3fE2DZLMwHMa03aMZ7TFG0dvXaudfqrrBZq
	fQJIrg/nB+3CZlr2Xj+0TUZHlVkZo7IfhfpRza3PiCuCc5Hyd1jvpkSWQ8m1BgRQVXk=
X-Gm-Gg: AZuq6aKGn/CPGt0WZkCpzTGqpLygJjZrjiLTsIa6wFZI6YFqp65Z4jbgcxUzWsOb5lJ
	x25EplmFvXLT8fsHd56smG+ptcRg/hOQ3LyUHQ7GG6Lg9Cy9Gse53MLNfb8kI5rQYryPMhyhtg2
	tl6zn3gnZKaiS0mrRz4YnqQfmM+yMeURNFAXQB9vdesC9sd+MWKDdXgA+GRe680kHZgz27Y/SMI
	xwFMD10+r7xM2EqqiZ+v/+pgQjrUVG8iwttD4izLFDuRgW9d0Q3WAyGAEaKtLRvmREzpaKlWM9y
	hDQRsiJU9y3TIyZffO4OdLK4knDwNMZ1fPsIWzc3o6mobPokG5Qf87yVqAopBB12HpYi7tYdKPL
	7aOqLI5s97LYJAGTukwUfZYMWnCS7ArHsSgKeVYDUEm1MUivRaR3sDlgrDYLF+J4A3tTAQdYOce
	fCk94o7nTjLHQH0/avuB1Qu4mIva8TG3tUyxrs2BdsuIRbSQ==
X-Received: by 2002:a05:7022:249d:b0:123:2d38:928e with SMTP id a92af1059eb24-12741bd5d74mr633497c88.35.1771043308556;
        Fri, 13 Feb 2026 20:28:28 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:28 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v3 09/21] nvme: Implement cross-controller reset completion
Date: Fri, 13 Feb 2026 20:25:10 -0800
Message-ID: <20260214042753.4073668-10-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202829_821125_F2E8F2E3 
X-CRM114-Status: GOOD (  17.00  )
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
index 765b1524b3ed..a9fcde1b411b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1916,7 +1916,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
-	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
+	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -4880,6 +4881,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
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
@@ -4956,6 +4998,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_DISC_CHANGED:
 		ctrl->aen_result = result;
 		break;
+	case NVME_AER_NOTICE_CCR_COMPLETED:
+		queue_work(nvme_wq, &ctrl->ccr_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -5145,6 +5190,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	cancel_work_sync(&ctrl->ccr_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
 }
@@ -5268,6 +5314,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	ctrl->numa_node = NUMA_NO_NODE;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
+	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3ab9411cac5..af6a4e83053e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -365,6 +365,7 @@ struct nvme_ctrl {
 	struct nvme_effects_log *effects;
 	struct xarray cels;
 	struct work_struct scan_work;
+	struct work_struct ccr_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
-- 
2.52.0


