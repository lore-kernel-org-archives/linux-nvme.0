Return-Path: <SRS0=tys/=MU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4290C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jul 2021 15:40:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57F660FE7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jul 2021 15:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A57F660FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESESod1IU4dx0eGQo9T8eVhpMRQf+tqC6siYDWPWuvI=; b=prJja40rScTGKaCy5RDx1b1cW9
	/7EGvoqEPpEDxQkuOXArNvJCav7fYPIdRhhlzkJTKEGX/WrK4gQvZnBoFxmCq+pnbhYGprT56sbnz
	TKsG4GItpLtG/d0bwHsGRhOmA0c0N7iSUfLv3ZYNUwV1ltU9d7zS6Du3KkZ+61DXzi+GaW2Vz9bU3
	tpOGDy4jTJmh8vwj8MiL/mWDvSIj9O6j8lEihwnUtx9XmmFLYzlNPlcxtUUh9yog/VjVEdJo5z2Tj
	utoet3VrmTxDGysik5bARWOk6lE9wem10X5m8l6bq67uI7/meDedW0tqzXt9Y2P/Z9SXq2M8MWbC2
	ysDWLZCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8lew-001M1Z-Kf; Wed, 28 Jul 2021 15:39:50 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8leg-001Lvb-4B; Wed, 28 Jul 2021 15:39:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 937221FB;
 Wed, 28 Jul 2021 08:39:29 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750F13F70D;
 Wed, 28 Jul 2021 08:39:28 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com> <YQF1AKS6Y14dLU/A@T590>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e1ec45e5-8e8b-7295-4a95-af6fe92573ee@arm.com>
Date: Wed, 28 Jul 2021 16:39:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQF1AKS6Y14dLU/A@T590>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210728_083934_250375_2FDAC593 
X-CRM114-Status: GOOD (  20.54  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021-07-28 16:17, Ming Lei wrote:
> On Wed, Jul 28, 2021 at 11:38:18AM +0100, John Garry wrote:
>> On 28/07/2021 02:32, Ming Lei wrote:
>>> On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
>>>> On 23/07/2021 11:21, Ming Lei wrote:
>>>>>> Thanks, I was also going to suggest the latter, since it's what
>>>>>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>>>>>> indicative of where the slowness most likely stems from.
>>>>> The improvement from 'iommu.strict=0' is very small:
>>>>>
>>>> Have you tried turning off the IOMMU to ensure that this is really just
>>>> an IOMMU problem?
>>>>
>>>> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
>>>> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
>>>> disabling for kernel drivers).
>>> Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
>>> on this issue.
>>
>> A ~90% throughput drop still seems to me to be too high to be a software
>> issue. More so since I don't see similar on my system. And that throughput
>> drop does not lead to a total CPU usage drop, from the fio log.

Indeed, it now sounds like $SUBJECT has been a complete red herring, and 
although the SMMU may be reflecting the underlying slowness it is not in 
fact a significant contributor to it. Presumably perf shows any 
difference in CPU time moving elsewhere once iommu_dma_unmap_sg() is out 
of the picture?

>> Do you know if anyone has run memory benchmark tests on this board to find
>> out NUMA effect? I think lmbench or stream could be used for this.
> 
> https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/

Hmm, a ~4x discrepancy in CPU<->memory bandwidth is pretty significant, 
but it's still not the ~10x discrepancy in NVMe throughput. Possibly 
CPU<->PCIe and/or PCIe<->memory bandwidth is even further impacted 
between sockets, or perhaps all the individual latencies just add up - 
that level of detailed performance analysis is beyond my expertise. 
Either way I guess it's probably time to take it up with the system 
vendor to see if there's anything which can be tuned in hardware/firmware.

Robin.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
