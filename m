Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53562E6BF3C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zyhzdc6roNohqktXVF46V+5k877QRUEUXl/CXU7Oa7c=; b=Sdt0KhyKWRb7RwGlDxVhmt4z01
	jkigQq3Y1wzJY0/I2PImkq7hTIo2uMq9PStCbjmy+KUpdse7bO+vUszb+hbk8aqEO3jhnhxd24nt1
	atm1oteizF5YzD9ppi0o1PMBm5pwbUex9puTt6uQfP4Ip081Ig2j00uMjDMCwAFgdY3uTx6/klv67
	PiQxQKPXVl8KmZe9E9084WvZkj5r98v94Y7rN4XBj6KXIc8nBltZDZilJO3n/zabKPw8/FY7Ch/jX
	ACk+MxigeHL2VjFDYfLHP2OTwUnpHinYEteNSgkJohR7OkCtUUZX6cPMr+BiDR3V3X0nJlsb+/KfM
	r808aSvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6Y-0000000232I-3bxe;
	Fri, 30 Jan 2026 22:36:42 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6Q-000000022qI-49ZT
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:37 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-2b71515d8adso2691865eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812594; x=1770417394; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyhzdc6roNohqktXVF46V+5k877QRUEUXl/CXU7Oa7c=;
        b=E7ipk79FebW4nsK1a58L/O83EIVruVsrbAgQ92Cao+njq0F8WHHQzV43rtLD8BtmFO
         U7H/UJPNe2zNIoDmCCw/ydkAy4G1gF0cDCScuu7Zx0VytmQRKGhIiNPbLjS0gEEb1KeL
         VhWR7piSR5M0whzUkr5v7Bh3NX4Tmn3uHFJhcPMln5Zw3gZBiClDrxU4BGn1Hw53I61o
         RzDhHadibzZ0RMLhq+T4Np38uF/VsSNJFGYIkimcpduPRB6ayZPoHwsEPhph5cwGT15W
         NiooTnyM/sAbfn8VVXF0hTrf0u4xV4RC2/0llcnxKobtHd3NRfvpIYQARegZ8qkd4S/8
         AqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812594; x=1770417394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyhzdc6roNohqktXVF46V+5k877QRUEUXl/CXU7Oa7c=;
        b=mptUQvquuBP8B3k85XJQwPlKyzOf0q56QpBHJZdCSwTigPy6DlYlSpZ+lx1a9eLQu/
         N5abXlUJQdlo3db52EhugmqpEx9oya+BxiriXDrMxm1sl8xdnLU1ysC7F+gyGkhZRi+A
         61JtgrZPbBHTZKnSd4PrxJ4572eNyDkW1gZI+HKTvD5ah3PakyUNQHK+IpunWOSBrlqr
         6H4dzAIZCVwZk5ArlDfF7SrCyFWx/T7p2EWzzxmWzOapuPVURj6hwIAXHA/NUOWXNKJN
         vYAqvSgrQa9g/4h+1xdTpzb4NaWDJt3Izho85CYHHLJJAbXOccQLyrThVMJA51kn7mxZ
         jScw==
X-Forwarded-Encrypted: i=1; AJvYcCX18k85ATm4wSwNtUn6wlVjBtpvTNE6UhthSgN5y5dnSZVatahRYB9M8Cqykqnn364dh93rLUidWyjr@lists.infradead.org
X-Gm-Message-State: AOJu0YxfM7c90Rp3FS/L2nrHhP+0ATbGFd8tCCnO0cF+NfxUF3q+tEDi
	rANgdli35QLgaMdC+NfKLWyfJRaEAHdwFBC0mbsm9LtGGro0lJEehM4BGNIFLUuMjGXVwczy0kd
	vy3YA
X-Gm-Gg: AZuq6aJ2KQnkLYLSGIbtv0Av2z8weUHUJA+BFaRBZzR8uvMSdnk1yBo48PK1Ky608On
	Ndj6LCvl/ch6vexq10vBlj8XZvRmYHbM4XgH7fDo/mXUFMhYb0Ga/n2QkjO8AZpRa1FjPhrZO4a
	ZfLepcgTJJ8v2iwSMMpMsyKnd9/Zx4GCjlf9D7eeEyaXQCSnsyP0oxeKeSIK4Nqqn9qGycD6TQO
	9XwqUKxWo/UoOC7K3yPRjl2gAarULH0b+bt/5FyH8izjb6KNG5IsMXkMDgEQ/lmqm6xVbv7UVxu
	i/d7ZgA434q9avRSZLPCFuojVaYaSL13AKMPgc53BzGYpHHBAH9caWgtQARwsAnvgBKMi+eX2Lp
	oA7SXqHZo30tCKdwssWxyLi8PZPi2f2PM5vQDehLx4SVl7CODVevn+GrHwt4uvGZCO64sNNqZ8t
	Ge7T/y6IAryMZ4WDYXUVhVC4lg/0surg42Lw==
X-Received: by 2002:a05:7300:7306:b0:2b7:2fff:ed1f with SMTP id 5a478bee46e88-2b7c86657admr2320612eec.17.1769812593797;
        Fri, 30 Jan 2026 14:36:33 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:33 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 11/14] nvme-rdma: Use CCR to recover controller that hits an error
Date: Fri, 30 Jan 2026 14:34:15 -0800
Message-ID: <20260130223531.2478849-12-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143636_640220_D6AA7378 
X-CRM114-Status: GOOD (  17.70  )
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
terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTING
and continue error recovery as usual. If CCR fails, the behavior depends
on whether the subsystem supports CQT or not. If CQT is not supported
then reset the controller immediately as if CCR succeeded in order to
maintain the current behavior. If CQT is supported switch to time-based
recovery. Schedule ctrl->fenced_work resets the controller when time
based recovery finishes.

Either ctrl->err_work or ctrl->reset_work can run after a controller is
fenced. Flush fencing work when either work run.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/rdma.c | 62 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..da45c9ea4f32 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -106,6 +106,8 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
+	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -1120,11 +1122,58 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_rdma_fenced_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *rdma_ctrl = container_of(to_delayed_work(work),
+					struct nvme_rdma_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
+}
+
+static void nvme_rdma_fencing_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *rdma_ctrl = container_of(work,
+			struct nvme_rdma_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (!rem)
+		goto done;
+
+	if (!ctrl->cqt) {
+		dev_info(ctrl->device,
+			 "CCR failed, CQT not supported, skip time-based recovery\n");
+		goto done;
+	}
+
+	dev_info(ctrl->device,
+		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
+		 jiffies_to_msecs(rem));
+	queue_delayed_work(nvme_wq, &rdma_ctrl->fenced_work, rem);
+	return;
+
+done:
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
+}
+
+static void nvme_rdma_flush_fencing_work(struct nvme_rdma_ctrl *ctrl)
+{
+	flush_work(&ctrl->fencing_work);
+	flush_delayed_work(&ctrl->fenced_work);
+}
+
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
+	nvme_rdma_flush_fencing_work(ctrl);
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -1147,6 +1196,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
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
 
@@ -1957,13 +2012,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
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
@@ -2169,6 +2226,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
 	int ret;
 
+	nvme_rdma_flush_fencing_work(ctrl);
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
@@ -2281,6 +2339,8 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_rdma_fenced_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-- 
2.52.0


