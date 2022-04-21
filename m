Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338BFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d6eavg0GQTJ7FfBqHnuTcYU2VU691/tHgSQgrWxodSY=; b=lcphYrydmtv0tXakfZWuHEUA3J
	qW94QAQxuFV7oy2WSv6sZQL07in4HB4IwPXZWYN1u06xiWmrw5DCrbJZplOLC3ak+Xyn/XrwOOcmy
	VYEc8UJMcsUkVNdD6xO0IaovDKEfNpiTATcz6qjJtEKYWFryMG4k9U00EGRYwNlNp0ObS4bBbJrBn
	s3wVUAHLzHkVo3wfnIMQh5zCqji+nSU8PCw2G2u/WdAF1uMNWo5pJNrVfT3cLSq+h+qle1gMIfdII
	VVa4OaIw6Ak1kBV2G1Zv0ehA9MgN+N/m0jCFf61T3F7UOl3kaYcYpFKDriARjyCyKRrQyTnNjr+0e
	ZJSValDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhSUj-00CVcY-PT; Thu, 21 Apr 2022 08:48:57 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhSUf-00CVYO-Ex
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 08:48:56 +0000
Received: by mail-pj1-x102c.google.com with SMTP id
 n11-20020a17090a73cb00b001d1d3a7116bso5385175pjk.0
 for <linux-nvme@lists.infradead.org>; Thu, 21 Apr 2022 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d6eavg0GQTJ7FfBqHnuTcYU2VU691/tHgSQgrWxodSY=;
 b=DCd9ub/q3xmvDwW9yATPgmEk68HeKgyNsnBw6V9nASUr20J3f51mfanl9KJRYinjpH
 B4aKzLOEtJRjHGBbUSnvwk9R9kA8A7VNqUYqMY/MHD2iYme0hado+OfByQ0mXwrAQqfV
 ZXHDEGBCjeAcdbS92A+twlF6DE71ODQfPAqk7K4LcEnyJ/bjlxKKYWREWu8UMVnyorgc
 FWCCRbFQCw2zLXruD4YpajCy/FbGjixUqolJFVyjWPfD2VT/rsLoBX5OAcsOH1tJSsMK
 0O+nMZbWn0yjGg8EllBgZk+fj/R4tICLTzwsVwKBIA2gyGRFSzT7dZzHjBg5hNPOGa/3
 rAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d6eavg0GQTJ7FfBqHnuTcYU2VU691/tHgSQgrWxodSY=;
 b=CVdkLAlwtA8VvueUtYOzHWb9eWdZE7cewuTHtosTy7WJB03lgaZ9B856WOspwqMj9p
 GpEaEoXBiDyZoabLGjQecdlj4lMFiPE6/mXTu+GyNak+sTQhAUHSJpPUnL5VTmFnfdPV
 ydgt/ms/vfWyzUSwnGVJcUCvDbnAUnAknqGRlNAIMYRmhWtblzBlVPbdNIDjOK7JPb3A
 RKvSOjm2yxwAFlA3mhtbs29GYrnk7RSJln23GDvgPdwX9yaxrIK0lYfdXBBxblbl5nVO
 BzggfEzefTeXHuqFxFWwEpncblQy5tOswzfelKLXOnofJ7sgtz+IoHkzzhwvy/XYGOF/
 XyUg==
X-Gm-Message-State: AOAM530x5nRFHyl5tbU6m/fTRwYhgPOpwmeUh1yBptTG/lu+RYHIzA1p
 wpGT4rtSGXg0JfTw+j0CcPrhkryy7xc=
X-Google-Smtp-Source: ABdhPJx/gZcJr5/CFafOJMNHCID46m10LFaVlRilW0y2WJ7cOcEnDHQOpBBgiNqQC0XPzTEuUX6xzg==
X-Received: by 2002:a17:90b:4a85:b0:1d2:aee9:23ce with SMTP id
 lp5-20020a17090b4a8500b001d2aee923cemr9287825pjb.99.1650530927834; 
 Thu, 21 Apr 2022 01:48:47 -0700 (PDT)
Received: from ideapad.. ([161.81.112.246]) by smtp.gmail.com with ESMTPSA id
 f16-20020aa78b10000000b0050a81508653sm12625156pfd.198.2022.04.21.01.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 01:48:47 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v2] nvme: fix interpretation of dmrsl
Date: Thu, 21 Apr 2022 16:48:41 +0800
Message-Id: <20220421084841.2106-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_014853_569983_5821A4F0 
X-CRM114-Status: GOOD (  12.16  )
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

dmrsl is in the unit of logical block, while max_discard_sectors is
in the unit of "linux sector".

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
v2: ignore dmrsl if its sector-equivalent is larger than UINT_MAX
---
 drivers/nvme/host/core.c | 8 ++++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8e2d..9d2f32739a15 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1622,6 +1622,11 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
+	int lts_shift = ilog2(size) - 9;
+
+	if (ctrl->dmrsl && ctrl->dmrsl <= UINT_MAX >> lts_shift)
+		ctrl->max_discard_sectors = ctrl->dmrsl << lts_shift;
+
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
@@ -2881,8 +2886,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 	if (id->dmrl)
 		ctrl->max_discard_segments = id->dmrl;
-	if (id->dmrsl)
-		ctrl->max_discard_sectors = le32_to_cpu(id->dmrsl);
+	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
 	if (id->wzsl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1393bbf82d71..1c85edcf7dbb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -279,6 +279,7 @@ struct nvme_ctrl {
 #endif
 	u16 crdt[3];
 	u16 oncs;
+	u32 dmrsl;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
-- 
2.35.2


