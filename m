Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD8FC07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 12:44:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0F260FDA
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 12:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0F260FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a2GniItCtuLWaWT+HKokDNFO4qx8ELFy+gzWKMXnQAA=; b=l/njobow7jJvwX
	6fJ83IsFLHn2WQ3LO5fKKwndGYlX4osRJj8HQ5exee3iAgj0mXSTywFjvDHVxw2EEm/7B3z2ubxZ8
	IoIfCLJqFw+VE2uoimYK/TC8fn1HmxM0jUOJEmhsfZaqrlQNX9wZFlaeLz4mAyAnuat2ROOa33V4k
	p3qvNSMT3zRObTVWrVqEvuX38mOvcpPpqgeFP3jd1g7fPG8COUxQmFUgxrTeXiYedjFnjKWdlsBTu
	ohW76HjBvIJubGytj/JlmFvzt6RkPZJa608ds1YnLh9hoLP3fUOfYcDkeoIp/Hq9HLj5viumh4wKh
	VQdqkbyUNbx35t+5nuFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5p6e-00CoNV-PE; Tue, 20 Jul 2021 12:44:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5p6Q-00CoHN-45
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 12:44:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E226F202DD;
 Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626785038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5k7XNc5+yPEatIcV2+Rzvnk7tPH3TwekV1DDGT6cYwk=;
 b=BUHtxkYh5vULvVX1wWG9DVxV3O5daCs1I888sVXWnOqRPya6jvu7pJ0pdFFz0NX5De+XqF
 XJfo4wqjicz++ZDXU1VaMck7xmM0wZjCJyzCMoUxsXtjeX4vma6fW6FeEqQ8nOnIUUPCTF
 pjRvv+dKUNtNlpFBRVXyyAyJb9wG13c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626785038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5k7XNc5+yPEatIcV2+Rzvnk7tPH3TwekV1DDGT6cYwk=;
 b=iWR0LBvFla0McKz4TeyppaZ8OAgaHEp6CfjYHrJLZYQWdZ0JUGfJHiNNyPkhDIuNEiDm4U
 bFuJDzhqiidK3wAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id D1DDFA3BAD;
 Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 18D1E5171932; Tue, 20 Jul 2021 14:43:58 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 6/6] nvme-fc: fix controller reset hang during traffic
Date: Tue, 20 Jul 2021 14:43:53 +0200
Message-Id: <20210720124353.127959-7-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210720124353.127959-1-dwagner@suse.de>
References: <20210720124353.127959-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_054402_378165_CBFB8FC9 
X-CRM114-Status: GOOD (  12.59  )
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

From: James Smart <jsmart2021@gmail.com>

commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
exposed an issue where we may hang trying to wait for queue freeze
during I/O. We call blk_mq_update_nr_hw_queues which may attempt to freeze
the queue. However we never started queue freeze when starting the
reset, which means that we have inflight pending requests that entered the
queue that we will not complete once the queue is quiesced.

So start a freeze before we quiesce the queue, and unfreeze the queue
after we successfully connected the I/O queues (the unfreeze is already
present in the code). blk_mq_update_nr_hw_queues will be called only
after we are sure that the queue was already frozen.

This follows to how the pci driver handles resets.

This patch added logic introduced in commit 9f98772ba307 "nvme-rdma: fix
controller reset hang during traffic".

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 112e62cd8a2a..ad3344f6048d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2486,6 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * (but with error status).
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
