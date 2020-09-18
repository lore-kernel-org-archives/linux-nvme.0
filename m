Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A29CC43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 08:38:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9501321D43
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 08:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bbewvA68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9501321D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/lfoP7v0+7KQy7Feodc0OmWBJkTBk3U3W5xOjC3Fsco=; b=bbewvA68X/RRmL3G0zZYwpo1c
	LVSMuivjFdHXXSZGsQLWga0IqeIASDz5lG5oFZdzz1esW/R/EXXHK7wxC0euiIfjJ+V0F+6EyRTdw
	lu7ugBpNaSU//PrQ+VSppHpQUSYOWwC/bmRo3Rv4bNIU5sqSNfZqoKLvWKD4368MdDJnk1jxIJACN
	K6CLHKlP66vfapm4M2PsjxvygECLLQ/a6i0wmOeWLxUmo5uYnq66vuidcuHOlTUI2MlCbWf1K24CJ
	P/t9pqMZWvsFyx7+T2sYxU7gb2Ig/x4ONL2O7wh1yaDghPHThaOvN/mcmJjYiYLnKKlvGgz6JhU9P
	UK6+5fOew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJBuI-0002ww-TH; Fri, 18 Sep 2020 08:38:15 +0000
Received: from smtp.h3c.com ([60.191.123.50] helo=h3cspam02-ex.h3c.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJBuB-0002t4-8d
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 08:38:12 +0000
Received: from DAG2EX06-IDC.srv.huawei-3com.com ([10.8.0.69])
 by h3cspam02-ex.h3c.com with ESMTPS id 08I8bNaf080831
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 18 Sep 2020 16:37:23 +0800 (GMT-8)
 (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX06-IDC.srv.huawei-3com.com (10.8.0.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Sep 2020 16:37:25 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Fri, 18 Sep 2020 16:37:25 +0800
From: Tianxianting <tian.xianting@h3c.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH] nvme: use correct upper limit for tag in nvme_handle_cqe()
Thread-Topic: [PATCH] nvme: use correct upper limit for tag in
 nvme_handle_cqe()
Thread-Index: AQHWjZCEmyk8L06KUk++z8H0Pc/pn6luEhoQ
Date: Fri, 18 Sep 2020 08:37:25 +0000
Message-ID: <5fb643bb455549598ed2036eb2e8e683@h3c.com>
References: <20200918074434.6461-1-tian.xianting@h3c.com>
In-Reply-To: <20200918074434.6461-1-tian.xianting@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08I8bNaf080831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_043810_053468_1D5BB723 
X-CRM114-Status: GOOD (  15.02  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I am very sorry,
Please ignore this patch, the code need to rewrite.

-----Original Message-----
From: tianxianting (RD) 
Sent: Friday, September 18, 2020 3:45 PM
To: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org; tianxianting (RD) <tian.xianting@h3c.com>
Subject: [PATCH] nvme: use correct upper limit for tag in nvme_handle_cqe()

We met a crash issue when hot-insert a nvme device, blk_mq_tag_to_rq() returned null(req=null), then crash happened in nvme_end_request():
	req = blk_mq_tag_to_rq();
        struct nvme_request *rq = nvme_req(req); //rq = req + 1
        rq->result = result;  <==crash here!!!

        [ 1124.256246] nvme nvme5: pci function 0000:e1:00.0
        [ 1124.256323] nvme 0000:e1:00.0: enabling device (0000 -> 0002)
        [ 1125.720859] nvme nvme5: 96/0/0 default/read/poll queues
        [ 1125.732483]  nvme5n1: p1 p2 p3
        [ 1125.788049] BUG: unable to handle kernel NULL pointer dereference at 0000000000000130
        [ 1125.788054] PGD 0 P4D 0
        [ 1125.788057] Oops: 0002 [#1] SMP NOPTI
        [ 1125.788059] CPU: 50 PID: 0 Comm: swapper/50 Kdump: loaded Tainted: G   ------- -t - 4.18.0-147.el8.x86_64 #1
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

The analysis of the possible cause of above crash as below.

According to our test, in nvme_pci_enable(), 'dev->q_depth' is set to 1024, in nvme_create_io_queues()->nvme_alloc_queue(), 'nvmeq->q_depth' is set to 'dev->q_depth'. In nvme_dev_add(), 'dev->tagset.queue_depth' is set to 1023:
         dev->tagset.queue_depth = min_t(unsigned int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
					//why -1?? first involved by commit a4aea562 In nvme_alloc_queue(), 'nvmeq->q_depth' is set to dev->q_depth'.
So we got below values for mutiple depth:
dev->q_depth            = 1024
dev->tagset.queue_depth = 1023
nvmeq->q_depth          = 1024

In blk_mq_alloc_rqs(), it allocated 1023(dev->tagset.queue_depth) rqs for one hw queue. In nvme_alloc_queue(), it allocated 1024(nvmeq->q_depth) cqes for nvmeq->cqes[]. When process cqe in nvme_handle_cqe(), it get it by:
	struct nvme_completion *cqe = &nvmeq->cqes[idx];

We also added below prints in nvme_handle_cqe() and blk_mq_tag_to_rq():
	static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
	{
		volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
		struct request *req;

		//debug print
		dev_warn(nvmeq->dev->ctrl.device,
			"command_id %d completed on queue %d, nvmeq q_depth %d, nvme tagset q_depth %d\n",
		 	 cqe->command_id, le16_to_cpu(cqe->sq_id),
			 nvmeq->q_depth, nvmeq->dev->tagset.queue_depth);

		if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
			dev_warn(nvmeq->dev->ctrl.device,
				"invalid id %d completed on queue %d\n",
				cqe->command_id, le16_to_cpu(cqe->sq_id));
			return;
		}

		... ...

		req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
		... ...
	}

	struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
	{
		//debug print
		printk("tag, nr_tags:%d %d\n", tag, tags->nr_tags);
		if (tag < tags->nr_tags) {
			prefetch(tags->rqs[tag]);
			return tags->rqs[tag];
		}

		return NULL;
	}

According to the output, we know the max tag number(nr_tags) is 1023,  but
nvmeq->q_depth is 1024 and nvmeq->cqes[] has 1024 cqes. So if 
nvmeq->command_id(tag)
is 1023, the judgement "if (unlikely(cqe->command_id >= nvmeq->q_depth))"
in nvme_handle_cqe() is useless, we will get a null pointer, which is returned by blk_mq_tag_to_rq():
	[   16.649973] nvme nvme0: command_id 968 completed on queue 13, nvmeq q_depth 1024, nvme tagset q_depth 1023
	[   16.649974] tag, nr_tags:968 1023

This patch is to make command_id match to its correct upper limit 'nvmeq->dev->tagset.queue_depth', not nvmeq->q_depth. So even if we got 1023 of command_id, we can avoid a null pointer deference.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 899d2f4d7..c681e26d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -940,7 +940,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
 
-	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
+	if (unlikely(cqe->command_id >= nvmeq->dev->tagset.queue_depth)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
 			cqe->command_id, le16_to_cpu(cqe->sq_id));
--
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
