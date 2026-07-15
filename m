Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77697C44501
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EFUaahqQTIsq/3mncvKpCUZdl3I/8KWM6M0gU6bQrhw=; b=ZqCtaKzDyh2uSiDCgA0hC6T5T+
	TiLeiv+F8ZL6VxMO6ZCprbiaCXr1AvSdXr84bi3I7O4wBpZRLLUT8mw26QK5fmVbDEKz2PQ7baUi8
	rPk8ZmgQuKQP9j3H16BMILGZ0up/eQM2bgOnK4f0yrZpENqQwgkV0OilgUxg44ZQVOAS+QffNvDig
	GHTAx2urut7T428GkwAtsIggkfqQSQffd3PA3wSfEaVBBwcwgP7knLqsTzbDQ9IKDJ5KHuYuneSb9
	I1lggvyNHOxpbGMeO6Ce+BBYFSGz0Yi3pFIkLEtRlwlDfM8XE1Xkrz9WhfxFmNXz/MzyDFByjBNGl
	eLJHK3Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjy2T-0000000Ec4v-13h0;
	Wed, 15 Jul 2026 11:44:33 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjy2R-0000000Ec4W-0tyq
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 11:44:32 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8486672f03cso5034938b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jul 2026 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784115870; x=1784720670; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EFUaahqQTIsq/3mncvKpCUZdl3I/8KWM6M0gU6bQrhw=;
        b=NysYqZGnLEo0gN+3o2EqstzWou9dzrOSJyahVFi6SxvLCouqsUzXw0K/6Sw5xodxnx
         mmjJe+IFcxVaxKZ7lBq4twHHXqOAtvdU2EDYl8bsknYC850M5PoDc4wZY9n5HtVhbnYd
         utyd8nYTdBccZwuD9sdvjjLAJPW7eGelq2tKqKGZrR/S+xU6Qezc/Wgjk2FVnFtudC3V
         bgpT6/xZ7bjT745i6ezQ92cqIZx5YC6FCwZ5l9RYdGDmzv8Dq/5bmGHAgVnC9bkT6YDv
         HjuPRHhgzFxwUw1YoW6IWUoq5nEDKmwesF4ILykcMybJPpLAsKFDmSFTGSI4SWENkR8H
         t1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784115870; x=1784720670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EFUaahqQTIsq/3mncvKpCUZdl3I/8KWM6M0gU6bQrhw=;
        b=jD+1fPPKMqtOL4JhN+MkJi+GNnAjwOwa4X9TjqoMXYdt2Hg37eD6IlQ1kPZtBBWcaL
         FBX8wWrcUrYAtvRoOeYOF66k0ecpjRUpfPqZdwQCsGYZAitY3JDUx3MRn9ixfkrZGW92
         ASaYjiwW6C7bRTLtQR6Bx5PiW79w9LRHM0muko2D3zxMvzyajbfAOuBj06XeOR2XVvoZ
         TLEHUMLSLWYveVZ1pxPggSWDMBg66Krxhyb5cCXf7JEkzs0Wvw3HUMC9svVFDdOKrH92
         YWEg9Utmt0z90Z/U6yngXKZqq6hPpZrjBOCiwewS7dU/F2ToogvGM1qGmATKPy3szQuo
         QYgw==
X-Gm-Message-State: AOJu0Yyf/5THMXEZEzjO3QwJSEQV85gtUEWvrYhlFrLxsXWrG9wN71v8
	dwLHSRu3wqJ4O7uErjZHKtLDRFVqYNjwLBh/IjHbkOQe7k8kEuVCaW4D
X-Gm-Gg: AfdE7ckZpaX8zmXuOHb25uCYc/CZbQ29di+azegfdbm92UYic6SxZNGK6evQB/dqQH2
	EiZMNL7TpphKIUuf+epvcgzvgsKLSvdM+MwUUBu0+ZNMXxCmb35LAnXZjNjarRFIC88JSy5iSTf
	DDFDNoe+pf7zHuqdBVLpNKKjO8DHQ3jNXX7L09Up2NB3K2S76OlqxRDCFGl46SBtrNyZgrK8J93
	MY2Rs0qEBAoUj8Uc03vgDsoaGA6dSbsIzjSO4ewyg6L/ZcbNsJFHU+N+TarZ3fa3ZYSlaIoIMWf
	3MuSxW548Axatk/WlAwRA8EK77EXnIY3Pgla/0M6bMuoNyns8zh4MLcJJl9IAzDRtAOOMVf8M0A
	om6Hk3imf92t3e85CXC2WnD9q39YUuJ94jxUE9Xne85VK6K7i/IJiA5bPBJfm9KHgtlLmeKSQIv
	5tteJ1
X-Received: by 2002:a05:6a00:a883:b0:848:56ff:6ce4 with SMTP id d2e1a72fcca58-84a671da4d7mr2162722b3a.5.1784115869748;
        Wed, 15 Jul 2026 04:44:29 -0700 (PDT)
Received: from n232-175-066.byted.org ([240e:83:200::35e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238930sm3021341b3a.3.2026.07.15.04.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:44:29 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: [PATCH v3] nvme: reduce firmware activation poll interval
Date: Wed, 15 Jul 2026 19:44:01 +0800
Message-Id: <20260715114401.1084214-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_044431_262037_11FCD146 
X-CRM114-Status: GOOD (  12.82  )
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

From: Guzebing <guzebing@bytedance.com>

nvme_fw_act_work() polls the controller processing-paused status every
100 ms while firmware activation is pending. Some devices can complete
online activation in only a few hundred milliseconds, so the fixed
100 ms interval can add up to 100 ms of latency before the driver
observes completion.

nvme_wait_ready() already uses a 1 to 2 ms delay between CSTS reads.
Use the same delay in nvme_fw_act_work() for consistency, and add a
common helper for both paths.

Signed-off-by: Guzebing <guzebing@bytedance.com>
---
Changes in v3:
- Add a common polling delay helper for nvme_fw_act_work() and
  nvme_wait_ready().

Changes in v2:
- Drop the module parameter and use a fixed 1 to 2 ms poll interval.

v2: https://lore.kernel.org/linux-nvme/20260714092846.3381169-1-guzebing1612@gmail.com/
v1: https://lore.kernel.org/linux-nvme/20260627010610.47768-1-guzebing1612@gmail.com/

 drivers/nvme/host/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd09..499fe36792266 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2688,6 +2688,16 @@ const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
+/*
+ * Wait between CSTS reads in nvme_wait_ready() and nvme_fw_act_work().
+ * A 1 to 2 ms interval avoids excessive register reads while allowing
+ * changes in controller status to be detected promptly.
+ */
+static void nvme_busy_wait(void)
+{
+	usleep_range(1000, 2000);
+}
+
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 		u32 timeout, const char *op)
 {
@@ -2701,7 +2711,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 		if ((csts & mask) == val)
 			break;
 
-		usleep_range(1000, 2000);
+		nvme_busy_wait();
 		if (fatal_signal_pending(current))
 			return -EINTR;
 		if (time_after(jiffies, timeout_jiffies)) {
@@ -4813,7 +4823,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 			nvme_try_sched_reset(ctrl);
 			return;
 		}
-		msleep(100);
+		nvme_busy_wait();
 	}
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||

