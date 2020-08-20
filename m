Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E41C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04039207DA
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eFe8Z4Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04039207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Z8QeSXTXdN4b8v9u+DqRJM8BpXJPzciQxoTsiPd6ic=; b=eFe8Z4VeMdM4iiSB5wdt53YFZr
	Q6MqGNI6ohR46DAoIuGAjDY2Pxwm/RC+d08BeT9pZxyxbcKJHErygLHov1bhDoeLb6PITD4EzE/h4
	u6hVe0nxqQivND+m7jVPHsxMMwO377iUmCrhMwdFDMsxvNVs3DFO/Tbk+fOimtWFEvYHOiY7CphDc
	i5KV9Z/vs9YywFQ+GEULM7M422ZjNeTBC+9enfdVgjXRT/cffDqzvb1wpdywu8+MhSnL98SVOayFZ
	OeuV95mD5sqJIXfAlU6heV06H+0kj2FjZJVUVKqMW0nKjIpl/0xzFCKqNjbu1KEraBZ7NEghS3FLi
	fZrEIosA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8bef-0005fC-VW; Thu, 20 Aug 2020 03:54:22 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8bed-0005e5-12
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 03:54:20 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CE7F2C1F96EF9441C564;
 Thu, 20 Aug 2020 11:54:16 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 11:54:06 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 2/3] nvme-core: fix deadlock when reconnect failed due to
 nvme_set_queue_count timeout
Date: Thu, 20 Aug 2020 11:54:06 +0800
Message-ID: <20200820035406.1720-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_235419_788446_962944C8 
X-CRM114-Status: GOOD (  10.29  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-block@vger.kernel.org,
 lengchao@huawei.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A deadlock happens When we test nvme over roce with link blink. The
reason: link blink will cause error recovery, and then reconnect.If
reconnect fail due to nvme_set_queue_count timeout, the reconnect
process will set the queue count as 0 and continue , and then
nvme_start_ctrl will call nvme_enable_aen, and deadlock happens
because the admin queue is quiesced.

log:
Aug  3 22:47:24 localhost kernel: nvme nvme2: I/O 22 QID 0 timeout
Aug  3 22:47:24 localhost kernel: nvme nvme2: Could not set queue count
(881)
stack:
root     23848  0.0  0.0      0     0 ?        D    Aug03   0:00
[kworker/u12:4+nvme-wq]
[<0>] blk_execute_rq+0x69/0xa0
[<0>] __nvme_submit_sync_cmd+0xaf/0x1b0 [nvme_core]
[<0>] nvme_features+0x73/0xb0 [nvme_core]
[<0>] nvme_start_ctrl+0xa4/0x100 [nvme_core]
[<0>] nvme_rdma_setup_ctrl+0x438/0x700 [nvme_rdma]
[<0>] nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]
[<0>] process_one_work+0x1a7/0x370
[<0>] worker_thread+0x30/0x380
[<0>] kthread+0x112/0x130
[<0>] ret_from_fork+0x35/0x40

Many functions which call __nvme_submit_sync_cmd treat error code in two
modes: If error code less than 0, treat as command failed. If erroe code
more than 0, treat as target not support or other and continue.
NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both are cancled io
by host, is not the real error code return from target. So we need set
the flag:NVME_REQ_CANCELLED. Thus __nvme_submit_sync_cmd translate
the error to INTR, nvme_set_queue_count will return error, reconnect
process will terminate instead of continue.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c    | 1 +
 drivers/nvme/host/fabrics.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 43ac8a1ad65d..74f76aa78b02 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -307,6 +307,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 	if (blk_mq_request_completed(req))
 		return true;
 
+	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
 	blk_mq_complete_request(req);
 	return true;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4ec4829d6233..6c40054f9fb4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -552,6 +552,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
 
+	nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
 	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
 	blk_mq_start_request(rq);
 	nvme_complete_rq(rq);
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
