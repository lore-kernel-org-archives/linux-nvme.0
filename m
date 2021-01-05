Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B08C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 22:50:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6B122E00
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 22:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6B122E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V/dDwAOx4bXlP+ap6o/eTjVy3SY4wxEhtNrZRpoOisM=; b=bpsBLJQh1CEhkWKCSafrrZ0Tn
	Kw9ajamqmrtZYOa2xe+VYtQPdeAj+pwXK1x/qkRtOk2rK8AlT6tBQ2B/uC8iHPL/g3kaDKZaOgH+7
	P529Sq0kvkQM2b/xglRadIA+Uintquml0DsqaMiI7aoO4+uE29vtNg0nYKG2t54R9x2LEPqxVT1+j
	zWmNbxoEgF6Z1Nr0NnMaATHKzgRf8lsUNe7HL6TcKXQENABwhU/tN+49IF4VJ4WmytR9TM3UNkSwT
	dUliCR+YK+qljble1y6WCy4WF/J+dCVwBQbvXRhnIMml7NA0mN2AskpVvrrW80E7glsVBD7GQ1ITF
	A/uSHHSjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwv9J-0002C1-E7; Tue, 05 Jan 2021 22:49:57 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwv9F-0002AS-Hw
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 22:49:54 +0000
Received: by mail-pg1-x52c.google.com with SMTP id i5so884212pgo.1
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KBNaH8oSCrU7IQxNXOZDbTq4i7ueJLqqzxia33+BLhc=;
 b=neph9sX0+6XXQYi7CqtgA3UjtQ0o1T0n5aEiSvcgs6PMkPUIynokOnIi8BdvAHwfm4
 4Ig6HUO3p8UHvZ+ZKYWe+ix/oxw/aUtD2a9RrDdei2/Igdo96YNh5MzfvFuE3UOu6kB+
 rcQrMpJQ5Bipk/bhHIpziH1NcvbfCoyOH1D+Ek/umNd+MJI/0ZYkpGaiK/jrsi1khnOL
 wdAjBHKZ3xKOI25IgZc1qBJkMaVks9w/3jA1oFSUzYzOjOs8hpIh3/glw4V7NJXLaVkB
 014ne4bByOWBbVGORicSbxd17Wzq8xYcfZm0op6EhDr0uEiC5tRwdGJK6hmQRY43t5nM
 dhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KBNaH8oSCrU7IQxNXOZDbTq4i7ueJLqqzxia33+BLhc=;
 b=DLxJ5skrFhB569vG40SNJmO/JaBIi5pFWkBMfaWW7Aj2AsPNb15SPhmpumDEnkP/sP
 5Zu4SGBMqdm4EvVnclP9pQVGRlEKMqKIvktOMpTLty92gYRgLgV/Y2m2CaGdCr3O9Dv/
 B5FpJsCgNyvPE56UsWXo01veDjufTJ8cZEnvjEMPkDmcNS74yhz0i94U26VMA0jGr8Xa
 B9cBlJsC8oQpsBaYjW1j30CPrM82P1K8WxeiWXTAjTvIfy9maNYZs5h7z0etRATKTzLM
 DLOLmytz4TRPqLHD4Wp7x7FLiAgWaQafJlz0ajlEr6diFfxKgfY6iWid4rriyi55KYTH
 0gbA==
X-Gm-Message-State: AOAM532e4d91w/bPsNJ//BXVWhARRyulDbdsbjuIeXWsDT3/FLkwHQTY
 CJGhIG1LAPtXvKAMPhi95NTcf9spoAYdoRSlqjM=
X-Google-Smtp-Source: ABdhPJwR9n8/Bl+l177IWtmSQU4OH+UDzua0QcU3wqf5tHjmcoR2hYFspZAk5+w0+XApldTdQrYI6g==
X-Received: by 2002:a63:d814:: with SMTP id b20mr1371223pgh.202.1609886989535; 
 Tue, 05 Jan 2021 14:49:49 -0800 (PST)
Received: from kai-mayerc-x40e.us.kioxia.com ([12.201.142.42])
 by smtp.gmail.com with ESMTPSA id 6sm351516pfj.216.2021.01.05.14.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 14:49:49 -0800 (PST)
From: klayph@gmail.com
X-Google-Original-From: clay.mayers@kioxia.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: support fused nvme requests
Date: Tue,  5 Jan 2021 14:49:38 -0800
Message-Id: <20210105224939.1336-2-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210105224939.1336-1-clay.mayers@kioxia.com>
References: <20210105224939.1336-1-clay.mayers@kioxia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_174953_615515_73668A8E 
X-CRM114-Status: GOOD (  19.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Clay Mayers <mayerc@kioxia.com>

Adds support for fused nvme commands to be tunneled through a blk_mq
queue and submitted atomically to an nvme device queue.

If the nvme cmnd has the first fused flag set, nvme_request.nrq2 points
to the nvme_request for the second fused command. Instead of submitting
the first request, its cmnd is saved in the second command's
nvme_request to be submitted as a pair once the second request is
processed by nvme_queue_rq().

Signed-off-by: Clay Mayers <clay.mayers@kioxia.com>
---
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9a270e49df17..a498cf6a9eaf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -514,6 +514,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_req(req)->retries = 0;
 		nvme_req(req)->flags = 0;
+		nvme_req(req)->nrq2 = NULL;
 		req->rq_flags |= RQF_DONTPREP;
 	}
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 567f7ad18a91..187dde1f11fe 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -157,6 +157,8 @@ struct nvme_request {
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
+	struct nvme_request	*nrq2;	/* Points to second fused request */
+	struct nvme_command	cmnd;	/* Saved fused first cmnd */
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3be352403839..c24729e100bc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -491,6 +491,30 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
+/**
+ * nvme_submit_cmd2() - Copy fused commands into a queue and ring the doorbell
+ * @nvmeq: The queue to use
+ * @cmd: The first command to send
+ * @cmd2: the second command to send
+ * @write_sq: whether to write to the SQ doorbell
+ */
+static void nvme_submit_cmd2(struct nvme_queue *nvmeq, struct nvme_command *cmd,
+			     struct nvme_command *cmd2, bool write_sq)
+{
+	spin_lock(&nvmeq->sq_lock);
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
+		cmd, sizeof(*cmd));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
+		cmd2, sizeof(*cmd2));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	nvme_write_sq_db(nvmeq, write_sq);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -918,7 +942,13 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
+
+	if (cmnd.common.flags & NVME_CMD_FUSE_FIRST)
+		memcpy(&nvme_req(req)->nrq2->cmnd, &cmnd, sizeof(cmnd));
+	else if (cmnd.common.flags & NVME_CMD_FUSE_SECOND)
+		nvme_submit_cmd2(nvmeq, &nvme_req(req)->cmnd, &cmnd, bd->last);
+	else
+		nvme_submit_cmd(nvmeq, &cmnd, bd->last);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
