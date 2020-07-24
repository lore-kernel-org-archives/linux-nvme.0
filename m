Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFE0C433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 21:55:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCAB206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 21:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VlnKj/ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCAB206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Gp7UCKUYNvjSiCgJ6dEw475yt5pUCtO4kx9viFPeKOI=; b=VlnKj/riAc72dqYk/X0GvDJkY
	AOea/JThpcpvjcv+dCGaN6sEAqjtGXyD42LxRWLHleMCKUP+riXDU+eUEf/LWK6T4DVedUihO1HNg
	ot//LcSF/ywNZMqxwHSsJNKtS0fKTJ/xL5ioOmTwAae54+LMVtCxSTVCjO6NUHKTxr1u7BvdFdU1E
	XgcVrUpmaTUh7pG+WzTLxHAQqAWlfaKYYaH4gn+LlMPwqVMB2nZeco2KKa9Zv1rpq8aozcf0fvvm/
	ruGU7s4lP8Vo/dgf31HUNYv6ymMeNMmry8ztihLVHOk/39YYE5euJvTEjg9q08Rf3kFrABQVWTsoe
	Ax74mYkYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz5em-0003TQ-ME; Fri, 24 Jul 2020 21:55:08 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5eg-0003R2-U8
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 21:55:03 +0000
Received: by mail-pg1-f194.google.com with SMTP id s189so6153170pgc.13
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 14:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j1HtTpqO4/D5V0K9QT+SO6JrW5GfoQgoJAt8lEykY1U=;
 b=ZUxh9+6ZBkr2jiXNh2/TyWvnVtRd/25FzTcSRFrssnyelGtZC+W689S9wq0ohngUfe
 rWmjyz0tmr95jglexhMgw6EcdIHhmL89Mf6SFDMGwE8Io8eXjN7mkcznSnZ4vBX0pgdD
 wf2vIwvdJ8+c7y2nCX0D4crK2gwdKfivI4InaIM/4rBxq4Ve1SeSIXcq4K+lul4JzcmD
 cc9LvMdimNW9k35h3BsRiSCEIb8lwXepH7RYBQUMLteqSk1NzXrg78kz5OYWfPQgrrh2
 0J2iwOzSnN00frlKxKkmGRx0TbQqYqu9GNVk1U8p0PGSLPANpvdhq3eXlFE6HQbNh9gc
 bdGQ==
X-Gm-Message-State: AOAM533YivAgO/T/jkgwuVclYF7L97urZrEfDvt+aiLTkG2jQ/Iddlqj
 2dhqygDAkkcVNCpBqQ0I+f4M92Lk
X-Google-Smtp-Source: ABdhPJzUtl/qj9KEff4jcdK0bET+wQr4L8D3TKyRpwOXEOM08TBTjEsfogw9bYLFx9+t/p3r9X6GKw==
X-Received: by 2002:a63:20d:: with SMTP id 13mr10350275pgc.166.1595627698414; 
 Fri, 24 Jul 2020 14:54:58 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 144sm7565112pfb.31.2020.07.24.14.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 14:54:57 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc 3/4] nvme-core: reduce io failover time
Date: Fri, 24 Jul 2020 14:54:51 -0700
Message-Id: <20200724215452.26401-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724215452.26401-1-sagi@grimberg.me>
References: <20200724215452.26401-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_175503_024403_261E2FF2 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

We test nvme over roce fail over with multipath when 1000 namespaces
configured, io pause more than 10 seconds. The reason: nvme_stop_queues
will quiesce all queues for each namespace when io timeout cause path
error. Quiesce queue wait all ongoing dispatches finished through
synchronize_rcu, need more than 10 milliseconds for each wait,
thus io pause more than 10 seconds.

To reduce io pause time, nvme_stop_queues use
blk_mq_quiesce_queue_nowait to quiesce the queue, nvme_stop_queues wait
all ongoing dispatches completed after all queues has been quiesced.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1a76bad226e..0796c448a3c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4548,8 +4548,13 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		blk_mq_quiesce_queue_nowait(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
+	/*
+	 * BLK_MQ_F_BLOCKING drivers should never call us
+	 */
+	WARN_ON_ONCE(ctrl->tagset.flags & BLK_MQ_F_BLOCKING);
+	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
