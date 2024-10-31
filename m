Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D52E68946
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3Uzx9YXCAgUL0b0ptA2ChqP59cVGDdWu9ezqMEtWGdU=; b=lvjpnhz8HYDXym8mMZAwHhCd+i
	/PdxajAE1v1GJvdhVzUaXN4g/478CEv0PXv37oUEUt9bwh/Kaa7qOvLwYNrW24fXGVur5fVPE355Z
	AkdeB5p5lfLpkfJKdo3CJVBLSj9933dlbj9JgR5hPXHSaVp1j54eJTrtH2vefuSE+JWZnASVNWO6b
	PZ1yVJ5eMIYAWbUXdQvekVA1pbo1Xs7xb5ClGMuo0QSMUbKCeay7NFWtvBnwnPs8q3kmr+YVMFBYz
	goOS0kr+y8fnXegABIp0rMgQKd3O9S3BBFO6x6QrqIyFqeicj0wK2WWBg3YXNfw26GqPAABk1t7eg
	98+Xwf8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6KuL-00000002Lrp-1FJG;
	Thu, 31 Oct 2024 02:27:33 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6KuH-00000002LrE-48R7
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 02:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730341646; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3Uzx9YXCAgUL0b0ptA2ChqP59cVGDdWu9ezqMEtWGdU=;
	b=VG7euqe34D152duA3Cn0TZdIraJW6ZCGr5gIlJ13HFlsSDbBT4YHFL8gzxFhnp0yontQYe2HuwUg/ZiDEgxgkmGAvCEERkmif3rn73qf2lgPgU3+QeHZqFr5UDYR09Ur4OPvXAtgKeDiZJ2Iaeow+LT1l8mJEWXHVGIsKHae17w=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIGaix-_1730341640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 10:27:25 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
Date: Thu, 31 Oct 2024 10:27:20 +0800
Message-ID: <20241031022720.27202-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_192730_542447_6DE7EC86 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
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

In some complex scenarios, we deploy multiple tasks on a single machine
(hybrid deployment), such as:
  1. Docker containers for function computation (background processing).
  2. Docker containers for real-time tasks.
  3. Docker containers for monitoring, event handling, and management.
  4. An NVMe target server.
Each of these components is restricted to its own CPU cores to prevent
mutual interference and ensure strict isolation. Additionally, we make
the nvmet_wq visible in sysfs, allowing for tuning its attributes
through sysfs, such as cpumask.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ed2424f8a396..15b25f464e77 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1717,7 +1717,7 @@ static int __init nvmet_init(void)
 		goto out_free_zbd_work_queue;
 
 	nvmet_wq = alloc_workqueue("nvmet-wq",
-			WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+			WQ_MEM_RECLAIM | WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvmet_wq)
 		goto out_free_buffered_work_queue;
 
-- 
2.43.0


