Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F74BC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 02:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Cchrfa8eIXWEq/fb8YAhdNX//HQqlhIwVZ6NSv/uTAM=; b=lOwV0AbENdfoEMe6qFprP2KnYY
	XqLpPYchQzpMhhAUZegj3xG8S1e9Qu3LYBKPM7/rO7hj/SmA2Y+dekyOtz/1L0Q0v5+X1Meh2dI4L
	FK4svesurN1wKBgy7Z0zQQcPmfdbW2VB2UkNeMiLWZRxCpf+cz+qwuRt4WiR4uDO9OLAfkIyTIV2D
	zwm5lc0Nz0vynrXbbfoEk6fyJM5H5WAss8D9KlvAMTNK706RyoIZaMuhdhNPmGhBBKLhmYULL/QNW
	Ev8kSjhsmTjRqZSPh7Uqjjwgrqblph9u5LkerhgwwG94LR2LfKDG8f3HYKTkQBJyeHdayAveqLhOG
	u711MkeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1d4A-00000004mSv-2z10;
	Tue, 30 Apr 2024 02:17:58 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1d48-00000004mSL-00kv
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 02:17:57 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso3835231a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Apr 2024 19:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714443474; x=1715048274; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cchrfa8eIXWEq/fb8YAhdNX//HQqlhIwVZ6NSv/uTAM=;
        b=lVjqseMpaRf4V8So5PhciD48A25Ekbqo15tOu04O6Frf6PYHKBKl98w3W22+CgH4Dd
         0FdyZx335ByVJ6JYQuhPWZN3rUaQXgusCahgp5jlUDZcQDU1BUYqTLGFEYjaN50U3sUR
         fdFnx9jzpD+2rVg9PIm7qczmu8L2a9mFcV6KD3vaHvW4YYphUEP27a8AlBt0/fcLSrfL
         dQka3JplNWIRa4cFTL/+VitBPpeDi0TcDPDWeRoDfoZ58QcGJYgmujxX2Qgww4u0xEIn
         N3Y+YZMZF5k5TeLCM0xMyAiIQSUhmIdTobPtCIGyHsdzdv14RolikjQrLbueGH9OqPNw
         /B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714443474; x=1715048274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cchrfa8eIXWEq/fb8YAhdNX//HQqlhIwVZ6NSv/uTAM=;
        b=N4ECShcPaSeVyH/cpmo0lEKiwc67MAGxg8E9a2iDneaRKn14BF9lsVXad76YDVLKg0
         sk/BLErGO2voTDxWUboAZ/HNVWq6CWAijtVYfu1Np2ivEQ+9WNXxT4INfH9/iPmn0gCF
         UI5NPbStRnsstpX+NhMy0Xu3UNIrqXjYIjZ3ZUNt0H+d3yCq79ToqPZIeO3xjuiiuvQ+
         lvLzfmacq9GzhZhTvC0OolUwGRfxtoY9PQSLqJUBQA7InfYclsBpeBuZX02dme6oiEG6
         VtwBilm2QIug0teG/m2YPhURj4/5or3g85hZUnVuZtw9x9G3r6TpBYIbYVEYwCF27G11
         n62A==
X-Gm-Message-State: AOJu0YynsKGw9c8xYtSHEFIsMNWJnsABRf97IZIq9D0IN/Hkl3iHo+Ob
	Vu7dYpiq/0gfIgEhz9mDTlyJpSZJEtIPlJUUO8latx9zRSqDj++zn/jQDhjICR8=
X-Google-Smtp-Source: AGHT+IEF3eO70FW3TItLtjRdAj6x49nr+2Kh7RJrVnC3sLWoPwJO4yfoQOluLguDyR+oKOT9sfZO6w==
X-Received: by 2002:a05:6a20:c70e:b0:1af:3857:e653 with SMTP id hi14-20020a056a20c70e00b001af3857e653mr8338836pzb.12.1714443474145;
        Mon, 29 Apr 2024 19:17:54 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902694600b001e20afa1038sm21154619plt.8.2024.04.29.19.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 19:17:53 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
Date: Tue, 30 Apr 2024 10:17:53 +0800
Message-Id: <20240430021753.385089-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_191756_094792_12E5716D 
X-CRM114-Status: GOOD (  12.65  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

In some scenarios, if too many commands are issued by nvme command in
the same time by user tasks, this may exhaust all tags of admin_q. If
a reset (nvme reset or IO timeout) occurs before these commands finish,
reconnect routine may fail to update nvme regs due to insufficient tags,
which will cause kernel hang forever. In order to workaround this issue,
maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
tags. This maybe safe for nvmf:

1. For the disable ctrl path,  we will not issue connect command
2. For the enable ctrl / fw activate path, since connect and reg_xx()
   are called serially.

So the reserved tags may still be enough while reg_xx() use reserved tags.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22..f6416f8553f0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -180,7 +180,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -226,7 +226,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -271,7 +271,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.25.1


