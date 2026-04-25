Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC4CFF885C
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2026 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eKN6hgJitCrGcDFf0yJdGpm+5omlrhdg6Mmleco0h7M=; b=gzq1J1CdgiMhYOj4NTCLTKSR7z
	ZEmH9zi2erIkJ9SAZqlO0+eVZuaCpzXKy+rYDR/cGO6m+NqnwntCVfrBh/wrR9Q0gu2RxRifqx78K
	Bpg3dqRRYpehLRE/pcQJdRE0+cobJeWrc1eCuFDoXmueefPhTeltBASN+MX6SWYZ2NOme/DbuqT4U
	9y4IAueGneEo0Y5lJNhKawDmz3pTV4nteCYodMag66Ehl7ZA+dfs+cSttM/yS5CHJp2oxOLX1M+uK
	CyEd7c7Bk4H/y6yrWmvjZwDq3IvGI0NfVsxqpLPeCeXI3XrhZTNJT7mCAlLgwzUShLjks0e08PCns
	L+DBcrwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGcgW-0000000ESXE-4AaA;
	Sat, 25 Apr 2026 13:04:36 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGcgV-0000000ESWh-0B6U
	for linux-nvme@lists.infradead.org;
	Sat, 25 Apr 2026 13:04:36 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82f8893bff3so4144774b3a.2
        for <linux-nvme@lists.infradead.org>; Sat, 25 Apr 2026 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777122274; x=1777727074; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKN6hgJitCrGcDFf0yJdGpm+5omlrhdg6Mmleco0h7M=;
        b=hhPd6kMsHEYf8ZLy4OpWmqTA3KIU0igdy5CDgcFhgf17coE4pw3tySaxOF2luQsO52
         SkCPnxGvTfeNqgx5rUQOzG7JXGHO5a3aJq3KqilAehV/orvh4eZ/23V/u0TNGOz+iOKb
         OsnmHbfpOKaqpLfkxaLekDrwUft81tRRLutFD1GGj59zrQX58wbV6uzRxJZkIHDjzehM
         n1ezzaOilk9xvi8uR39EW7UP8dS5z/DS7pbnTOgXGRCS5Xlrfp3SBMI943oEk/ybo4rK
         v6j7r6wJzKBI2sVm84QU7b4cMt7ri9NwEFTYMdO5MdSzS/snxS0p8l0CWt5Cuz/q82Vy
         j9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777122274; x=1777727074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKN6hgJitCrGcDFf0yJdGpm+5omlrhdg6Mmleco0h7M=;
        b=cosAWoAhKNYuEE5nFiRsdQRxG8zuxnWvKVqQhY69MY4fMCLa+z3sjSwqr1fIMpJksA
         XQka+4fwOepY0AK2E1JC9h24mycdGl1bfE2CCgSzNOR/3a/FNP94SN8CFLaljrCsUcGL
         67FhrFuqWZ4rauaEGToumd/WuMDKdixjwdaymhpq+5bUJzFM7rwsqDRyT7zQg+miRAgM
         S4DZqLv+jtwxW5KkgDxX0LX5joCft1xyddQjA8F94xpGRwqcb44ON7amKIcj/n6ptwkq
         SBvEdRH1aTByVfdhOoxGox5Q7JdRbPB+4dbK2FTz+PhrU1P+QwplFmxCMZu/Bc65oi1O
         NA4A==
X-Gm-Message-State: AOJu0Yw+DqCbLT5mMjbR6jzmlWOX6Epli066VntubD8u8WjDvq9s/wdn
	mq8ZY9oz8SmGWftK2MmBQZJ4s0Eov48/9xM61hfiim13/ytBpoAeQIyv
X-Gm-Gg: AeBDieuEI1uhd0ZVO0g4u1VRCOp50jjtSUdnbDjD/BUasu8SksyiE086+X+XmQupd88
	kHFyS2DA1LRzJu+FQE/VdA3wJ9RUoacTdF6R96LTr8c0idNik6l5DHBM1pm5xFJUkqJxUAsfKjL
	wJk/GTeprTp/l0tC3YaSb1W3H6Fvu4MKiaKQQOTiq3vYuRNAECBqsshs0TJX+ouKU5M9CW7KDbA
	mvqS/DuFnjwDuJh1F9D+7RUgPGJ3XPxgX/w7pWk8FycZa+QYOlSBcj7pDNUkmEoHNhQ+grAgczo
	gQVThiAGEMtAyY/95pSpJkc07oC1AwZw6BGGiormHfAK5KvdE6gm3QtDLz+tsxfi7M7gQheisOC
	7zdTqFMlPsXqUCb0AVaXpYf8AJ8V/fXUg6X3IAIEEL2jhenR2OZdHe8x/dOsNeDjLPii4EdRCd0
	wSVdRXKsR/yqI3cfBrsiwuscxkZEdVk/YJIjxLY5TS6hgzWVw=
X-Received: by 2002:aa7:8112:0:b0:831:7627:4ab7 with SMTP id d2e1a72fcca58-831762765a3mr9279214b3a.29.1777122273955;
        Sat, 25 Apr 2026 06:04:33 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:6ec6:dcf2:7610:e61d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea0a97esm32302802b3a.27.2026.04.25.06.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 06:04:33 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v3 1/2] nvme: delete unnecessary empty lines
Date: Sat, 25 Apr 2026 22:04:12 +0900
Message-ID: <20260425130426.10061-2-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260425130426.10061-1-ikegami.t@gmail.com>
References: <20260425130426.10061-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260425_060435_077617_DFBC6E35 
X-CRM114-Status: GOOD (  14.12  )
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


