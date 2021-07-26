Return-Path: <SRS0=7ItS=MS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71C5C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 13:24:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B4B6056C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 13:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69B4B6056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QmZRf3bhBDruCF7H1O+w+5/iY/BvcgWUbdXu+mawG/Y=; b=gDWcRW0qz7PtSX
	l3AWyCMCnaVJ4BhC/08wDvbsifX39njsTgubRrZ+Nb120yf/cW7eUBBtFcFWKlHg0bfYR+OfJ2QGH
	2yJBD4Nh8x71Pq3DUCLVWbRqWEIl6elZfIyYerUz1b/nUi3onYFHNTgUnovLD3ULnkHSgSfiKb3fc
	1dW/YIGAzmVTMKaGP49DAzy3W8OJeapZjbEqBwl6GlDyHWhDRof/1hGNcUtaADde7F8rQg3fXs1Z0
	lJZXNJETIls8X3ThKiEtQB+lKi+mHjU4+HmweWZ/VYSvkY7A7D8PCN0J7fcd5ORqTnewjp0B7RKVz
	9JOFzkRC3uwUaXDi7WzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m80aa-00BJ69-NE; Mon, 26 Jul 2021 13:24:12 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m80Zs-00BJ1k-8e
 for linux-nvme@lists.infradead.org; Mon, 26 Jul 2021 13:23:29 +0000
Received: by mail-wm1-x333.google.com with SMTP id
 l4-20020a05600c1d04b02902506f89ad2dso2148097wms.1
 for <linux-nvme@lists.infradead.org>; Mon, 26 Jul 2021 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vUFZDTLZHnU1oCPFZuxkDptiIQaZJMAsbw41GQLH7/Q=;
 b=IVoYLwOw5JN1oCFRdvUg0eLbzGchcEB8nZCO7lBZhKB/8147IS7l3Yk1H31VVU3z2A
 Zzi36BJr0BwAccqS8ToN9U0HVBotwuEE+JTetVSy8mpum60gIVHO2OBJFS4REbtEP5Oi
 vBzB3MZLaBo0vQc1+kq0IDflWaKKybxZ9qT7Moyo+upVzVdzOvn14PwjsxfsePynInWd
 +DTZmblbrQJDUK1SVfCaP4ayBNbBH4gU+KS0arMq8rxDVwZzebCB8org+MoHCC5Sc/zw
 HVp7edtE6LYcA9tWPN26xxlWcF/pUlLJ+f9aGbf1ttBJbJbBBJ7MEIB4xL4/pb/rcYDH
 JywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vUFZDTLZHnU1oCPFZuxkDptiIQaZJMAsbw41GQLH7/Q=;
 b=YHhwWh1UHpuEKEEK9RYy5LMVlZDb0R/A6LOTxUxWfnyFdPDlD/G1EMMMhUEWI/RZkh
 ppZZzDveEjUOkWWQEHtKqEo9bOB1i7Y3rDW/UolG8t2clwFV38lPXHVRGuH3rWyRckND
 3DnbFiQhqzWsKBdTbxu+1pIl8pj6zWcRCpWQz5H3oWd90U6UPU/C/xCPjJEH1Lf909Bq
 qXOqxTNhkVR/e3sUOGRoO5snoC8I4acJmnkG2COZaqRaYZdaNjLBc/tqNhQStVKhnlL9
 f+BWUv8vpzCKa0BcT/VZ+ixetkylWo4IdtfadyLGWVFympTGquC9CsyAg+Ba63ap78sQ
 VdPw==
X-Gm-Message-State: AOAM530stOTq1wKwz8hZND+tSzaVwPr8a6SObobilvk1nnQmTPTjD0Mf
 kw8tnCgGJyNOM9vQtMatWAD4RGwu23RPMtuj
X-Google-Smtp-Source: ABdhPJzcV8t+TGXZXIiVaksrhgLSCW6B1efSSPRuIX4BgWqT3wYH/A5WVMjNZNNYTKPji0dxHBj9ag==
X-Received: by 2002:a05:600c:4f48:: with SMTP id
 m8mr10032791wmq.22.1627305806793; 
 Mon, 26 Jul 2021 06:23:26 -0700 (PDT)
Received: from microndev.lxd (ip5f5ac0ff.dynamic.kabel-deutschland.de.
 [95.90.192.255])
 by smtp.gmail.com with ESMTPSA id w15sm8580wmi.3.2021.07.26.06.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 06:23:26 -0700 (PDT)
From: shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
 linux-pm@vger.kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v2 2/2] nvme: Add abrupt shutdown support
Date: Mon, 26 Jul 2021 13:22:23 +0000
Message-Id: <20210726132223.1661-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726132223.1661-1-sshivamurthy@micron.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210726_062328_334201_1FAF6257 
X-CRM114-Status: GOOD (  15.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Enabling the abrupt shutdown support. In this shutdown type, the host does
not need to send Delete I/O Submission Queue and Delete I/O Completion
Queue commands to the device.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 drivers/nvme/host/pci.c  | 6 ++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11779be42186..760ffb071c1b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/nvme_ioctl.h>
 #include <linux/pm_qos.h>
+#include <linux/suspend.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
@@ -2159,7 +2160,11 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	if (pm_power_loss_imminent())
+		ctrl->ctrl_config |= NVME_CC_SHN_ABRUPT;
+	else
+		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 320051f5a3dd..07be319f63d9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/suspend.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -2524,13 +2525,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead && shutdown && freeze)
+	if (!dead && shutdown && !pm_power_loss_imminent() && freeze)
 		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-		nvme_disable_io_queues(dev);
+		if (!pm_power_loss_imminent())
+			nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_suspend_io_queues(dev);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
