Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E35C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:05:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A50164E99
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50164E99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dBP/sNGr42fii+OroQJy3J/93m/v1Y9HWo2ZtJiiTtw=; b=Ut5EJxtnjkL1nm
	v1cvy0US0sLi26GaMDTt3lX+epFq9XOpEqDf2b+CjO/30ryQNltXCP5URZ5jUeq1gYdL5LSfzVUTU
	tlKTo+iT1KRsgUJpAYVgfqlkQau0OwuBDv3KVC1OflxlcPcf8YeQlqn9QyW/rpcGavswAVRniiFLj
	mf/qDG56E/cVz+lVCQB5OppVp3NYivllgDgy7u9NwXyYNygM7XLQHcO4q8V1iY+kr7b0NrPCl8/Kb
	beg4lLtJnklS0ySXmht1Fr1PeBi7/VMLgmQR3NMzNfYANVtxX/qaPCRAwXH171OJWRAZTIzfDbmFE
	iqCAjw9LSGWZvbpFU7Qg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuOR-00Gtfp-4M; Mon, 15 Mar 2021 21:04:51 +0000
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuO8-00Gtdp-JV
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 21:04:36 +0000
Received: by mail-pg1-f179.google.com with SMTP id o10so21208481pgg.4
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 14:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VEvqSAm6uRb4FT1LiZ8J1hU4sU9kcchMcdH0/hqc8LE=;
 b=Vb/2+uY7rXz7niNGj2fFII0bOcxqq5Y2IxVBak3hMel6MEE6B8kcBA0zZybglrmukK
 k9eJlOzJF9YCq70tUt5KQQXavzR6PO88QCHbfsbaxVywPdFVME11z3mCcZ90QZE0etuF
 B215SVPDjCE11ODc9sVOqp6necBN0hp+5p5X+/xQd77IT0F8MwU5LltQPauIbaLHuuPL
 gtQblUP7f7I5H1SvVeCklTNhSTU76RJ/ux3wN4PD2lYqqK5P6OqrLFj3IEkV0kuNt05H
 jNY7POWxLXQYOBA4aPQY8VN0l4jVxFVPh+3twufHayzrXyDp6xfUEIaf0I21dzrb1lkU
 zAQg==
X-Gm-Message-State: AOAM5332iuaW8GZHUOQ2PjJM/LcnJIL3uD5EA2/VeVMhwPzB9miMjVM0
 NVlJDnToACZisU0D3q8VhPq2NWqt43w=
X-Google-Smtp-Source: ABdhPJzCnISMrmoPDJLklK5zACahK0fr/PWjAesaoIdCsHyDIdE3M0H7FnMkNheQlgvnaH4Dh13N2g==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr882591pgm.304.1615842269989; 
 Mon, 15 Mar 2021 14:04:29 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id fs9sm511042pjb.40.2021.03.15.14.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 14:04:29 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Chao Leng <lengchao@huawei.com>
Subject: [PATCH 1/2] nvme-tcp: Fix possible hang when failing to set io queues
Date: Mon, 15 Mar 2021 14:04:26 -0700
Message-Id: <20210315210427.357584-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_210434_898217_A68CB43B 
X-CRM114-Status: GOOD (  13.41  )
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

We only setup io queues for nvme controllers, and it makes
absolutely no sense to allow a controller (re)connect without
any I/O queues. If we happen to fail setting the queue count
for any reason, we should not allow this to be a successful
reconnect as I/O has no chance in going through. Instead
just fail and schedule another reconnect.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5274cc5800f9..31e4e59f0866 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1752,8 +1752,11 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 		return ret;
 
 	ctrl->queue_count = nr_io_queues + 1;
-	if (ctrl->queue_count < 2)
-		return 0;
+	if (ctrl->queue_count < 2) {
+		dev_err(ctrl->device,
+			"unable to set any I/O queues\n");
+		return -ENOMEM;
+	}
 
 	dev_info(ctrl->device,
 		"creating %d I/O queues.\n", nr_io_queues);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
