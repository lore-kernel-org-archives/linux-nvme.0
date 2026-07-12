Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306DAC43458
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVbEu2+Mr7kV1EL18RxKM6hBIrgT5eJTpURd1PTGGYY=; b=Wit9lTN7F5fo2ptMPEDvfm3dCw
	gX4xCzFp98PhLnbpyUzWn91oTK6LrbpjEaCnrvNdeoU2iV4JSkMxbzJDlZVCLN9Cv/HugPGMaEu6J
	ZMx/u8wHQooqS1sDwIHlHEcKypVrU2EbxDDH+KKK4racKoPwXilASz1FM6Vdl4dWi/T9LhFX5AytL
	OPp2DUqh1iM8dsa+XlmE/PTnbSjP280oc1zwtGoNZqbQT1P2RG4pBMz1YimivNh3jWTolz4yimyoJ
	z6Z51Mh3GDfEfhHgGNDHcoXmDqD49nhYE2ZiEa7BZqY8vqNlfNYDloD9LZlp9ed4myV7EPCe3NgYE
	8ug1gINA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijss-000000071Xy-37mb;
	Sun, 12 Jul 2026 02:25:34 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsp-000000071TY-39fC
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:32 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so1430288a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823131; x=1784427931; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVbEu2+Mr7kV1EL18RxKM6hBIrgT5eJTpURd1PTGGYY=;
        b=TkZaCTnQ8+6gLcyA5SXFmamkiluCr1PXJt/SReg4nalJfcPsHjAKqZUkFoH4J+jvTp
         IxQy0uBs1ztyBT2fTzcLHRE5btW+ig0PJothpB5cXT159PL0XulcS0azxY9s3x4fSI0i
         TAZLO91jXU/wx53+syQt9ISaaNcbsYyQi1rQnP9rIm020xgowRweYSuUEmRT6qWkfI5t
         ra7VbYjx6lRN/o5rsSQBvDEdZehV4icLn0awjJwQvtsU3Dew94grucPIdwLLkwPyaoFr
         oD7Hy7Qm0fbqERw8cF1DdgoTOCB/P0Kza10TIPotzHf5+I5UB5rKpJwG5vgdwkbMVPHj
         6rTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823131; x=1784427931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVbEu2+Mr7kV1EL18RxKM6hBIrgT5eJTpURd1PTGGYY=;
        b=Vn6v27rk1f+QT+TIABB3aOrAERdwoLDHATRcDdk5FDS8pZXUWbxYl2fKRwZ7t19YKh
         DfCOllXk2XD9+DtVyOLYuvGBM5f5vLDxW4FycKpzvliC4OxQANAdGlVI53A8Nvf35bu/
         920QOsniS6q75qpeuS1hCsVykom2xMZV6Ls/S8Jt6pYtXb/FatbTgZViqBODjgnzlCmt
         w4e9Ni3WtHCN1zE7jmFTNu58QjcQ6XLIDieZbba/uPcfapU51Py6m/e2gQWKMze356/7
         5FdKbNnz6EXb+6fpbA5zqml8hNPVWwatXpGl9fGeSssdt0PwBjD/35+7dFWC3G8tWz03
         dRug==
X-Forwarded-Encrypted: i=1; AHgh+Ro9x1gTn23SKrOSMh1GucAfZ5Iu2uE8E1ftvCb2gcKTL+cbBDOG2OnlK380WjdSgO6YSjI4vBVMEcLi@lists.infradead.org
X-Gm-Message-State: AOJu0Yxe+9t2cMZTgCNJTZSER+ekk+SFSfnQty/EAoVjHVpJUP9XQjSH
	BQ+rbSIzzuv8FJas7J6E+XvZqC5q85WJBhnHpiCdgspzG7gV8r2+iom5QzAS/VNA1nI=
X-Gm-Gg: AfdE7clPxXcTm19nbrXPHU9UidIqfXXCWnlRKZ3MEmonSsG39TkyTxbGEjt1bfPrVuB
	rwkwsAUkypKcA5ru/y3+JL9SSRL9RzMVe2egWEsk+UTy7sRo74XupMm6ZNc268wS6ZwIEtQR2k7
	QqTRqMPZezGONMwhuDvpElFfeJNByVseUyNNWyucdrqCSyYqBfF4iDB7dmHWuVWEukVEZP1uDRP
	PUDoQ3ZhdGBvpEgKuGXVVi6Mo8Nf/4yopFQB6fN0R0PseK1rQ4rJSALdWLdSGuNZFLl0joc4Do4
	4WInWrJYr9XpRaCQRCg+x3Slo84mzx90xMz/QfFDATftZlNx0cIfkAGvdzTgwutupTOxxqs9g+O
	s3Z+lVhDhdHG4Gh+MYDQ2ffxGMt1eyMHrGoJNAr1Rzg5g3+zhh4weO86hE2v9rVdMskjPtr8n9y
	yjJ5XC
X-Received: by 2002:a17:90b:1848:b0:381:b1ad:c9e4 with SMTP id 98e67ed59e1d1-38dc7755a44mr4819914a91.26.1783823130537;
        Sat, 11 Jul 2026 19:25:30 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:29 -0700 (PDT)
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
Subject: [PATCH v5 08/16] nvme: Implement cross-controller reset recovery
Date: Sat, 11 Jul 2026 19:23:29 -0700
Message-ID: <20260712022437.3743117-9-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192531_802027_C09C112E 
X-CRM114-Status: GOOD (  23.23  )
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
index 1ef4dc38f755..a1deffc3cc00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -571,6 +571,157 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
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
@@ -5205,6 +5356,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	xa_init(&ctrl->cels);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e558a19781bd..90b989302e21 100644
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
@@ -393,6 +401,7 @@ struct nvme_ctrl {
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	atomic_t ccr_used;
 	u8 ccrl;
 	u8 vwc;
 	u32 vs;
@@ -887,6 +896,7 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.54.0


