Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CF4D5B840
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 01:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z3alLAUKWweAfGt1Yn5sFh7KER21SSRlrV6DVOsyPpY=; b=GMRnA4Bc/BE8qMlyCiKbTChb4A
	DQlbmnZaiMJkhsjhuDJUAszs2QETY0ICGUIsUcsh0m7vFbAcs5wO26Gw1mArUWoE0/YSOX5IvYDWF
	LcE5n51YEulooW/upllQpfsixOlVhJ+uzyOQI+SfQsNGJoxwFivyORHRV9Uku7SCYDhDQO57zN6g2
	Fpb5hZhVwEYEN66Ca6U2YkhsRORwNk7763TQVgMTOwk1CZYHMq7UlGCi1sQMclfL5EbEO/tKmiv23
	b5Z/hJYVC5ldvsNj4xSZPkAfeXy7SvbgovuFK+YRi97qcJdjfAiHEdP8ZpV8A6ASlaiAZ/5I4j0Sd
	shwlqwBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5bMS-0000000CtXe-2BAA;
	Tue, 29 Oct 2024 01:49:32 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5bMN-0000000CtX4-1k53
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 01:49:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730166564; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=z3alLAUKWweAfGt1Yn5sFh7KER21SSRlrV6DVOsyPpY=;
	b=JGwMtXQCxKpKS6UATR9v+rNW53RjXFbRY8DLpD5cM6xfzD5z9ChWxAKJvLpBOfbvBef/pAZq0VmtxFj2KprAYD19SyEX+gtuqzzbygqG3AxXeQFV02HSrMVA8f+XXZky68jvz8VMonOO7HIjkqpEMGEmhlwmh5JynlKvD8rQPaU=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WI8IlDd_1730166555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 09:49:22 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: make nvmet_wq visible in sysfs
Date: Tue, 29 Oct 2024 09:49:15 +0800
Message-ID: <20241029014915.16646-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_184927_946775_00B00833 
X-CRM114-Status: UNSURE (   8.56  )
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

Make nvmet_wq visible in sysfs, allowing for tuning the it's attr
through sysfs.

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


