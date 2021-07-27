Return-Path: <SRS0=n/mE=MT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA4C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 17:08:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C0460F90
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 17:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98C0460F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P7N5JTZZxYB3HAHYfCximpwUYRQ4X3dUjJ2BLoad+dk=; b=TJ1RQI0smRSkv+eSRwjXNJfoCM
	4thlNxI4QpKacxZRnPiz0HJIWsH4jilljtMk/Pect8Q0Ghox+/UjFfHEsXfsNVTnWqO3p21abtCsX
	KgIZ2z/X2grx+DKROUEUGZtS0VrADOl/5urhBZ6GLN7eOsYwx2mgGDKjT3DABs3roEQ/zUMJI18cO
	gh/7rSd67oYxXNq1P3wW2eVv6ESFARDVNJ/Z1l6zbLasTv1HtfTBF6dhzB1sRNcFtZBlbAO4fNxur
	rY/uSUq4PfebAVMJwt+B47SXWTCzEpLxOIagt2DbmN12LtvR3zuLoArcy/xNs/B1dXvoCSn9Q7uzy
	PRLqr62g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8QZD-00FTK9-Rq; Tue, 27 Jul 2021 17:08:31 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8QYw-00FTCN-HC; Tue, 27 Jul 2021 17:08:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE7981FB;
 Tue, 27 Jul 2021 10:08:11 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A11BF3F70D;
 Tue, 27 Jul 2021 10:08:10 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
References: <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b74d7025-c452-049f-f9a9-75ba555d029d@arm.com>
Date: Tue, 27 Jul 2021 18:08:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPqYDY9/VAhfHNfU@T590>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210727_100814_751863_78056927 
X-CRM114-Status: GOOD (  22.95  )
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

On 2021-07-23 11:21, Ming Lei wrote:
> On Thu, Jul 22, 2021 at 06:40:18PM +0100, Robin Murphy wrote:
>> On 2021-07-22 16:54, Ming Lei wrote:
>> [...]
>>>> If you are still keen to investigate more, then can try either of these:
>>>>
>>>> - add iommu.strict=0 to the cmdline
>>>>
>>>> - use perf record+annotate to find the hotspot
>>>>     - For this you need to enable psuedo-NMI with 2x steps:
>>>>       CONFIG_ARM64_PSEUDO_NMI=y in defconfig
>>>>       Add irqchip.gicv3_pseudo_nmi=1
>>>>
>>>>       See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n1745
>>>>       Your kernel log should show:
>>>>       [    0.000000] GICv3: Pseudo-NMIs enabled using forced ICC_PMR_EL1
>>>> synchronisation
>>>
>>> OK, will try the above tomorrow.
>>
>> Thanks, I was also going to suggest the latter, since it's what
>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>> indicative of where the slowness most likely stems from.
> 
> The improvement from 'iommu.strict=0' is very small:
> 
> [root@ampere-mtjade-04 ~]# cat /proc/cmdline
> BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.14.0-rc2_linus root=UUID=cff79b49-6661-4347-b366-eb48273fe0c1 ro nvme.poll_queues=2 iommu.strict=0
> 
> [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=1530MiB/s][r=392k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=2999: Fri Jul 23 06:05:15 2021
>    read: IOPS=392k, BW=1530MiB/s (1604MB/s)(14.9GiB/10001msec)
> 
> [root@ampere-mtjade-04 ~]# taskset -c 80 ~/git/tools/test/nvme/io_uring 20 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=150MiB/s][r=38.4k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=3063: Fri Jul 23 06:05:49 2021
>    read: IOPS=38.4k, BW=150MiB/s (157MB/s)(3000MiB/20002msec)

OK, that appears to confirm that the invalidation overhead is more of a 
symptom than the major contributing factor, which also seems to line up 
fairly well with the other information.

>> FWIW I would expect iommu.strict=0 to give a proportional reduction in SMMU
>> overhead for both cases since it should effectively mean only 1/256 as many
>> invalidations are issued.
>>
>> Could you also check whether the SMMU platform devices have "numa_node"
>> properties exposed in sysfs (and if so whether the values look right), and
>> share all the SMMU output from the boot log?
> 
> No found numa_node attribute for smmu platform device, and the whole dmesg log is
> attached.

Thanks, so it seems like the SMMUs have MSI capability and are correctly 
described as coherent, which means completion polling should be 
happening in memory and so hopefully not contributing much more than a 
couple of cross-socket cacheline migrations and/or snoops. Combined with 
the difference in the perf traces looking a lot smaller than the 
order-of-magnitude difference in the overall IOPS throughput, I suspect 
this is overall SMMU overhead exacerbated by the missing NUMA info. If 
every new 4K block touched by the NVMe means a TLB miss where the SMMU 
has to walk pagetables from the wrong side of the system, I'm sure 
that's going to add up.

I'd suggest following John's suggestion and getting some baseline 
figures for just the cross-socket overhead between the CPU and NVMe with 
the SMMU right out of the picture, then have a hack at the firmware (or 
pester the system vendor) to see how much of the difference you can make 
back up by having the SMMU proximity domains described correctly such 
that there's minimal likelihood of the SMMUs having to make non-local 
accesses to their in-memory data. FWIW I don't think it should be *too* 
hard to disassemble the IORT, fill in the proximity domain numbers and 
valid flags on the SMMU nodes, then assemble it again to load as an 
override (it's anything involving offsets in that table that's a real pain).

Note that you might also need to make sure you have CMA set up and sized 
appropriately with CONFIG_DMA_PERNUMA_CMA enabled to get the full benefit.

Robin.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
