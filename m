Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB98C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 11:04:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237132068E
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 11:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HGXyF6Y8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237132068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aEiX3++YRNGHg//PBcuTE8rhJsu+e4n214I7ut0lceo=; b=HGXyF6Y8dwI91QRW0bNRRQBGf
	erJx4aB111ygg05H3RwcukFDbyK4a2tPMsbACicOWJTzqkru8OgzFvRyX+UlwW3obhNP2+MX9C08x
	FRBfbVMYdMmp10FxhmAAeN5WGCo1bhOM6yy3t9RlZFSweqz75qrho+fq9tsx4a2GD/T2I+5hUrUlJ
	b2ub09FnTEG8SWET2kJE3hPHBBhR8goYTQHAyA8Hwb8mIlEQ0XNIlJtPWfAaRu0mAn1AvJeCXh9mU
	iYfI9uqgyogHVsP+t/rcSvWSlBdOq5oA57N0XXbRrbm4GVNM1q1YOOZhwqxfeN8b4Ym6NBmRJxJcb
	Gq+QGIBDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWHqq-0002el-Rb; Wed, 06 May 2020 11:04:32 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWHqn-0002cu-OF
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 11:04:31 +0000
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id EFA5CAB5D7FD8738C1E7;
 Wed,  6 May 2020 12:04:21 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.169) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 12:04:21 +0100
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
To: Keith Busch <kbusch@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
Date: Wed, 6 May 2020 12:03:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-Originating-IP: [10.47.1.169]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_040429_938160_F85EF88F 
X-CRM114-Status: GOOD (  13.13  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 29/02/2020 05:53, Keith Busch wrote:
> On Fri, Feb 28, 2020 at 09:45:19PM +0300, Alexey Dobriyan wrote:
>> @@ -982,11 +982,9 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
>>   

I think that this patch may be broken when use_threaded_handlers=1, as I 
see this crash on my arm64 system:

[   29.366700] Unable to handle kernel paging request at virtual address 
ffff800
01178500e
[   29.375316] Mem abort info:
[   29.378096]   ESR = 0x96000007
[   29.381135]   EC = 0x25: DABT (current EL), IL = 32 bits
[   29.386422]   SET = 0, FnV = 0
[   29.389461]   EA = 0, S1PTW = 0
[   29.392587] Data abort info:
[   29.395456]   ISV = 0, ISS = 0x00000007
[   29.399272]   CM = 0, WnR = 0
[   29.402226] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000020252be08000
[   29.408896] [ffff80001178500e] pgd=00000027ff835003, 
pud=00000027ff836003, pm
d=00000027ffa53003, pte=0000000000000000
[   29.419457] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[   29.425003] Modules linked in:
[   29.428046] CPU: 17 PID: 1023 Comm: irq/137-nvme2q2 Not tainted 
5.7.0-rc4-ga3
c4a5a-dirty #117
[   29.436528] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V
3.B220.02 03/27/2020
[   29.445356] pstate: 40400089 (nZcv daIf +PAN -UAO)
[   29.450133] pc : nvme_irq_check+0x10/0x28
[   29.454130] lr : __handle_irq_event_percpu+0x5c/0x144
[   29.459158] sp : ffff80001008be90
[   29.462458] x29: ffff80001008be90 x28: ffff002fd7b144c0
[   29.467746] x27: ffffb111ce83e440 x26: ffffb111ce83e468
[   29.473032] x25: ffffb111cf14426f x24: ffff0027d6b67800
[   29.478319] x23: 0000000000000089 x22: ffff80001008bf1c
[   29.483606] x21: 0000000000000000 x20: ffff0027d6b67800
[   29.488893] x19: ffff2027ca8e6880 x18: 0000000000000000
[   29.494180] x17: 000007ffffffffff x16: 00000000000001de
[   29.499466] x15: 000000000001ffff x14: 0000000000000001
[   29.504754] x13: 000000000000002b x12: 000000000000002b
[   29.510041] x11: 000000000000ffff x10: ffffb111cef71cb8
[   29.515328] x9 : 0000000000000040 x8 : ffff2027d10fbe08
[   29.520616] x7 : 0000000000000000 x6 : 0000000000000000
[   29.525903] x5 : 0000000000000000 x4 : 0000000000000001
[   29.531190] x3 : 0000000000000400 x2 : ffff800011781000
[   29.536477] x1 : ffff800011785000 x0 : 0000000000000001
[   29.541764] Call trace:
[   29.544201]  nvme_irq_check+0x10/0x28
[   29.547847]  handle_irq_event_percpu+0x1c/0x54
[   29.552269]  handle_irq_event+0x44/0x74
[   29.556088]  handle_fasteoi_irq+0xa8/0x160
[   29.560167]  generic_handle_irq+0x2c/0x40
[   29.564158]  __handle_domain_irq+0x64/0xb0
[   29.568238]  gic_handle_irq+0x94/0x194
[   29.571970]  el1_irq+0xb8/0x180
[   29.575097]  nvme_irq+0xe4/0x1f4
[   29.578310]  irq_thread_fn+0x28/0x6c
[   29.581868]  irq_thread+0x158/0x1e8
[   29.585343]  kthread+0x124/0x150
[   29.588556]  ret_from_fork+0x10/0x18
[   29.592116] Code: 7940e023 f9402422 3941d020 8b031041 (79401c21)
[   29.598249] ---[ end trace 33259050d5109e6f ]---
[   29.607114] Kernel panic - not syncing: Fatal exception in interrupt
[   29.613459] SMP: stopping secondary CPUs
[   29.617404] Kernel Offset: 0x3111bd6d0000 from 0xffff800010000000
[   29.623468] PHYS_OFFSET: 0xffffe13f80000000
[   29.627633] CPU features: 0x080002,22808a18
[   29.631797] Memory Limit: none
[   29.639056] ---[ end Kernel panic - not syncing: Fatal exception in 
interrupt
]---

Reverting this patch makes the crash go away.

>>   static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>>   {
>> -	if (nvmeq->cq_head == nvmeq->q_depth - 1) {
>> +	if (++nvmeq->cq_head == nvmeq->q_depth) {

I figure momentarily nvmeq->cq_head may transition to equal 
nvmeq->q_depth and then to 0, which causes an out-of-bounds access here:

static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
{
	return (le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
			nvmeq->cq_phase;
}

>>   		nvmeq->cq_head = 0;
>> -		nvmeq->cq_phase = !nvmeq->cq_phase;
>> -	} else {
>> -		nvmeq->cq_head++;
>> +		nvmeq->cq_phase ^= 1;
>>   	}
>>   }
>>   

Any disagreement to sending a revert patch?

Thanks,
John

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
