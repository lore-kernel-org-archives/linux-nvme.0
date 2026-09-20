Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1783AC982EE
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pt50IjaPgH08hi1k4e76/CT4Nc9n3avKxSKgQhL0Gzo=; b=HsQOhU1dX15q7qC8bH6LNxx6gZ
	k5+iFlEoSYUkoBELQqr2Vdi6Zd4yRD8/JKk4YQ4x7vCen/33qxQ16gm/5KjtzsXVAIkZbr1/+AqQ8
	B9OtHodDcs34ny+AQu2unSUK7lKOGHiWING6gOPZaiAMudUprJXc5cJPEhhgSP5RMz+qA+ZBZ+Shv
	/854bDTvcDDfNYY5RzC6xWRhGIg2ko+Hl1I4xvMejA44lVLpwHrs6f2R3HU/Pe3kNVlbxdwQdFMO8
	fgLl3nzGLhRYtESzOyIgcKWovr+059gT35AZ/EHkVRd09xkt5fZ/3P6Otu1BtwEJK8EIGQpADzku/
	qzPNsQyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ4-00000000Drk-316f;
	Sun, 20 Sep 2026 18:30:30 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ2-00000000DoU-1jMZ
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:29 +0000
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1875941a91.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929028; x=1790533828; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pt50IjaPgH08hi1k4e76/CT4Nc9n3avKxSKgQhL0Gzo=;
        b=POAysCkYxnugwASHcZNyJBJkZ0gw1jXEl0PR5sLbbF1AOXNmrzzmjxRE7vNr0PsEP9
         LghGizfLIwMFVyInark+0+NKGD0Y7BL8YgTGkLuLhdqILGADsPWOEac6KMI+JX9YiWkA
         nctn7QMEr9XAfuueo40o6sjKSdwZDx8faNEC1lxS+lt07d7W8xiD05nd79DTQ6moEYSs
         ADJe0+tgu7bU0PSjhC3z+BpZl1j3YOq4SnFn0L8w5iFTfXIpg1CVGcyWPrAlH02XpoKD
         goFcA6Q63EyyauMfjPV/bosb9NKJt2DhstCFmWyeCAbic5Azzzysm99iVYSZZwYf58kG
         JMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929028; x=1790533828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pt50IjaPgH08hi1k4e76/CT4Nc9n3avKxSKgQhL0Gzo=;
        b=UD4jmgTUTdzQNJNpYijSmeOTvzYwl1ymCu8c04voXCVyrPy0yrohzACJw/O9UoMpUY
         5PIioS82kcrJQzMfVm4ySBmaAzT2Br7x5AT56KXwG63YkvPKnSF967oAKP+0he8OGEFO
         LojgxkIMw/y3rlkDCOnEUFeV1ZXQSKyNUv3DybI12b/6vDXFdeDkTbbb8jxzv6RM9Y0Y
         Ot7BMlq3EbI4vvwZFW535GSFCgpyeCJX7HOUjLe0D8KZolqojcnV0CyRe3elx+ka/0uq
         HYF3bmi/oo63fL96PRWUgrqvPVoqeyo1YPyqA31MAZlfEdUwcr6cWDgSB3aFfTTlILxW
         p4vA==
X-Forwarded-Encrypted: i=1; AKwUvBy4UDIItgOtCALCmFTrJq+/SOYUHg6oxg6VXO8kW3DdBiO+EIltzNtLANONwiJHqEu2mV0AguqPhgoI@lists.infradead.org
X-Gm-Message-State: AFuF++kdI8cKA6F8RSuuWETS6BHL+k48LacUiDMkEmvNGJFIt1vcAieD
	H/980GWoWoLiuWboHdxPYF8si8mgvFspRw2hYmH4tW9MqtUooheArFbITdDYJceR9e8=
X-Gm-Gg: AYBFou2iE1tBUWs4/NnXUtgnbsnWU6v0ECR6s0P515fzKLgx4KfICt1JJXYNYJsIvAR
	aaUJPbYcujKDRcD1lSKQSeE3ZXfXkvjK30b5pRLea9ky7l6k9fbKdkqYvWGvIHzs1ombYTFsLrD
	N0luL1dm9XOUWo0HBHcVgulJItg7mHPItCjITrTgab3vZKrdA5aFoikK0aKtdBmjE/Omg6XBhSM
	3cmQEUsm1pZ9CwbOhkGQwRuewSU74RrQxZYy7bDIOfWd7WEYk2CvROKZ+g+3rZ/LvMTUW9XB6fw
	d6LGHgvbDdjnJs00Dkk6bxbKpCoL8CVrOb0Nz8ancLeZGYLEKDLCQ9mzvbreap3mFicungD6SSD
	ZR/JSxbv33kG4mAcN3zxy6SdXb3z0qof4/PAowftlvRSlhASODqKpM8fLFo5pQtEMDfatupZJOH
	cViXzk0e8us9hoBEP6LbbVnSHQCXLuLC9Dr0hkTXxLSBb/2pbkVuVK4zwt
X-Received: by 2002:a17:90a:2ca7:b0:39e:6a7f:eef1 with SMTP id 98e67ed59e1d1-39e6a7ff07emr6228368a91.22.1789929027333;
        Sun, 20 Sep 2026 11:30:27 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:26 -0700 (PDT)
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
Subject: [PATCH v6 08/18] nvme: Implement cross-controller reset recovery
Date: Sun, 20 Sep 2026 11:28:06 -0700
Message-ID: <20260920182936.2317916-9-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113028_464761_F07A9618 
X-CRM114-Status: GOOD (  24.52  )
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

A host that has more than one path connecting to an nvme subsystem
typically has an nvme controller associated with every path. This is
mostly applicable to nvmeof. If one path goes down, inflight IOs on that
path should not be retried immediately on another path because this
could lead to data corruption as described in TP4129. TP8028 defines
cross-controller reset mechanism that can be used by host to terminate
IOs on the failed path using one of the remaining healthy paths. Only
after IOs are terminated, or long enough time passes as defined by
TP4129, inflight IOs should be retried on another path. Implement core
cross-controller reset shared logic to be used by the transports.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/constants.c |   1 +
 drivers/nvme/host/core.c      | 152 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  10 +++
 3 files changed, 163 insertions(+)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index dc90df9e13a2..f679efd5110e 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -46,6 +46,7 @@ static const char * const nvme_admin_ops[] = {
 	[nvme_admin_virtual_mgmt] = "Virtual Management",
 	[nvme_admin_nvme_mi_send] = "NVMe Send MI",
 	[nvme_admin_nvme_mi_recv] = "NVMe Receive MI",
+	[nvme_admin_cross_ctrl_reset] = "Cross Controller Reset",
 	[nvme_admin_dbbuf] = "Doorbell Buffer Config",
 	[nvme_admin_format_nvm] = "Format NVM",
 	[nvme_admin_security_send] = "Security Send",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e4e18fb72159..c8e3129d84a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -576,6 +576,157 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
 
+static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
+					    u32 min_cntlid)
+{
+	struct nvme_subsystem *subsys = ictrl->subsys;
+	struct nvme_ctrl *ctrl, *sctrl = NULL;
+	unsigned long flags;
+	int ccr_used;
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->cntlid < min_cntlid)
+			continue;
+
+		spin_lock_irqsave(&ctrl->lock, flags);
+		if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+			spin_unlock_irqrestore(&ctrl->lock, flags);
+			continue;
+		}
+
+		ccr_used = atomic_inc_return(&ctrl->ccr_used);
+		if (ccr_used > ctrl->ccrl) {
+			atomic_dec(&ctrl->ccr_used);
+			spin_unlock_irqrestore(&ctrl->lock, flags);
+			continue;
+		}
+
+		/*
+		 * We got a good candidate source controller that is locked and
+		 * LIVE. However, no guarantee ctrl will not be deleted after
+		 * ctrl->lock is released. Get a ref of both ctrl and admin_q
+		 * so they do not disappear until we are done with them.
+		 */
+		WARN_ON_ONCE(!blk_get_queue(ctrl->admin_q));
+		nvme_get_ctrl(ctrl);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
+		sctrl = ctrl;
+		break;
+	}
+	mutex_unlock(&nvme_subsystems_lock);
+	return sctrl;
+}
+
+static void nvme_put_ctrl_ccr(struct nvme_ctrl *sctrl)
+{
+	atomic_dec(&sctrl->ccr_used);
+	blk_put_queue(sctrl->admin_q);
+	nvme_put_ctrl(sctrl);
+}
+
+static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl,
+			       unsigned long deadline)
+{
+	struct nvme_ccr_entry ccr = { };
+	union nvme_result res = { 0 };
+	struct nvme_command c = { };
+	unsigned long flags, now, tmo = 0;
+	bool completed = false;
+	int ret = 0;
+	u32 result;
+
+	init_completion(&ccr.complete);
+	ccr.ictrl = ictrl;
+
+	spin_lock_irqsave(&sctrl->lock, flags);
+	list_add_tail(&ccr.list, &sctrl->ccr_list);
+	spin_unlock_irqrestore(&sctrl->lock, flags);
+
+	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
+	c.ccr.ciu = ictrl->ciu;
+	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
+	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
+	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
+				     NULL, 0, NVME_QID_ANY, 0);
+	if (ret) {
+		ret = -EIO;
+		goto out;
+	}
+
+	result = le32_to_cpu(res.u32);
+	if (result & 0x01) /* Immediate Reset Successful */
+		goto out;
+
+	now = jiffies;
+	if (time_before(now, deadline))
+		tmo = min_t(unsigned long,
+			    secs_to_jiffies(ictrl->kato), deadline - now);
+
+	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	completed = true;
+
+out:
+	spin_lock_irqsave(&sctrl->lock, flags);
+	list_del(&ccr.list);
+	spin_unlock_irqrestore(&sctrl->lock, flags);
+	if (completed) {
+		if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
+			return 0;
+		return -EREMOTEIO;
+	}
+	return ret;
+}
+
+unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
+{
+	unsigned long now, deadline, timeout;
+	struct nvme_ctrl *sctrl;
+	u32 min_cntlid = 0;
+	int ret;
+
+	timeout = nvme_fence_timeout_ms(ictrl);
+	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
+
+	now = jiffies;
+	deadline = jiffies + msecs_to_jiffies(timeout);
+	while (time_before(now, deadline)) {
+		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
+		if (!sctrl) {
+			dev_dbg(ictrl->device,
+				"failed to find source controller\n");
+			return deadline - now;
+		}
+
+		ret = nvme_issue_wait_ccr(sctrl, ictrl, deadline);
+		if (!ret) {
+			dev_info(ictrl->device, "CCR succeeded using %s\n",
+				 dev_name(sctrl->device));
+			nvme_put_ctrl_ccr(sctrl);
+			return 0;
+		}
+
+		/*
+		 * CCR command or CCR operation failed on this path.
+		 * Try another path as long as we have time.
+		 */
+		dev_err(ictrl->device, "CCR failed using %s, ret = %d\n",
+			dev_name(sctrl->device), ret);
+		min_cntlid = sctrl->cntlid + 1;
+		nvme_put_ctrl_ccr(sctrl);
+		now = jiffies;
+	}
+
+	/* Fencing timed out call it done */
+	dev_info(ictrl->device, "fencing timeout\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_fence_ctrl);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -5254,6 +5405,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	xa_init(&ctrl->cels);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 84ea3f2728bd..8da75a15ac04 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -341,6 +341,13 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FROZEN		= 6,
 };
 
+struct nvme_ccr_entry {
+	struct list_head list;
+	struct completion complete;
+	struct nvme_ctrl *ictrl;
+	u8 ccrs;
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
@@ -358,6 +365,7 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
+	struct list_head ccr_list;
 	struct mutex namespaces_lock;
 	struct srcu_struct srcu;
 	struct device ctrl_device;
@@ -402,6 +410,7 @@ struct nvme_ctrl {
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	atomic_t ccr_used;
 	u8 ccrl;
 	u8 vwc;
 	u32 vs;
@@ -902,6 +911,7 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.55.0


