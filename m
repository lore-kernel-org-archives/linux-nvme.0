Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 09:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2174761163
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 09:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2174761163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1pyqpqjyGHb7gxXD+OK6419LunxXSoYc+h2KzHVe9hg=; b=pkLQQwo/m7zIo7
	sQhz9YQsSVheVUTTCpDM8aFiODlgYHIa8IRutXzsndjuMwNbbQWZZXHb+e3flmSy/bKxQM1FKdPEc
	fjHnNf4QtoeOgNJEGEk7ciplNJQPGpcaW2e29cN+pJO0aKjcvjlMu0I6sba50z1VXhfpos7gJzxTD
	dgpMyhbrX3I6Rb4T/JKKtkB8CUfhryW1tiNbfCFJvRpXqt4ll8H0n3BJwrIC1rg+EYp06zWoapCnM
	cM0++dddKw6fasgxkjnrSXm/CgXy7jogKEc/71xTL+4oP7zGGIzC9sKQMoH4M4CggyePhaJFDnGdY
	LqzHZ78eIUgiyr+F5Rbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ4cJ-004yhW-H4; Tue, 14 Sep 2021 09:20:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ4br-004yXG-FS
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 09:20:15 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A68D4200E5;
 Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631611209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvNXtZL2Cnz/ihNZ+foEvV0IL5NeP4sXHi9jS3nzwog=;
 b=QP02cubGK7TykxogJT+hf9XcOhQr0GbgQesd8AkkbJyMqrK8pAD/izf/vOVRT1O2ok+Y0m
 UZ3agbDAmvGqYqnU5ZIO54HWeA+d02+tGTAHNr/gGnXGhWrjO8gQKl33vMfT/ihr/eedbq
 BL1iHcGu0L35uj136cvz7xPHaA0djgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631611209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvNXtZL2Cnz/ihNZ+foEvV0IL5NeP4sXHi9jS3nzwog=;
 b=/wWGY1DOcWmQR/B5dC7sme3VoZB2uqejbsbksBwvJE9zv7rK6zdnGA+e/IsVL+M8F9kYbJ
 hLKMyH7f6h/2jDDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 9C79FA3BD0;
 Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 88B49518E62B; Tue, 14 Sep 2021 11:20:09 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 2/3] nvme-fc: avoid race between time out and tear down
Date: Tue, 14 Sep 2021 11:20:07 +0200
Message-Id: <20210914092008.40370-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210914092008.40370-1-dwagner@suse.de>
References: <20210914092008.40370-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_022011_853210_F002748B 
X-CRM114-Status: GOOD (  11.47  )
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

To avoid race between time out and tear down, in tear down process,
first we quiesce the queue, and then delete the timer and cancel
the time out work for the queue.

This patch merges the admin and io sync ops into the queue teardown logic
as shown in the RDMA patch 3017013dcc "nvme-rdma: avoid race between time
out and tear down". There is no teardown_lock in nvme-fc.

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Chao Leng <lengchao@huawei.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b5d9a5507de5..6ebe68396712 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2487,6 +2487,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
@@ -2510,6 +2511,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * clean up the admin queue. Same thing as above.
 	 */
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
