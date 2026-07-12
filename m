Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495FAC44506
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2svGMIPbamdfrr6utGGIH21OI5vt/Yz4GZPo9S8rv5I=; b=hfnCGyNxaquCSom+NazaG/ab3r
	usw8edbniPDy25DyCNRzCyGBDVNJHxA9Pq48OwOLuRFxqA1OJDuJf1EfLSKtZrh4RJfR6sq0ioBMe
	WH3luRTI6VfA1/mrXvXktq6J5glphtRjsg19dFKnB9eQxaobUeGCbOMJAL6YDMYeZpmeG5gtTxI/9
	k6HVlXuvG1j9Ds1H+5f2c5LOgpmckOk+J6zx/BCvsQsHQuCX3YkjgCpkrHPBWHS5Sw+RGHKsyq7xQ
	+ANajaGlsiR8zYDtrVCDr95g3hpB0puBIV/MrCQDmnB6CvprWJpYPwIEtq2b6pz/NmMDsAv4bAfTE
	PLQsbfdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijst-000000071ZY-3dVB;
	Sun, 12 Jul 2026 02:25:35 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsq-000000071VG-3gsR
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:34 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso1420992a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823132; x=1784427932; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2svGMIPbamdfrr6utGGIH21OI5vt/Yz4GZPo9S8rv5I=;
        b=Z2vsVEeAS1msdAWXgQ0Y2HkEWsH8Ei4vwyI6IvxC7EtGp/0kBrDClLjftzYTbKtflc
         f6mMBIfhXHOSATXIkmq20dsf7YVft41KVaUBoUS15VwNSg+FK6tD4GoFo89HDaaSJ8Gk
         XaSY0rhW4AIVJD3vp5flI+iSw/KTWZY6Knq7w50Axbji7kOs6VicmeR5/UdJ8tes/Pus
         lFiCBzETs0sGhPmv1iwMw6o2nHnwaqxAjyCW3q7aZiC3SopsAJLw2gJ4xnrfsbXY2Uro
         M7/NA6zVvhphQjLPYmywoG3AFx/sqAYb7HshyGyMqBwwRG8lwccmIerqV8N11zW9tXAD
         l2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823132; x=1784427932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2svGMIPbamdfrr6utGGIH21OI5vt/Yz4GZPo9S8rv5I=;
        b=IlzJhv2YZlgGfqTObLuIdg3LcXnovHwZ/SWUvD08ZVRwwgfCgg0PLYWoKmhRUadsdc
         c3grrfHctWu8CuCVtC58yvNK6xmcCd5aHw0KzEm6Th+kBwOlIhiorJn/QsM2GYG/IxlZ
         5uh5CKcFzcNmaW2aQFK8U1CvaqaLSDfdgE8a4k3P7bT9BM9kgTaSd2YzSOXGhggUdpyu
         XKe9dl2FEVET7qz0vw3BrSD3rEYk4USQoY0qVl9+9BlujXDCGLTYBt2d+00c9upndnqu
         cJwU+a3L8DC+yG0NHmLPgstv8Q51yz6hhYmvJ8XRjWtP2auLizgo01Oe5p9GoE2ChWXy
         pm8A==
X-Forwarded-Encrypted: i=1; AHgh+Rq+XTqNb94zz9R9Hf+6cz5lhPK8zEbAwaHxT8MHOXUTy3dNryN/FJjVNHzrQwE1//0o3plkjmtIM4lj@lists.infradead.org
X-Gm-Message-State: AOJu0YxuGTsNHZ/PGkewTcxI66WYi8MhPZzNIDOaKf0WoVnPNCsayJIq
	WPofLcwnHBuRh5CTILzm9Dbt4R7whtnuvRo5t+fHJYilIbcIonuxF/jFDnkCP6U0PtI=
X-Gm-Gg: AfdE7ckO1aSyn+CRX49KHJXEAzF0qNsB1cEmYv93WcQS/kQkkEa05FtCHuBVBvRAq2N
	M99RSPcAsGkOkDRXlEl4+LXsPwAPs3aHLYf74KcxoAa0CgutJ4I5kOyYO9i2lUrrmrfYZB5Aj98
	BhlxD4UYo22QxwBLWfrYkPhsIGDsIZSFny7XhFWQI9OQ564pCMBQ+D9tjK8Mxe9XeFg/eAC1mWA
	prEs6dVidoahqmoB3+7a6OJPx8LqYzuZ79P/MkS4OVe00A8dYMKoQUqlM+umjpiW8tAjYiz0wvo
	3EAPhvMtng980aO/KkNw7MmPv9NCifIJKHwK9Q9IjGjLtwC5bYC1uweUY/47kXRSNS3b7f/yNm8
	1aTEVuxmT55oxLf/+xt4aBSPlRRIfHeU4hpJgeHg/TtqgBR+dhS7NVnocvZnGFCzo8EtNi1IF01
	+v0MAv
X-Received: by 2002:a05:6a21:d83:b0:3bf:6c08:fb97 with SMTP id adf61e73a8af0-3c110a1b5b6mr4347640637.57.1783823132125;
        Sat, 11 Jul 2026 19:25:32 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:31 -0700 (PDT)
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
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 09/16] nvme: Implement cross-controller reset completion
Date: Sat, 11 Jul 2026 19:23:30 -0700
Message-ID: <20260712022437.3743117-10-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192532_925859_F299A575 
X-CRM114-Status: GOOD (  17.20  )
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
---
 drivers/nvme/host/core.c | 50 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a1deffc3cc00..18de3805eff8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1943,7 +1943,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
-	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
+	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -4974,6 +4975,48 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
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
@@ -5050,6 +5093,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_DISC_CHANGED:
 		ctrl->aen_result = result;
 		break;
+	case NVME_AER_NOTICE_CCR_COMPLETED:
+		queue_work(nvme_wq, &ctrl->ccr_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -5238,6 +5284,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	cancel_work_sync(&ctrl->ccr_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
 }
@@ -5363,6 +5410,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	ctrl->numa_node = NUMA_NO_NODE;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
+	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 90b989302e21..578fedda9946 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -422,6 +422,7 @@ struct nvme_ctrl {
 	struct nvme_effects_log *effects;
 	struct xarray cels;
 	struct work_struct scan_work;
+	struct work_struct ccr_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
-- 
2.54.0


