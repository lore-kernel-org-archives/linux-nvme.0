Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A562AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:05:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C65164F0F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C65164F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nLaA0quhvk6QagJB+XeBbCdBhTjrgv6QkXWkkg+C3E0=; b=DAtwouAES/iKchTC8LQKIHrOi
	fHUqus/BBDjhnt/OeehrtpTM+iTiwbTF1pdZEZzkuAIaernpDZp6DDlMbidWqMDBjJi7fpo0tUO/X
	4Pk54FlYAt0PeMVrloSadilqsE+SNndTHp1+sbuxpf0shdoDCI2+Qw55+dzV47hXlKLO0NIoLwcyO
	YTd0bMHOx1H+lqrDun3BgtxOnXiA4ABGtPYTpiVedS7NORtRcMmVNiPIpN+5phJtqfpa7D/jbOA2f
	awfy5h6scfr/AOUuAY7LXDMsGtSPw+/ewFfyOpSSj3AVKzy1BkFP+qYT0vtOJlBpDsh9ZIkXSMnl2
	sfwsHe8xA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuOH-00Gtem-Jc; Mon, 15 Mar 2021 21:04:41 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuO9-00Gtdr-Es
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 21:04:36 +0000
Received: by mail-pg1-f180.google.com with SMTP id 16so14783076pgo.13
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 14:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6BRiFR2fomYX4tovWVF+UalcgAchmn+TvC0m9tW8oZQ=;
 b=qu4NEElnBExY4IeR5zuEpuixKdMKXxJEvr47aOdc0S1W8lvcpJFEiJIAcQk/6IMU4L
 zHUO1cbChoa/JHF+J9smoGngcpsrQbRucpOqBv1IV5RmOblWfArQylvelqDawX3fidew
 XPveMDTsKqpzdTbb2KZHSpiSMn+aQoj5dMOfvYguUpZ1qDFrk8Mqmu26vcGtSrJJCaXd
 HXtPdYIZoskEsSX+sBQm1rXTuE11hV6DkzkdHtfPF/VwoyyxmBNMXrN55D6eLfaH4Xue
 jiDb3tYs+twFce5QaH86rawyv+K1SYMIamtpzbTpamuHR93vFOeWlGcszw04RL/IKMGB
 OrqQ==
X-Gm-Message-State: AOAM5320upFHE4kSJjopY9MQb2A3DHIEGP1B0kiBw08aSkfimjDmqFhj
 mvtHfIndF54CEk0OxYT/j5KK3AXJDDM=
X-Google-Smtp-Source: ABdhPJyr8lzbsxXiz+z74Oysrp0t3MYL6jMUNoxnivPqdIiHHTo/tOomK2zIXr3Rb7+1Fjo+JBWexQ==
X-Received: by 2002:a63:1026:: with SMTP id f38mr901567pgl.142.1615842271077; 
 Mon, 15 Mar 2021 14:04:31 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id fs9sm511042pjb.40.2021.03.15.14.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 14:04:30 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Chao Leng <lengchao@huawei.com>
Subject: [PATCH 2/2] nvme-rdma: Fix possible hang when failing to set io queues
Date: Mon, 15 Mar 2021 14:04:27 -0700
Message-Id: <20210315210427.357584-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315210427.357584-1-sagi@grimberg.me>
References: <20210315210427.357584-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_210435_037375_6F7A7271 
X-CRM114-Status: GOOD (  14.03  )
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

Reported-by: Chao Leng <lengchao@huawei.com>
Fixes: 711023071960 ("nvme-rdma: add a NVMe over Fabrics RDMA host driver")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 53ac4d7442ba..eb093ea5ffa1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -736,8 +736,11 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 		return ret;
 
 	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	if (ctrl->ctrl.queue_count < 2)
-		return 0;
+	if (ctrl->ctrl.queue_count < 2) {
+		dev_err(ctrl->ctrl.device,
+			"unable to set any I/O queues\n");
+		return -ENOMEM;
+	}
 
 	dev_info(ctrl->ctrl.device,
 		"creating %d I/O queues.\n", nr_io_queues);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
