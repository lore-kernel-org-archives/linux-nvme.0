Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACBAF9EDDB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eKN6hgJitCrGcDFf0yJdGpm+5omlrhdg6Mmleco0h7M=; b=2ZRamIs5QVHPDoqrxrdz3jVtSb
	ptBm14sIbQ2/GZ2SfjdsUMBjrFuWRgQlFm7WPv43kNvzWR9jI0qn9/9qFKw0ri6t7nXxIDD+sRz1a
	pS/n+j+5GVV4lh32OXCuOMTsT8Vhp3Q7NyNxRHL1FaLgsqQb8iVoL1wxQv6ZUEyFXsmLrIV8rxcVl
	LPKYs2PWX0G3pW+0ksq2Ni6+olJenyV3/0KMQshPi2K4NW+2CfUQgHwayH+PVuh5CDjqM06qMWhMW
	qU1qKuLUCEs//cl9D68D4D4eIh4hqo56aL2Kf74WM+F1iVKlR1n7kaqrQ4valglZFu8rsh8xq8kap
	Gs8VrE9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYJQ-0000000ALL2-1twO;
	Wed, 22 Apr 2026 14:12:20 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYJG-0000000ALIN-23ot
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 14:12:18 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82f69adeecbso2370450b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Apr 2026 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867129; x=1777471929; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKN6hgJitCrGcDFf0yJdGpm+5omlrhdg6Mmleco0h7M=;
        b=BOU2IZB1zXeQxWlHuvx7MZuCpyaXWVojYEsZsWDgWxSawl60/CQxNICi+lWDOjt0nA
         rkc8YK0poq96AuLbLPMqkNhVw3zgx+UP25LirvuP1hZDREMJrPIJzpmIHldnachRcgYC
         2pyOsQKTJdcH6Pg679rXs94zaJgS/W84JBl2+UMVgoJqbXgly6LfXYf/Mkijif4TDmSW
         uSliOMyD8xNl0wBsF2k3zGEb2lBU+bL8EyCIETsDsWqrDdoNlyZnlWAHZIur9dI3NHS8
         kEeohfewtP5dWGpA7Y04kXy7Vxzd5CJg7YO7r3p+BFD8hi4+Kxj7eLV4kcJsjAN4r8SV
         i7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867129; x=1777471929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKN6hgJitCrGcDFf0yJdGpm+5omlrhdg6Mmleco0h7M=;
        b=dHbEBqYUv9gm/UWp52/V7MFUpuQR78QKG6OF8H+a3Y4/afwbZH3y/o7nG+XPpcllSn
         LAxIslJbVSd5nCtrES/9PfdH168IcSMkNAmrMp8JqgnVE2ESABxUoscydaDNKigm+YgB
         bARvdQNJUc8u5tqSU9HctZ2wtdhSSgpKhbrBMRnEuqKkymTZwudo9x5Ss8mDD+6dBd2t
         16n48PCiQ2mPPJJd/h/RziSGRmVqcTszsY4Am2QEQr5M2ex70jNt3vegAVSQQ09CakEZ
         Ua9xhYgkarpVxFm1cinJe3nTI7eRuiOW8X2QTwJxP2DibTCX7L5lF7pnuhzjoutdlZk0
         jNgQ==
X-Gm-Message-State: AOJu0YxkS2mxxUAIRll99ESheXjNUWScfxm+bGuEDa8sU9KVa9BCZlFx
	XxLReRM9QbJhTRlk4n1jR5oD7KpxFBBJ0ndC4zCcjiV5Na3fg8tGDKGy
X-Gm-Gg: AeBDieuijLAJG5OTBA4AimxB7WnxzmFmM6/2Nb9MfjnsyHtSG4KKwMPEOZuEhGgeMp1
	Fx5D9wxQqjzNtXXgjQ8e5mGLyq4XhcGwPYCuZVe1BX7ljucQ8xTgMqKAckcyahT/yBLNt9jWSfX
	L/MfjBLF42cXHhBVRfSYVOZdXZtQ2Xxzlb8zmeVVZAC3e1DP8NU+xnE7VvC+A35P7m8OU4WDCEH
	j3Oh5aty6xYHPnIzfQbcn2iBGHw78TWTAr4l15p3p/BtClWXGNvXJtI66KGJR15r4qy+ioeL9fp
	78YnpbrOs2gOu4uZfqjvHw/AdYzWfIy9b1nd1oSHBOa1s3Pw+JG+AFGUU0tAKo70IsTZMKso9Qn
	bVTY0mj+YMlcYTiAoKRFiKvSG2kBHSxZR+yRWMS6/7e5K2EigpRN6vQK0/ZyJ6TIAPFntrvlSP6
	TC3rZ06ZW/T0W0FcvPzgH1beCS6c07dg2UZm8QiyQ7Qk85xPs=
X-Received: by 2002:a05:6a00:408a:b0:82f:4a53:a95b with SMTP id d2e1a72fcca58-82f8c99177bmr25710056b3a.37.1776867129370;
        Wed, 22 Apr 2026 07:12:09 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:5cdd:bd85:7f37:6252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec24850sm17974824b3a.60.2026.04.22.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:12:08 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2 1/2] nvme: delete unnecessary empty lines
Date: Wed, 22 Apr 2026 23:11:47 +0900
Message-ID: <20260422141159.10881-2-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260422141159.10881-1-ikegami.t@gmail.com>
References: <20260422141159.10881-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_071210_528958_1A8E29B4 
X-CRM114-Status: GOOD (  14.71  )
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

Also fix incorrect indentation errors.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v1:
- Fix the incorrect indentation for the continuation of the condition.

 drivers/nvme/host/apple.c | 3 +--
 drivers/nvme/host/core.c  | 5 +----
 drivers/nvme/host/ioctl.c | 1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..8e583ef05d53 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1060,8 +1060,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	 * or the previous stage shut it down cleanly.
 	 */
 	if (!(readl(anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL) &
-		APPLE_ANS_COPROC_CPU_CONTROL_RUN)) {
-
+	    APPLE_ANS_COPROC_CPU_CONTROL_RUN)) {
 		ret = reset_control_assert(anv->reset);
 		if (ret)
 			goto out;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e33af94c24b..1f973d88c830 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1774,7 +1774,6 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 
 static int nvme_ns_open(struct nvme_ns *ns)
 {
-
 	/* should never be called due to GENHD_FL_HIDDEN */
 	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
 		goto fail;
@@ -1793,7 +1792,6 @@ static int nvme_ns_open(struct nvme_ns *ns)
 
 static void nvme_ns_release(struct nvme_ns *ns)
 {
-
 	module_put(ns->ctrl->ops->module);
 	nvme_put_ns(ns);
 }
@@ -4684,14 +4682,13 @@ static void nvme_async_event_work(struct work_struct *work)
 	 * The transport drivers must guarantee AER submission here is safe by
 	 * flushing ctrl async_event_work after changing the controller state
 	 * from LIVE and before freeing the admin queue.
-	*/
+	 */
 	if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
 		ctrl->ops->submit_async_event(ctrl);
 }
 
 static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 {
-
 	u32 csts;
 
 	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9597a87cf05d..a5545dab70a8 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -638,7 +638,6 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
 {
-
 	/* NVMe passthrough requires big SQE/CQE support */
 	if ((issue_flags & (IO_URING_F_SQE128|IO_URING_F_CQE32)) !=
 	    (IO_URING_F_SQE128|IO_URING_F_CQE32))
-- 
2.51.0


