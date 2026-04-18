Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B83EF436BC
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2026 07:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h2dxZGc8HBb7l0+gkNf09Oy4wvuvi5kYhGx/LBbAMrY=; b=x2GCAgNX+DqxuaUYlr3dqKrdYi
	vnyI75jhBByPwYNW4jCU9yUeVaFypbs0U4Lsjnq6hA1wzHCa0MWcBTxwqw+2sOvvurhJmgxWzDIUL
	fQAEl9lvGyobIZzWEKfvaXivWwDQ3jrGEqcCXnDMctZ+m62rheLI/Kksb5QmH57L9e2oK/P7jdpmL
	/n8UJLBGI36PNnm+QF39C8IDNSQNCAcQj+H74KYBNQV0jPQ1h70eXby9vJdhsLRqjz476Jxx+eZsW
	xWVDnqSqNA/VTJTxbPYHMtTWF+PV/E8CqXcaT15+1uBfNLT7wTunmEHrF3pqVGBjHxZjw6H2RxIPK
	StY9r/5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDzr8-00000004nod-2vMS;
	Sat, 18 Apr 2026 07:12:42 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDzr6-00000004no9-34Ap
	for linux-nvme@lists.infradead.org;
	Sat, 18 Apr 2026 07:12:41 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2ab46931cf1so18520615ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 18 Apr 2026 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776496359; x=1777101159; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2dxZGc8HBb7l0+gkNf09Oy4wvuvi5kYhGx/LBbAMrY=;
        b=csah1IzsnBCiNINNJ69c6bpZ1DA+jcl8BSo9cAnNq7dY89TuYdY1rKKBNgvykIVhn0
         ETRNWO0GAOyPwle6Mf9K/cbN76ULY8bNVkEVr1j3Mg1+RZULlvuljNgHlb+S4y+ysw8K
         vs7hS4xrZow0/wMnb9dsh21/Zg3MkWjc1K0SrpQowWA+xcYEU0/nEyUMnBZsc4v+ri43
         J/Wg9mZArwyxl5b+SSahmnM7K73e4nBGTXvAqV9A8LFO0zbHGG6QcfQePTbYaNB65Uv7
         fywXwmGoBDV+AqQkGXu1PWrYCrS0QUguE9NKh02wyeoq9l3Q23372M+txA+lgaRGzQY7
         12OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776496359; x=1777101159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2dxZGc8HBb7l0+gkNf09Oy4wvuvi5kYhGx/LBbAMrY=;
        b=DzfIDJ4w2vEiX8T7+K6BpMZ80w1mKN9RV1Eaolued8w/J+WIsFY1NcFoam3nIQxvLb
         FeLtF1i22dHKRQ60GKFGR6QKhj2UKc4Ka3kkeEnrurjrrmjniifYa8Lfnhw1LoM5Qbvi
         wMy1BiJY1+SYylHUxsGFqCPfUQ9uNvGExGJjJZ3GjeOVWLAnNOrqRv0e0ge+eneQl2z1
         VDj7H9HZV7u76uRLakSS80a087v2HGq9vNeEseLY+QhnygoI76L03H3M3T6r70/HaWYu
         O2rnxHWO694RIJU5O9v/nqoZTecgPNw448wSEJy30LTPmJBIWEZ/6xmGfUg6VVc0jTId
         7/cA==
X-Gm-Message-State: AOJu0Yx+k7a0sgMzavzumQwiSMEFmtay/Dtq7CAKOrLZGkrzqlpNLEyo
	WSqNrPJ1Uuty58T/uODtSz/cjezYU5RHbm87KYK045GmgEI+9RYXNFoT46XxZw==
X-Gm-Gg: AeBDietI8e4ulfdf8G0jHEwFpmnrC5brJZZ97KvEiucNqmGOzqC3Bn84pyd/c3hSxeX
	S6NEA/rJ+yOTYT0Ty5vjewAEldYnpz+ZQTbdc+1kKQ8FZc5f5JpKJ0a6hNEhub6YXYPVJ48SW16
	ViMy+eJMrIPm75yddzsvxize41L3dbBFSYSazg2EDn6tFT2q3ACFqtp0TcH/ug3oXQkwX+8fOKa
	BUiPGMNhH+vQOxMODqehf9OkbuXacSFNTk8taEn7T216J2zBTBI+8SX4YXrRTEkl/Wd+gZAu7UQ
	I/piXQ7S8JXRL9ZSBCjUEsQrhuWt9AFWQsWkjsaIraFuZjRfyP3ib0liP8hMbJXBXOCSINCZp6C
	ZsjMBV0MT64mbBTxmxR4o9oyO2ZRohyO/nm/om3/Va9Eg5claERaG5d/iqIqAvuaQdUi7KwR2OC
	0spqETKxAoEXkXvfhc37HbijgTQgoT/VhOrzKptG8YteaMAsDjdU/NjjTUkQ==
X-Received: by 2002:a17:903:1aaf:b0:2b2:4fc1:f653 with SMTP id d9443c01a7336-2b5f9da4c95mr51877695ad.3.1776496359139;
        Sat, 18 Apr 2026 00:12:39 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:f0c3:ed1d:cde2:5283])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1763dsm37651375ad.23.2026.04.18.00.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 00:12:38 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: delete unnecessary empty lines
Date: Sat, 18 Apr 2026 16:11:51 +0900
Message-ID: <20260418071217.13866-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_001240_773299_9FD63DAB 
X-CRM114-Status: GOOD (  11.78  )
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

Also fix a comment indentation error.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/apple.c | 1 -
 drivers/nvme/host/core.c  | 5 +----
 drivers/nvme/host/ioctl.c | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..d1ced4f38a40 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1061,7 +1061,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	 */
 	if (!(readl(anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL) &
 		APPLE_ANS_COPROC_CPU_CONTROL_RUN)) {
-
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


