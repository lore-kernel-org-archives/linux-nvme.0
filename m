Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE4DC48285
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VSMUUk09uYh/xf1OoFCr5URssSzWpZIfC5J7LXvxTnA=; b=qQNx2jWa+kAFfxqJZO8WWbv6Uq
	VXM6q+TqCXnkXH/VDfUOsbgZ1COG1SSFXtc0Zs8MmjOTR7bh8c5wm9mcQYSTZAhvDfA51NbINdxFe
	FKILzz3ZRehdMlI+XyIfJuFSadBRqmQeFXjjwDRerfhx33Wj/16aR8d0lCGtq1zBdJOGMHsEE7gkV
	xeW5gaUa8R6J5DE+SYkju5hsaTvJ+aI8dQrTrhJT9sfZdOuk6hRKUe/yn+d7tP6CmszzkRROo5BXU
	CKXJp2RVa+JugGEvsJO+N3s8eO9oTSu02JsPTIeFVv4F4yaLTSEx4yeUiLBqbZKnKoJYceQH2INxx
	dH+GlPYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEq-0000000DuTq-1h78;
	Mon, 29 Jan 2024 18:20:08 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEn-0000000DuRE-10Il
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 18:20:06 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5ca1b4809b5so1249203a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1706552403; x=1707157203; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSMUUk09uYh/xf1OoFCr5URssSzWpZIfC5J7LXvxTnA=;
        b=O31nGUvCeuEchnwQ07EK2t72V27WW+yh86z2WrSFYNoWUhMMRIQ+5ueS21fXp3Cbl/
         p5iIjAhNL8vaIycVq+77/Ke9t1U3l8kGmmFMzB/5HWi6VcMjsYXM4OvMybvxQ6KjZrr5
         4COsDU4AhzSowsx1VBOcp8SO/wyeu9MkZZkhifHXeIaIBusrEAu3RcbgEAbl4Wi7fueg
         9WK+OyM63Syu/MSpTz/zaYkpml96RtFvAmWJ2tLd5nbvz0KY7WTV8jp6CCanhyemiSnJ
         b2tpye7crssWt4TqaFGExNgnAEZVWn5yYGtkcFvagxbRuQQXFnx+KOLYVXBsEdQyMFhv
         doKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552403; x=1707157203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSMUUk09uYh/xf1OoFCr5URssSzWpZIfC5J7LXvxTnA=;
        b=joYWCAj1i71b9GQDJKEKo/sPUrk4U70f8fKtlamESGDg8Yth3rSYoOF7dMuYWksbCt
         2S7kCShKugW18nPkw98QF4Ypkh5Qv3IPyL8IPJoF9BauLDhBCaSdt5iFLfhxRLYvmKsV
         /PsSpXQSZD8cY3ysLwIeQbiXUBp1fxmbNeDilijpfC7aEjUok8oRBOawb27TFmRn46H6
         W8IUuysHEVZEUWzSfTQ3ndYQactNdodyJkZ+kmkVCpXiH0Y75qHM5B5WBIaegfh2/5Q/
         AMuautBUIcBe6VdKSvY5EtUfNZTkACQCkZcFICk+m6BKm6/mN/65+bnsZ9efdlrFkE0n
         GbxA==
X-Gm-Message-State: AOJu0YzWcTqI1o/ApsEbP+FwnrZYphEyj9kUn45IK1oo2wfatqbAJAqR
	v5FvIATdM1wO8Uo/GzshOqLdwJLqBs3PiLM0Y/5vkLpZRHfmHi2MdG9m19MnQ/A=
X-Google-Smtp-Source: AGHT+IH1t1RrE5LMLfc1DJl/JmMB2mXsTskpY/Uf+5c1oB70nsNlyaViMAtOC8aeFsBPL4+QrxuLLA==
X-Received: by 2002:a05:6a20:c113:b0:19c:58fa:5a71 with SMTP id bh19-20020a056a20c11300b0019c58fa5a71mr2456038pzb.54.1706552403447;
        Mon, 29 Jan 2024 10:20:03 -0800 (PST)
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id bv123-20020a632e81000000b005c1ce3c960bsm6617750pgb.50.2024.01.29.10.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:20:03 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/5] nvme: Add a new exported function nvme_request_shutdown().
Date: Mon, 29 Jan 2024 10:19:52 -0800
Message-Id: <20240129181953.1183084-5-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129181953.1183084-1-jallison@ciq.com>
References: <20240129181953.1183084-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_102005_371032_6283D323 
X-CRM114-Status: GOOD (  13.37  )
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

Sets the shutdown bit but doesn't wait for ready.
Use from nvme_disable_ctrl(). Export nvme_wait_ready()
so we can call it from drivers/nvme/host/pci.c.

Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/nvme/host/core.c | 22 ++++++++++++++++------
 drivers/nvme/host/nvme.h |  3 +++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a42c347d08e8..13635ef88569 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2215,7 +2215,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
-static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 		u32 timeout, const char *op)
 {
 	unsigned long timeout_jiffies = jiffies + timeout * HZ;
@@ -2241,18 +2241,28 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_wait_ready);
+
+int nvme_request_shutdown(struct nvme_ctrl *ctrl)
+{
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
+	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+}
+EXPORT_SYMBOL_GPL(nvme_request_shutdown);
 
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	int ret;
 
-	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	if (shutdown)
-		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
-	else
+	if (shutdown) {
+		ret = nvme_request_shutdown(ctrl);
+	} else {
+		ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
+		ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	}
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1700063bc24d..a3409afbebc5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -758,6 +758,9 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+		u32 timeout, const char *op);
+int nvme_request_shutdown(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.39.3


