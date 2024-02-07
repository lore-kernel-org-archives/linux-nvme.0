Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57221C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uli3+3IESPz0DHcdIZuTc50mls/3k5GISEzttApfKIQ=; b=QX3qjG2Q99I8OAQ2ara2BUmmLi
	txucHl5h0zlNHMY9dnxSTC7wF9jZ7zDQYjtQWwD8XDZZB8yHCZYNnPzcn6/CyC+5CcKdPjdsL2VD9
	7Ly0X+xX1WR28eqslHjPPN1Gr0o+570uwtTVGHtbKZYBykhY97uVmGupbZK5q4fYiIxKyegkrojiw
	3htnQV608/4CqoqBcBhFVcUGZfQkWiDVp/KjO8AsGw4A+6Khx+Nz8qM/FWorAgRU1dXcAVUHTtLBY
	H36VTVY1c/S1Gk8FrMWM/eLV9C5V7bY6qafI4VDWAgTL1DhPcs2vg9DtDKK4z/dugXIJnU1MpFWew
	TzzJwR+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf9-0000000Bx9X-3mcH;
	Wed, 07 Feb 2024 21:40:59 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf5-0000000Bx5N-1gJg
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:40:56 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d7881b1843so11301235ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 07 Feb 2024 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1707342053; x=1707946853; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uli3+3IESPz0DHcdIZuTc50mls/3k5GISEzttApfKIQ=;
        b=mUdvTs+LQBxgibz44smj5iVtA8KPMkqQ3cH6DPDdUAqbdM+/hQZBWe4IDPrJ5xbZOB
         +kBMxaIuKNbzA52x3weZMSrnBZuF26Lg3MCSsQ8Ylq++mZKqYBnJwNEIJRd1yHsDkEM+
         RWNwxgArWb5xe0EA0PrLNAaS1E+fOlzNlT1GjGDaqf60gCdSCNEt9HBA+LDy/JckEXn3
         On09dqmAiUJMKb2yr6ZTIcuD3hodQcIvNMinEJewEhyF/nk/gNPCAP6wkVdgRqlMEDDh
         5AD4dX8Nn7P2ZXRMxEo8nSe5B4snA/SlusUQI/MzDzcdBorVCHwVsxtvdqKcSdNyB0un
         hmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342053; x=1707946853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uli3+3IESPz0DHcdIZuTc50mls/3k5GISEzttApfKIQ=;
        b=pIeRWJAW2HDT61hl041smoaVBYm+1A/2AqAOf/yhHF2GSA+57LVznKL3UhDRyfZiez
         NnqvK7zY7dpCck4v8NMRtl2zfTbICYrlYvLQiwBuMbIjuzT1+pvJUL6aXmFnBK5b8nWF
         6+VbxhretG+pHEPYtfs8RQZDvqgvwLkPjQdlH8inBYJZEj+A9Ea9Ke9QOISiqa/evKcX
         C5/ZlexSk2uZYJRxPa9bqRMoRuNLkcw+QENy+qTPUlP68E7Ghyi+GdW3XwpQaUZSG1sH
         Xb0WJjF8TyEvBYHosSC08Cu1AoEQN/gzpT9/R/MzrUyZwOZSX2bRyhiUVlr3B/xoe4Gy
         mIIg==
X-Gm-Message-State: AOJu0YxguRfdaOPPDGQsv064QtTP/2Ui7x0Uf4agOp8zpwDMIeoG/QLu
	c9qbt/E/5FhlrQljyLeBAmAJJyabu5SP9947XC+VDTcaOMqO513qckcWK7ackQY=
X-Google-Smtp-Source: AGHT+IEYR2R5ZnsPNzJZED/dpH2cdRoajDGqjOtITg5YbyIa7fVPCvIhfFLLYVjoNlLnba+zt8df+g==
X-Received: by 2002:a17:902:ed8b:b0:1d8:ee30:aaac with SMTP id e11-20020a170902ed8b00b001d8ee30aaacmr5004879plj.69.1707342053680;
        Wed, 07 Feb 2024 13:40:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYQRAU+B9Pz7kQkjEyIHQzwRG/zJJB33ZB2EqOp50ZynE4yBOh5bM3u0yLdw4WVSV9dU1++KsPJKiqTWIdZ82r4T6Q7im9gTEXtV8PMRddlSvGJzdnsPhJ4vKWnRqbmxjUVv/DAzhTLvigsJgnYQTPYVe5+4Au1T5nPFE35KiWPIe1oD94/2Fwtx0wQ0+to+2HCbEFlZIhyiXyQH2BlsALHvzdC5FV09pxCTeQsVkPT46BTENdBhH5QXfDAj5o7qpIuvnPyxpP3d/A
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id ml7-20020a17090334c700b001d7274cbd33sm1939005plb.121.2024.02.07.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:40:53 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me,
	djeffery@redhat.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/5] nvme: Add a new exported function nvme_ctrl_shutdown_start()
Date: Wed,  7 Feb 2024 13:40:43 -0800
Message-Id: <20240207214044.2374295-5-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207214044.2374295-1-jallison@ciq.com>
References: <20240207214044.2374295-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_134055_458583_FC186428 
X-CRM114-Status: GOOD (  13.46  )
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
index 60537c9224bf..b7695f472fab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2260,7 +2260,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
-static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 		u32 timeout, const char *op)
 {
 	unsigned long timeout_jiffies = jiffies + timeout * HZ;
@@ -2286,18 +2286,28 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_wait_ready);
+
+int nvme_ctrl_shutdown_start(struct nvme_ctrl *ctrl)
+{
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
+	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+}
+EXPORT_SYMBOL_GPL(nvme_ctrl_shutdown_start);
 
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	int ret;
 
-	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	if (shutdown)
-		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
-	else
+	if (shutdown) {
+		ret = nvme_ctrl_shutdown_start(ctrl);
+	} else {
+		ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
+		ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	}
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7b87763e2f8a..f52cb3d1d9c7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -759,6 +759,9 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+		u32 timeout, const char *op);
+int nvme_ctrl_shutdown_start(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.39.3


