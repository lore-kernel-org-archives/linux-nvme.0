Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAEEC433EC
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 08:09:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4812070B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 08:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xSBmHwDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4812070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QIERmeBxRACe2scgJXogkmkf6U7leQikylTyhnMNyW8=; b=xSBmHwDaLr23DF/po2nVbr6R0o
	7hiwc/sH0BGD/NkZMc7IlX5NVvynfG0n14rtRK7ebvlDKSe4U5uFqG7dJ5EaRUj8Btmv7tzg9uaTc
	jyd2lS6yxXuQeM0VZ8elJLQVDE4CFM7p7F8iN5fayF9EDrsvr7SJNc3HgIYE6/ZQLYCfHw3J2CNXm
	HCKPbtyHoIAdj88zYKFIsTEtD5OXwxUqCUv/QeOtYXKMN0mbbqX6GN1h9mKYjfa0XJ8kj51xZW9bh
	dVOXTA+varAeqcGEgwCv5S7wo3ITTM4nwghXDdl2PF0xzXEmcGnkwfHl28xpY/oEs68e1NeTbJibU
	la2LJlow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzyCa-0001L3-JU; Mon, 27 Jul 2020 08:09:40 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzyCX-0001JI-Mr
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 08:09:38 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E72841BDD4A0D41CC3C3;
 Mon, 27 Jul 2020 16:09:32 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 16:09:26 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-rdma: fix deadlock when delete ctrl due to reconnect fail
Date: Mon, 27 Jul 2020 16:09:26 +0800
Message-ID: <20200727080926.30776-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_040937_991290_99092579 
X-CRM114-Status: UNSURE (   7.48  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A deadlock happens when test link blink for nvme over roce. If time out
in reconneting process, nvme_rdma_timeout->nvme_rdma_teardown_io_queues
will quiesce the io queues, and then the ctrl will be deleted after
reconnect times exceed max_reconnects. If run fdisk from the time
when the queue is quiesced to the time when the ctrl is deleted,
delete ctrl will deadlock, the process: nvme_do_delete_ctrl->
nvme_remove_namespaces->nvme_ns_remove->blk_cleanup_queue->
blk_freeze_queue->blk_mq_freeze_queue_wait, blk_mq_freeze_queue_wait
will wait until q_usage_counter of queue become 0, but the queue is
quiesced, can not clean any request.

Solution: nvme_rdma_timeout should call nvme_start_queues after
call nvme_rdma_teardown_io_queues. further more, we need start queues
regardless of whether the remove flag is set, after cancel requests
in nvme_rdma_teardown_io_queues.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f8f856dc0c67..b381e2cde50a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -989,8 +989,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 				nvme_cancel_request, &ctrl->ctrl);
 			blk_mq_tagset_wait_completed_request(ctrl->ctrl.tagset);
 		}
-		if (remove)
-			nvme_start_queues(&ctrl->ctrl);
+		nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, remove);
 	}
 }
@@ -1128,7 +1127,6 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, false);
-	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
