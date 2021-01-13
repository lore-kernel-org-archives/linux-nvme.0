Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3DDC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:03:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3FE23383
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3FE23383
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AffU/UMNxHqZMTpTP30qlSUXdOzFe+sFPMQ0df0kgSw=; b=J7PSoxQB0ZQtln9LV1vBpXP/mW
	Q5kf4XTiuq92y4ij0Uh533AHkoGpCFji9uXFHQEbO211vNzMX27qIc/fGBaXUEaK7KlgDYX34fMdN
	91uVGwOKC/Uz6Hk8nSY9BzLqs9RYJg++h7qN6k3UjFtjlHypJOu5P3arTcnJ0gM/2qDp5GNBFt1aF
	7tdR7qpleQwRu/3Ud4pdsR3iU+Je4ppFo/2v5YF9YMKcU1xJLCoIHpxswH4ca5msCXQ0nvxCQx3+Y
	oo0g4vgXTVx6DZ6RzvXlTa/ARGRW1wbtXmKdyXgQYCIBtBLunJuj/lcg1uWcsjb3k2AjFJlsmAorG
	scluNFfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzoEU-0006LZ-M5; Wed, 13 Jan 2021 22:03:14 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzoER-0006Kz-Qx
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:03:12 +0000
Received: by mail-wm1-f44.google.com with SMTP id r4so2982134wmh.5
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ISP7PMh9NSSM8W0MFnMkIdvCxfw99iqA3t3b4iOXFmA=;
 b=GMoYL+dn2rD05hIhAwIK1HWXIjbHFmhXQtULrMDLPmrubToApEu40Zj92FvId+bhP2
 rmtWFCu/SHtwwpTyUcLyH6mf6NyQfilBLVfLCHqW6M9LzID4E5Vv3OqjSII8FccPpl+R
 caY2eVy6YwopuBxgVl+8Den2/we6MaYXLqZqFCkKSiYPVQXBbLObl/WUdfLaLKTscixO
 YtFbql9ztQrtwYs6tG0uJmfbP4nbu7/6G8zLYoREeztVnVY11wJtRlFmL+/mVZ15W47j
 cJa+n218rtT7gzjBea9nockEYlOyJOqn0PziMhVHKnCLTqQ+9kbvSqaOx9TzsFepgHXo
 8NVg==
X-Gm-Message-State: AOAM533c7FLu+lhXXqK6j3wVoCCxuR6RYeHrikI07CEwRc+nb5yhOQbx
 p0ztdb/gfuwalKz8pyukmaKC/+sRJ0c=
X-Google-Smtp-Source: ABdhPJyGEy54mtmQJDd/O5cPHZ2edpxkCuHySyRf5v90CTnjq832RPcDX3ksFOWdK8tlEwhfOSVLyg==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr1110354wml.58.1610575390115; 
 Wed, 13 Jan 2021 14:03:10 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id f7sm12681717wmc.1.2021.01.13.14.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 14:03:09 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-tcp: Fix warning with CONFIG_DEBUG_PREEMPT
Date: Wed, 13 Jan 2021 14:03:04 -0800
Message-Id: <20210113220304.1615735-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_170311_895272_E6C9491B 
X-CRM114-Status: GOOD (  14.71  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We shouldn't call smp_processor_id() in a preemptible
context, but this is advisory at best, so instead
call __smp_processor_id().

Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
Reported-by: Or Gerlitz <gerlitz.or@gmail.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f67a442a5188..4f8936751aa3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -286,7 +286,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 * directly, otherwise queue io_work. Also, only do that if we
 	 * are on the same cpu, so we don't introduce contention.
 	 */
-	if (queue->io_cpu == smp_processor_id() &&
+	if (queue->io_cpu == __smp_processor_id() &&
 	    sync && empty && mutex_trylock(&queue->send_mutex)) {
 		queue->more_requests = !last;
 		nvme_tcp_send_all(queue);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
