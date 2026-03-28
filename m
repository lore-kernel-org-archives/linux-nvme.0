Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A9810F3DC0
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HoxD5uMALorP/CUpuT5YOO2jyxxdHWPhu3WHKWZf4sY=; b=rY5RusAwlSOS5608E//I4j7hRg
	UzSIZlbzMMSDB/3Y+6y33jQUJGlC0RtN6Sr575Qhs7Ayk2IW+l8t9/rmPM0KGDGQFVmOxBKADoOkA
	x9kZD6etNw+Ywd6HLN+mmlIDtDjYkd2RKcP26UzqH/iJzmxmmVm/I3IgqgIIguL2AE7pbwBJK7g7L
	CpKyk0MtRI1td+SgMY4Hu+BdCvAPbf8iXfE57EOobNlfmKARb0L65OZIJQEL8hw/rAqcVPHimJ/4h
	6HCU3gMPj0v7wfamU/FylpXHpCwAW3B1o9cHgRZYBEMZGtQA1H88I3PF8CgWbpiBg0UEOZOwrHwVB
	WM2kv1uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoX-00000008O3E-3i4y;
	Sat, 28 Mar 2026 00:46:09 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoV-00000008O08-2c9j
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:08 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c73c990a96dso1321353a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658767; x=1775263567; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoxD5uMALorP/CUpuT5YOO2jyxxdHWPhu3WHKWZf4sY=;
        b=LBJEYex5pGCG5wpBh4YGOuTkpVR9yXy0dHkJlt2nuQj3OAaEYlgfSCV+UhAugNTuKv
         e7W0zpZjet0OZCo7uQ+9xqJiZAi1ixhR7t5osUJb6GIJqioFHaGlUCCxok0ET0VbuR1f
         E6lI9q7VZcUCjVLGB8e4VT6LvqqKx1h/MNwMrNW/Up8pRUCj98Va1Ue94q3gC1lTQ9g1
         t3SsUJG5xnnVfg7+8a4AwPmLp9p6iJgA8s74E2UNqpwxYqzSVVWmRP6+yeGPENpFLGTE
         6/9Yk+TitcRepDfFD9HQnDdWb64LHQDpUBUjPQw2vitsnEUpG9yiaZ5xgREq5TXpiEYi
         2/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658767; x=1775263567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HoxD5uMALorP/CUpuT5YOO2jyxxdHWPhu3WHKWZf4sY=;
        b=buwATKYG8D+02MXzpOsDRqONP4+p68Z73veky1CMX9kUGBEG1Oj4ICnTit8wPm8t5i
         GqqBYNbk+/0FEB+uEP8cTRxi3A2eTXrTlX0wLV+ENCcPy4H63w8krQYtqZzbA1LHPLcY
         o3E02TtKsZ0IaKIF3YwndfJhWr2ownLYnisM173pQZMUJLoBl2UrVlqKDmyoRqj7mk1/
         Dn1FyL3jbtETq7e5o0d+EEDAOWAkPEngvlwqDL7wYTWKegkAfaWwmUe96FDfMEwGkLzx
         9nRuN1nSQR6iMZ9Rs7VtaJvveTbODEzo6qA3uBqN3tTb2Z20oAL0JnXjtQN7dRlTN9nu
         8f/w==
X-Forwarded-Encrypted: i=1; AJvYcCXRsQhEQmCPrlmrBAHvVs+alzXy9nM2k3zm1uhMEQsAXFOLBslriJDo7MxOd8Ahgc/zxa3KbMiF2M2e@lists.infradead.org
X-Gm-Message-State: AOJu0YzzuprNw2UqE3FYAQ4n0fg+JM66S+p3aabkt/NQ6m1m1URm7yht
	lCOBUu93jbGA2XRaanKQLoTVgHbQpHjasu8bJgTmTOpZrBq4ouLS7iJwkdmLKdbaMoM=
X-Gm-Gg: ATEYQzxPO5AigtutfqBaU98Nr7Fc4yXdUGH/iFnB8FlywIGPoqCuG4sa7UsZXBz9nfX
	/rqyQNwo5lkZ8zv264gnvNfJVsSRMMXi7DzpRVclw9STnZ7nP8n2+NSbOelbb8DUHIanS32AoI1
	L36D/QAvx34eFXVR6oBafPxqx7BQgQngAUFw4StQiBjk4ySP783mQzjDHUy6oKlm32BhonxuVbW
	UkonWudcAyJQlzwekQcpBv9i60hasWRBvAriq0ZJ5IawjAfAAuCwOWxiVo+NCWtkFBji9a8sQga
	MMCrGi0Kb8A8L3DcuMcTOIZzyDAxzTGeBacL7GWV4HU9mT5JyXdtUF3qS16YQWy9jerkLSL/ieT
	Z3kJmKB2oWM1hcBYRnCm1EPgL+e2N7Jjin2wjHt990QF3EX6n6QFbEuNgKDEZIFqoit1hFhZoln
	PZ823s2jI=
X-Received: by 2002:a17:903:2405:b0:2b0:62dd:3a93 with SMTP id d9443c01a7336-2b0cdc0f3f7mr47700325ad.7.1774658766541;
        Fri, 27 Mar 2026 17:46:06 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:46:06 -0700 (PDT)
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
Subject: [PATCH v4 11/15] nvme-rdma: Use CCR to recover controller that hits an error
Date: Fri, 27 Mar 2026 17:43:42 -0700
Message-ID: <20260328004518.1729186-12-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174607_664976_D88A8574 
X-CRM114-Status: GOOD (  14.45  )
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
index 57111139e84f..b42798781619 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -106,6 +106,7 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -1120,11 +1121,28 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_rdma_fencing_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *rdma_ctrl = container_of(work,
+			struct nvme_rdma_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
+	int ret;
+
+	ret = nvme_fence_ctrl(ctrl);
+	if (ret)
+		dev_info(ctrl->device, "CCR failed with error %d\n", ret);
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
@@ -1147,6 +1165,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
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
 
@@ -1957,13 +1981,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
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
@@ -2169,6 +2195,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
 	int ret;
 
+	flush_work(&ctrl->fencing_work);
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
@@ -2281,6 +2308,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-- 
2.52.0


