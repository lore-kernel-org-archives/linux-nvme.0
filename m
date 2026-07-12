Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D85C44506
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Qa2xMYNGZeTkTFfjF7wK7qrZQsQxsgN9mLNQPwLDOE=; b=rlckqg0K48mx5m/EBMqXym8CK3
	9R/ds2v/MUnmKBpa1qxm3ybSBv1LFgPHUDrCjFZerj/7ex3kEdDG+PWyfykba+usq8wnfMFqzmUd+
	RITKYTfuZPbZKD4vGUENlZiGaIQc0hji6tE/3Rn7/aTmVmLL6xsqbfWynOL/bFkCz15t9FRvsty2A
	oZ5nVbA/LOvFW78k804feuu7YG+k0DOsYt8+y8iwj4/3baiNS83S5Cd12woCSjlW90yvoeuruZ24O
	ZE7U6cGTUdvENUKsnfQBtGhRXued0pc8kg2EXKxJhbImiRH3wWRUqk2vUrdjfmCVPqdSELJojcCkr
	fgfhfJXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijtA-000000071yz-3ure;
	Sun, 12 Jul 2026 02:25:52 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijt4-000000071qf-2vYR
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:51 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1745700a91.1
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823146; x=1784427946; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Qa2xMYNGZeTkTFfjF7wK7qrZQsQxsgN9mLNQPwLDOE=;
        b=baBSpVUBp5JibQVCscrA97oG/0vCyJhCe4hDOQ+Kr7RoibM5w3+bDmogwTULzXrdAJ
         MkZAduaFiyl/rOJe9BcypQ6SPfqYiGVJZ/l81qSaap9E2lxiq8SBmM5GODZfMjizk8FR
         L8xr0lgbfMsnG8rAvbBqmLiAXS+ihocP+BjRGXIEpjNkPbXvOa2qZAHowpNQxEhEYEOp
         iRH3Sc+p9sm6EqwXiSsX1frHiBU1Rt6MSyuTZiDz/9vnkqN2lbppt4l1c2qWJcNOQz/o
         H1Aal76iCeHhGpJnSFCgqm87Uq2OQ46D2kli+Ux+Gkz5wcLi44Fq8tqzXrI4MvNZwqPX
         RbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823146; x=1784427946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Qa2xMYNGZeTkTFfjF7wK7qrZQsQxsgN9mLNQPwLDOE=;
        b=YaVft6s7zfbni0bfzPmerd8RtswmmAKokhYNkUcR5Yb/tsSPFjCMuGN9jNQGQa/RRw
         +8rzFXnVSprQnobNvngRE58bvJ6b36DoHOYpsadHKdE6F5RhuWvw6fdT8LR6XmLEEjST
         AGkB1XDjstuNXDkRTIYLaT+dVxdMaw0B5UdHVopkbBUjbl+aczN7fyquQprLKokxOPkl
         1C6cmIfVNXXpmLd029IthULI0G6tXOoLePCddEIkMrcqjvIT23npsKz3ilBw6CqUEKP6
         g7uHApM/qdmtdkeOWWCKktr40oDGlV2DIm9wiAE5vnqcNvKFUUrD6AUIe69lJU0jfwFW
         3SHA==
X-Forwarded-Encrypted: i=1; AHgh+Rpu/Y4hiPN/L57/YIiU420Ojj3UeK3lJXMlfmHjICn+E325Fa6LaBMXV+JrkBke9DC5Suh0prqNV/O8@lists.infradead.org
X-Gm-Message-State: AOJu0YyzUhcyVdQmg/Tr15bw00Kux716MjQ/pC5iUEmkW8BwmVXPQXQR
	EpcHk+noTUweu7qaVn/7gKvfzlRXlUJDuvDrJMEsinaxkMW+H0kMYqWxznUUV8eDnIhdUV7QK15
	xClJU
X-Gm-Gg: AfdE7clItx/bihWDUNpxjOCF7VN4ySvlzPPaprb3lcbPFSeqa4gB2RVT/bu7pGZz5m8
	s0mSjrROCkKXTZqoqQ27r1l1aX2SN7ImCPjvr9vVB9gP63XhNosUsQjmjnnpwAPYrGsTVHjiRqy
	TiwTdGAnX6aBvmQmYtM9piiPnk0LjWAjR7uy/261goI4zFUqxmXrELLmPYHyCua1NMnHA/VlwtH
	ch+tEVFMOutEtndj3Gv1W9IzDv4/mJ3u9J5Ox8mM7OBU6Pp64iOFPboKfYM5O42cJqPYpXtMwnn
	y1OovPdE43FKuxMww1W8z5EawGni3vYgJzHd/dFkJBIGFWpjh2y7N1g5vXWswfvbE2Z00wTU9sA
	nzqx2fl+wElYHaus5VNdShv1hhzlNAGatLxypME7WJlRZIykvalThDoSFnf+nkHb1mOz3KOV3yS
	pHhbWiyKHJ2jLr/q4=
X-Received: by 2002:a17:90b:1645:b0:380:873:49cb with SMTP id 98e67ed59e1d1-38dc774d582mr4427579a91.21.1783823145888;
        Sat, 11 Jul 2026 19:25:45 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:45 -0700 (PDT)
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
Subject: [PATCH v5 16/16] nvme: Add support for CQT to nvme host
Date: Sat, 11 Jul 2026 19:23:37 -0700
Message-ID: <20260712022437.3743117-17-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192546_797515_C77AC590 
X-CRM114-Status: GOOD (  18.37  )
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

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
limit for attempting Cross-Controller Recovery. Add ctrl->cqt, read its
value from controller identify response, expose it via sysfs, and have
nvme_fence_timeout_ms() account for it.

Use CQT to drive time-based recovery in fc, rdma, and tcp transports.
Add a fenced_work delayed work to each transport controller. If CCR
fails, fencing_work switches to error recovery immediately if CQT is not
supported. Otherwise it schedules fenced_work after the remaining fence
timeout, which also switches to error recovery when scheduled.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/fc.c    | 41 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h  |  5 +++--
 drivers/nvme/host/rdma.c  | 41 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/sysfs.c |  2 ++
 drivers/nvme/host/tcp.c   | 41 +++++++++++++++++++++++++++++++++++----
 6 files changed, 117 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 18de3805eff8..d3a2db50a89c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3821,6 +3821,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->ciu = id->ciu;
 	ctrl->cirn = le64_to_cpu(id->cirn);
 	ctrl->ccrl = id->ccrl;
+	ctrl->cqt = le16_to_cpu(id->cqt);
 
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 006b5a984dfe..dca7a26a4b15 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -167,6 +167,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	tag_set;
 
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -1878,6 +1879,18 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	return ret;
 }
 
+static void nvme_fc_fenced_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
+					struct nvme_fc_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+
+	dev_info(ctrl->device, "Time-based recovery finished\n");
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
 static void nvme_fc_fencing_work(struct work_struct *work)
 {
 	struct nvme_fc_ctrl *fc_ctrl =
@@ -1886,14 +1899,33 @@ static void nvme_fc_fencing_work(struct work_struct *work)
 	unsigned long rem;
 
 	rem = nvme_fence_ctrl(ctrl);
-	if (rem)
-		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
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
+	queue_delayed_work(nvme_wq, &fc_ctrl->fenced_work, rem);
+	return;
 
+done:
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
 }
 
+static void nvme_fc_flush_fencing_works(struct nvme_fc_ctrl *ctrl)
+{
+	flush_work(&ctrl->fencing_work);
+	flush_delayed_work(&ctrl->fenced_work);
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
@@ -1915,7 +1947,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 		return;
 	}
 
-	flush_work(&ctrl->fencing_work);
+	nvme_fc_flush_fencing_works(ctrl);
 	nvme_fc_error_recovery(ctrl);
 }
 
@@ -3395,7 +3427,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
-	flush_work(&ctrl->fencing_work);
+	nvme_fc_flush_fencing_works(ctrl);
 	nvme_stop_ctrl(&ctrl->ctrl);
 
 	/* will block will waiting for io to terminate */
@@ -3573,6 +3605,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_fc_fenced_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 578fedda9946..8ea7d22b78f8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -392,6 +392,7 @@ struct nvme_ctrl {
 	u32 max_zone_append;
 #endif
 	u16 crdt[3];
+	u16 cqt;
 	u16 oncs;
 	u8 dmrl;
 	u8 ciu;
@@ -1334,8 +1335,8 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 static inline unsigned long nvme_fence_timeout_ms(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
-		return 3 * ctrl->kato * 1000;
-	return 2 * ctrl->kato * 1000;
+		return 3 * ctrl->kato * 1000 + ctrl->cqt;
+	return 2 * ctrl->kato * 1000 + ctrl->cqt;
 }
 
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7c8108523980..3745b7242fce 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -113,6 +113,7 @@ struct nvme_rdma_ctrl {
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -1152,6 +1153,18 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_rdma_fenced_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *rdma_ctrl = container_of(to_delayed_work(work),
+					   struct nvme_rdma_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
+
+	dev_info(ctrl->device, "Time-based recovery finished\n");
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
+}
+
 static void nvme_rdma_fencing_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *rdma_ctrl = container_of(work,
@@ -1160,20 +1173,39 @@ static void nvme_rdma_fencing_work(struct work_struct *work)
 	unsigned long rem;
 
 	rem = nvme_fence_ctrl(ctrl);
-	if (rem)
-		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
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
 
+done:
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
 }
 
+static void nvme_rdma_flush_fencing_works(struct nvme_rdma_ctrl *ctrl)
+{
+	flush_work(&ctrl->fencing_work);
+	flush_delayed_work(&ctrl->fenced_work);
+}
+
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
-	flush_work(&ctrl->fencing_work);
+	nvme_rdma_flush_fencing_works(ctrl);
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -2226,7 +2258,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
 	int ret;
 
-	flush_work(&ctrl->fencing_work);
+	nvme_rdma_flush_fencing_works(ctrl);
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
@@ -2348,6 +2380,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_rdma_fenced_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 3853c9a6356e..7479cd370584 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -486,6 +486,7 @@ nvme_show_int_function(numa_node);
 nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
+nvme_show_int_function(cqt);
 
 static ssize_t nvme_sysfs_ciu_show(struct device *dev,
 					  struct device_attribute *attr,
@@ -966,6 +967,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_sqsize.attr,
 	&dev_attr_ciu.attr,
 	&dev_attr_cirn.attr,
+	&dev_attr_cqt.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a1711dd1d3c2..13e250110c1b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -162,6 +162,7 @@ struct nvme_tcp_ctrl {
 	struct nvme_ctrl	ctrl;
 
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -2501,6 +2502,18 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_tcp_fenced_work(struct work_struct *work)
+{
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
+					 struct nvme_tcp_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+
+	dev_info(ctrl->device, "Time-based recovery finished\n");
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
 static void nvme_tcp_fencing_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
@@ -2509,21 +2522,40 @@ static void nvme_tcp_fencing_work(struct work_struct *work)
 	unsigned long rem;
 
 	rem = nvme_fence_ctrl(ctrl);
-	if (rem)
-		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+	if (!rem)
+		goto done;
 
+	if (!ctrl->cqt) {
+		dev_info(ctrl->device,
+			 "CCR failed, CQT not supported, skip time-based recovery\n");
+		goto done;
+	}
+
+	dev_info(ctrl->device,
+		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
+		 jiffies_to_msecs(rem));
+	queue_delayed_work(nvme_wq, &tcp_ctrl->fenced_work, rem);
+	return;
+
+done:
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
 }
 
+static void nvme_tcp_flush_fencing_works(struct nvme_ctrl *ctrl)
+{
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
+	flush_delayed_work(&to_tcp_ctrl(ctrl)->fenced_work);
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
-	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
+	nvme_tcp_flush_fencing_works(ctrl);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
@@ -2566,7 +2598,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
-	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
+	nvme_tcp_flush_fencing_works(ctrl);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);
@@ -2956,6 +2988,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_tcp_fenced_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.54.0


