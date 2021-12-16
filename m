Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB489C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z+2oYvndBswSZaKsj1QzPxEnhIwscC5+Oo0mdTn6+Dc=; b=yZxvzu76TlD1S5V+UIY7IowRQI
	SXfmdJiSfO9D4KFNsBwbNMexfeTUFiWNJ5sKnk1QpW9mKYlfNKzlNs/AjWSX9dPypkZ7rXYCqkDXd
	n5n2XXIYAd4XUwtBHDVG9XonJBWFXjlfy57VHk10nsW2+zdtNecY4caRC/CAfEpDGvhDXeZT/MqL8
	uUC3pNaP2sIJJLqCVQoaZ+UpD971WMXMKIN8AtIPXgUlY25Jq0V9T2Ak9B43cIaKdejUM/sPmYqfd
	rmjqW5tvuNg0dLZXQ7ft76hSfowAK3AfSUu0i/rk4ogFsPBSB9ArKwFWoTRBQYutNwQ887c94rWHT
	sqM4fVxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxu0R-006kZA-DM; Thu, 16 Dec 2021 16:53:23 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtmc-006fnh-0Y
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:39:07 +0000
Received: by mail-io1-xd32.google.com with SMTP id m9so36067134iop.0
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z+2oYvndBswSZaKsj1QzPxEnhIwscC5+Oo0mdTn6+Dc=;
 b=yVowYWvxaczkDintg9/OYs4mta6ur4XI8QM9V7IS/4j7hJ7IVfG/p1UtKN9Oj9HKyf
 dvpycSXBY66fnxl4f4ODqsuvnE0bt4Iu5ypURdLq3JdGrKjsYd9KjOII+m4kzTXzqI6c
 zdf5Zx4EuwHP8ls6C6eCZXSXRa+kwCD/6c1e0GKV94IgCtbghoLn7mGbCRPv/sRDOM5Q
 4igld9S5Imxsd/4QUU8av6SYgW2lezEhL4kyebUmOM/+Cf//4dJ+bRJDEbiniKLSqegM
 gW4Mu1E2LOMKCRru5ZBvUOPnoeYj7Y/jY4qnbFbZaM7rSjmcATav3eMTpQwWCK4pLneC
 E44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z+2oYvndBswSZaKsj1QzPxEnhIwscC5+Oo0mdTn6+Dc=;
 b=uWcaN5WVQAOVCjcGUArxPZgYg9JN+f0AzitKdoeBcRcNPRaRg/DclNEFJgSRKN9xuX
 T1oEaqYG65Hcb9Pij3EKagSxyr/3dszsrRub7O9BkBj+3Ip5mpR/nO1aFQFGfmsc7fns
 2dSs+IHV4qkNQodPl0evHaFLMw4ESD3ayFPDP5zb/t3ohexiGINrEDZ95WDMQ2/u4XkB
 MAv68k9cYR+Qlb8jhCphz1Y41MoW2Thy+A13pJfZhNRihLQSlUmOttnoI7Qc7LSobJmP
 EEoKRFGlQ+L4GXNVJ4+zXQNi4rS5t4i41jaomFTURTwPbtL5O4Ep7T6ya3+VvOw4tQha
 vC6w==
X-Gm-Message-State: AOAM530pwKIMi2cAbifX22iHl3LgCgWHQJbb6nVExEdEmgeK54osovSu
 V20rIkc6gyjtJ3FrE59vOwsK9Q==
X-Google-Smtp-Source: ABdhPJyVdd7iRMbi7TlLSgBNUbLTjF4iOc3lkxSgG43dQaU+1dqqGcxHWIIAam4lk1kutc09Uj2kjA==
X-Received: by 2002:a05:6638:4087:: with SMTP id
 m7mr10188047jam.112.1639672745102; 
 Thu, 16 Dec 2021 08:39:05 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:39:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] nvme: split command copy into a helper
Date: Thu, 16 Dec 2021 09:38:59 -0700
Message-Id: <20211216163901.81845-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163901.81845-1-axboe@kernel.dk>
References: <20211216163901.81845-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_083906_096981_85C11CE5 
X-CRM114-Status: GOOD (  12.26  )
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

We'll need it for batched submit as well. Since we now have a copy
helper, get rid of the nvme_submit_cmd() wrapper.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8637538f3fd5..9d2a36de228a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -500,22 +500,13 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
-/**
- * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
- * @nvmeq: The queue to use
- * @cmd: The command to send
- * @write_sq: whether to write to the SQ doorbell
- */
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
-			    bool write_sq)
+static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd)
 {
-	spin_lock(&nvmeq->sq_lock);
-	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
-	       cmd, sizeof(*cmd));
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes), cmd,
+		sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	nvme_write_sq_db(nvmeq, write_sq);
-	spin_unlock(&nvmeq->sq_lock);
 }
 
 static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -957,7 +948,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, cmnd, bd->last);
+	spin_lock(&nvmeq->sq_lock);
+	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+	nvme_write_sq_db(nvmeq, bd->last);
+	spin_unlock(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -1140,7 +1134,11 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
-	nvme_submit_cmd(nvmeq, &c, true);
+
+	spin_lock(&nvmeq->sq_lock);
+	nvme_sq_copy_cmd(nvmeq, &c);
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
-- 
2.34.1


