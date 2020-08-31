Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5140C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 07:02:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4782072D
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 07:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XmoAJxTF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C30V6ni0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4782072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nL5H8UxFcSzV18bU1FVqRj8cXo0skWxNizUN8XKX/5w=; b=XmoAJxTFVt5C1etVifsLMDogUq
	d1VAt4nfQ1GftQW/6Klv625zGVATmp1uWsWCPb6HSVQUjpvHvO9cti7OXacrnRxJStYMKQuawwBJh
	ofoAeLpe9z8aLsF6qZnjsmjfXyNSyXlGnCIPZx/Ek3pWlgbHXuHkvikLPG7p4vFPDbvbCHkIUuwn9
	52aP39iLXPOEx49KK8qLy/6Gg4OpGXoNAPZlXmgfeJXDboVjnGqTiTbbcRtT5knSyioCKq+JkW4P8
	FhbbxPqKaT0zCdmDoThb5mUoMLdT3r04cLmYx4pL4bam0x7lCsFoWeYRKfXKBPSiXU7mvaxPrIFf1
	nrRkvOOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCdpK-0006AG-LL; Mon, 31 Aug 2020 07:02:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCdpJ-0006A6-3h
 for linux-nvme@merlin.infradead.org; Mon, 31 Aug 2020 07:02:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=mX4qO+mNkbYPs8f7R2H55m+yNHuT4IeBkGY0El/cShE=; b=C30V6ni0vvOwWLiARl3MU6dwNT
 rPKzFlBWzTZkjttkNW3ORkgZ/6fJDdj0NsAsNW2Rdy1+TKQ1AjlxNcr3pyvEkT1yMWUeOm2695F/L
 219HXRQy5Ac6khxlu6ceOAM9jAqIp4duFQD2/4uR3yu8egQx6gLEjbEQMtbO/HgQVFS0Rd5l84ZpI
 sGyXhmklaRtuXD/US0VVnQTmYENuS3lcg5HSSybmTBX//t9GxQayrb5tOoaYvtzCpcGptgyJfR5DP
 KALaek1t+jYzsfj9qJKAcK0VpXcD6wiWW3tgK1n8RM+/OdEJZetsT6Okvx+xktNVpbQUHr0gNL8Ub
 f5I6YNKA==;
Received: from smtp.h3c.com ([60.191.123.56] helo=h3cspam01-ex.h3c.com)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCdp3-0001BR-Dg
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 07:01:57 +0000
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
 by h3cspam01-ex.h3c.com with ESMTPS id 07V704Zl018891
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 31 Aug 2020 15:00:04 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 15:00:07 +0800
From: Xianting Tian <tian.xianting@h3c.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
Subject: [PATCH] nvme-pci: check req to prevent crash in nvme_handle_cqe()
Date: Mon, 31 Aug 2020 14:53:11 +0800
Message-ID: <20200831065311.40731-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07V704Zl018891
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_080146_140578_84177EAA 
X-CRM114-Status: GOOD (  15.69  )
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

We met a crash issue when hot-insert a nvme device, blk_mq_tag_to_rq()
returned null(req=null), then crash happened in nvme_end_request():
	struct nvme_request *rq = nvme_req(req);
	rq->result = result;  <==crash here

The test env is, a server is configured with 2 backplanes, each backplane
support 8 nvme devices, this crash happened when hot-insert a nvme device
to the second backplane. We measured the signal, which is send out of cpu
to ack nvme interrupt, the signal is very weak when it reached the second
backplane, the device can't distinguish it as a ack signal. So it caused
the device can't clear the interrupt flag.
After updating related driver, the signal sending out of cpu to the second
backplane is good, the crash issue disappeared.

As blk_mq_tag_to_rq() may return null, so it should be check whether it is
null before using it to prevent a crash.

	[ 1124.256246] nvme nvme5: pci function 0000:e1:00.0
	[ 1124.256323] nvme 0000:e1:00.0: enabling device (0000 -> 0002)
	[ 1125.720859] nvme nvme5: 96/0/0 default/read/poll queues
	[ 1125.732483]  nvme5n1: p1 p2 p3
	[ 1125.788049] BUG: unable to handle kernel NULL pointer dereference at 0000000000000130
	[ 1125.788054] PGD 0 P4D 0
	[ 1125.788057] Oops: 0002 [#1] SMP NOPTI
	[ 1125.788059] CPU: 50 PID: 0 Comm: swapper/50 Kdump: loaded Tainted: G   --------- -t - 4.18.0-147.el8.x86_64 #1
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
 drivers/nvme/host/pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba725ae47..32712a41c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -939,6 +939,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
+	struct blk_mq_tags *tags;
 
 	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
 		dev_warn(nvmeq->dev->ctrl.device,
@@ -959,7 +960,15 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 		return;
 	}
 
-	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	tags = nvme_queue_tagset(nvmeq);
+	req = blk_mq_tag_to_rq(tags, cqe->command_id);
+	if (unlikely(!req)) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			"req is null(tag:%d nr_tags:%d) on queue %d\n"
+			cqe->command_id, tags->nr_tags, le16_to_cpu(cqe->sq_id);
+		return;
+	}
+
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_end_request(req, cqe->status, cqe->result))
 		nvme_pci_complete_rq(req);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
