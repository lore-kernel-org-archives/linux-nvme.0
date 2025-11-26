Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75923D10378
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CjnV0mSDq9jYPBsBREKX0CT54nJKxP3oh1Vdl0zWWFg=; b=kD1MLR/BvdvRXBHej+tYPjL7oa
	Kb4cqpqefqLqyAZvynyus+OyutlGs8tPfp0nhi+2iKJG49sGdV/4lApMeARMTsUwc+/XzQ+fQW4Hs
	E5Y2D1X09jVhSHvj0XrMkI9EHIz8gfjJYCyaN1APzJnynX02ejU++5N4eCGd5FOWugNXPDp3usphv
	a0b66GY+INSiKb8M+BzATmsRr30GznAGXli3KZJZW29S5TcBZvkOMpdrN39F567FY8InaB7/vDxz6
	YMyWu/eQais07NUDezlzTESnyWT8H18VcIuWqBXsLaEtW8evMUZXexZrTrPaVh6BPS9pjXaQ6BHA1
	QCz/R8zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52E-0000000EDTq-1CNO;
	Wed, 26 Nov 2025 02:13:34 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO529-0000000EDOL-1IXu
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:32 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-bc0d7255434so3426992a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123208; x=1764728008; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjnV0mSDq9jYPBsBREKX0CT54nJKxP3oh1Vdl0zWWFg=;
        b=YhVOx0B1uP8gt5f1hBfGBjqqqGqA83ifNxKYzV01/EeHhGBO2qxzg3Avp8xaPbQGjI
         3NTxwn/d/N6pJW3KncdvuVhSZxHawxnrBdqqjVEHma/+XNmUCcLKaaVJOKcouQFLZMJ6
         b3wvsht7rDF6hgZlZfHQgS23+Jt3kdgdGPRGeMQ30zVUiCQt8S1LIGot+C4uXVwDde7x
         7ld82NOdRxXOcn8PFiDHSFSD6IqhSvGErZxGkbC+RQJ0dTkPeuqTVzPUvO/HzrB7cW1a
         a+WsOwQCvUQr1t4PAQJ2UD0AlvnnC7kXyi6V06ZjV7PJaJynPX6zUpFVVkdHOB0UMOgY
         03GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123208; x=1764728008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjnV0mSDq9jYPBsBREKX0CT54nJKxP3oh1Vdl0zWWFg=;
        b=lx4YI5qYpQ3nkS7TrV3BjbGly6+fAS7G6K25zO7cMtKixqwxocm+avSUHv6xKMy/SS
         j5gDL8U95T7I7oJ4FKTmip6ZvC2CpWWkJYrHwzjCwZfWlYimJhV4YlWtB0TJK7UmuihB
         ZPMihIncPUVoUbaX0HQkGJAx1i5vPvN+OM1F5JhYDvv/Zsa62ka3j6N/XCPJLJBnWRrA
         k8F7qSuaRjnq3Tt6Btx2Mt2EUnC8XW+KobayM6JDgQ8npGbYu++YhTW4TzrP2D9ta0nR
         qYlEn21oWuqkCNt3kTk6AwZlvHDg9qwHWq2DiOgaQZJzX3i6PWwEd1fdAwAT3VUe+Xnn
         IRKg==
X-Forwarded-Encrypted: i=1; AJvYcCX54SrW2n+4/7p92U/uZkh6jiMyOeU0Ce3jJD5LkMxhRUvI9EkrkydwdBZp8S9MtNnRkwR0zt3UO+c+@lists.infradead.org
X-Gm-Message-State: AOJu0YzsF/ionTbwfIjYNf/uVRPcvdJWM/KofpbwU7MsslEch9sHu858
	wFcFzKLLtY0vVq6nZeA+Ppb/sAlXaoFPRv0W5ppLSwlNAw1eX3v6qPhgemW5Nd0zQJY=
X-Gm-Gg: ASbGncuwK5dn95zGF8LyInoY++6MQe5SD8LpnMQUdh6NnJkvR7NkvCR9D2l+DBd4OPU
	Y21/f2MJSsGmWHePoCjKB4wAx2n/11V30HroOL9vw4SW9Qty6rhgWb0sNkHBM8PXHVp0H4s+v2w
	sIm+zr8DwLIDIHp6epRmgCds7/DOFaJFJOPWj3+tqZhhyQFGo/Aj/TXGPt6LrOmuARp2RO2TZWz
	i3udfY1QUSBzqDNO+v8CwC1voXCtQycVLM+K4ocRx+ABPIY5XQvBCkhloPHmqifWc/w+awNLIjU
	9UYDZwgJ5A5aSTCM23oF8zLdPqXXy6lLDhP6urXCCYBZr1sEW+m93R17RpsfxyL4fm/lh1OQ9YG
	5NpYniZwXG48TIox56VqpFGc4+h1RoEiWt/aQlVFzFHreuet5ByXNwm27qx6KAZKsO2bY6ciUcs
	W50Gbl8vkhKRjyPgB9xsA3W57MVIzTOKu5Jw==
X-Google-Smtp-Source: AGHT+IEhnXE+QCydeFnkH60Wu36pjMR+ctQOkgAui/pVLevVZNZbL7OAINeVbFcTTLvp5xLjhA13mw==
X-Received: by 2002:a05:7301:5f83:b0:2a4:6784:d99 with SMTP id 5a478bee46e88-2a941890ca7mr3944316eec.31.1764123208180;
        Tue, 25 Nov 2025 18:13:28 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:27 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 08/14] nvme: Implement cross-controller reset recovery
Date: Tue, 25 Nov 2025 18:11:55 -0800
Message-ID: <20251126021250.2583630-9-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181329_377039_42390F7E 
X-CRM114-Status: GOOD (  23.77  )
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
 drivers/nvme/host/core.c      | 133 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  10 +++
 3 files changed, 144 insertions(+)

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
index f5b84bc327d3..f38b70ca9cee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -554,6 +554,138 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
 
+static struct nvme_ctrl *nvme_find_ccr_ctrl(struct nvme_ctrl *ictrl,
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
+static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
+{
+	unsigned long flags, tmo, remain;
+	struct nvme_ccr_entry ccr = { };
+	union nvme_result res = { 0 };
+	struct nvme_command c = { };
+	u32 result;
+	int ret = 0;
+
+	init_completion(&ccr.complete);
+	ccr.ictrl = ictrl;
+
+	spin_lock_irqsave(&sctrl->lock, flags);
+	list_add_tail(&ccr.list, &sctrl->ccrs);
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
+	if (result & 0x01) /* Immediate Reset */
+		goto out;
+
+	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
+	remain = wait_for_completion_timeout(&ccr.complete, tmo);
+	if (!remain)
+		ret = -EAGAIN;
+out:
+	spin_lock_irqsave(&sctrl->lock, flags);
+	list_del(&ccr.list);
+	spin_unlock_irqrestore(&sctrl->lock, flags);
+	return ccr.ccrs == 1 ? 0 : ret;
+}
+
+unsigned long nvme_recover_ctrl(struct nvme_ctrl *ictrl)
+{
+	unsigned long deadline, now, timeout;
+	struct nvme_ctrl *sctrl;
+	u32 min_cntlid = 0;
+	int ret;
+
+	timeout = nvme_recovery_timeout_ms(ictrl);
+	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
+
+	now = jiffies;
+	deadline = now + msecs_to_jiffies(timeout);
+	while (time_before(now, deadline)) {
+		sctrl = nvme_find_ccr_ctrl(ictrl, min_cntlid);
+		if (!sctrl) {
+			/* CCR failed, switch to time-based recovery */
+			return deadline - now;
+		}
+
+		ret = nvme_issue_wait_ccr(sctrl, ictrl);
+		atomic_inc(&sctrl->ccr_limit);
+
+		if (!ret) {
+			dev_info(ictrl->device, "CCR succeeded using %s\n",
+				 dev_name(sctrl->device));
+			blk_put_queue(sctrl->admin_q);
+			nvme_put_ctrl(sctrl);
+			return 0;
+		}
+
+		/* Try another controller */
+		min_cntlid = sctrl->cntlid + 1;
+		blk_put_queue(sctrl->admin_q);
+		nvme_put_ctrl(sctrl);
+		now = jiffies;
+	}
+
+	dev_info(ictrl->device, "CCR reached timeout, call it done\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_recover_ctrl);
+
+void nvme_end_ctrl_recovery(struct nvme_ctrl *ctrl)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	WRITE_ONCE(ctrl->state, NVME_CTRL_RESETTING);
+	wake_up_all(&ctrl->state_wq);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+}
+EXPORT_SYMBOL_GPL(nvme_end_ctrl_recovery);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -5108,6 +5240,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->ccrs);
 	xa_init(&ctrl->cels);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cde427353e0a..1f8937fce9a7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -279,6 +279,13 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_RECOVERED		= 7,
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
+	struct list_head ccrs;
 	struct mutex namespaces_lock;
 	struct srcu_struct srcu;
 	struct device ctrl_device;
@@ -805,6 +813,8 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+unsigned long nvme_recover_ctrl(struct nvme_ctrl *ctrl);
+void nvme_end_ctrl_recovery(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.51.2


