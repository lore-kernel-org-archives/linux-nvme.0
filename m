Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB3C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 18:17:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0884364E8E
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 18:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0884364E8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ztxOG2q9GXfNf7lkcaTf0IjHyachWOlQxfHhodG4BsE=; b=cZpPLHrQf5mxQhgqxjoAw7Z+fg
	T1aXQuZLiETbHLJbFOwKIx4VTe5H8Ms2N1Eh0dkDjMMdjrxHEdvL4E4Yck6udMbCCEDQ71O7xPUg3
	boczahHmazuOZAGlEbVMUIrWMbUazqk9QwE+ZchsKt94Og/wzcZgh8xxza1ZNZaR/ds+SdEE1BO0X
	XZhq04yCXGmj1+ABD9ub8nV50IdF3ZPdwlv/BosXC5mVWxAaF5IVLqcPlwu26qCyyHVz8wOct0CHz
	RVy3IuiZ4mS0JpEStznkF4WnMX8SIGuzGCIOq1rItsZxIsO+x0z2y0wwJSBafk3r/ZuJ0is2ChxFa
	HqGonOaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAd0p-00062v-0W; Fri, 12 Feb 2021 18:17:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAd0m-000629-K6
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 18:17:49 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6759AAFEC;
 Fri, 12 Feb 2021 18:17:46 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: Check if request has started before processing it
Date: Fri, 12 Feb 2021 19:17:38 +0100
Message-Id: <20210212181738.79274-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_131748_902911_6407603D 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk_mq_tag_to_rq() will always return a request if the command_id is
in the valid range. Check if the request has been started. If we
blindly process the request we might double complete a request which
can be fatal.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

This patch is against nvme-5.12.

There is one blk_mq_tag_to_rq() in nvme_tcp_recv_ddgst() which I
didn't update as I am not sure if it's also needed.

py-crash> bt
#0  0xffffffffa76a33de in arch_atomic_try_cmpxchg (new=<optimized out>, old=<optimized out>, v=<optimized out>)
    at ../arch/x86/include/asm/atomic.h:200
#1  atomic_try_cmpxchg (new=<optimized out>, old=<optimized out>, v=<optimized out>) at ../include/asm-generic/atomic-instrumented.h:695
#2  queued_spin_lock (lock=<optimized out>) at ../include/asm-generic/qspinlock.h:78
#3  do_raw_spin_lock_flags (flags=<optimized out>, lock=<optimized out>) at ../include/linux/spinlock.h:193
#4  __raw_spin_lock_irqsave (lock=<optimized out>) at ../include/linux/spinlock_api_smp.h:119
#5  _raw_spin_lock_irqsave (lock=0x8 <__UNIQUE_ID_license257+8>) at ../kernel/locking/spinlock.c:159
#6  0xffffffffa6eea418 in complete (x=0x0 <__UNIQUE_ID_license257>) at ../kernel/sched/completion.c:32
#7  0xffffffffa721f99c in blk_mq_force_complete_rq (rq=0x8 <__UNIQUE_ID_license257+8>) at ../block/blk-mq.c:634
#8  0xffffffffa721fa0a in blk_mq_complete_request (rq=<optimized out>) at ../block/blk-mq.c:672
#9  0xffffffffc0b092ef in nvme_end_request (result=..., status=<optimized out>, req=<optimized out>) at ../drivers/nvme/host/nvme.h:477
#10 nvme_tcp_process_nvme_cqe (cqe=<optimized out>, queue=<optimized out>) at ../drivers/nvme/host/tcp.c:485
        rq = 0xffff948b840d0000
        hdr = <optimized out>
        ret = 0
        queue = 0xffff949501dd8110
        result = 0
#11 nvme_tcp_handle_comp (pdu=<optimized out>, queue=<optimized out>) at ../drivers/nvme/host/tcp.c:542
#12 nvme_tcp_recv_pdu (len=<optimized out>, offset=<optimized out>, skb=<optimized out>, queue=<optimized out>) at ../drivers/nvme/host/tcp.c:660
#13 nvme_tcp_recv_skb (desc=<optimized out>, skb=<optimized out>, offset=24, len=0) at ../drivers/nvme/host/tcp.c:805
#14 0xffffffffa7598af5 in tcp_read_sock
    (sk=0x8 <__UNIQUE_ID_license257+8>, desc=0xa <__UNIQUE_ID_license257+10>, recv_actor=0x1 <__UNIQUE_ID_license257+1>) at ../net/ipv4/tcp.c:1645
#15 0xffffffffc0b075b8 in nvme_tcp_try_recv (queue=0xffff949501dd8110) at ../drivers/nvme/host/tcp.c:1102
#16 0xffffffffc0b08fc7 in nvme_tcp_io_work (w=0xffff949501dd8118) at ../drivers/nvme/host/tcp.c:1126
#17 0xffffffffa6eba4e4 in process_one_work (worker=0xffff948d1b633ec0, work=0xffff949501dd8118) at ../kernel/workqueue.c:2273
#18 0xffffffffa6eba6fd in worker_thread (__worker=0xffff948d1b633ec0) at ../kernel/workqueue.c:2419
#19 0xffffffffa6ec0a3d in kthread (_create=0xffff948d1b618ec0) at ../kernel/kthread.c:268
#20 0xffffffffa7800215 in ret_from_fork () at ../arch/x86/entry/entry_64.S:351

py-crash>  p /x ((struct request*)0xffff948b840d0000)->state
$2 = 0x2

 drivers/nvme/host/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..4bec705ce8e6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -485,7 +485,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	struct request *rq;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
-	if (!rq) {
+	if (!rq || !blk_mq_request_started(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag 0x%x not found\n",
 			nvme_tcp_queue_id(queue), cqe->command_id);
@@ -506,7 +506,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 	struct request *rq;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
+	if (!rq || !blk_mq_request_started(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x not found\n",
 			nvme_tcp_queue_id(queue), pdu->command_id);
@@ -610,7 +610,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	int ret;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
+	if (!rq || !blk_mq_request_started(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x not found\n",
 			nvme_tcp_queue_id(queue), pdu->command_id);
@@ -696,7 +696,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	struct request *rq;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
+	if (!rq || !blk_mq_request_started(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x not found\n",
 			nvme_tcp_queue_id(queue), pdu->command_id);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
