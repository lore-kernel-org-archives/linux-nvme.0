Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9596C44501
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cHeryY6vgxsV95CWKD2Kjdif2w+1k42bjuOLEzQoEGM=; b=DwQLeNA4AwPALw2i/lO1+Nu3mo
	B7Vdr+hoUxFPMMgYhGKgTUfI7TBFn2TaCpGKav822zR3u31Ldgxhk0GAwRlmsLIrdyqFnOKPWvdOd
	iOB5hCfVMMRQAzIQt8fWBFjjKZjs95t2nBpLyyKkIK3VmKUcH6L27fGrYorexaQ0vtsz6AqWJxfle
	dRZaWBQkKfpsD1BxacN7/AXxsWranzP3OJEY6E2MyVEN1J5duiZRAtVYJJ7hCjrQdvYbopsshQvPi
	rVdkFN92e3vxKYVkq74CxNPYE/LxAO7AYazmcOydREi2Aqvv3XH5Z5CkW9CbKQCHK9Sr9abdJ29lO
	vV0Nlb2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijt6-000000071sY-0n3F;
	Sun, 12 Jul 2026 02:25:48 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsy-000000071hO-38zJ
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:47 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2cacf197759so30865805ad.2
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823140; x=1784427940; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHeryY6vgxsV95CWKD2Kjdif2w+1k42bjuOLEzQoEGM=;
        b=O7Q2K15Bdb0Y2Lq9pYwkk6SlYBhIEsh1XaUyv2f2tjw177OzcPOlm7QPHaE4ZX0pRF
         gQbWj0rtHcCJykpLVXguV+3Y/8CmuMmfc5Leql3vS8KepELOqvhfRBwXJkdvVbTSdGs2
         6tgYkKP/QOw0n30qkHC5V7vpzU/s7ZejS6vXcNzOFoLPCY3KPnjo0MoqC+Zr+Jt4ch/r
         3e57jX5X3/fmhVboBSJHd7VjYHkfBAmm3KIR4Oq7J/i98wOeCjypCwgbm0CSKhOSrhS6
         bM73WtlQgfUEHmKL1ViKV4rcx2tCqAasqDhbPzzNEJI7ewZ31x8WaWIWfmTuqaH8qAg5
         uJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823140; x=1784427940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cHeryY6vgxsV95CWKD2Kjdif2w+1k42bjuOLEzQoEGM=;
        b=sP69ONkBjcHhxjXB3tAD0VeK+6LTHAILZGbOrI+BaYaZbU7L5ItD8Cx8dEapYW7bOi
         CEYRPCenfez/LS1zEXvaMoD0lql8If3fZFGbwY6ahBUPOmcpsfxLkb6iMpR+or4Ta1or
         O5AUWKcetvW6plr13y2YpaHv7ExQL1Zdhb/dBU46SIDdQZ9Z5nEKOwqEG7BXjxtPD7nH
         fTCxVXLsreCGlnju1K80edP5pGIdLO8g52EuSNcWAZPfV8Be0hgrNTMl3gXT/IRcXn/o
         iKsrZMnNtUuHSX5wotYi+SJ753URbEvNswLIFojdAtECf9HLPfpjmT4Dys9CJezaxWAQ
         YbfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5DIWcVfT4wG+hQ6i5lU47A/f/o72HEIzyEZFv/Nn6PR/1bV0YJg5oazrkk+9wh7iYPaZbKEvZTVx4@lists.infradead.org
X-Gm-Message-State: AOJu0YyN+Q8XhOJ4OIHyuFB08WjfqviN4rsrbyh83HBxsliCGBbpqbym
	Y130cjQbiKJll6kK3fD+prLqszMOkppRO1TZKKRZ8jGMwDWhjEu6i50Bqs7j3iad94w=
X-Gm-Gg: AfdE7cleJqx2VUtttxWS6ODzwjjDuMdz+BDz3dyS1dzATcyPb910UPUTcakhV8LlVfp
	e5PrgKuX6DoJYsswPDrwczBV0LQInFfG8cHvH5dQ6c6Ji3W0FCQLzsKZcFRJmkY1WKItTdHTtEm
	o3whnuk7+Nm4kmzLH/uofs4vUQYjVrBD34/48vVUGBWJyXQHScfkC5u/veDpFCJ9HpsYXsjwKnZ
	fhke/Sb3B/w3LVpabQ7Ac3v79QZd5tG8RViiupIRNMIMAK+2FGFDAUz5gtIYINT3UZ0yDDM1g5n
	dplxp5kGGBmdHDd8w6MQ/6oA9iI9iItc5ZKogY9zeYwnclcXn2BCfqY7RyRe3R/M78lVLpaa87L
	09OsmBtmxwdS+JRsdT9NwE4hh+AKKA9uSLUO1FDdvgIJpu2oxcWGbL9sKY9nqo+fF/2eH6nIN8N
	sFOFA4OC1ZxnYXPfs=
X-Received: by 2002:a17:90a:da85:b0:387:e0db:3fa9 with SMTP id 98e67ed59e1d1-38dc777018cmr4731701a91.34.1783823139833;
        Sat, 11 Jul 2026 19:25:39 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:39 -0700 (PDT)
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
Subject: [PATCH v5 13/16] nvme-fc: Use CCR to recover controller that hits an error
Date: Sat, 11 Jul 2026 19:23:34 -0700
Message-ID: <20260712022437.3743117-14-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192540_804099_F10F790D 
X-CRM114-Status: GOOD (  12.74  )
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

An alive nvme controller that hits an error now will move to FENCING
state instead of RESETTING state. ctrl->fencing_work attempts CCR to
terminate inflight IOs. Regardless of the success or failure of CCR
operation the controller is transitioned to RESETTING state to continue
error recovery process.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 54a09db9716d..03b6c3649210 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -166,6 +166,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
+	struct work_struct	fencing_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -1868,6 +1869,22 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	}
 }
 
+static void nvme_fc_fencing_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl =
+			container_of(work, struct nvme_fc_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
@@ -1889,6 +1906,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 		return;
 	}
 
+	flush_work(&ctrl->fencing_work);
 	nvme_fc_error_recovery(ctrl);
 }
 
@@ -1921,6 +1939,14 @@ static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
 		return;
 	}
 
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: starting controller fencing %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_wq, &ctrl->fencing_work);
+		return;
+	}
+
 	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
 		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
 			 ctrl->cnum, errmsg);
@@ -3328,6 +3354,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
+	flush_work(&ctrl->fencing_work);
 	nvme_stop_ctrl(&ctrl->ctrl);
 
 	/* will block will waiting for io to terminate */
@@ -3504,6 +3531,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
-- 
2.54.0


