Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9858ED10377
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=exbjro8ZxYsk67jB8sE9mQJiuAHlrcOp4NnBqCERfJk=; b=Xyv9z4lyg+OQ4UKWJFsy01BYK3
	4eJ7p4UYvQV1YRW79PgizVtl+fDqe8Ly8yNpGZyffNKIkcWRoaJjR7zARe7lSWHJBf0PmYjKwcHnJ
	z4vid16ZCohba38iP1omSMBU2eD300RFfV7MzF5/BzD2fgfci/gYnDr4CXu23AI8Tz1ZYzw/+PDMD
	sNAsXfcwJ3olUQfqzALzZyrR5Ed7v4vaMtwR2VXQC1ciD4CqP86JINeO/SlFGeJUKK39LRfy+P+q8
	ZmTGcxN49CPoT8fmYSY2dFzZWOT+8g28WO3MOV1FigutxEMQyUMc6iLZ00zDfGQRBQ/IWOcRWQv97
	YHqa986A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52E-0000000EDVU-3Zac;
	Wed, 26 Nov 2025 02:13:34 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO529-0000000EDPW-3dXs
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:33 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo7283688b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123209; x=1764728009; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exbjro8ZxYsk67jB8sE9mQJiuAHlrcOp4NnBqCERfJk=;
        b=UDdBzZNoubG2JTkUjVk6UQpkQf64TvHfmwMUZh0Y5HLaxU3lPwWlQS/Oq7wXw6J2Eq
         wzQsC+BzS9IIASf8wrlqwSwqTILQEeifG+XbKJUlb+5pFJPS0WJR7JYng00cXVX3TaRA
         V18LByMsRwDDTTy8TIwiwuQOAFpstCoyK3RvVKddMGqTEUeikV1NTQIRStniwN1BLX69
         dU9+mrCOyK7B9hR9k6VmZHfVH4uaNcbs9DK1/uzi+JAmLDIxw/mEsdmhXFPrUqRSe4AF
         MYMkDzRfr3eUBYuGXdp7P3HdrGPegfRBJN49IuM+7W+tKYpxqZo1x/m0RwhgbRPDmbeG
         D+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123209; x=1764728009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=exbjro8ZxYsk67jB8sE9mQJiuAHlrcOp4NnBqCERfJk=;
        b=qyjo/9oM24BmSZZ3Ufg+BGKlQQudnk3GBEZrFCLa5P8LCU6BcZ5sXzL8hdhoWJFJHl
         IGNzbnMziTJ1ZONfXwPxJ8r3Ap/B8ZalvQOh0PgdBdUtjn7RdQiln6Sek5ecyxwgIy6X
         e6TQyIEljkfFu76z1z8dbPKB/aKXUeZ4eU86iNr9bQ5P+dH2dgLrCyv93oDIjWLgfdE6
         mBiI1mSeFtVfkgPtYnAQ8KpKGDNaBCIfyXF+qaGTIP64X3b5UgiicV2eIWzMfKq81pvg
         aUrICxakP3fujk6Mj9z1UjGOiDZIsGvno/HG/7UD22+pSTPSa+5EyjSyDdkdZLMUpMrx
         renQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpRCQtePR8A5AYUnI0RLJ3+oJ9CqRWan2BEPMK6oOd3epglggrRT0OwbmjUBhjYmzhDN15fprszMXw@lists.infradead.org
X-Gm-Message-State: AOJu0YxCqqdwR0LAZybTc0WD6KvGzjektK23g81wmC516ssjP033SkMz
	sBZ28/L/H9qijQT8QuKeuvob4s7NNSGiNXqW/9ZmsoHfVdHXUpS60aKGKakL+l1ZDjY=
X-Gm-Gg: ASbGncvsXqT1lU7s4ca6SMtmt2RwP0c+X7tD1V0OcCBkZpt3jTD32/7LbhwPkAP9xc+
	QRNrYvAGwDuH/jmqbJyY6zjpjnxwtL6q30g6/7/cf+yJAWnfitYvyca91rZuYMsQ1ss39RljkGH
	N7nKcHfvt/+8OhMxVEjaoIDW/BhbZKWNbsntK24rZtlnUepVC2tHfwdLkYIsZaE/C2nuHIOxsvA
	fmScpjzX3Vnkw8M9rZPfS+fXaUzKmXmG/elTWZRhz3PeIVaFg7nE3jzEpZ/0vA00R+qJDSYn0CE
	sUpJqX/1sIOhAtX/k/BXNSq9M1e3ChkE57RwMDD8RSGXOTKoe7KcpEx6s2lHhohcNTLFExtExe8
	W6Q90STZ/fCIaNQFWVPOrqd/YEpNYCk8dbMhqi7UfB+0KNQl6iaDuan88StkmUjPo8JbElcLW1y
	HbeG0hkcsrWFrPNBQH24e8C8XZIQACLidZxf5fhYTGa0wj
X-Google-Smtp-Source: AGHT+IE7adP0QSTlX5R/fE1HuvFPh7U731vSvH+n5NFHCnbsls7zofkCi5K19Xzrg3IFSrz0CdjnZQ==
X-Received: by 2002:a05:701b:2803:b0:11b:2138:476a with SMTP id a92af1059eb24-11c9d8539eamr9245799c88.27.1764123208925;
        Tue, 25 Nov 2025 18:13:28 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:28 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 09/14] nvme: Implement cross-controller reset completion
Date: Tue, 25 Nov 2025 18:11:56 -0800
Message-ID: <20251126021250.2583630-10-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181332_083108_9A70047B 
X-CRM114-Status: GOOD (  18.42  )
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
index f38b70ca9cee..467754e77a2d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1894,7 +1894,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
-	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
+	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -4860,6 +4861,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
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
+		if (entry->ccrs == 0)	/* skip in progress entries */
+			continue;
+
+		list_for_each_entry(ccr, &ctrl->ccrs, list) {
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
@@ -4936,6 +4978,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_DISC_CHANGED:
 		ctrl->aen_result = result;
 		break;
+	case NVME_AER_NOTICE_CCR_COMPLETED:
+		queue_work(nvme_wq, &ctrl->ccr_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -5126,6 +5171,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	cancel_work_sync(&ctrl->ccr_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
 }
@@ -5247,6 +5293,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	ctrl->numa_node = NUMA_NO_NODE;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
+	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1f8937fce9a7..3f5a0722304d 100644
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
2.51.2


