Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FAFC4363D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 06:33:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2047A239A1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 06:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ojkn3WKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2047A239A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SS2rv/JEiGzIBexq8nKli+I+137SRHjRVM+Ye707ZE0=; b=Ojkn3WKPPU3N5T0wZfQydZUO+c
	rPqzwWTWE2OnoruLNM2ET5CEuH8qAaqmsJhbWcXfgECx9HeIdEjhRjCaEKQYfJVVcLDAsKUVO5j7+
	k8WKvf2glX4Ui/MYIStNA2hk92QDd2MS60D8+xvToMmnH/A2LD1NA/QXyPgSfArNg51EV7ATn1gTM
	0oLjU9nQ8bEhGTOJoNOcLP9KFOxspBHFxk5ls+PX/rka34giLm5p8jiQBCdaoql1k6saOiT5r8YBF
	CzBglH8IHELAaq/ZrRkudNmjzH6AQfwVW1CauffXtarK2LG99wJcI0lzOT4h3hNZ23ormU2gDqXgS
	XfT8BynQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKbrT-0006jt-Qf; Tue, 22 Sep 2020 06:33:12 +0000
Received: from smtp.h3c.com ([60.191.123.56] helo=h3cspam01-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKbrF-0006eX-Hy
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 06:33:04 +0000
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
 by h3cspam01-ex.h3c.com with ESMTPS id 08M6WGU6032330
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Sep 2020 14:32:16 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 14:32:19 +0800
From: Xianting Tian <tian.xianting@h3c.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
Subject: [PATCH] [v2] nvme: replace meaningless judgement by checking whether
 req is null
Date: Tue, 22 Sep 2020 14:25:17 +0800
Message-ID: <20200922062517.30031-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08M6WGU6032330
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_023259_844974_BB807BC7 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: Xianting Tian <tian.xianting@h3c.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently, we use nvmeq->q_depth as the upper limit for a valid tag in
nvme_handle_cqe(), it is not correct. Because the available tag number
is recorded in tagset, which is not equal to nvmeq->q_depth.

The nvme driver registers interrupts for queues before initializing the
tagset, because it uses the number of successful request_irq() calls to
configure the tagset parameters. This allows a race condition with the
current tag validity check if the controller happens to produce an
interrupt with a corrupted CQE before the tagset is initialized.

Replace the driver's indirect tag check with the one already provided by
the block layer. With this patch, we can avoid a null pointer deference
as below.

        [ 1124.256246] nvme nvme5: pci function 0000:e1:00.0
        [ 1124.256323] nvme 0000:e1:00.0: enabling device (0000 -> 0002)
        [ 1125.720859] nvme nvme5: 96/0/0 default/read/poll queues
        [ 1125.732483]  nvme5n1: p1 p2 p3
        [ 1125.788049] BUG: unable to handle kernel NULL pointer dereference at 0000000000000130
        [ 1125.788054] PGD 0 P4D 0
        [ 1125.788057] Oops: 0002 [#1] SMP NOPTI
        [ 1125.788059] CPU: 50 PID: 0 Comm: swapper/50 Kdump: loaded Tainted: G
						------- -t - 4.18.0-147.el8.x86_64 #1
        [ 1125.788065] RIP: 0010:nvme_irq+0xe8/0x240 [nvme]
        [ 1125.788068] RSP: 0018:ffff916b8ec83ed0 EFLAGS: 00010813
        [ 1125.788069] RAX: 0000000000000000 RBX: ffff918ae9211b00 RCX: 0000000000000000
        [ 1125.788070] RDX: 000000000000400b RSI: 0000000000000000 RDI: 0000000000000000
        [ 1125.788071] RBP: ffff918ae8870000 R08: 0000000000000004 R09: ffff918ae8870000
        [ 1125.788072] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
        [ 1125.788073] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
        [ 1125.788075] FS:  0000000000000000(0000) GS:ffff916b8ec80000(0000) knlGS:0000000000000000
        [ 1125.788075] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        [ 1125.788076] CR2: 0000000000000130 CR3: 0000001768f00000 CR4: 0000000000340ee0
        [ 1125.788077] Call Trace:
        [ 1125.788080]  <IRQ>
        [ 1125.788085]  __handle_irq_event_percpu+0x40/0x180
        [ 1125.788087]  handle_irq_event_percpu+0x30/0x80
        [ 1125.788089]  handle_irq_event+0x36/0x53
        [ 1125.788090]  handle_edge_irq+0x82/0x190
        [ 1125.788094]  handle_irq+0xbf/0x100
        [ 1125.788098]  do_IRQ+0x49/0xd0
        [ 1125.788100]  common_interrupt+0xf/0xf

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/nvme/host/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 899d2f4d7..f7cf01fc7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -940,13 +940,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
 
-	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
-		dev_warn(nvmeq->dev->ctrl.device,
-			"invalid id %d completed on queue %d\n",
-			cqe->command_id, le16_to_cpu(cqe->sq_id));
-		return;
-	}
-
 	/*
 	 * AEN requests are special as they don't time out and can
 	 * survive any kind of queue freeze and often don't respond to
@@ -960,6 +953,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	if (unlikely(!req)) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			"invalid id %d completed on queue %d\n",
+			cqe->command_id, le16_to_cpu(cqe->sq_id));
+		return;
+	}
+
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
 		nvme_pci_complete_rq(req);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
