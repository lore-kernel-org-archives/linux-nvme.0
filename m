Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EEBC433E8
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:06:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9555D206C1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y08gOoEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9555D206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xjagljQHsUuEmf1M23or5YYFknArotjqWuxyIMfpOB4=; b=y08gOoENMQ7HVSD0cGRmhEke/
	CPWCaCAcvj9qB1vaQoypY96WfUD01UuMOlDr5q+7Ip+a3PTJmpWPPnEXNMLtvf9O3c4LNFYh/uOsw
	xxOIzA6aPZyREtD2H8fxLOfa7SRmHlD+OG1cqYOjZs03U9827Wd2010vXRN1nQqLxDvwUh3ne+ITa
	Astt00FukqEuVetj0G5oEEDAYM0aiIYFYeOLc7jrKqTVElXQ0pkh33AIpH/gBMi3WxonjXOGMbxND
	ctxsxheta2xb1I6bEvtR7XLqxkg7rsa5jqcMiAVi9IVOWaUbv4bDIWUDqBf4j4B02lqssI7XP6dnY
	mrWFtj8oA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz6lf-0002kc-DI; Fri, 24 Jul 2020 23:06:19 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz6lb-0002j0-JL
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 23:06:16 +0000
Received: by mail-pf1-f195.google.com with SMTP id t11so6066921pfq.11
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 16:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D1flcxeC3p+o5DtKhKKbBmp7SrZT3kR/FCqklJLBgh4=;
 b=GBdHI5GnrHat5FaLXWqF47rU0ABEmM7xpys304DzCyO+/SkbCOd3RdZ8S8fnmhHi0O
 ru88mUmaE97tQZxxNpMytjf04fP1D7X8oHb5V0g2UeXuikPT9r0vMHZGUWyYioEpEl8p
 G4ximWbZsdGj8S8+MSx9DccyMe9mma942fj2nU3THZzidHe5aoluA8RBEZJTCuExGmD4
 Fhx1hyF8OkdMBqn04hAiIgetJeDhDdM66qEcnQnGARfY8i3GDsIpXC/IMQOECgV06QEk
 x4/nZ/WWwRkSy5/hS8RQTA6kIGZElDh3RSEoIYbh6dqtN0XUyrIqNuzV6Q4ETI04F8wO
 sfjw==
X-Gm-Message-State: AOAM530y1HXz/jNN8m2eNJwzHZmdMShe6kXi/4NWC+wXQ7UErzWcwKI0
 ch9dKiFOmOL1nyaNiY3cuExGScCe
X-Google-Smtp-Source: ABdhPJydIrfPSYYjrG3JJi9b/HLmbE5ilHAy+xWfpcCKQNnOzwOyrIGk6ProsVTprypTTM4ZR22dgw==
X-Received: by 2002:a62:6446:: with SMTP id y67mr11223215pfb.299.1595631971517; 
 Fri, 24 Jul 2020 16:06:11 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 129sm7552379pfv.161.2020.07.24.16.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 16:06:10 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc v2 3/4] nvme-core: reduce io failover time
Date: Fri, 24 Jul 2020 16:06:03 -0700
Message-Id: <20200724230604.34625-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724230604.34625-1-sagi@grimberg.me>
References: <20200724230604.34625-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_190615_680278_53C10C32 
X-CRM114-Status: UNSURE (   9.98  )
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
index 2ae8caa4e25f..e3fae68f7de6 100644
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
