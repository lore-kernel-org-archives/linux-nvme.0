Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0553C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uR2n9vqmHYDmRi4Mo+EM5BpT0JuFoc+JmwQnzy9M4Yk=; b=HIgS+UpNJdrjSvh9R6NSuVIPLF
	WB8WPjlTVv/8sxGja4cpZdwp5IQjzMeovLb/EsIiSnGLLlGtKnsLY37TBjLznZMPrQlGqAhunhkou
	6+tc1ILtITmY7ZZ1bQxLAKKuY3wAETON3y1Q8DcSQcsWhaD5JYmRxyZvCoWSup/zXocTxWASy9P9S
	+buavtCEgF5VyKzrdI8tWE3wFiTmRlLA5s8tREhlTG4kf5KG2I7GTFDrS2upJwyX9Ts5z9WYqj8uC
	hMYkoaldUX8VWV8f/b0sqdipHCRe+WgND3LgkUgMKirlhz7e37iWxSWbE+39MXWnzHznQzkckgL5B
	4O2RSleQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBaf-00000004D7a-3ejK;
	Thu, 07 Mar 2024 11:07:09 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBaZ-00000004D66-3QQO
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:07:08 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so438507b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 03:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709809618; x=1710414418; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uR2n9vqmHYDmRi4Mo+EM5BpT0JuFoc+JmwQnzy9M4Yk=;
        b=MqHru+V750JWpNb4+Zd8EV7j6ASRN7uh7fyRYoph8kzVW4eJoqqmaonmDAyU6KP9/g
         AgOrw/gggaXg4R1gXBDCFn3c/e1B18GS405Cb/cXcyDRZpruObYxSW1mDiqj0cC9pZXC
         954+iofshhDg0qUxVYvwCUExaqWcMh7RfqRjQyQyncwKWBcrsNTwxr+RlMvnT/bSG9MR
         zByhRhD9pHTAm+Et0DKTgwwMQ2MAPkXFOgpd1jh4AY9d0Ck/dTmralnPTKgo4BINX6qN
         DgzvZeMrKHtgzvkOMXozHH51oZJKJwzdZfbGXWJBve6scbqw3o0/xVx6PnEtHZyog5ww
         OOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809618; x=1710414418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR2n9vqmHYDmRi4Mo+EM5BpT0JuFoc+JmwQnzy9M4Yk=;
        b=fvziuLcSA15zUvzfNgc2Z7VuHzV+3RGkpVzi/6Bgn21uRhwgp5fjgV4YU4J/nMZx7u
         osaL4jIg7naxUoAbFlgge+r9rwiTC6XcuobD9atzV2Sha6R1ayoayeM7fo1RHx8UhpVV
         OXpvgsYUI1mTDxiWyk6HCOHysFiHWogHkAyoWQ7d3oCsU+wvviclIG3dDvkLydClaqDv
         6XXjLDFYfSPI/k/qDZPQA9Axrjc5qv9DeYHLvCipGdr+NQMYcT0Zyw4msq5W0GNlTYul
         PywU/nqXtS9Qo4jy0IP4Gw1OHqOmMTNIBPrThLN069F3J36KjhaUZbgaSIuTh1Rb7zig
         w1og==
X-Gm-Message-State: AOJu0YxCDNYuS4ENykA7cu1QHknai0oKDQKMoroAHgS4GqGMRbERyi17
	8y88bjyptXFni+t8liaIP3qmi5hg5uAAuyb7G1rFwTIb52fX6iaz
X-Google-Smtp-Source: AGHT+IEaTzs45VumZZImiBx+kdUqEeJkyq0RDS0XcfTiQIBbtVQ0nQpC27vWSszWIKYpSdti4zlvyg==
X-Received: by 2002:a05:6a20:3114:b0:1a0:a06e:41cf with SMTP id 20-20020a056a20311400b001a0a06e41cfmr5752759pzf.32.1709809617767;
        Thu, 07 Mar 2024 03:06:57 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id n17-20020aa78a51000000b006e56bf07483sm12297854pfa.77.2024.03.07.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:06:57 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme: fix reconnection fail due to reserved tag allocation
Date: Thu,  7 Mar 2024 19:06:57 +0800
Message-Id: <20240307110657.252120-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_030704_113918_87015B54 
X-CRM114-Status: GOOD (  16.69  )
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

We found a issue on production environment while using NVMe
over RDMA, admin_q reconnect failed forever while remote
target and network is ok. After dig into it, we found it
may caused by a ABBA deadlock due to tag allocation. In my
case, the tag was hold by a keep alive request waiting
inside admin_q, as we quiesced admin_q while reset ctrl,
so the request maked as idle and will not process before
reset success. As fabric_q shares tagset with admin_q,
while reconnect remote target, we need a tag for connect
command, but the only one reserved tag was held by keep
alive command which waiting inside admin_q. As a result,
we failed to reconnect admin_q forever. In order to fix
this issue, I think we should keep two reserved tags for
admin queue.

Fixes: ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c    |  4 ++--
 drivers/nvme/host/fabrics.h | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..3d394a075d20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4359,7 +4359,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -4428,7 +4428,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
 	else if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..a4def76a182d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,12 +18,10 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
+/* Reserved for connect */
+#define NVMF_IO_RESERVED_TAGS		1
+/* Reserved for connect and keep alive */
+#define NVMF_ADMIN_RESERVED_TAGS	2
 
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
-- 
2.25.1


