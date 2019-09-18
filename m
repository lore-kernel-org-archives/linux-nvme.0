Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B80EC4CECD
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 00:00:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69616214AF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 00:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V7fWNAeU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RvHt6Yp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69616214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DwOWqHWkBrqEcTM1XfC/UDuLJbEJZMlD7fjWHdCCGig=; b=V7fWNAeUCwSoA1
	xjTfrIPT/+Dm85HnxcT7Ld+lgpRmZT9jW6ZUxNqqrYDnZUm5uYL8+dkXXhIQ/eprkpvnc2/4mm9q9
	le3mEsiSoSjbUS7D2SGqzoYb9yaNq2P03gbmFHysTc2R4ho4Fx2+t+dFUJ9p3RIdsE8ysZXgp6Tih
	nRzqMK/Bn6+knbglW9Mr4Q17W9+G3PvrH2gusF9Va2W/ZoRLKR+WOb9L9lUJeMc6EWNhNriPcLsn2
	98TpLV8YA38JujHLUuq3COtMhsSkhdACB8jCW4Lq55Tujm0gjyM4K8W7U6ma48JZyriI7dDbtyr7x
	nFPaEIgxLTacB+P2eAsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iANOV-0006bN-IR; Wed, 18 Sep 2019 00:00:27 +0000
Received: from mail-eopbgr730113.outbound.protection.outlook.com
 ([40.107.73.113] helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iANOR-0006aZ-Fp
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 00:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrIquL7w6NwxfiEaoCVrrdm5w2boR7pslVwbMP5ldO0BRmn+8G+zPZEpY2sgen+GG5+goXArfRJkwOCkJ1Dc03MEMtpwZ4q+Ub2G0t7BUoUBfrXpg+PYSOWXf1dkxEGvhJb7/l7dTi/n0+f1dmtpZyX01lC0HH/mgbRLqfvwlugdFRuXvGx+UFJ3xrh9RIJuXhK1DI5+NH4JM38yZkqXMtF84qBdy8QXj5J7M77mnBtGKLt7IEL78GutjTqZmOTqhFhfxCQcnPIjif14wmlmv6I6aaT+hrGWr0S+VvOa1QTutjCcViSxr07uhohoHftyma4oHaX9dLfCfNwnFbiolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkgrmLrNg5+5a6VhDzC1h16S24c6Lf6A09VIPyR/4bk=;
 b=Q7gHLVpI5MJWdNKyLUgkMxZV3/d9qxzr6uOjOXO0Bs0Kd7g7ahbjDkraAPcAuhVX3rht6F0ZisxCBdEyIo0NL3dueAzO1Vzsrpf9lIsM6rNCNTSCLtmQvIs8mu7bTAvTe3v4QMSfsu9TMvwl1YVdpOFsQ688UrHdiq8bMwLfmLOjKt0Mzl8GWKw6qsdoil4civhyk1YaD0wL0oBeNjXJV+PQJLsmhu0SSt0iMgMWzbmvG/nh3o0lrIEdTP56JM8/2oLy8WQJ78rB4n3cesHmo/ATiV9Ayj9x6x6bLBcsn2wRERC3SLT0HtA5dX4lep0HZj42kz22y1GY053XeseEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkgrmLrNg5+5a6VhDzC1h16S24c6Lf6A09VIPyR/4bk=;
 b=RvHt6Yp46kNJG5pl07QwjZTlm47n6DSXeBT0eMXOJss0JQxfqs/U45p38ApqxO+DV7Deo1/TX2m6VQlhB90mraHDSINkbhNSwHB3RzqyQwNE4kqsn8fcAXBVvCzGbPBPYeHOnIhCsxSPoVg8Vkad33vCXmfcJRnY4FitFe1CKNU=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.12; Wed, 18 Sep 2019 00:00:16 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::c8f4:597b:9f3a:9fd]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::c8f4:597b:9f3a:9fd%2]) with mapi id 15.20.2305.000; Wed, 18 Sep 2019
 00:00:16 +0000
From: Long Li <longli@microsoft.com>
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Subject: RE: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Thread-Topic: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Thread-Index: AQHVXLUAoNqN0R8TLUadmsLcmKb6xacPEcMAgACKtgCAAAMjAIAAyEgAgAAEnwCAAClMgIAABJWAgAi79gCAACnHgIAACOEAgAACjoCAAA16gIAABfMAgAIuJgCAAAa1AIABBRqAgAAZZYCAAP6SgIAAOYeAgADemICAAFw4gIAE69SAgAxPKbA=
Date: Wed, 18 Sep 2019 00:00:16 +0000
Message-ID: <CY4PR21MB0741838CE0C9D52556AA4558CE8E0@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
 <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
 <20190906014819.GB27116@ming.t460p>
 <ffefcfa0-09b6-9af5-f94e-8e7ddd2eef16@linaro.org>
 <6eb2a745-7b92-73ce-46f5-cc6a5ef08abc@grimberg.me>
 <20190907000100.GC12290@ming.t460p>
 <f5685543-8cd5-6c6a-5b80-c77ef09c6b3b@grimberg.me>
In-Reply-To: <f5685543-8cd5-6c6a-5b80-c77ef09c6b3b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:edea:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03acca44-ea1e-4015-94f6-08d73bcb300c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR21MB0631; 
x-ms-traffictypediagnostic: CY4PR21MB0631:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR21MB0631147EEE9B9F3C1127F33FCE8E0@CY4PR21MB0631.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(199004)(189003)(66476007)(7736002)(229853002)(10290500003)(6436002)(8676002)(71200400001)(66946007)(8990500004)(305945005)(2906002)(74316002)(66446008)(66556008)(110136005)(81156014)(10090500001)(54906003)(81166006)(498600001)(30864003)(55016002)(4326008)(76116006)(966005)(11346002)(25786009)(99286004)(71190400001)(64756008)(446003)(7696005)(22452003)(8936002)(486006)(7416002)(5660300002)(6306002)(52536014)(9686003)(6246003)(86362001)(256004)(6506007)(102836004)(6116002)(186003)(14444005)(76176011)(46003)(14454004)(476003)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0631;
 H:CY4PR21MB0741.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jR4K0IPZ2Bk5DbkTpL8W9CTXR7QDfjthgfRBJwH7aWvH/3V94hAUbqNxJqGJqKCwqif27psCkaPEsoBITJIBgahfVL/MpAhd8dsqQBeYcoYkrES671UOvRrAhTE2XEfPsNSmAt1R0qLFl78yhjqYpvq3IGL2fRFoqmnyvZYSyd4LF6dBf+PbDFUGjNkB2/wi1sEK3fQE0XlFIH1UMzTdwnYYmGHGL5Npg9dfd0XINnLBU10cgv8T02rl5JZM8UQXh4qey8stQAfV89Hk2jY/5eDwepH1iXJOCvJjNHZV37HPWxDv+HykCn8BTUS2pNirSRbO+3aAL9usPRUFdUGzbLEr8zEBVXwmsg0Gi6j8tarkeAPELG3qq0cLopkkEM/WmU+OKOK5V8jeTH2eKIzvNBwR/+c7sr2jF5jHhMqvLIQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03acca44-ea1e-4015-94f6-08d73bcb300c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 00:00:16.5825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVrFvpisrMVX9Dtqz0bxK08wkAoxOLQy4iq9Z4HwtUrWuwP0tYuceSFg06JFKVTbs8QRIPPdqeiQKCLbqOfyqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_170023_639807_F56FE0FF 
X-CRM114-Status: GOOD (  20.57  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Bart Van Assche <bvanassche@acm.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, John Garry <john.garry@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
>
>Hey Ming,
>
>>>> Ok, so the real problem is per-cpu bounded tasks.
>>>>
>>>> I share Thomas opinion about a NAPI like approach.
>>>
>>> We already have that, its irq_poll, but it seems that for this
>>> use-case, we get lower performance for some reason. I'm not entirely
>>> sure why that is, maybe its because we need to mask interrupts
>>> because we don't have an "arm" register in nvme like network devices
>>> have?
>>
>> Long observed that IOPS drops much too by switching to threaded irq.
>> If softirqd is waken up for handing softirq, the performance shouldn't
>> be better than threaded irq.
>
>Its true that it shouldn't be any faster, but what irqpoll already has and we
>don't need to reinvent is a proper budgeting mechanism that needs to occur
>when multiple devices map irq vectors to the same cpu core.
>
>irqpoll already maintains a percpu list and dispatch the ->poll with a budget
>that the backend enforces and irqpoll multiplexes between them.
>Having this mechanism in irq (hard or threaded) context sounds unnecessary a
>bit.
>
>It seems like we're attempting to stay in irq context for as long as we can
>instead of scheduling to softirq/thread context if we have more than a
>minimal amount of work to do. Without at least understanding why
>softirq/thread degrades us so much this code seems like the wrong approach
>to me. Interrupt context will always be faster, but it is not a sufficient reason
>to spend as much time as possible there, is it?
>
>We should also keep in mind, that the networking stack has been doing this
>for years, I would try to understand why this cannot work for nvme before
>dismissing.
>
>> Especially, Long found that context
>> switch is increased a lot after applying your irq poll patch.
>>
>> https://nam06.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists
>> .infradead.org%2Fpipermail%2Flinux-nvme%2F2019-
>August%2F026788.html&am
>>
>p;data=02%7C01%7Clongli%40microsoft.com%7C20391b0810844821325908d73
>59c
>>
>64d2%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637036818140279
>742&a
>>
>mp;sdata=GyBWILwPvwHYvrTGSAVZbdl%2Fcoz3twSXe2DrH2t1MeQ%3D&am
>p;reserved
>> =0
>
>Oh, I didn't see that one, wonder why... thanks!
>
>5% improvement, I guess we can buy that for other users as is :)
>
>If we suffer from lots of context switches while the CPU is flooded with
>interrupts, then I would argue that we're re-raising softirq too much.
>In this use-case, my assumption is that the cpu cannot keep up with the
>interrupts and not that it doesn't reap enough (we also reap the first batch in
>interrupt context...)
>
>Perhaps making irqpoll continue until it must resched would improve things
>further? Although this is a latency vs. efficiency tradeoff, looks like
>MAX_SOFTIRQ_TIME is set to 2ms:
>
>"
>  * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
>  * certain cases, such as stop_machine(), jiffies may cease to
>  * increment and so we need the MAX_SOFTIRQ_RESTART limit as
>  * well to make sure we eventually return from this method.
>  *
>  * These limits have been established via experimentation.
>  * The two things to balance is latency against fairness -
>  * we want to handle softirqs as soon as possible, but they
>  * should not be able to lock up the box.
>"
>
>Long, does this patch make any difference?

Sagi,

Sorry it took a while to bring my system back online.

With the patch, the IOPS is about the same drop with the 1st patch. I think the excessive context switches are causing the drop in IOPS.

The following are captured by "perf sched record" for 30 seconds during tests.

"perf sched latency"
With patch:
  fio:(82)              | 937632.706 ms |  1782255 | avg:    0.209 ms | max:   63.123 ms | max at:    768.274023 s

without patch:
  fio:(82)              |2348323.432 ms |    18848 | avg:    0.295 ms | max:   28.446 ms | max at:   6447.310255 s

Look closer at each CPU, we can see ksoftirqd is competing CPU with fio (and effectively throttle other fio processes)
(captured in /sys/kernel/debug/tracing, echo sched:* >set_event)

On CPU1 with patch: (note that the prev_state for fio is "R", it's preemptively scheduled)
           <...>-4077  [001] d... 66456.805062: sched_switch: prev_comm=fio prev_pid=4077 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/1 next_pid=17 next_prio=120
           <...>-17    [001] d... 66456.805859: sched_switch: prev_comm=ksoftirqd/1 prev_pid=17 prev_prio=120 prev_state=S ==> next_comm=fio next_pid=4077 next_prio=120
           <...>-4077  [001] d... 66456.844049: sched_switch: prev_comm=fio prev_pid=4077 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/1 next_pid=17 next_prio=120
           <...>-17    [001] d... 66456.844607: sched_switch: prev_comm=ksoftirqd/1 prev_pid=17 prev_prio=120 prev_state=S ==> next_comm=fio next_pid=4077 next_prio=120

On CPU1 without patch: (the prev_state for fio is "S", it's voluntarily scheduled)
          <idle>-0     [001] d...  6725.392308: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=fio next_pid=14342 next_prio=120
             fio-14342 [001] d...  6725.392332: sched_switch: prev_comm=fio prev_pid=14342 prev_prio=120 prev_state=S ==> next_comm=swapper/1 next_pid=0 next_prio=120
          <idle>-0     [001] d...  6725.392356: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=fio next_pid=14342 next_prio=120
             fio-14342 [001] d...  6725.392425: sched_switch: prev_comm=fio prev_pid=14342 prev_prio=120 prev_state=S ==> next_comm=swapper/1 next_pid=0 next_prio=120

Thanks

Long

>--
>diff --git a/lib/irq_poll.c b/lib/irq_poll.c index 2f17b488d58e..d8eab563fa77
>100644
>--- a/lib/irq_poll.c
>+++ b/lib/irq_poll.c
>@@ -12,8 +12,6 @@
>  #include <linux/irq_poll.h>
>  #include <linux/delay.h>
>
>-static unsigned int irq_poll_budget __read_mostly = 256;
>-
>  static DEFINE_PER_CPU(struct list_head, blk_cpu_iopoll);
>
>  /**
>@@ -77,42 +75,29 @@ EXPORT_SYMBOL(irq_poll_complete);
>
>  static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
>  {
>-       struct list_head *list = this_cpu_ptr(&blk_cpu_iopoll);
>-       int rearm = 0, budget = irq_poll_budget;
>-       unsigned long start_time = jiffies;
>+       struct list_head *irqpoll_list = this_cpu_ptr(&blk_cpu_iopoll);
>+       LIST_HEAD(list);
>
>         local_irq_disable();
>+       list_splice_init(irqpoll_list, &list);
>+       local_irq_enable();
>
>-       while (!list_empty(list)) {
>+       while (!list_empty(&list)) {
>                 struct irq_poll *iop;
>                 int work, weight;
>
>-               /*
>-                * If softirq window is exhausted then punt.
>-                */
>-               if (budget <= 0 || time_after(jiffies, start_time)) {
>-                       rearm = 1;
>-                       break;
>-               }
>-
>-               local_irq_enable();
>-
>                 /* Even though interrupts have been re-enabled, this
>                  * access is safe because interrupts can only add new
>                  * entries to the tail of this list, and only ->poll()
>                  * calls can remove this head entry from the list.
>                  */
>-               iop = list_entry(list->next, struct irq_poll, list);
>+               iop = list_first_entry(&list, struct irq_poll, list);
>
>                 weight = iop->weight;
>                 work = 0;
>                 if (test_bit(IRQ_POLL_F_SCHED, &iop->state))
>                         work = iop->poll(iop, weight);
>
>-               budget -= work;
>-
>-               local_irq_disable();
>-
>                 /*
>                  * Drivers must not modify the iopoll state, if they
>                  * consume their assigned weight (or more, some drivers can't @@ -
>125,11 +110,21 @@ static void __latent_entropy irq_poll_softirq(struct
>softirq_action *h)
>                         if (test_bit(IRQ_POLL_F_DISABLE, &iop->state))
>                                 __irq_poll_complete(iop);
>                         else
>-                               list_move_tail(&iop->list, list);
>+                               list_move_tail(&iop->list, &list);
>                 }
>+
>+               /*
>+                * If softirq window is exhausted then punt.
>+                */
>+               if (need_resched())
>+                       break;
>         }
>
>-       if (rearm)
>+       local_irq_disable();
>+
>+       list_splice_tail_init(irqpoll_list, &list);
>+       list_splice(&list, irqpoll_list);
>+       if (!list_empty(irqpoll_list))
>                 __raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
>
>         local_irq_enable();
>--
>
>Reminder to the nvme side (slightly modified):
>--
>diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
>52205f8d90b4..09dc6da67b05 100644
>--- a/drivers/nvme/host/pci.c
>+++ b/drivers/nvme/host/pci.c
>@@ -24,6 +24,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/sed-opal.h>
>  #include <linux/pci-p2pdma.h>
>+#include <linux/irq_poll.h>
>
>  #include "trace.h"
>  #include "nvme.h"
>@@ -32,6 +33,7 @@
>  #define CQ_SIZE(q)     ((q)->q_depth * sizeof(struct nvme_completion))
>
>  #define SGES_PER_PAGE  (PAGE_SIZE / sizeof(struct nvme_sgl_desc))
>+#define NVME_POLL_BUDGET_IRQ   256
>
>  /*
>   * These can be higher, but we need to ensure that any command doesn't
>@@ -189,6 +191,7 @@ struct nvme_queue {
>         u32 *dbbuf_cq_db;
>         u32 *dbbuf_sq_ei;
>         u32 *dbbuf_cq_ei;
>+       struct irq_poll iop;
>         struct completion delete_done;
>  };
>
>@@ -1014,11 +1017,29 @@ static inline int nvme_process_cq(struct
>nvme_queue *nvmeq, u16 *start,
>         return found;
>  }
>
>+static int nvme_irqpoll_handler(struct irq_poll *iop, int budget) {
>+       struct nvme_queue *nvmeq = container_of(iop, struct nvme_queue,
>iop);
>+       struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
>+       u16 start, end;
>+       int completed;
>+
>+       completed = nvme_process_cq(nvmeq, &start, &end, budget);
>+       nvme_complete_cqes(nvmeq, start, end);
>+       if (completed < budget) {
>+               irq_poll_complete(&nvmeq->iop);
>+               enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
>+       }
>+
>+       return completed;
>+}
>+
>  static irqreturn_t nvme_irq(int irq, void *data)
>  {
>         struct nvme_queue *nvmeq = data;
>         irqreturn_t ret = IRQ_NONE;
>         u16 start, end;
>+       int budget = nvmeq->q_depth;
>
>         /*
>          * The rmb/wmb pair ensures we see all updates from a previous run of
>@@ -1027,13 +1048,23 @@ static irqreturn_t nvme_irq(int irq, void *data)
>         rmb();
>         if (nvmeq->cq_head != nvmeq->last_cq_head)
>                 ret = IRQ_HANDLED;
>-       nvme_process_cq(nvmeq, &start, &end, -1);
>+
>+       /* reap here up to a budget of the size the queue depth */
>+       do {
>+               budget -= nvme_process_cq(nvmeq, &start, &end, budget);
>+               if (start != end) {
>+                       nvme_complete_cqes(nvmeq, start, end);
>+                       ret = IRQ_HANDLED;
>+               }
>+       } while (start != end && budget > 0);
>+
>         nvmeq->last_cq_head = nvmeq->cq_head;
>         wmb();
>
>-       if (start != end) {
>-               nvme_complete_cqes(nvmeq, start, end);
>-               return IRQ_HANDLED;
>+       /* if we still have cqes to reap, schedule irqpoll */
>+       if (start != end && nvme_cqe_pending(nvmeq)) {
>+               disable_irq_nosync(irq);
>+               irq_poll_sched(&nvmeq->iop);
>         }
>
>         return ret;
>@@ -1346,6 +1377,7 @@ static enum blk_eh_timer_return
>nvme_timeout(struct request *req, bool reserved)
>
>  static void nvme_free_queue(struct nvme_queue *nvmeq)
>  {
>+       irq_poll_disable(&nvmeq->iop);
>         dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
>                                 (void *)nvmeq->cqes, nvmeq->cq_dma_addr);
>         if (!nvmeq->sq_cmds)
>@@ -1480,6 +1512,7 @@ static int nvme_alloc_queue(struct nvme_dev *dev,
>int qid, int depth)
>         nvmeq->dev = dev;
>         spin_lock_init(&nvmeq->sq_lock);
>         spin_lock_init(&nvmeq->cq_poll_lock);
>+       irq_poll_init(&nvmeq->iop, NVME_POLL_BUDGET_IRQ,
>nvme_irqpoll_handler);
>         nvmeq->cq_head = 0;
>         nvmeq->cq_phase = 1;
>         nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
>--
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
