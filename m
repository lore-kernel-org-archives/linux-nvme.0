Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0073C982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xpEVTaDIEqTTyPgj4k8QhiOl8bbLm2x6tGVGdtqRrPM=; b=BP1h76jp84GZAV2fe3c6IDyXSZ
	begweId0Qbsi4v2XkV2VW7mn3jqFzXpWhc9ZwGjs4gd0LOrE8wjm0S3fvTsywn6zUeRs+zwluU8GA
	lDW2qN88K6lhgOhUzt9P8i5moDbaS7sICl8jwsnpnvCVpPwbpmZYCevcm5bTMHfRwpx9t53HmKqVT
	tvw4iSuGnKrySaPdpIGxA1NhRMpXlNbZfVu77ezu7wCjjh2qQmZbmkcyiphEMWYaRRJ+3suG0PTYU
	C22yddWqA5tvKp5d6PvMgjLfE9+yrnZOjtkVDl6TY37XRdPC8WXURtCeWKDjslxA7l2SmjUlBXrDl
	+/c20r1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9F-0000000FHS7-42RT;
	Fri, 18 Sep 2026 18:17:21 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9C-0000000FHJp-2qKe
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:20 +0000
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-398beb616f5so423943a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755438; x=1790360238; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpEVTaDIEqTTyPgj4k8QhiOl8bbLm2x6tGVGdtqRrPM=;
        b=Cz7194JE5gpVnJyx8ZN1AcX3UU3xJLYZMDiYikIAoo7wtLJUjN9PU38+NJLUJejlLg
         Ckayn/4Kus7amDvGyt5bkhTGbXX7q9uSn+246RV8N0HGCTxa0ag2d/3XvMY55q9Evwga
         KjaVhBy4DoJd+37mLsLctyVBTEDf4qqLXvjJfnTNMGIxHMqDl0gqcY9UdG8mUPAQL4h5
         chIQrC2m0QqQXE9XHx+TRJzQE92lIFbrP9b+1MWKjDP7hx3uQ9jC+QWc1VNajOh1B7mz
         lS2WBaEWCgfhZ7zdIySYMlJCPgEyBzozNaVXwB9cylYq1yAR9S0dZD8jDMfCoSc9wLQ8
         24qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755438; x=1790360238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xpEVTaDIEqTTyPgj4k8QhiOl8bbLm2x6tGVGdtqRrPM=;
        b=cxwOgc/REbBLHezp6BXteMfK0GtkHFxKfqm6x9WFKijMaMji8K6MwGJIPBltSErQRq
         c2W01d02gVn+a1IlMNsL7fr7TR1JkRwYePVJ7T98a6GkgKejmSvmZQcc9c987/LrCJMY
         Rd+U346drsTN+XgqCCw7LZliY66m7fJ33cB9ByXZzeDlZDCY9VLLX4bmzIJ1mq3AZcx2
         Z6koUXD1wn3f1w2EksmNr1ecRiXyGFWvcC7vzA1cufwYTWE7+IsTYQ4x/FfEIkp714VG
         d3yRzC/YjThTpKh6rx5FcQnmQV0HBpJoWUTBALY3Re5gMDaBySXj/OQZ5CXrYQ0n4TTJ
         mzDw==
X-Forwarded-Encrypted: i=1; AKwUvBxMaBVrojllJSI2KYCHmRGgwCYFzkw3izunp1V+f3ZyCYfNSrZxtnMW86pF3ur1Sfl6i1MsKkFMumMH@lists.infradead.org
X-Gm-Message-State: AFuF++logYCtejzjGXaFc3tvLDqIED6iDh2hv3p+NqQMPHa+S2Mvm12Z
	oG2jJCsYNGKL+6Z7Yhscj8zZSqspoCMFaY9Yn0w+70MoLB8BJhQjHOBX9jK1hkk0wfI=
X-Gm-Gg: AYBFou3JfAqJmXofGFUNS8DBJs7esYSx32B9qdBsXwI5ewWxb2dp2XzLV9EuC6WQ+S9
	oSsiL5xC2R1faNr8aYExNK5upxCVP/Z92B+E9UL9ZVjZtZ/dt8mqUvqaoR46K72Skw2ZHzhwRHs
	4TLjNwcE6r+CA55AQm17Ru/5LtQMXwRntqCIuem6EH9NMvwWSG/w5+a2VCH7XdHFNf3nlKxnjLQ
	LtYWhn1yYBiLRoN5t4A9xYJEr1/BEvvNQJSYpTR6yvuHRxK8Iz1LtFb0J7ypNLges7Xv5ovC+tn
	kdp4st6T1dPi+8Cse8lFBM4UFcRsL9gcA7FzpQxJeqxxDjVrgFkCqfb2osaPtWG8m0ADpKs98FG
	VFpUU+ABd+ddncASpkpHDPgM1ARtflCXmHAO/ZohTPufgmwMngj1gw2QeoH6q9cnakyFkHs+piN
	zIWTwV8yBi7twUUjVBJNC7891dikF7OqgpWpRp3KQl2kFaGr5O3Rw3CDRc5uJa4NvcjBdItn8bD
	+2WlpOhmkdyRiS309cKls3VqA7R338w
X-Received: by 2002:a17:90b:38c8:b0:39e:6a7f:6187 with SMTP id 98e67ed59e1d1-39e6a7f6404mr766298a91.24.1789755437763;
        Fri, 18 Sep 2026 11:17:17 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:17 -0700 (PDT)
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
Subject: [PATCH 17/18] nvme: Add support for CQT to nvme host
Date: Fri, 18 Sep 2026 11:14:17 -0700
Message-ID: <20260918181614.3947933-18-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111718_790883_C342CDC8 
X-CRM114-Status: GOOD (  19.77  )
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


