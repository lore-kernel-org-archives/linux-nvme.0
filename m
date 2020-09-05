Return-Path: <SRS0=rLKq=CO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DCEC433E2
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 04:28:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57C320E65
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 04:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NGS03MyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57C320E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8GQwtsCrLHiKPbVki1WAjpLqww/oKi9n7HdJW/rwDuQ=; b=NGS03MyGxNhLGtYV44ueQmpVsB
	MyTgr34elw7/uSCSD5plqoX93It5M8px/5N1oulsr+rRdIA+0JqIVTRlwPComK5Yiwx7EpmsKylJN
	qk03DCAonKvpUEiKPUdTzTS1G3bRlSBFif5iDsBM38XXC6teiC7gADyP1vSqJFIV89jnmXFtZRLdt
	BD4sgab1DWrnJFp760zB3G3hYRdtih7b399a6MYv81Oei+KhgYsERXswYbQV8lrzlB96HgWaWWCWb
	3//GDD2VrSd8hp6KOM2a2b0L7wWTOfMZvltAZpbHeGSDYdKupbFl9u8hGaM+bSOdlQ50cqF7+G6Am
	izuExLEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEPnv-0004mD-SR; Sat, 05 Sep 2020 04:27:56 +0000
Received: from r3-21.sinamail.sina.com.cn ([202.108.3.21])
 by merlin.infradead.org with smtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEPno-0004li-EB
 for linux-nvme@lists.infradead.org; Sat, 05 Sep 2020 04:27:52 +0000
Received: from unknown (HELO localhost.localdomain)([123.115.164.148])
 by sina.com with ESMTP
 id 5F5313B200025318; Sat, 5 Sep 2020 12:27:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 959119628756
From: Hillf Danton <hdanton@sina.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: wait request queue freeze long enough
Date: Sat,  5 Sep 2020 12:27:20 +0800
Message-Id: <20200905042720.8944-1-hdanton@sina.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200905_002748_769481_2AF0B422 
X-CRM114-Status: UNSURE (   5.59  )
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
Cc: Hillf Danton <hdanton@sina.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Apply the input timeout to every queue in order to avoid false positive.

Fixes: 302ad8cc0933 ("nvme: Complete all stuck requests")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Hillf Danton <hdanton@sina.com>
---

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4570,15 +4570,16 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
+	long ret;
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
-		if (timeout <= 0)
+		ret = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
+		if (!ret)
 			break;
 	}
 	up_read(&ctrl->namespaces_rwsem);
-	return timeout;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
--


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
