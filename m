Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A6DC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:18:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FD020659
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QcokdIgC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fArK9ryr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FD020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UsAJ+UaEX2tK33nP6ED57p8fJ3JRT9dvAl+gA8mispg=; b=QcokdIgCH2QmcP
	PdtgXSkSCXnoAcIoOzYdKta3pGFGsxbfiVIsFsUnt3d4iDPS7/OdiFF1/fE0e6mgL5ls2n627YU6W
	kQZkBddxJzQ3veTu+ZDunqzkCLvL4o6Np/22a9kCT0uoGzchIoG6ojF1TSCAa+ijXVnUJvBNxNiot
	m6GpxKbEnVXNcxhJGCPjM3nQNcOPg7lCZOt6laOmSWxr5aaInGhsbuF42zZqKYocdJpVcukERmDPU
	RyODYUGBQNPq4LS9FSa7usApz2ZYYVN/8XLxyN+ceUdcJ5r6MdAVS+3+57xUPXco35tv04EtN9UB8
	6cl0T/WCLags8b57zcsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUdY3-0007Ng-Hh; Tue, 12 Nov 2019 21:18:03 +0000
Received: from mail-eopbgr730134.outbound.protection.outlook.com
 ([40.107.73.134] helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUdY0-0007NK-4E
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 21:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvGp8C1Z/dkAJokY9MoboBiPx35IxNO4u/PRdp3xihdSYE6ZdQzqL0HEFPVOxZF11EO0KJqOcr861qri/9eXNrm/S+oOcidbhPVfxdyPRdNN3uyb37bcTfznzVxWLUxr2H98SOcXovvleRMAJ2snTqxdd0V+1bEKa/hArZZ8kFcdEW7QhSg92IL+J57KnrXuG5v7+QDT8FkWhaAUQUxR0MblShuSas2mGbrulkv558vdBcvJkJ3OOnTYe0qAnB2/4pHUAJoTYGJ3HB6A5uK9N+5r6RdBhYlpmW6Mact6LHEFTDOAN3SLacV0v8wOM9TJJqvU8CUeSj49966nv0UwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onR5VhDZezz/EgQAsScoHr79HeXOlDtj9u8+qEtJ1ho=;
 b=ZDkMy+SUiPxO3ZcI4RNqHzb2Fd/hKYN8WNsSzdVUbq/YlQsNyp4FL+rCHUVbeKs8lXUrrAcfC8QsFhhM51mW3s4BRllM+cmmq+oPY/efjIc4w1p+xQ7KblPDF9Nv20LAg9nVjX96coX75P8edPRriwEvsa9VncsclvzCfKPiZWI6PTtcae5jzdrlEk8kwVgiY7UxFgMdNnYrQpfVkpTm89W7ZCS6lJnFjtWUWTrb1A6ZxlX8ff0iUriI5s1/nMqAJF0eo+hCR0Km8kDcY2OU2feNZdwu1ibh6A+YQABIlAT1ADoHWWA5mnLGgog0/KT8agi4TLmaxs3VQrYz4kvmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onR5VhDZezz/EgQAsScoHr79HeXOlDtj9u8+qEtJ1ho=;
 b=fArK9ryr3sQRgM9fAKZTYwFd5VLdabMZmBUKlvjF30MWoaENOdGBRKrg50iCQT7ML9EwwKtPRf0fftd/G6LG1UREMg/yIkgn/bDik7gNH2ygvVhSQu9B7P7KISzCjBCah2cyUwHbN+BlqL+oxMAY+qNvkDvlK8iqEt0Gx03qJLo=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.11; Tue, 12 Nov 2019 21:17:57 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::8c0d:e8a3:4fb7:e083]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::8c0d:e8a3:4fb7:e083%9]) with mapi id 15.20.2451.018; Tue, 12 Nov 2019
 21:17:57 +0000
From: Long Li <longli@microsoft.com>
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Subject: RE: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Topic: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Index: AQHVlehiYcB/lSKxl0SzyAz+DwfVW6eGyYoAgACJpYCAAIANAIAAOEeg
Date: Tue, 12 Nov 2019 21:17:57 +0000
Message-ID: <CY4PR21MB0741CB372ABC707223ECC6FECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <82fb330e-a507-999a-69f3-947f13bbaae1@grimberg.me>
 <20191112095649.GE15079@ming.t460p>
 <4664ca6f-2ebb-c69c-5b7f-226a86394adf@grimberg.me>
In-Reply-To: <4664ca6f-2ebb-c69c-5b7f-226a86394adf@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:eddf:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c09b21b5-41a8-494d-99f2-08d767b5ca29
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277DBEF1086D67400B8AB1CCE770@CY4PR21MB0277.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(51234002)(189003)(51444003)(476003)(25786009)(9686003)(33656002)(55016002)(6246003)(486006)(8936002)(4326008)(7736002)(74316002)(305945005)(10090500001)(6436002)(99286004)(256004)(14444005)(71200400001)(71190400001)(76176011)(478600001)(229853002)(10290500003)(54906003)(64756008)(186003)(102836004)(86362001)(446003)(6506007)(316002)(66446008)(66476007)(66556008)(66946007)(76116006)(2906002)(52536014)(22452003)(8676002)(8990500004)(46003)(5660300002)(110136005)(14454004)(11346002)(6116002)(81156014)(81166006)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0277;
 H:CY4PR21MB0741.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPAvyLCW9lcsHVP99cUiRfcjXMSRuBVTf0pteoMhh0c88xNn6nym+jl76QfhJYwBKB0cSQiR/+D3l82TEPFIh31eCxhzgctrMwBW+9zwgGVeljZaV+4qhwqj4Id3XnuzmuM8DwRN5lEz1lkhRgfKCe6YKjpJSCL/Do79/qnZYPwA3IDaT5367NUu5WAD+5rCuPHX9RmXPnUqcdqzgnY46tfF5K6kRPsp6TP+YC+KwDu4tH2wHoXxa8yHY4Szw/YHCOJe27ernkdhxHwK6Zjk/+5KagruqqMGQwIOgSKnhbfRGDnwG2EKpUAO5umjiporVqz2GOYhLUkFGHrURr8kCPX9GFFlIeaD75LIiUB3VOskiOUH1YvOrXDUSxU+BkFsQEi9m8uKtEgAQBvZs4QS546jeg82ueoKdze67GgD9Ckx69Q6bkb+MLvQ88Z2EVdOEXogC3UEV4v66E5MQR+NQg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09b21b5-41a8-494d-99f2-08d767b5ca29
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 21:17:57.2640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ewQnDkrI+TIsgPShog3kc0Zentvk/gdrFLGRJBIgmIIguo69BD5nBhpeDwolUwYDFMAVaXR71jTuJ1jhN1AGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_131800_226539_AD19988D 
X-CRM114-Status: GOOD (  18.46  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for multi-
>mapping queue
>
>
>>>> f9dde187fa92("nvme-pci: remove cq check after submission") removes
>>>> cq check after submission, this change actually causes performance
>>>> regression on some NVMe drive in which single nvmeq handles requests
>>>> originated from more than one blk-mq sw queues(call it multi-mapping
>>>> queue).
>>>>
>>>> Actually polling IO after submission can handle IO more efficiently,
>>>> especially for multi-mapping queue:
>>>>
>>>> 1) the poll itself is very cheap, and lockless check on cq is
>>>> enough, see nvme_cqe_pending(). Especially the check can be done
>>>> after batch submission is done.
>>>>
>>>> 2) when IO completion is observed via the poll in submission, the
>>>> requst may be completed without interrupt involved, or the interrupt
>>>> handler overload can be decreased.
>>>>
>>>> 3) when single sw queue is submiting IOs to this hw queue, if IOs
>>>> completion is observed via this poll, the IO can be completed
>>>> locally, which is cheaper than remote completion.
>>>>
>>>> Follows test result done on Azure L80sv2 guest with NVMe drive(
>>>> Microsoft Corporation Device b111). This guest has 80 CPUs and 10
>>>> numa nodes, and each NVMe drive supports 8 hw queues.
>>>
>>> I think that the cpu lockup is a different problem, and we should
>>> separate this patch from that problem..
>>
>> Why?
>>
>> Most of CPU lockup is a performance issue in essence. In theory,
>> improvement in IO path could alleviate the soft lockup.
>
>I don't think its a performance issue, being exposed to stall in hard irq is a
>fundamental issue. I don't see how this patch solves it.

With the patch, it's possible to process CQ on the CPU issuing I/O, effectively distributing the work to process CQ across multiple CPUs.

The original condition to trigger lockup is that multiple CPUs issuing I/O, and one CPU (where the HW queue will interrupt) processes CQ for all of them. With this patch and when I/O load is heavy, those issuing CPUs always have something to poll after I/O is issued. It's very difficult to overload the CPU that takes interrupts.

I have run tests for several days and couldn't repro the original lockup with the patch.

>
>>>> 1) test script:
>>>> fio --bs=4k --ioengine=libaio --iodepth=64 --filename=/dev/nvme0n1 \
>>>> 	--iodepth_batch_submit=16 --iodepth_batch_complete_min=16 \
>>>> 	--direct=1 --runtime=30 --numjobs=1 --rw=randread \
>>>> 	--name=test --group_reporting --gtod_reduce=1
>>>>
>>>> 2) test result:
>>>>        | v5.3       | v5.3 with this patchset
>>>> -------------------------------------------
>>>> IOPS | 130K       | 424K
>>>>
>>>> Given IO is handled more efficiently in this way, the original
>>>> report of CPU lockup[1] on Hyper-V can't be observed any more after
>>>> this patch is applied. This issue is usually triggered when running
>>>> IO from all CPUs concurrently.
>>>>
>>>
>>> This is just adding code that we already removed but in a more
>>> convoluted way...
>>
>> That commit removing the code actually causes regression for Azure
>> NVMe.
>
>This issue has been observed long before we removed the polling from the
>submission path and the cq_lock split.
>
>>> The correct place that should optimize the polling is aio/io_uring
>>> and not the driver locally IMO. Adding blk_poll to aio_getevents like
>>> io_uring would be a lot better I think..
>>
>> This poll is actually one-shot poll, and I shouldn't call it poll, and
>> it should have been called as 'check cq'.
>>
>> I believe it has been tried for supporting aio poll before, seems not
>> successful.
>
>Is there a fundamental reason why it can work for io_uring and cannot work
>for aio?
>
>>>> I also run test on Optane(32 hw queues) in big machine(96 cores, 2
>>>> numa nodes), small improvement is observed on running the above fio
>>>> over two NVMe drive with batch 1.
>>>
>>> Given that you add shared lock and atomic ops in the data path you
>>> are bound to hurt some latency oriented workloads in some way..
>>
>> The spin_trylock_irqsave() is just called in case that
>> nvme_cqe_pending() is true. My test on Optane doesn't show that latency
>is hurt.
>
>It also condition on the multi-mapping bit..
>
>Can we know for a fact that this doesn't hurt what-so-ever? If so, we should
>always do it, not conditionally do it. I would test this for io_uring test
>applications that are doing heavy polling. I think Jens had some benchmarks
>he used for how fast io_uring can go in a single cpu core...
>
>> However, I just found the Azure's NVMe is a bit special, in which the
>> 'Interrupt Coalescing' Feature register shows zero. But IO interrupt
>> is often triggered when there are many commands completed by drive.
>>
>> For example in fio test(4k, randread aio, single job), when IOPS is
>> 110K, interrupts per second is just 13~14K. When running heavy IO, the
>> interrupts per second can just reach 40~50K at most. And for normal
>> nvme drive, if 'Interrupt Coalescing' isn't used, most of times one
>> interrupt just complete one request in the rand IO test.
>>
>> That said Azure's implementation must apply aggressive interrupt
>> coalescing even though the register doesn't claim it.
>
>Did you check how many completions a reaped per interrupt?
>
>> That seems the root cause of soft lockup for Azure since lots of
>> requests may be handled in one interrupt event, especially when
>> interrupt event is delay-handled by CPU. Then it can explain why this
>> patch improves Azure NVNe so much in single job fio.
>>
>> But for other drives with N:1 mapping, the soft lockup risk still exists.
>
>As I said, we can discuss this as an optimization, but we should not consider
>this as a solution to the irq-stall issue reported on Azure as we agree that it
>doesn't solve the fundamental problem.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
