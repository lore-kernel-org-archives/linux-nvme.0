Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6C6C63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 12:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A3260FE7
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 12:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A3260FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yC7k98IUJzh/4gwF2GYfSR5B4CfwLn8RVJerZjrVsaQ=; b=ZdeIS0wnv+mZrzPcvHTkZtPaqv
	7YCT/ehJkR+6ISRPj3Mz4ZOEjIJi9xtZt96QN6YyiXJ4H6yFW7/HF+eeQON/cx8n7bNJMxh3UgOnX
	32f/NoV0bfeDSCvSQmVq7ZCRQaSlmHD5/GJwXUSD2sTRIMewjHIqfhp4B7HPmsLNUpDiqepsCVB9D
	JTh1Conolv52gQ+AGcD5NedEAoV67Y9x486eyFSrgBjHk51lUAh5kspuD7WuaVK69ICJH/oUUY54g
	guuL3S2KBadF6o0Ru0GhlU8ppimw5uZNiOpEl3oGGe+eF7fOACFXqGVhMdZe4I6NsBRh7zNdO9R4t
	3brmp5wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Xyl-001Vnh-7f; Thu, 22 Jul 2021 12:39:07 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Wcj-001KEO-0t; Thu, 22 Jul 2021 11:12:19 +0000
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVqHV2mDDz6H7l3;
 Thu, 22 Jul 2021 19:00:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 13:12:11 +0200
Received: from [10.47.26.161] (10.47.26.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 12:12:11 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: Ming Lei <ming.lei@redhat.com>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com> <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
From: John Garry <john.garry@huawei.com>
Message-ID: <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
Date: Thu, 22 Jul 2021 12:12:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YPlGOOMSdm6Bcyy/@T590>
Content-Language: en-US
X-Originating-IP: [10.47.26.161]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_041217_440525_0E483BD1 
X-CRM114-Status: GOOD (  18.69  )
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

On 22/07/2021 11:19, Ming Lei wrote:
>> If you check below, you can see that cpu4 services an NVMe irq. From
>> checking htop, during the test that cpu is at 100% load, which I put the
>> performance drop (vs cpu0) down to.
> nvme.poll_queues is 2 in my test, and no irq is involved. But the irq mode
> fio test is still as bad as io_uring.
> 

I tried that:

dmesg | grep -i nvme
[    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init 
crashkernel=256M@32M console=ttyAMA0,115200 earlycon acpi=force 
pcie_aspm=off noinitrd root=/dev/sda1 rw log_buf_len=16M user_debug=1 
iommu.strict=1 nvme.use_threaded_interrupts=0 irqchip.gicv3_pseudo_nmi=1 
nvme.poll_queues=2

[   30.531989] megaraid_sas 0000:08:00.0: NVMe passthru support : Yes
[   30.615336] megaraid_sas 0000:08:00.0: NVME page size   : (4096)
[   52.035895] nvme 0000:81:00.0: Adding to iommu group 5
[   52.047732] nvme nvme0: pci function 0000:81:00.0
[   52.067216] nvme nvme0: 22/0/2 default/read/poll queues
[   52.087318]  nvme0n1: p1

So I get these results:
cpu0 335K
cpu32 346K
cpu64 300K
cpu96 300K

So still not massive changes.

>> Here's some system info:
>>
>> HW queue irq affinities:
>> PCI name is 81:00.0: nvme0n1
>> -eirq 298, cpu list 67, effective list 67
>> -eirq 299, cpu list 32-38, effective list 35
>> -eirq 300, cpu list 39-45, effective list 39
>> -eirq 301, cpu list 46-51, effective list 46
>> -eirq 302, cpu list 52-57, effective list 52
>> -eirq 303, cpu list 58-63, effective list 60
>> -eirq 304, cpu list 64-69, effective list 68
>> -eirq 305, cpu list 70-75, effective list 70
>> -eirq 306, cpu list 76-80, effective list 76
>> -eirq 307, cpu list 81-85, effective list 84
>> -eirq 308, cpu list 86-90, effective list 86
>> -eirq 309, cpu list 91-95, effective list 92
>> -eirq 310, cpu list 96-101, effective list 100
>> -eirq 311, cpu list 102-107, effective list 102
>> -eirq 312, cpu list 108-112, effective list 108
>> -eirq 313, cpu list 113-117, effective list 116
>> -eirq 314, cpu list 118-122, effective list 118
>> -eirq 315, cpu list 123-127, effective list 124
>> -eirq 316, cpu list 0-5, effective list 4
>> -eirq 317, cpu list 6-11, effective list 6
>> -eirq 318, cpu list 12-16, effective list 12
>> -eirq 319, cpu list 17-21, effective list 20
>> -eirq 320, cpu list 22-26, effective list 22
>> -eirq 321, cpu list 27-31, effective list 28
>>
>>
>> john@ubuntu:~$ lscpu | grep NUMA
>> NUMA node(s):  4
>> NUMA node0 CPU(s):   0-31
>> NUMA node1 CPU(s):   32-63
>> NUMA node2 CPU(s):   64-95
>> NUMA node3 CPU(s):   96-127
>>
>> john@ubuntu:~$ lspci | grep -i non
>> 81:00.0 Non-Volatile memory controller: Huawei Technologies Co., Ltd. Device
>> 0123 (rev 45)
>>
>> cat /sys/block/nvme0n1/device/device/numa_node
>> 2
> BTW, nvme driver doesn't apply the pci numa node, and I guess the
> following patch is needed:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 11779be42186..3c5e10e8b0c2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4366,7 +4366,11 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	ctrl->dev = dev;
>   	ctrl->ops = ops;
>   	ctrl->quirks = quirks;
> +#ifdef CONFIG_NUMA
> +	ctrl->numa_node = dev->numa_node;
> +#else
>   	ctrl->numa_node = NUMA_NO_NODE;
> +#endif

 From a quick look at the code, is this then later set for the PCI 
device in nvme_pci_configure_admin_queue()?

>   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> 
>> [   52.968495] nvme 0000:81:00.0: Adding to iommu group 5
>> [   52.980484] nvme nvme0: pci function 0000:81:00.0
>> [   52.999881] nvme nvme0: 23/0/0 default/read/poll queues
> Looks you didn't enabling polling. In irq mode, it isn't strange
> to observe IOPS difference when running fio on different CPUs.

If you are still keen to investigate more, then can try either of these:

- add iommu.strict=0 to the cmdline

- use perf record+annotate to find the hotspot
   - For this you need to enable psuedo-NMI with 2x steps:
     CONFIG_ARM64_PSEUDO_NMI=y in defconfig
     Add irqchip.gicv3_pseudo_nmi=1

     See 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n1745
     Your kernel log should show:
     [    0.000000] GICv3: Pseudo-NMIs enabled using forced ICC_PMR_EL1 
synchronisation

But my impression is that this may be a HW implementation issue, 
considering we don't see such a huge drop off on our HW.

Thanks,
John

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
