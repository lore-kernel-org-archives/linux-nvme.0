Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A459E6BF3C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UYqxizsivYL+kINzdcPOhMPZJZrAVTcG/K2aY25NvUc=; b=iT6prnn27Sj60BAfwaYCg7yHBy
	tIxVCse/pvh9Ojcd06nn7zoajVkjnc0fhV74TxYZ0DXhI7PhcQ60q1uc4qB6XfRpiIeAjmBKGdII6
	iyhkt02SJHqvl/vT0/19KfHWRW+mjE54sf/Y0GMA55X8CUAxmKbmH/Ps82rU8llFEQSzliJvHfsK0
	ZffD3VW9a12esi67F3YulGXwn79YtaixAHhRHxEbP1/S+ynZmqkkhX5tS6xTr9ABoahZV+jh2YLH+
	611eQ/iVeeJVCoGWgctLCTxgMN72JAe+iBEbYu74D7W13GaNYo0ZrhE2tHM9eekm37BQy/3oD/Tq5
	8agh4Wnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6Q-000000022ph-1HOe;
	Fri, 30 Jan 2026 22:36:34 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6O-000000022kr-0RDJ
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:33 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1233c155a42so4518904c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812591; x=1770417391; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYqxizsivYL+kINzdcPOhMPZJZrAVTcG/K2aY25NvUc=;
        b=C73N/HJN83oEmQoaFB9/3Zr5kwqzVkfky3MbE2dzXFiki6VuMaFRIklWoq2ohxdDOL
         lOO7v459BqKI8wSpXpopXVgm4X/tikV8zvBVmOdDBGITGpwSJl7gTlJK1Mn7JWOsvCF6
         mlBHfSBPaEU4MvuMnvOV2+x6On72nxa4b07ew13tWEzlt028lHtA6Ev9CNyc3Umva8fz
         CLjjCpEknlStWtcrhKpyorkZ1OfQMuOETW09IVZXnylNSB+buL15T3a68fIiid89HbZQ
         auU3Y7V/A1LYxOcZx7hbx894PLI5cVB0j+O5RPG3+xgSnDhl/4cXFjsjC1AQJqKIPJZs
         szJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812591; x=1770417391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYqxizsivYL+kINzdcPOhMPZJZrAVTcG/K2aY25NvUc=;
        b=Oz31iFO5AVp01WBGkCP0lHCREll+qms9Td9/vtL0LWitGXHhVRGYAqHcJOVRwNRAKr
         rxXk+wLNJTQlaLFg+DWESDAQxicgyA4Z51rH3mEDKdqHWWA902H6XlE5WIyjGSX2HrQc
         EYBVJdenJN/6yD3Ekq01jfBI5FpV7pns5GYEPmj5gi7glk/5cKMc01colK6SDxzHwzi2
         1rCZG97DAP4F3B99fm2gyhqdcfnaZ8Wzn+ioRgLzO+XZJWs59cxQXjmIG50LT7MCw9ef
         FY4PhOqu2e6hfrRqinisgO5rVdXPMThFD2X+smdDCwzJrHp+4/bs7nv9tCvSpyY6Rk1s
         S7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1y4nq7iTka1YIOc/5BP9q+GeFgxfKDC1ETFm+2TyA59oMVJUShXc9eBQOiXB0cxTvHsIp5nzv+zi@lists.infradead.org
X-Gm-Message-State: AOJu0YwctBhuHz7Psp/1XuxIZYutsvHJLLxvFfZmtAQuTq2UzCTMS7As
	EWhoRA0GRrjXtGHiJlLLBj4N7t1hMZqwu564PrThI35q6tVL1YcMCPvrydrk8WNEnKM=
X-Gm-Gg: AZuq6aK7PVmtq9Q6XEsFrRJigW80wmIYl85+MVqp3t7Clu0AfWD7VbTiMSPysKk5PGg
	MxSzHZ5y/ad2dMe779kVKCMnTMcKsX5YoZ58WnKLe5bRfu+NbE+I4ckfMKD/hDSaOKqJp6f3Xec
	gUgvNcwy8XSmYyfWr/P25ow68p9/2KxOq0VUIvoAVgYlPv/MUjt+dlS4nGwrYB9XhM0gNLCWYPs
	25FoG/zlO7nFanqdTecEKT4AxXbWUJZ6+ujq3caUiH+nF71VXYgwwNk8LroUmFXF9Y2axLUOg2v
	jyi5bv5R4cgIEGKgsMO2EZYJHLRv0XzDX+WUCa2DGaHOFD+vzvYtS0PEEEMxoAVYIYsm8I17bup
	hYl4JjBZ5LVCILYZ8GElJsKrBDTWca3jSNeMDrLn5dXlBh8gbF+4rf6PahLa6mMDTkb6yEZazYm
	m4ijh4OgYlHePcKGcclWe9Y7+DZr0/3bpC2g==
X-Received: by 2002:a05:7022:226:b0:122:a2:ffcd with SMTP id a92af1059eb24-125c0feb1f8mr2186268c88.23.1769812591032;
        Fri, 30 Jan 2026 14:36:31 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:30 -0800 (PST)
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
Subject: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
Date: Fri, 30 Jan 2026 14:34:12 -0800
Message-ID: <20260130223531.2478849-9-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143632_165846_8698A867 
X-CRM114-Status: GOOD (  23.34  )
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
 drivers/nvme/host/core.c      | 129 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |   9 +++
 3 files changed, 139 insertions(+)

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
index 3e1e02822dd4..13e0775d56b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -554,6 +554,134 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
 
+static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
+					    u32 min_cntlid)
+{
+	struct nvme_subsystem *subsys = ictrl->subsys;
+	struct nvme_ctrl *sctrl;
+	unsigned long flags;
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
+		if (sctrl->cntlid < min_cntlid)
+			continue;
+
+		if (atomic_dec_if_positive(&sctrl->ccr_limit) < 0)
+			continue;
+
+		spin_lock_irqsave(&sctrl->lock, flags);
+		if (sctrl->state != NVME_CTRL_LIVE) {
+			spin_unlock_irqrestore(&sctrl->lock, flags);
+			atomic_inc(&sctrl->ccr_limit);
+			continue;
+		}
+
+		/*
+		 * We got a good candidate source controller that is locked and
+		 * LIVE. However, no guarantee sctrl will not be deleted after
+		 * sctrl->lock is released. Get a ref of both sctrl and admin_q
+		 * so they do not disappear until we are done with them.
+		 */
+		WARN_ON_ONCE(!blk_get_queue(sctrl->admin_q));
+		nvme_get_ctrl(sctrl);
+		spin_unlock_irqrestore(&sctrl->lock, flags);
+		goto found;
+	}
+	sctrl = NULL;
+found:
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
+	if (ret)
+		goto out;
+
+	result = le32_to_cpu(res.u32);
+	if (result & 0x01) /* Immediate Reset Successful */
+		goto out;
+
+	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
+	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (ccr.ccrs != NVME_CCR_STATUS_SUCCESS)
+		ret = -EREMOTEIO;
+out:
+	spin_lock_irqsave(&sctrl->lock, flags);
+	list_del(&ccr.list);
+	spin_unlock_irqrestore(&sctrl->lock, flags);
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
+		/* CCR failed, try another path */
+		min_cntlid = sctrl->cntlid + 1;
+		nvme_put_ctrl_ccr(sctrl);
+		now = jiffies;
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
@@ -5119,6 +5247,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	xa_init(&ctrl->cels);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 00866bbc66f3..fa18f580d76a 100644
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
@@ -814,6 +822,7 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.52.0


