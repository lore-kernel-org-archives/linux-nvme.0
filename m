Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE303EDF142
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zCK7MkIJ9W8S4oRts15YT/FeKYBXhBdPnkffI4uC3PQ=; b=HqTLAKsK9XghS8I/hAiGyBtK+2
	azRIrbB+j2WwfkCN27uNr6rQsBZJEM3eqG0XXFq7kcd6TQ1pH/pu6AgyY4HlIxsyrr2xFr/jlugDb
	acH2EM/+tvM5gpi2s9O93P6FcXYSXlcNutvhAKrtor1ppWSjQunQkOIFFYhkrs9XnHwhoJNTojVaS
	1SRa6Kt/8Mie3/4eVeCBnUmS427cwGV2YVIoYa0c3XoNGnJzQN6TfWv0cXl17WUP47uzZ0l41Wpc1
	Zn6tsThif6qCSBBfaUQ688EjqtO5QtyvDDfeYB65NIPqh9njM3J9R+p1/FyZx49ywKt0vKl/E1/pt
	j3Lz/0yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gi-00000004F4B-0Vyy;
	Sat, 14 Feb 2026 04:28:32 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Ge-00000004Eyi-2pRd
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:29 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1273349c56bso2148202c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043308; x=1771648108; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCK7MkIJ9W8S4oRts15YT/FeKYBXhBdPnkffI4uC3PQ=;
        b=FwEOdhFOY01iFua0v9e5YWXE4GRvWU3DkOJxIfz/Dlts1Ausp8BReVWy9Z08iUvR1G
         K+pEdMp3i9bNuMw5qlG49Ofmfkw+MRh45JihmjY9os/62uQt9uvCaRlVssaVHNvas/aU
         s0z9TGrAqn9BRn5dGEiuIxEifEbhoWCCgywvGiZuSGMs0PrGAUKZJQYtX/WNjQiEoPCm
         N8XUxBe1eFpi8L4u+KLxd+tbrPnrJNXNmPCKipdwg4avK6DbkCuD/Bw2D7aRIoJeDzEW
         XfV7R5//2EbonBLIOKyaYlnMOW4mz/LpVeNouWtgQ6wZlOWI2ux3+FPdyLcKWIvDn2jW
         fgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043308; x=1771648108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCK7MkIJ9W8S4oRts15YT/FeKYBXhBdPnkffI4uC3PQ=;
        b=D3QBfwJZzCnqEXet/uaSWzAxBjBddmXQMoyDR+liCSeazQevIdbl9z/cQUR9HJRgvx
         Obp21i/62BT3jY6DsqmzMnZ0IQtJcLazzayIjnCvjJa21gJlkTOpubUQdBT0XgPbYzX1
         4p+Rw4JZ/7bvTcIVtuokCJiBa4jsIqtuZ7cb0w2+IjBt3VWRZ5kHT/kYwPIIa+2V9C4u
         D06slde3zA18FOAd5yjsPCaOTPyq5H3PN62SI7YRT0T/9JAU52jneMOnwBFA7uJI5TaY
         5Mw9J6DRDoaEsgMX+kx41eUqBdXq95RT7lyGg/Gdhj329ll83pWmU5No37VSbSrv3R5h
         zf3A==
X-Forwarded-Encrypted: i=1; AJvYcCVQFFSuPUTSijosC23229trJ4ggiXfxI7Mz9nTQdVBl+SnfSf/8JQLwW+W+bvEwUKDEkkODzjsoZqz+@lists.infradead.org
X-Gm-Message-State: AOJu0YwR3q4TLUlDdBSi3p22mKVN6iW+8kph5h4XbDIQjcYczGubhLYM
	tvWHF0c57lXKTibDISSNyMR7H210+gNsiWhgOgYbJjc4Sg/77o6VsvexkVkgk04YMKg=
X-Gm-Gg: AZuq6aK3QK7FFoLVbvlWrNpdCAK44JayDKWOWQp7C+EUZmwEnoR3/fOsczuqUPOFF6e
	jb/ZHwveOc9cjEb7wxaI6gbUIpvMFuOpm6LUIrrc/g1s1VZk0xvc0RrhrMbkDQ/2sEeEvUyiMU+
	kUA3X4ZDe5B55O8wkrrBQ0o06x9CXerp7WAEsJRQDDcFrOI/VOYY6GfRVS8p9T1/2mQiZ+X02UT
	oiuIGZhBSVBg2UC+9BPTxkHoSY7YFL4anLUEakV2GLWDDQYsFNsXpJlSvjnJJ3e9FGEXiO9CZzt
	bab+HfBySEdts/fNkLcl8cn26XTPrRaXz0VFcmVX9YqfYbNRh0INy7mY1oKp1IBjquuY2/rAbrk
	jqLh5YdwYGPbU7A4ghSQuMnoa3/ymoovSF9/x8Srm0eN8GGO/g6yom1oPF1esMJ3MyFqmHKdqRb
	WGVHZiwxFhxYg3b0ofCbjmgoNNATQMcmfOeqKvhdHuX+m+/6RFme830UeM
X-Received: by 2002:a05:7022:6ba9:b0:127:3863:6440 with SMTP id a92af1059eb24-12741c02ba9mr605463c88.47.1771043307739;
        Fri, 13 Feb 2026 20:28:27 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:27 -0800 (PST)
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
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 08/21] nvme: Implement cross-controller reset recovery
Date: Fri, 13 Feb 2026 20:25:09 -0800
Message-ID: <20260214042753.4073668-9-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202828_740913_8EDCADCB 
X-CRM114-Status: GOOD (  23.12  )
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
---
 drivers/nvme/host/constants.c |   1 +
 drivers/nvme/host/core.c      | 141 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |   9 +++
 3 files changed, 151 insertions(+)

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
index 231d402e9bfb..765b1524b3ed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -554,6 +554,146 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
 
+static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
+					    u32 min_cntlid)
+{
+	struct nvme_subsystem *subsys = ictrl->subsys;
+	struct nvme_ctrl *ctrl, *sctrl = NULL;
+	unsigned long flags;
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->cntlid < min_cntlid)
+			continue;
+
+		if (atomic_dec_if_positive(&ctrl->ccr_limit) < 0)
+			continue;
+
+		spin_lock_irqsave(&ctrl->lock, flags);
+		if (ctrl->state != NVME_CTRL_LIVE) {
+			spin_unlock_irqrestore(&ctrl->lock, flags);
+			atomic_inc(&ctrl->ccr_limit);
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
+	atomic_inc(&sctrl->ccr_limit);
+	blk_put_queue(sctrl->admin_q);
+	nvme_put_ctrl(sctrl);
+}
+
+static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
+{
+	struct nvme_ccr_entry ccr = { };
+	union nvme_result res = { 0 };
+	struct nvme_command c = { };
+	unsigned long flags, tmo;
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
+	tmo = secs_to_jiffies(ictrl->kato);
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
+	unsigned long deadline, now, timeout;
+	struct nvme_ctrl *sctrl;
+	u32 min_cntlid = 0;
+	int ret;
+
+	timeout = nvme_fence_timeout_ms(ictrl);
+	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
+
+	now = jiffies;
+	deadline = now + msecs_to_jiffies(timeout);
+	while (time_before(now, deadline)) {
+		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
+		if (!sctrl) {
+			/* CCR failed, switch to time-based recovery */
+			return deadline - now;
+		}
+
+		ret = nvme_issue_wait_ccr(sctrl, ictrl);
+		if (!ret) {
+			dev_info(ictrl->device, "CCR succeeded using %s\n",
+				 dev_name(sctrl->device));
+			nvme_put_ctrl_ccr(sctrl);
+			return 0;
+		}
+
+		min_cntlid = sctrl->cntlid + 1;
+		nvme_put_ctrl_ccr(sctrl);
+		now = jiffies;
+
+		if (ret == -EIO) /* CCR command failed */
+			continue;
+
+		/* CCR operation failed or timed out */
+		return time_before(now, deadline) ? deadline - now : 0;
+	}
+
+	dev_info(ictrl->device, "CCR reached timeout, call it done\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_fence_ctrl);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -5121,6 +5261,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	xa_init(&ctrl->cels);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b1c37eb3379e..f3ab9411cac5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -279,6 +279,13 @@ enum nvme_ctrl_flags {
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
@@ -296,6 +303,7 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
+	struct list_head ccr_list;
 	struct mutex namespaces_lock;
 	struct srcu_struct srcu;
 	struct device ctrl_device;
@@ -813,6 +821,7 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.52.0


