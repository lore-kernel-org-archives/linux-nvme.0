Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A9AC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 16:54:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D92C611BF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 16:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D92C611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WOaMN0+5gMAt9Xcvolh1gyHqIV28TClPe8z0kusOYXs=; b=bkmW7zO7C6j1wt7xsox0iir9r
	P910mFhwJIvEmh40m6Qz45LXN6k+MiNSmpEQiOpmH59oYCbu2iFfGKYldT0XVz8FH/mLKcQBitBET
	sMuNbY1XrKVROD2M5JMyOmwhXT945HZ7K9j8Hc3p7mHZ6m+c93V1HRRkmAiPz7UFW2RIKPOCwMzOo
	vJm0Q8o/YbKRw4xDqUWg1xz9jsisPNA8pV6I+Dp3Dl5Ixpm0mlMOj6th5hquzIZdu4Rmlon7Qwmvi
	rb3unYhaXQyCt/PX0DZtIQ7xecy9gm/soPgv4DGPBX769Kgmc4FoktDwu0XBLPHfu6nauitEsdqSO
	v93gIYQBw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXRjO-002s54-2w; Fri, 16 Apr 2021 16:54:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXRjL-002s4B-DZ
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 16:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=pahAdOjdUL3ScA5zd/wBJkufnTMDNa/OutEb9oezVGc=; b=fsrMiACehI2PKY62Jz3C8mgglH
 CnEayOgAgC4LtqXFRj0FVtXbUeULit43WtypnM2hnA+pUHWpVaeLZBOXlitTRe/Eusia51boIt3BO
 5SukgKjJNrFuCGmYtpzMmcXScJ9v6LeqVECeXjcjzY9V+EcsBXe24DRduxH1UEPUEbUZ1DaCvWrzr
 mSKcbdba3SyMF/p93qiloKEHv0h905hUhVvx1s3mUok7OVTkWG0DBGBS9NrwM15iXX+LNO1x5j8TZ
 d0EsN+qnriGcTDhYHEEl/r3QCvFaXXDOHkCTr4cwzU/K7+aOSWpYwB/PUnA/BsjptmN3iusdxNVVU
 DPUoY3uw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXRjJ-009ZbC-0X
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 16:54:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8BC360FF1;
 Fri, 16 Apr 2021 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618592042;
 bh=4BwAoZYuq6EaqLBmiYSzglPsq0jkn4ZTw3NCgs2hImE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dMEdiYxw1S3OQT+9bb26WpZwLoOOYE0EiOtelQtYkpfYq10YSIJubHsSAfS/Sj7Y4
 cIdedZtM6UoEbY2V1al77en5ibuCQALoZKswomRLoLHa1FkeR0GXPIvmfm8C9EZLZY
 MeGCe2aprMZEIh0VKOcUfcPP7gItayPQ4PrN+G0WUJK09UfjnjDl9LjEswevQaXjxs
 tyS0MBDvw8m8GVlVZNmOhvkwRLlt4vni1mpc0ZGhTcyaQQJ3qJAV9n5L0T/Ea7nSVq
 K1ujrNQKRvAB/0Tw+AEW2xkEN564eMTknUWj9kyTVacFNhsmFErrB87gio7g2c1d92
 BIIA+RWOfHMIg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Date: Fri, 16 Apr 2021 09:53:53 -0700
Message-Id: <20210416165353.3088547-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210416165353.3088547-1-kbusch@kernel.org>
References: <20210416165353.3088547-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_095405_098947_BF6FF149 
X-CRM114-Status: GOOD (  11.13  )
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

We don't have an nvme status to report if the driver's .queue_rq()
returns an error without dispatching the requested nvme command. Use the
return value from blk_execute_rq() so the caller may know their command
was not successful.

Reported-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85538c38aae9..b57157106cac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1000,12 +1000,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (poll)
 		nvme_execute_rq_polled(req->q, NULL, req, at_head);
 	else
-		blk_execute_rq(NULL, req, at_head);
+		ret = blk_execute_rq(NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
-	else
+	else if (nvme_req(req)->status)
 		ret = nvme_req(req)->status;
  out:
 	blk_mq_free_request(req);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
