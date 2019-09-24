Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8593DC432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 00:57:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E902146E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 00:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HigvLxYP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bla5le0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E902146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qnm02MLGxZEDcV7PoHLD2DXQOdUGLmrQ/v2Nf+G18DI=; b=HigvLxYPZnUcC1
	ot4cVk0l1A45eBm7PjzPRK4B2c/a1hszCUXC8yQyfKhdnGV8WpqEagKnJ2qGq4j1FT1Obs3HGoK+7
	EzCopImqsgj48JRU53y00anui9EbUURGhD0SyzONUJ/w7lO9hfy2Jr6ZqWhBLsA41eleloRCFuUMw
	2Jbg29H0CscbYKIKXUvT04zPNQ3UBSLel4d2h1Djc2C9cTQlZidAXuDsNkvz9nJObA8pLi8zFHNFz
	mIOrFa+NS1/XLC1pA1DeUzq2uKBBCePHOw44g9vlGSPhBsi4Xum15iuk9c2586sqbz7kwL4kN1wbO
	J964X/LSQiJOpRMhah0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCZ9I-0006Hq-2z; Tue, 24 Sep 2019 00:57:48 +0000
Received: from mail-eopbgr680121.outbound.protection.outlook.com
 ([40.107.68.121] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCZ9E-0006HI-FM
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 00:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHdcWkrh4VxjMoyzO1iOn5VLHgpWOjelqG0aHLFRpAM54IImNxxKPFYjHwxe/iKJ+quIiiqJJyd5H+lhktQEGXbSvLFVqIXDtMSO5rJDTXQ2qrRtHxNq76FfcZe6wX8l1MDzkTEnlyOpgPfmpBRNx3ozvqcR8huy0IC3+jCuH4k8AJj8J+BVr/18U90PgR1YZtPopt1rku4qd+CDwzumxEfsXSgXohyEhuMvaDp0miSLiUSTmSNm1r8pQ6QYC8F+3IkyOS6GsqlgkS2b43TxRKvzrfXxr5MzyN98Hc5RAEa6UcibceH3Z0JvZxA3BtUY/dM6b5dtR641gVuSR70E7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnycEY/HLyGt415GKKJFSZrGA9g2n+L74MwJD3ERXU8=;
 b=d5J11PukYrPdCAS3hSKQc+rhLPLAw7pYn+oWcVWXutaCoe8N4KAobrJi5wuiFG9cbudM8kLKX1+DLTxNju93AEN+qEVH7O5+LNZvhRvS5Jk1LFqvYJcpnoRdr6Ct0pIvwEdKpLtQN0vtdF8MIxj8PoMimhg9FxE6EAfj8uZJLis7390jrXxODVd9ZKQJUysxosZxTAswxmq/CRsuVe2IXBkm7QKhEyUec0dqybJKyr8dT/9d+wwn/Y4uxrw0W+0++TzIRfwvJEq+nEjCXefgqKwVSQ0fegL8SEJ95Pio5q4ElkwXHSteQ7ijSEgMKT1SVrGBrYppsJA2yHFG7MsaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnycEY/HLyGt415GKKJFSZrGA9g2n+L74MwJD3ERXU8=;
 b=Bla5le0HVzgjvaNacfzjJGIYDSFkXWPq5DvJeOmL3i2JhV+IlPdgzBlsLgeNMc3VP4pea0u5dO0feBPBdrMeSWXEzHZy0Uyn9Pn0L9vimMZTEJf5PQ7VhUmPMBPzYUw1ltngd/RayNxuVd9ImoDq5YMXNEUqB/v/7tIwUeEWdw4=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.5; Tue, 24 Sep 2019 00:57:39 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::c8f4:597b:9f3a:9fd]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::c8f4:597b:9f3a:9fd%2]) with mapi id 15.20.2327.004; Tue, 24 Sep 2019
 00:57:39 +0000
From: Long Li <longli@microsoft.com>
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Subject: RE: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Thread-Topic: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Thread-Index: AQHVXLUAoNqN0R8TLUadmsLcmKb6xacPEcMAgACKtgCAAAMjAIAAyEgAgAAEnwCAAClMgIAABJWAgAi79gCAACnHgIAACOEAgAACjoCAAA16gIAABfMAgAIuJgCAAAa1AIABBRqAgAAZZYCAAP6SgIAAOYeAgADemICAAFw4gIAE69SAgAxPKbCABFQsgIAAHz9ggAAbnACABN7PcA==
Date: Tue, 24 Sep 2019 00:57:39 +0000
Message-ID: <CY4PR21MB0741BC9992A7A945A0D4A62CCE840@CY4PR21MB0741.namprd21.prod.outlook.com>
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
 <CY4PR21MB0741838CE0C9D52556AA4558CE8E0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <30dc6fa9-ea5e-50d6-56f9-fbc9627d8c29@grimberg.me>
 <CY4PR21MB074168DE7729C131CE4394CCCE880@CY4PR21MB0741.namprd21.prod.outlook.com>
 <100d001a-1dda-32ff-fa5e-c18b121444d9@grimberg.me>
In-Reply-To: <100d001a-1dda-32ff-fa5e-c18b121444d9@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:ede4:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a3a52af-902b-406b-c7ed-08d7408a32ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR21MB0840; 
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB084093C08DA217D6BFDA5FBCCE840@CY4PR21MB0840.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(51914003)(55016002)(6116002)(74316002)(316002)(10290500003)(305945005)(66446008)(7696005)(71200400001)(76176011)(8990500004)(7416002)(446003)(76116006)(66476007)(86362001)(25786009)(6246003)(186003)(11346002)(52536014)(229853002)(10090500001)(486006)(66556008)(9686003)(71190400001)(81156014)(7736002)(14454004)(66946007)(46003)(8676002)(33656002)(2906002)(4326008)(110136005)(476003)(22452003)(5660300002)(8936002)(14444005)(99286004)(6506007)(81166006)(102836004)(256004)(54906003)(478600001)(64756008)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0840;
 H:CY4PR21MB0741.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zBRd6msD0toPulnkONop2wDzFjlolbDkBY3N1XZENOAFir+SYpGYDxfVVRpsqLqg6C+5d02tUXRKHkkQC0Z60x2i9P3KMbJN5co8qAqRAGRuewR418aNoIE1NGpp0ZONDUHDenU6peQxTu94rwdDaUT7ETAd8HyImErYhcvxit1iEdR3pmjskgVDW1smCVml5fq7T3NL7Hiq2KGv1mXSVUqeDaCQWyGNEbU09hF/7jVY3PhVvSiOSypTiaC2I4OhCv1V19FOU8WW2SZoCEPF0HUf6EKc+wLq7BSvyLXLeKrt9LiPN14JX3wa0CiBjrHqx421qimT7e8ABXvAZrlugbMDZbAdN4z1NIIxvH9A+g2Ou0tUcqpcue9De8wL1h7aAx34WxVuDLaxe3UwsK2S/qGgDBgyJh/fTnIKyE9evWI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3a52af-902b-406b-c7ed-08d7408a32ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 00:57:39.4980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbzsxctKFkAuJSTeNsET9d3i+5LmAMjzWCHKN/Bnj60+X2PCyvgdxEpxAX0fTuTzXeu/+3MSyaN59s7Pod9kSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190923_175744_596009_F52B95D2 
X-CRM114-Status: GOOD (  18.90  )
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

>Thanks for the clarification.
>
>The problem with what Ming is proposing in my mind (and its an existing
>problem that exists today), is that nvme is taking precedence over anything
>else until it absolutely cannot hog the cpu in hardirq.
>
>In the thread Ming referenced a case where today if the cpu core has a net
>softirq activity it cannot make forward progress. So with Ming's suggestion,
>net softirq will eventually make progress, but it creates an inherent fairness
>issue. Who said that nvme completions should come faster then the net rx/tx
>or another I/O device (or hrtimers or sched events...)?
>
>As much as I'd like nvme to complete as soon as possible, I might have other
>activities in the system that are as important if not more. So I don't think we
>can solve this with something that is not cooperative or fair with the rest of
>the system.
>
>>> If we are context switching too much, it means the soft-irq operation
>>> is not efficient, not necessarily the fact that the completion path
>>> is running in soft- irq..
>>>
>>> Is your kernel compiled with full preemption or voluntary preemption?
>>
>> The tests are based on Ubuntu 18.04 kernel configuration. Here are the
>parameters:
>>
>> # CONFIG_PREEMPT_NONE is not set
>> CONFIG_PREEMPT_VOLUNTARY=y
>> # CONFIG_PREEMPT is not set
>
>I see, so it still seems that irq_poll_softirq is still not efficient in reaping
>completions. reaping the completions on its own is pretty much the same in
>hard and soft irq, so its really the scheduling part that is creating the overhead
>(which does not exist in hard irq).
>
>Question:
>when you test with without the patch (completions are coming in hard-irq),
>do the fio threads that run on the cpu cores that are assigned to the cores that
>are handling interrupts get substantially lower throughput than the rest of the
>fio threads? I would expect that the fio threads that are running on the first 32
>cores to get very low iops (overpowered by the nvme interrupts) and the rest
>doing much more given that nvme has almost no limits to how much time it
>can spend on processing completions.
>
>If need_resched() is causing us to context switch too aggressively, does
>changing that to local_softirq_pending() make things better?
>--
>diff --git a/lib/irq_poll.c b/lib/irq_poll.c index d8eab563fa77..05d524fcaf04
>100644
>--- a/lib/irq_poll.c
>+++ b/lib/irq_poll.c
>@@ -116,7 +116,7 @@ static void __latent_entropy irq_poll_softirq(struct
>softirq_action *h)
>                 /*
>                  * If softirq window is exhausted then punt.
>                  */
>-               if (need_resched())
>+               if (local_softirq_pending())
>                         break;
>         }
>--
>
>Although, this can potentially cause other threads from making forward
>progress.. If it is better, perhaps we also need a time limit as well.

Thanks for this patch. The IOPS was about the same. (it tends to fluctuate more but within 3% variation)

I captured the following from one of the CPUs. All CPUs tend to have similar numbers. The following numbers are captured during 5 seconds and averaged:

Context switches/s:
Without any patch: 5
With the previous patch: 640
With this patch: 522

Process migrated/s:
Without any patch: 0.6
With the previous patch: 104
With this patch: 121

>
>Perhaps we should add statistics/tracing on how many completions we are
>reaping per invocation...

I'll look into a bit more on completion. From the numbers I think the increased number of context switches/migrations are hurting most on performance.

Thanks

Long
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
