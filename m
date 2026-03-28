Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452B110F3DC1
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q8007HwqSMobBfviM6haQwWqU81fF+x1NKc0cN+3Dhk=; b=S/IwRE+oChOHngdk97vHBUKmJE
	eZRn5tCfdkNh/4UMmkiFWRV3RPnvO/LFdJrvetrUc5/vehNaCM1sz3AGyyYoaKpF4boPQepqiNAau
	vUu21zriZRccOpG+uIPFZXPCg9Ym6HLaXOIV5+xri/+cvQY/s55zu1B6hRv04XB7CIzTjfk8CxWIX
	6fuqvbLPeoUFLc9VaJDjIE3V5bgGrRWO9FeD2b1PDC8TXxUXjrf4c7PawSeE7FEgHSuJgpM/dyjUC
	d/aLYCVP2xfPgieijNb1fItnv3auj8dvQsqh3ZSgfsToICmp2ugKuITYk+oA7u9TccbYlcXFHE/lc
	zUo0yZ3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoR-00000008Nwl-2YxQ;
	Sat, 28 Mar 2026 00:46:03 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoQ-00000008Nut-0jBA
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:03 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2b042533de1so15499315ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658761; x=1775263561; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8007HwqSMobBfviM6haQwWqU81fF+x1NKc0cN+3Dhk=;
        b=B3CXcMiugsjiBur98PV3tD3URDNXJw98SDrgivhGsu+dy585hN6HJW/kH9A20Rk1c7
         cNpjLghtiszlLNoPr39GkLhEMW92AtaEIFkW5Fd3MrTuEc2b9txv5rNZ6ztPcn6WdrDh
         xSVQSE1EcOj3028GfQcU6VlKaxQRyZrj+f8RJ9M7b+QBn+WeHXsKBX5SNljwywOfy4kI
         l5WVh1y/jkOrg+P7vES+I+h+8JcfMdbPljaaZjLHBHV1AN4F8BIdGyLYdsh0sFfAf6pN
         MwJOs/gqIYak/6B6tf8Vh3e0P76DABr8KH2BLyxayaxjUkK3w+eZ7miBXSumjSZ+pmzP
         yk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658761; x=1775263561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q8007HwqSMobBfviM6haQwWqU81fF+x1NKc0cN+3Dhk=;
        b=nluQ+nO3TDh0bjbQ5zbOpAkV0LOXETeEerJfCEe0HdSUq5zlfMq9G2W1i3SqUTvjze
         sDfbfbuipK9JIWnMB3duKMYmvrWGHC70joCzS499F2JrctuUEY52xF+yrBz/6ifwTNoI
         dTeHNO4DRhSsxbtxK5Jo6ZaXHD+FiOm6yfd8cy6TdJ8U/MRX9ubPsrk1hkeiF5CMxdwe
         1JwB5B76a1IOmTrpVMe49iaR4Fi+8isJzBWwrX6dFrnm6n8QgELXVz/9uzEc5qhnbNK7
         M1j1fzvLFbNbYzeVweLjBiDtKwnh+VfMYqsbAE08M0zF3FazxRDOR4AL5qYdnDfOc4lb
         GZzA==
X-Forwarded-Encrypted: i=1; AJvYcCWYyglsJHw+S0scznrJeBJ7+HDqNUB6UbkJje/8ChePRy6OnbbJIIfM5Z/RgF6psRJ9RzpUR4NwvqbU@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4ZRHDeLBjpPpJ6SKBLTlFZgFvKX9gCMWo1LFrCAA7/KPUWKuB
	de73d0TLa4VXO3fZX6CZxpSz8Ozm5W/1rb80cVGgbMOvaJjrfuHKry71L/s19MgUFHI=
X-Gm-Gg: ATEYQzzdoXJ4eG9AaSotq/v0Bj93Gj0KbFu8PA6zfaPYoyIEtu+dYm91ikzBC/txRUR
	emZ45Fe7FWwwormDfyiSe7SNjaRlkrhtWLiFU/6GQJGW+6vYlU1Pf7aCUGaEmiLLTs4ez51RLK/
	waZ1dR0BZlWxpwv81CsHcp7POsdeIe2IwMrC6Opn7RuzEMh3eP8P2ylblPHWzsWuZK//ckEmB1n
	dt4FADkklPYIrUag4thVKiElCaiX+I+QxWRLR9cmDh7DsEthAoEOuJO7g1xCdu0/sNFZ1oNuvWO
	/LIK4ldJPvegn9zM2NtBfqY8nv9nvTCIjkq+WNB3UPNUQbLX0vleb6i94RpHLVgpaKCL+WDCIoG
	9MoRMFC+Vw74UOWGF2KEcPyaUw6ZIzxYEGWAO9T3Vy8i+DHf4xjrLIWMoatn+M8m7imBUKXMTQ8
	FbC143B9w=
X-Received: by 2002:a17:902:da91:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b0cdc238f3mr49523395ad.7.1774658761285;
        Fri, 27 Mar 2026 17:46:01 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:46:00 -0700 (PDT)
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
Subject: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
Date: Fri, 27 Mar 2026 17:43:39 -0700
Message-ID: <20260328004518.1729186-9-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174602_224203_BA3555BA 
X-CRM114-Status: GOOD (  22.72  )
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
 drivers/nvme/host/core.c      | 145 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |   9 +++
 3 files changed, 155 insertions(+)

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
index 824a1193bec8..5603ae36444f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -554,6 +554,150 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
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
+int nvme_fence_ctrl(struct nvme_ctrl *ictrl)
+{
+	unsigned long deadline, timeout;
+	struct nvme_ctrl *sctrl;
+	u32 min_cntlid = 0;
+	int ret;
+
+	timeout = nvme_fence_timeout_ms(ictrl);
+	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
+
+	deadline = jiffies + msecs_to_jiffies(timeout);
+	while (time_is_after_jiffies(deadline)) {
+		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
+		if (!sctrl) {
+			dev_dbg(ictrl->device,
+				"failed to find source controller\n");
+			return -EIO;
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
+		min_cntlid = sctrl->cntlid + 1;
+		nvme_put_ctrl_ccr(sctrl);
+
+		if (ret == -EIO) /* CCR command failed */
+			continue;
+
+		/* CCR operation failed or timed out */
+		return ret;
+	}
+
+	dev_info(ictrl->device, "CCR operation timeout\n");
+	return -ETIMEDOUT;
+}
+EXPORT_SYMBOL_GPL(nvme_fence_ctrl);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -5116,6 +5260,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	xa_init(&ctrl->cels);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 45e58434cf30..f2bcff9ccd25 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -333,6 +333,13 @@ enum nvme_ctrl_flags {
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
@@ -350,6 +357,7 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
+	struct list_head ccr_list;
 	struct mutex namespaces_lock;
 	struct srcu_struct srcu;
 	struct device ctrl_device;
@@ -868,6 +876,7 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+int nvme_fence_ctrl(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.52.0


