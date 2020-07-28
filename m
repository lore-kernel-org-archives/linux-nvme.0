Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D5AC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 00:32:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5014020714
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 00:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wfo3KRm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5014020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1digpCz31RagqWc04QqBonkkdFzs0wFHF1CIrTLFYqU=; b=wfo3KRm4ymhCW4ryneH6a5FkgU
	2I642kAmHG6XrdYHOi672p9UXbIEsWaBTmyAp4H+ocWQbqJEv7frEMns/zlxzxuX5IPxzjXh7jqXA
	fy8xMI0945zwk6RQr5H6vnd+AopGbvBfjfkQjgToBrAliG1IDSoIIc13qLCmxWWbG3SF7ZHQFdbAU
	Jbf35a6mR39zxlSBHcdghzo95grUbmgeRs1jiN97Vtn0RzipWOQJCfn1BDNXAwmGxJf5NRoYm/L/W
	m8HsijqbZYPzA0zgbBUxEJqlm/qKu39dMHBnhEk98+gbx2WIk2fjbs2cv3SCEhJlF+bwnObz9k6Ss
	M/+QaQ0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0DXa-0007F8-7f; Tue, 28 Jul 2020 00:32:22 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0DXW-0007Ee-Fb
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 00:32:20 +0000
Received: by mail-wm1-f66.google.com with SMTP id 9so15671520wmj.5
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 17:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zFAcxMhUTIj88o8W1mqNMvLIkt81ixdpsjSfO2yJRnM=;
 b=cMUfdxXzMcSBv+QpYwNeoQR6Xm9kJCvxzXEETodl9d5ZKr9N2ipN9zI+BhXKqCgIPb
 XH5SXwXrVVbI+I6a7k9qnGtdPAZcVf/u8gtrCHiP//5aFrR/3g1n5YI4psdFy427BaO+
 ONuG6DQVeHBd2WCrJvoH+ImTopa4TSaZ6ueFBk8za1fi7zTSDqGZSwP7H70jrLjN6Rte
 8C5kUmd8LNvKNJfe3N7DjICaj2F3h8H/2bwDIK7OwR4cwDl7ewQLIOC036iTcwDYjYwq
 RiFOfp8dirdhMx3QIQs3I4cpR4qZ6tjzbKL3yEOtAqi5sgcu6/YSFM1rX46vwYYtEyIt
 KcCQ==
X-Gm-Message-State: AOAM532DK2Mh51L7u5/scO0r4ul2jYTZ7dy62Gx4MJLSZnFanhrTysXQ
 NMSLV9iOiGnnhGwKOzhCyivZVARq
X-Google-Smtp-Source: ABdhPJz1jYA2R9gfgh9pUm0ul8EmYeXXLRu0sR0IF98JnKlV08lMKUXujGsuuSsx2hktdiLm/diN9A==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr1441591wml.35.1595896336789; 
 Mon, 27 Jul 2020 17:32:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id h5sm16584470wrc.97.2020.07.27.17.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 17:32:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2 v2] nvme-rdma: fix controller reset hang during traffic
Date: Mon, 27 Jul 2020 17:32:09 -0700
Message-Id: <20200728003209.406197-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_203219_467577_9629AA03 
X-CRM114-Status: GOOD (  15.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
exposed an issue where we may hang trying to wait for queue freeze
during I/O. We call blk_mq_update_nr_hw_queues which in case of multiple
queue maps (which we have now for default/read/poll) is attempting to
freeze the queue. However we never started queue freeze when starting the
reset, which means that we have inflight pending requests that entered the
queue that we will not complete once the queue is quiesced.

So start a freeze before we quiesce the queue, and unfreeze the queue
after we successfully connected the I/O queues (and make sure to call
blk_mq_update_nr_hw_queues only after we are sure that the queue was
already frozen).

This follows to how the pci driver handles resets.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- fix silly compilation errors

 drivers/nvme/host/rdma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5c3848974ccb..44c76ffbb264 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -967,15 +967,20 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->ctrl.connect_q);
 			goto out_free_tag_set;
 		}
-	} else {
-		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
-			ctrl->ctrl.queue_count - 1);
 	}
 
 	ret = nvme_rdma_start_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
 
+	if (!new) {
+		nvme_start_queues(&ctrl->ctrl);
+		nvme_wait_freeze(&ctrl->ctrl);
+		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
+			ctrl->ctrl.queue_count - 1);
+		nvme_unfreeze(&ctrl->ctrl);
+	}
+
 	return 0;
 
 out_cleanup_connect_q:
@@ -1008,6 +1013,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		if (ctrl->ctrl.tagset) {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
