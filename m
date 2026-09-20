Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D18C982DA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xpEVTaDIEqTTyPgj4k8QhiOl8bbLm2x6tGVGdtqRrPM=; b=flVTo5vihdMJolbkxdM207nGrA
	Hg1Ahsu8VD17ig36XiCBCv+u07OHhDKE0rG5sowP98k5ZKFxtsnGzPnYRu/PQH1bqQYE1ZEGqxNQQ
	sA2ihnbB/KqnoptwQd4XiUE3NzH/GKCz82cuDtdMZZILQvV8UdGl1qzsqj9eas0vIpJ/gVmC3N1aN
	PWJfjoVVZDEaWxFdUdaMq3vX4x26h2HoB5FSPY/V9uHlwUzztiY+IfmxH1UpQOkSI3+fX3x7u1sX8
	CcynQBZgQwzj04jgIoNDI9G8IN1F8/gYSaWMZQh4T1VXI2pqHtENzPhJJUyrpm0KqRTJbsCnwD3mF
	2l2IYLIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJJ-00000000ECm-3pj0;
	Sun, 20 Sep 2026 18:30:45 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJH-00000000E7n-2YbL
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:44 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2db710396ffso24875195ad.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929043; x=1790533843; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpEVTaDIEqTTyPgj4k8QhiOl8bbLm2x6tGVGdtqRrPM=;
        b=ImrLnFHJ/ZhKH2vwXfKrgahJT4Vec/S8BYrJfHOBWG5aiuIdkmEAtJT+mYyeVf2mqo
         q9oF/B5VrUFfbmQzq6aqY13D51AHN4qdGCQbI93eTmCgNMzjj2vZVbz7I9op+b+MZctG
         UjMdXKWAEUpldLzGTAeo+ciwNqnqULxEN2W1Gq61ovmF7zrmAVthAW1POb/Z/Cen4ilc
         uTmktUPeH0Z6xFo6jNV+f7y8Au5CcFNZ/BbHYf/NpcsTqE3yRJMg5VLlcbdCtMjnWUdM
         MC73yb2MSIpvQ2VCTz2ZjO59NYdhCV69MyrjrnzHwTXx0vzPNfNbvTq0iHOZCi04bM9A
         qa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929043; x=1790533843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xpEVTaDIEqTTyPgj4k8QhiOl8bbLm2x6tGVGdtqRrPM=;
        b=I9wXP2y25Lg1znBVmUoU2QXXnoxirldSekrjWKDBeXCw2ZvWuSqKLxS1We/mY038Z/
         dh7Nab4fGPUFKUmCm4Efp3vvgnQUhqoYumlS/ilyeXvCVv5+3nAhVeHzdLHsttOmEtQH
         tj5mSXZEIheheV3rpf0JVXaD/lMubossj5q6pNAcE7Z8mWjtuDV/FT2U3EA80sOnwLcM
         gP2s6fg35YLJWRHwPMHc/9sy7ggqxv/KfKrEHhKCu7++IB+xGItcL0riRS5ObD78DSb3
         oPiBm9pscqQjdrewO051OLfGObZtMfyzgqji95wF622uSB+B+aX5/JIWZYXQHK4SV0Kz
         ed9w==
X-Forwarded-Encrypted: i=1; AKwUvBweYm3bGRVKXy54SQFZ+91wAoyMK4hHx2DB1z7qFNgGsyrNzFxtFxuU8KOzvBBQvXNjC6sUa+vdXv4o@lists.infradead.org
X-Gm-Message-State: AFuF++mTfynxZAcCrlREKdsuRNtQZzA0LgcyFwGA+7ZDWttPkC+LLtaX
	FQyTKx2sMZ6O8le3HQPnIG858sl6pbYlic/8EhfmlU+YQEZZ4UB+JukGFUPRYg7HvUY=
X-Gm-Gg: AYBFou04tdt3KppjnNnrZhneDiCtOEeDWBLn2jzFLqe3zrxDnVTkdD//v9aGbaydAz3
	h8kbFTFe7Dz05haJFR90jdmk/4JJ5xlErUvvGkkYovI99CDdtFwIxWWWl7OoGojEUftsq+yK+At
	f0cf66DmhnGK9IqPWIKIjKg9tGcW6JIskndmhmm4s50VQYrvB0RJVb1bzAd1d9/c8KhUkZQtIQk
	ubxrI2/NCebPzPE772b/Jfo5ff/lO2ZxR/DaDMHp+0a96uRz+kA81/7+ExzTdOiaTJPYV0Y6Ppx
	Qn8WEltVtVhOZtq+akeCHExQtGaj773MLR4VWOoWLsYxighSLxc2H50Djw8wiOH3QZbfMCMsmj0
	CS0lZrhhEtdXF32lD2CdyxnQiftsp3p/IGcAcjwOx+cGn52Q9PS2Agq6ojVJdpMPK2wfmK+3v7O
	ecJwFzzlrtUGW4LEhJOM2N1ylollt1SPDKYChDLgMz+THzTIw89+RjWuZK
X-Received: by 2002:a17:90b:5403:b0:39f:6c3d:d4ed with SMTP id 98e67ed59e1d1-39f6c3dd7eemr4747809a91.30.1789929042496;
        Sun, 20 Sep 2026 11:30:42 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:42 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/18] nvme: Add support for CQT to nvme host
Date: Sun, 20 Sep 2026 11:28:15 -0700
Message-ID: <20260920182936.2317916-18-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113043_660122_484E77D7 
X-CRM114-Status: GOOD (  19.55  )
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/fc.c    | 33 +++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h  |  5 +++--
 drivers/nvme/host/rdma.c  | 32 ++++++++++++++++++++++++++++++--
 drivers/nvme/host/sysfs.c |  2 ++
 drivers/nvme/host/tcp.c   | 32 ++++++++++++++++++++++++++++++--
 6 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5509b58b51db..dc44e3af5f14 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3844,6 +3844,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->ciu = id->ciu;
 	ctrl->cirn = le64_to_cpu(id->cirn);
 	ctrl->ccrl = id->ccrl;
+	ctrl->cqt = le16_to_cpu(id->cqt);
 
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a6e0fa2dc341..3db111accd0c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -167,6 +167,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	tag_set;
 
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -1882,6 +1883,19 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	return ret;
 }
 
+static void nvme_fc_fenced_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
+					struct nvme_fc_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+
+	dev_info(ctrl->device, "Time-based recovery finished\n");
+	nvme_fc_flush_held_requests(fc_ctrl);
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
 static void nvme_fc_fencing_work(struct work_struct *work)
 {
 	struct nvme_fc_ctrl *fc_ctrl =
@@ -1899,9 +1913,22 @@ static void nvme_fc_fencing_work(struct work_struct *work)
 		__nvme_fc_teardown_association(fc_ctrl);
 
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
+	queue_delayed_work(nvme_wq, &fc_ctrl->fenced_work, rem);
+	return;
+
+done:
 	nvme_fc_flush_held_requests(fc_ctrl);
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -2541,6 +2568,7 @@ static void
 nvme_fc_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	flush_work(&to_fc_ctrl(nctrl)->fencing_work);
+	flush_delayed_work(&to_fc_ctrl(nctrl)->fenced_work);
 }
 
 /*
@@ -3661,6 +3689,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_fc_fenced_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7096f1e4f84e..bcecaaf06f7e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -401,6 +401,7 @@ struct nvme_ctrl {
 	u32 max_zone_append;
 #endif
 	u16 crdt[3];
+	u16 cqt;
 	u16 oncs;
 	u8 dmrl;
 	u8 ciu;
@@ -1360,8 +1361,8 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
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
index 9c50421d79c4..8ff5aa312377 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -120,6 +120,7 @@ struct nvme_rdma_ctrl {
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -994,6 +995,7 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
 	flush_work(&ctrl->fencing_work);
+	flush_delayed_work(&ctrl->fenced_work);
 	flush_work(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 }
@@ -1155,6 +1157,18 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
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
@@ -1163,9 +1177,22 @@ static void nvme_rdma_fencing_work(struct work_struct *work)
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
@@ -2354,6 +2381,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_rdma_fenced_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 3a12b07149d2..e8dad4722347 100644
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
index febbe8954473..7b1d9e2cb00d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -168,6 +168,7 @@ struct nvme_tcp_ctrl {
 	struct nvme_ctrl	ctrl;
 
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -2565,6 +2566,18 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
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
@@ -2573,9 +2586,22 @@ static void nvme_tcp_fencing_work(struct work_struct *work)
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
@@ -2657,6 +2683,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
+	flush_delayed_work(&to_tcp_ctrl(ctrl)->fenced_work);
 	flush_work(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 }
@@ -3023,6 +3050,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_tcp_fenced_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.55.0


