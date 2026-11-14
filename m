Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37238606A8BE
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=STEnhUL7;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=QfTW6R5i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7LHt1YY/w84/xvL9CnbL7Z5Lkjghg3PipRVormCwSLk=; b=STEnhUL7GzD4dp
	1SGbaqVW6Qv1a+ZHB27AaiVONzML9KSBiN8i4nZRw2VIZr0DGawOmMI62uy+lAQf5SsWr/MlBHVGC
	qX8GNYsehvldZ0sz0tXo347eGqkFk2J4HHcyE8J1j6coEcp1DJgeATu+fc4Rrm7t8utblR9SRsrab
	Pcf6RvfnHJ4IP4FpUA2zBJcKgWY4UzheGQpEF6QXuR8abtkcxSya6K0+nHSdmrTv8cB7sA4g7EkUN
	IAD6KvQdurjXhKfeg89+83OgKdbQ4nvwcabZVL+jakPaqATqhXxI5dnnonVa3/AXHVZFG63Q1hFp9
	lANhtpP3EeV+oBc5RDLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45i-0000000FABK-1nyV;
	Sat, 14 Nov 2026 03:06:10 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45W-0000000F9rK-318w
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:06:01 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1a2761c69fbso1079165c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625558; x=1795230358; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LHt1YY/w84/xvL9CnbL7Z5Lkjghg3PipRVormCwSLk=;
        b=QfTW6R5i0/5FLIuA9xrpAZsugqfx7eonpw1ZJX791SqRkch3mAPXR4/+SWvzzcEM/U
         MCeTj2ZpLl5XsH/n1ofqIKFonrUDFFoH1X7fyi5WawyeJeDIn98PVn7W3hF2RNaM6Py7
         3Ui6shR1lWXiAa6zNddQ5UPXqvhKVqDBzGVof+YK5b6/nBGRBD43O27UmX2uM5XThIu3
         XcWm2whlwoeo1yajRFnySbl8AC0TuoC9mgo3IxmYaApCm1mN8oX/2zjRbKCk319HUFpV
         gWS5aNYIm/TTdC9TG+FdeQcyEKQ1W34OZIZylmYoWSQIqS0BxUyDelXCwTtSYuqcXpgg
         Af7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625558; x=1795230358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7LHt1YY/w84/xvL9CnbL7Z5Lkjghg3PipRVormCwSLk=;
        b=MjJ31zMcEYFU4SoX1fJRReXqQgWrongaDvswW0U5uHhBTAIZtdaZwmjpRURsuRdrwI
         Cpj342/C6Iere+5ef69rjVxATUaFMiRWF7erUPzXqXLdK/TOlbXNzeU6eJa/pwVkIfqP
         zQsqvAXuz2FBKf8NsTUJ2ioB6PD6LFn+KDp6Ykl5z/PZ/Et3uCe3JF1ov2073fv+VEwl
         9KCPCAVW8CKpJDqWAWRVjvz0u/xdsTUdz9ZISdWlN+jnzr+aaprNC0xQLz894jyRog4z
         y4GF8jOQxVbvAQ3JaiKTatRzIZSKPOez4T7acmI5LVdPMIjLURQFoBhz8lu3ZpZCXLkp
         7wtA==
X-Forwarded-Encrypted: i=1; AL+hErFESgnLPXzVPje3HUwgZZquGKvVaFqQowu57JeoatEzYYgI9IB32+oUmMkA+Dksq7wZETQNwvthTMX4@lists.infradead.org
X-Gm-Message-State: APuU4Z+1oIolb3tiLr5AGEl3sT2xvktWqqiBsX2Y8MIkC9m+HhmfqDUy
	Ao19nBOtTNpZfpRxhWaBax56gxJwAllxyw4gxVFniSbbAA98ut5PhwA8DaKoPf6vt4Q=
X-Gm-Gg: AYBFou2nuQKTCDRQJ0Zj9ythqzuoTKL8U33dG7EYAGoxBToe5J/Xy+s35D7rG8RCVGl
	4mlD8vWmIXhGN6KlIx4sF/453ZUZJjc7iCx78QThUZlqOjN3myVStIlr1fUI8EA6+NusFkjZIM7
	Pmu8uY3WaN7dthYfuN/z2dVQlz/X7E7Zo9NryehsLEV17wgZx/59DXBMA5+c4riBC2DbPqLHGzy
	BZW/9UsLoOTn9bYbZK9ROMrOHaEiUXn5zDPapeskhPymJX2OfiLVO/9Fh5L7WdsaDrCSAK/d7h4
	RIfZDrAEPLJ5HbCcUX8ZdaB0XitkcAlojHzEuET6xhWumZ1ebiOKCnTHUhd7Z0jF4epWC2yY5+3
	R15VcyCHNjQzpHfdtQofTePcqfAjCMmhpf5kCYVmlfZ3hx4wbZ4NYf4/uZ0hreSsG/T9kgE4vgj
	+CrBssDrMQn6rbg/UwWBL0Pk41VPOgQFviWi27mJZjNgpGUte3n/PpwvWX0URnk32sbLtU68dY+
	gtmZ9ceehBggxQqRxdjhXC5eDJpYnBYWf3f4bvhIDBiYe8SB0DLeC6RpOXFbLgl3nhbSNBrPAf9
	XvFY6veGH8iyBwX06JgWzFyZP8vKw+4ioZZsp5DkcLH6So4NJHAh
X-Received: by 2002:a05:701b:4648:b0:19b:1202:77f8 with SMTP id a92af1059eb24-1b503192303mr4228556c88.32.1794625557274;
        Fri, 13 Nov 2026 19:05:57 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:56 -0800 (PST)
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
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/17] nvme: Implement cross-controller reset recovery
Date: Fri, 13 Nov 2026 19:04:22 -0800
Message-ID: <20261114030454.2836543-9-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190559_084729_C3FA5146 
X-CRM114-Status: GOOD (  25.85  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

nvme_fence_ctrl() picks a LIVE controller in the same subsystem that
has CCR capacity left, sends CCR for the impacted controller and waits
for the completion AEN. If CCR fails, it tries the next controller
until the fence timeout expires. It returns 0 on success and the time
left otherwise, which the caller can spend on time-based recovery.

Add nvme_fence_timeout_ms(), which bounds the time spent fencing a
controller. It is derived from the keep-alive timeout: 2 * KATO, or
3 * KATO if traffic based keep-alive is enabled.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/constants.c |   1 +
 drivers/nvme/host/core.c      | 152 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  17 ++++
 3 files changed, 170 insertions(+)

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
index 4be3ce2e72a7..27c33dc49175 100644
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
@@ -5277,6 +5428,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cb9fca419935..261955538efe 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -349,6 +349,13 @@ enum nvme_ctrl_flags {
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
@@ -366,6 +373,7 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
+	struct list_head ccr_list;
 	struct mutex namespaces_lock;
 	struct srcu_struct srcu;
 	struct device ctrl_device;
@@ -410,6 +418,7 @@ struct nvme_ctrl {
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	atomic_t ccr_used;
 	u8 ccrl;
 	u8 vwc;
 	u32 vs;
@@ -912,6 +921,7 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
@@ -1359,4 +1369,11 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline unsigned long nvme_fence_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000;
+	return 2 * ctrl->kato * 1000;
+}
+
 #endif /* _NVME_H */
-- 
2.56.0


