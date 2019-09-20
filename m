Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6C1C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 19:12:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62958208C0
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 19:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QMo80wGd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PTZMxBFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62958208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6ZGflQq9JnUrAXwpUtU9Jrp1d6cZd5ihd9dHUx0XFrE=; b=QMo80wGdHR8z7j
	/cywjEKTZsBGsPuWhvah2NRfEZZWJyTDqium3+EMuLeEU44fPH8L9Oe4AGaJRu6wWiIkXZkaCBJw8
	QDw6pC6bDoJsku6I0DMoRY8RjzSh2y46pEJoyb1qKHp4lX/Blk0EQr1GzW8d75ENwU8lTNZzu9jMP
	0fxmgas9pZ9RWz7vkqWFpA3VcNrCT5xHpyc/B9E/eIOdxbWbBhw/8p50wfyUzUHtlk1BPRUf1Mp5a
	5JVDoAMn+f/o+XbPF6K39Kujlq9h6zRZzisSV+4Z3ireB8WsVj7SFejpfJuEUhg1ppfosohF5FTIh
	WciQRTzzxa9hhz+5i9Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBOKB-0007iO-No; Fri, 20 Sep 2019 19:12:11 +0000
Received: from mail-eopbgr700093.outbound.protection.outlook.com
 ([40.107.70.93] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBOK9-0007hS-2X
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 19:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM1phx5/opLKSAeqxMCJMpzv8Pa5o+UVkU5v8y9uPr3kzmT+Lgzgvn0LHjjb4kZuO3eDE+cUV1P0YnAuNgfsbvL7XHykBlTcpMZc62YlwAGTMM0csDNnANxbxReGLGdT/snt9FyukFS1t0pPymidjf4Dem0vSUvaMBE4X3IywMYh34OnNNhD3Klv4FBxuA6fc4sq5Zl/icrLL+Zw9GqeeqE1PjgoItBo/xbJ8vpRVz3BcyuWLsSlxcQ1t+a7aOOwHDo2VNQE8xqqP0+FrmQo6oxWuBV0GFpiwTAJX9k7LAYF4z+p+dqGdBt3/mOgwwIKIgUxldTKzN1y8CB09B+P5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp+5kjuFgsnddCwe6y+Luer8vIcmy8XeshkmhmQ8P5I=;
 b=DuQQSmleMoGd6gciGyf/3MPptMCoocUsjIwWMymZewG7t0jXt1nAUUxRYMIb7YrIHtiYt1LeS2pPalv3CCvCpW476iRxXvxc/9+OCnPkdxrsXFwr1fIw+FACHNoEQC0QPkEdYjMvKwiJTPle1qjqIzVLnL/c7apyLjL8kXHPd+0kYxVwPUjOCdpJcp2OixtyPGxtWS4UElzY1v3AinC5z3VwzOf9MME2Tb2Yk8aR+CvoZToUe6U+ySAS1oAUh86vwj3witOznYq2+SuxHdwqM+KLKjcSA3ZKu4r2rXXWA2wdBz+NgA5uUcxDjx6wUSFijMox2f/56MF+N8RD/9Md/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp+5kjuFgsnddCwe6y+Luer8vIcmy8XeshkmhmQ8P5I=;
 b=PTZMxBFh2UqpjOhxrEQQGvvs0v3VDx5/YPWudERV5Zvfm2skB6IPzVAf4IKT/LfSEosnLYUWywjSpixctOE+yVaY+aZpBC2GGcXcBvKndAr7TRJ7AU56msRXI2xKeO4xJgb5/CJdjS3YVz/q3Li0gMZCdhanrTtIFFdoyM1him8=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0693.namprd21.prod.outlook.com (10.175.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Fri, 20 Sep 2019 19:12:04 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::c8f4:597b:9f3a:9fd]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::c8f4:597b:9f3a:9fd%2]) with mapi id 15.20.2305.000; Fri, 20 Sep 2019
 19:12:04 +0000
From: Long Li <longli@microsoft.com>
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Subject: RE: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Thread-Topic: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Thread-Index: AQHVXLUAoNqN0R8TLUadmsLcmKb6xacPEcMAgACKtgCAAAMjAIAAyEgAgAAEnwCAAClMgIAABJWAgAi79gCAACnHgIAACOEAgAACjoCAAA16gIAABfMAgAIuJgCAAAa1AIABBRqAgAAZZYCAAP6SgIAAOYeAgADemICAAFw4gIAE69SAgAxPKbCABFQsgIAAHz9g
Date: Fri, 20 Sep 2019 19:12:04 +0000
Message-ID: <CY4PR21MB074168DE7729C131CE4394CCCE880@CY4PR21MB0741.namprd21.prod.outlook.com>
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
In-Reply-To: <30dc6fa9-ea5e-50d6-56f9-fbc9627d8c29@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:8d96:a5ff:fe5c:e22c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 088af608-2ccd-4ec3-a6f6-08d73dfe6c7d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR21MB0693:
x-microsoft-antispam-prvs: <CY4PR21MB0693C51F428968EF7C069195CE880@CY4PR21MB0693.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(52536014)(99286004)(25786009)(2906002)(229853002)(478600001)(6436002)(55016002)(5660300002)(71190400001)(71200400001)(486006)(6116002)(9686003)(33656002)(7416002)(110136005)(11346002)(7736002)(6506007)(316002)(86362001)(446003)(14454004)(54906003)(4326008)(81156014)(74316002)(256004)(76176011)(10290500003)(476003)(46003)(66476007)(66556008)(66946007)(76116006)(8676002)(64756008)(10090500001)(81166006)(186003)(8990500004)(8936002)(102836004)(305945005)(7696005)(22452003)(66446008)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0693;
 H:CY4PR21MB0741.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7xbnduRm8WsGjHQVb4ZvrWQyKn7hXGgmS+R9+/XjoOKJh4yBjI9RU/vz1PvA9G6cHZqPvMoOpKalLsI76zMnPZpcPXrBSbacExZvLO0l+sRg5JM+jTCnInEPhYZs4j06Io+5jrdXgQ1s0bpvi8lxnrKG7ShhwkqPDxUVi2gANAMKYzjLO0eleAmK5MZklrQmv2yGOiFC/1khFq8Kejr+wKyevjnZI0WSy3odJrRBvxAvcRIFvRU6wgYaKMjFtEGqdKSAZ8xvj5Fu/2fYDn7t+afBVUY3OC3Rb6CXeSeIyOZ70yjfg4Z+sMMxhu9OZMcG0fQZvpEQwVYP72dBlKiq2hBJlUX0ySHmAKiMqpqAyR/suPFv0JPNq3XL3GxFjIwm8xk8tS/R2oSrh0WT/0cHBrSSFe4a5XpOvMxrCSWoYs=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088af608-2ccd-4ec3-a6f6-08d73dfe6c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 19:12:04.6566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w98tKGx8qf5jmZpGi33M9HEJZIpG0/sCpsGH6k1KaATWLec8B7Ydd9vE70WBGP+nonK6VPd5Z+59Kh6Nt0qXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0693
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_121209_204273_CA96B979 
X-CRM114-Status: GOOD (  16.19  )
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

> >> Long, does this patch make any difference?
> >
> > Sagi,
> >
> > Sorry it took a while to bring my system back online.
> >
> > With the patch, the IOPS is about the same drop with the 1st patch. I think
> the excessive context switches are causing the drop in IOPS.
> >
> > The following are captured by "perf sched record" for 30 seconds during
> tests.
> >
> > "perf sched latency"
> > With patch:
> >    fio:(82)              | 937632.706 ms |  1782255 | avg:    0.209 ms | max:   63.123
> ms | max at:    768.274023 s
> >
> > without patch:
> >    fio:(82)              |2348323.432 ms |    18848 | avg:    0.295 ms | max:   28.446
> ms | max at:   6447.310255 s
> 
> Without patch means the proposed hard-irq patch?

It means the current upstream code without any patch. But It's prone to soft lockup.

Ming's proposed hard-irq patch gets similar results to "without patch", however it fixes the soft lockup.

> 
> If we are context switching too much, it means the soft-irq operation is not
> efficient, not necessarily the fact that the completion path is running in soft-
> irq..
> 
> Is your kernel compiled with full preemption or voluntary preemption?

The tests are based on Ubuntu 18.04 kernel configuration. Here are the parameters:

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set

> 
> > Look closer at each CPU, we can see ksoftirqd is competing CPU with
> > fio (and effectively throttle other fio processes) (captured in
> > /sys/kernel/debug/tracing, echo sched:* >set_event)
> >
> > On CPU1 with patch: (note that the prev_state for fio is "R", it's
> preemptively scheduled)
> >             <...>-4077  [001] d... 66456.805062: sched_switch: prev_comm=fio
> prev_pid=4077 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/1
> next_pid=17 next_prio=120
> >             <...>-17    [001] d... 66456.805859: sched_switch:
> prev_comm=ksoftirqd/1 prev_pid=17 prev_prio=120 prev_state=S ==>
> next_comm=fio next_pid=4077 next_prio=120
> >             <...>-4077  [001] d... 66456.844049: sched_switch: prev_comm=fio
> prev_pid=4077 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/1
> next_pid=17 next_prio=120
> >             <...>-17    [001] d... 66456.844607: sched_switch:
> prev_comm=ksoftirqd/1 prev_pid=17 prev_prio=120 prev_state=S ==>
> next_comm=fio next_pid=4077 next_prio=120
> >
> > On CPU1 without patch: (the prev_state for fio is "S", it's voluntarily
> scheduled)
> >            <idle>-0     [001] d...  6725.392308: sched_switch:
> prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==>
> next_comm=fio next_pid=14342 next_prio=120
> >               fio-14342 [001] d...  6725.392332: sched_switch: prev_comm=fio
> prev_pid=14342 prev_prio=120 prev_state=S ==> next_comm=swapper/1
> next_pid=0 next_prio=120
> >            <idle>-0     [001] d...  6725.392356: sched_switch:
> prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==>
> next_comm=fio next_pid=14342 next_prio=120
> >               fio-14342 [001] d...  6725.392425: sched_switch:
> > prev_comm=fio prev_pid=14342 prev_prio=120 prev_state=S ==>
> > next_comm=swapper/1 next_pid=0 next_prio=12
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
