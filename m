Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7318107760A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 06:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vUEBVJdsL0kIDP0dE+Xb5G2CkFlPboUaMj20C4rFXzA=; b=NXRqH8pOPaU0bF7i5uGkVhFRyg
	J5SOhKeBvpAITuvCpHqmcPK0JdbkAx1vV08hM8FslsaMqLgZTmps97aZE5bQmmHavHX04k10L1ebx
	7SavkXInreFzzv7u6VEBP+0wNsj1Veu4D5I4+IAOYexFYBHGKvqDUfHF9jlfFDmxr9GCn6oj9o6ue
	9Yp/qok+HVtA9C1jARe0lyj8ixYBGPE4VPN2hAgi7MNaHaV7Mc6RbUtfBdfKMYY+1TCzptThOFRzV
	7y3UZrhLzmMhpAiFQ28Hq1IFBSZKEonYTQnxAlnj6YCxcvNpogj/U66/s1rdWJcZxCLt+V0QdnoD1
	87kB89yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w36Xr-00000009ydt-0Csh;
	Thu, 19 Mar 2026 06:07:47 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w36Xo-00000009ydR-2O1V
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 06:07:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773900464; x=1805436464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SivmnrAFIYwbeUndZBDy0z7NBvVuI7pZ/eqjqvAqOWw=;
  b=EOd4GT38A7X+5XoMI+FRqd1ExkKamboHVIWNB+Ao2UPM5JnBLn64/zbF
   ULx7OU6HhDO2Bf6QLxrxDKCGUePgBnZ6rOeNi+GvUAAQ5d+MuO8vUuiC8
   x7WUr8bQQuvl1k7RJ1oxFCzjTvN2KeVgAFJIvzoQYqSDYtSsrRDAZbZDz
   kvNokX2rPSe7XSuaXq2LYIQ5E2rTtPWDFU4DGdo3duokzAlouoIZXq3oi
   B75Rxak/TMPirjkgjfDGgdBXYi6KhwAGbVOsMwtMMyEUDjQcttMUtlc6W
   NZTIZ4qK+8GXd8CbmT3tVFN9JLN7g6/IHssYyshmSlauI7Sax0EbGilxc
   g==;
X-CSE-ConnectionGUID: /567DlL+SEmi3rYLxlyyQA==
X-CSE-MsgGUID: hAb6IcQxTKqbJkGTbW/sWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="77574115"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="77574115"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 23:07:43 -0700
X-CSE-ConnectionGUID: Uj6G5AaISgulHqnC05raRg==
X-CSE-MsgGUID: 9uasM1JKT2uT77r1puqdOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="218806151"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 23:07:41 -0700
Message-ID: <ef328a7e-59a4-4a74-bc72-aa13951b38ff@linux.intel.com>
Date: Thu, 19 Mar 2026 14:06:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux error `[DMA Write NO_PASID] Request device [3c:00.0] fault
 addr 0x0 [fault reason 0x05] PTE Write access is not set`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
 <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
 <311a59f3-10bb-4a43-b86d-2f1ef316a01c@molgen.mpg.de>
 <8665ed69-9364-4f8a-9238-6adf9b5590a0@linux.intel.com>
 <3a880676-861b-4447-9775-6197ae74ffd3@molgen.mpg.de>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3a880676-861b-4447-9775-6197ae74ffd3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_230744_622158_D51E6DCE 
X-CRM114-Status: GOOD (  19.70  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/18/26 20:55, Paul Menzel wrote:
> 
> Am 18.03.26 um 07:42 schrieb Baolu Lu:
>> On 3/16/26 22:54, Paul Menzel wrote:
>>>>> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the 
>>>>> error below:
>>>>>
>>>>>      [17959.189315] ACPI: EC: event unblocked
>>>>>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>>>>>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device 
>>>>> [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
>>>>> not set
>>>>>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>>>>>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device 
>>>>> [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
>>>>> not set
>>>>>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>>>>>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
>>>>>
>>>>> 3c:00.0 is the NVMe controller/device.
>>>>>
>>>>>      $ lspci -nn -s 3c:00.0
>>>>>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 
>>>>> NVMe Solid State Drive 512GB [1c5c:1284]
>>>>>
>>>>> This seems to happen only *sometimes* when resuming from ACPI S3.
>>>>>
>>>>> To my knowledge, this is *not* a new problem. Please find the log 
>>>>> messages attached. (Ignore the other DMAR error for now.)
>>>>
>>>> These IOMMU DMA faults are triggered when the NVMe controller attempts
>>>> DMA writes to system memory address 0x0. The IOMMU hardware blocked
>>>> these accesses because the system software has not granted the device
>>>> permission to write to this specific address. It's unlikely a bug or
>>>> problem in the iommu driver as far as I can see.
>>>
>>> I am seeing the same issue on a Dell XPS 15 7590 with Intel NVMe 
>>> controller:
>>>
>>>      $ lspci -nn -s 3d:00.0
>>>      3d:00.0 Non-Volatile memory controller [0108]: Intel Corporation 
>>> SSD DC P4101/Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)
>>>
>>> Logs from Debian’s Linux 6.19.8:
>>
>> Did you see this warning with the v6.18 kernel or earlier?
> 
> Yes, I did see it with earlier Linux versions. For the Dell XPS 13 9360 
> with SK hynix controller I found logs with Linux 6.16:
> 
>      Okt 14 08:10:02 abreu kernel: Linux version 6.16.11+deb14-amd64 
> (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-14 (Debian 
> 14.3.0-8) 14.3.0, GNU ld (GNU Binutils for Debian) 2.45) #1 SMP 
> PREEMPT_DYNAMIC Debian 6.16.11-1 (2025-10-07)
>      […]
>      Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
>      Okt 15 21:02:49 abreu kernel: DMAR: [DMA Write NO_PASID] Request 
> device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
> not set
>      Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
>      Okt 15 21:02:49 abreu kernel: DMAR: [DMA Write NO_PASID] Request 
> device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
> not set
>      Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
>      Okt 15 21:02:49 abreu kernel: nvme nvme0: 4/0/0 default/read/poll 
> queues

The error occurs when the NVMe controller attempts to access system
memory using IOVA 0. The iommu subsystem reserves IOVA 0 and treats it
as an invalid address; therefore, the Linux driver is unlikely to
program a device with IOVA 0 for DMA.

An exception is reserved memory used by firmware, where the regions are
identity-mapped by the iommu core during the probe process. There was a
recent fix addressing an issue with identity mapping at address 0:

https://lore.kernel.org/linux-iommu/20260227080638.208693-1-lkml@antheas.dev/

Could you please test if this patch helps? It has already been merged
into the iommu subsystem tree.

Thanks,
baolu

