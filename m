Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D53C43458
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4ikmBr5mw7p6ycSVAdXvIpwXhHnLZzoeuY1Qg3gT2Y=; b=D1oMNBCK+k1biVp387wZN42NKO
	laUz30gqFuxbKKj6JoDJYwNlLwAVKgZjQqfBo57MHIMVQ9ilsRmyEodlkasfwXYZVWGp5TB5mle/v
	jv82/oAZrEyMFUsmrvbRx47q3+C1q2GZ78LZt4Fnrisn0LNdbNiNQNVRueYWJ8uzTm8bfmxJYxW78
	iuq0mZsLrBrbdfR6shN8v0ONwdyJUkjbwEc3jQ054FWJY2jU0Omt0+vFqI2cbk00LxbDBMgVc2IH0
	/QJXfNJWaD3QD12iXN0pn+hDG2+89ClwrdhEJDSTox+qL9UoRfsQFtGQGF1lkArdFrl+t0pYrrtkC
	tyqmyaIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsx-000000071fW-1HmJ;
	Sun, 12 Jul 2026 02:25:39 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsv-000000071aw-0MK9
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:38 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2caf228a910so15431775ad.2
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823136; x=1784427936; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N4ikmBr5mw7p6ycSVAdXvIpwXhHnLZzoeuY1Qg3gT2Y=;
        b=BfR/tokZ8pYO+Nsr941pFZW4rQIM7h0kaUrCTFl33h+DfIdWIrZqbc5n0wYaiXs/Hr
         CsTCHQww6dGJS8OKwFA0zhM71xHxpLy+j2Pzq3kwtcEgjVUCVhaYEjm8O4S7vyzVwkT0
         M8W68y+hufgWl3AJx7bj1OwzxPdRVFJUpKC0aLufXJpw1Zvw6G/a8japJdhe8IsY6XEP
         s9QCWvOvEIDQ4n6xOMsac+k1WuKq6msWmsFovdaWTeJHpzDIVO6IHgdUtps+Bq2m/bW1
         OJM7dhU2tjvOUT84bieaxk6/Ttxzp3jDLAFk5QJ+Hve6zDoWzHbe5NwKeYDHWmbEgUrG
         2VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823136; x=1784427936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N4ikmBr5mw7p6ycSVAdXvIpwXhHnLZzoeuY1Qg3gT2Y=;
        b=ApJjTKWMBestvNVlBUKIdOpdjgFy211OeruNisa8uxUo/5DXMzLDaQWMLtry8+zmDl
         RC5D+OgaItgwNJZNzQ7KUPmmAvL0I18YSQPBN9QbClq5uWZs7ksYp6F/JzHMmjqvQQ5Q
         1Hjmh5qSlNGo3+ZiMhOlrNZqL2MySky+stt36W4q3N4+wHxkCRrXFH51lYhI3OtsX6cx
         r+XYVL+NTbj9Lt3kbrQuBLeaaf1EO3YfgKKGxVIllpnO3Im3lSmYfmMSEuIjP5n8qdV8
         xUCL3QGZh4a3hCL9uh1puP8N98980opCWEkSz5QE6Isr/mylywptrPR9BDeAX39GJYA9
         nmIg==
X-Forwarded-Encrypted: i=1; AHgh+Rot2FC/GSD2Lv9xDvn4V0pVYkXJRqZ3OkV1nOlLolbcyu+DdrCQ7BpRB41C42T7aiPKiQuuedD3yl5c@lists.infradead.org
X-Gm-Message-State: AOJu0Yya3Kaic/UZGuve1ilXEdec3KMvlctpblijOIIUtTS2kOQl0Boi
	v9qmMh9WxE0K65Ze5StKXajevi56UKyhCuk+UxnMqbF1jrXfPOIoF+EnR7haCWTLzGM=
X-Gm-Gg: AfdE7cn5xChregiuUEDR27EoqDzgxZIZYQbcTD1Wfk12RXIKa2g0koBkcd0YPeXSx3G
	Dh7Oyu5dC7Ig45lWwS9RwuD0PQv/utQqnxxL4Er/IA3cg1CPo5D6bZjkrP/eLTySDrdu/D452Vz
	i7jn2rpoE23zWM+tLiigkfBDmriZvNCzjcDJWE4XGxSBbsa5cYX3RaRbaJSYxFgyvMSsQu5Psd9
	6oCgHNBiO5I4A0G4ApMuX0mmrJoUea1Jz2rEW2jN3amD4n/6ChS+yCrursNAlb21zrfg3lbU7om
	yNprKUt2HlYMBHYIuVgVPc1h++kddncCJF9kCD4c1s8jW3tgpWAd7CRANsiYM9HuzmuI98lA+jF
	ZxMRziNJb3B+qIk853svgKSBicTMf5Jw45vsOu4bLsxT6sDi3gNqaxynMdkpQaJFGoqZ8jmVfKJ
	AhINPgYZxIwuYB++Q=
X-Received: by 2002:a17:90b:4a4e:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-38dc75ee9cfmr3966096a91.19.1783823135994;
        Sat, 11 Jul 2026 19:25:35 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:35 -0700 (PDT)
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
Subject: [PATCH v5 11/16] nvme-rdma: Use CCR to recover controller that hits an error
Date: Sat, 11 Jul 2026 19:23:32 -0700
Message-ID: <20260712022437.3743117-12-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192537_142594_77DFF2E5 
X-CRM114-Status: GOOD (  14.87  )
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
 drivers/nvme/host/rdma.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 52933d11ea03..7c8108523980 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -112,6 +112,7 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -1151,11 +1152,28 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_rdma_fencing_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *rdma_ctrl = container_of(work,
+			struct nvme_rdma_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
+}
+
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
+	flush_work(&ctrl->fencing_work);
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -1178,6 +1196,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 {
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->ctrl.device, "starting controller fencing\n");
+		queue_work(nvme_wq, &ctrl->fencing_work);
+		return;
+	}
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
@@ -1988,13 +2012,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 	struct nvme_command *cmd = req->req.cmd;
 	int qid = nvme_rdma_queue_idx(queue);
+	enum nvme_ctrl_state state;
 
 	dev_warn(ctrl->ctrl.device,
 		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
+	state = nvme_ctrl_state(&ctrl->ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -2200,6 +2226,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
 	int ret;
 
+	flush_work(&ctrl->fencing_work);
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
@@ -2320,6 +2347,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-- 
2.54.0


