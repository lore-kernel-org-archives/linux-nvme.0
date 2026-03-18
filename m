Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F17103E168
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y+4LhdS8gPrgVbCn0cwFBxkktEkE1iIBw2BlJ5Gx7Sk=; b=Cur+T6RsAgQPHdXbB9/JXfIgWu
	lrmEKD4Bqg5oEer+JdsAId4odUX0ujxXAt+lPWlDpr/3bLJ5nRMMdRI53PE/G8YjPOe/M4jPdJIxb
	u7sHzWEwztEPB5/J7QJEp6XwyLYZdox9DsPw6JJCJd5kUyMZzTNtTID34lDuzmcxrXhTu/5tSe+Rw
	egb6ivgY9L/UOEUJVODHzbETfcGrK7weX0y/iYNmCt93aotBTWsNZJEiqMQD9PTse4StyLcqW+gJX
	bT5H2C6lNHTKP2+9fZL6nkiN1SmS6X+7v834sLnmr05AYCrP+A/7Y7ydCQU7JWW2RFV/cXejNJ8nQ
	43jsggvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2qS6-00000008Qzv-0maM;
	Wed, 18 Mar 2026 12:56:46 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2qS2-00000008QwC-0qqT
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 12:56:44 +0000
Received: from [10.2.102.105] (cbg-alt-client.mpi-cbg.de [141.5.11.254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 533284C4431226;
	Wed, 18 Mar 2026 13:55:36 +0100 (CET)
Message-ID: <3a880676-861b-4447-9775-6197ae74ffd3@molgen.mpg.de>
Date: Wed, 18 Mar 2026 13:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux error `[DMA Write NO_PASID] Request device [3c:00.0] fault
 addr 0x0 [fault reason 0x05] PTE Write access is not set`
To: Baolu Lu <baolu.lu@linux.intel.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
 <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
 <311a59f3-10bb-4a43-b86d-2f1ef316a01c@molgen.mpg.de>
 <8665ed69-9364-4f8a-9238-6adf9b5590a0@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <8665ed69-9364-4f8a-9238-6adf9b5590a0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_055642_395940_564BAB05 
X-CRM114-Status: GOOD (  16.33  )
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

Dear Baolu,


Am 18.03.26 um 07:42 schrieb Baolu Lu:
> On 3/16/26 22:54, Paul Menzel wrote:
>>>> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the error 
>>>> below:
>>>>
>>>>      [17959.189315] ACPI: EC: event unblocked
>>>>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>>>>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>>>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>>>>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>>>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>>>>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
>>>>
>>>> 3c:00.0 is the NVMe controller/device.
>>>>
>>>>      $ lspci -nn -s 3c:00.0
>>>>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe Solid State Drive 512GB [1c5c:1284]
>>>>
>>>> This seems to happen only *sometimes* when resuming from ACPI S3.
>>>>
>>>> To my knowledge, this is *not* a new problem. Please find the log 
>>>> messages attached. (Ignore the other DMAR error for now.)
>>>
>>> These IOMMU DMA faults are triggered when the NVMe controller attempts
>>> DMA writes to system memory address 0x0. The IOMMU hardware blocked
>>> these accesses because the system software has not granted the device
>>> permission to write to this specific address. It's unlikely a bug or
>>> problem in the iommu driver as far as I can see.
>> 
>> I am seeing the same issue on a Dell XPS 15 7590 with Intel NVMe 
>> controller:
>>
>>      $ lspci -nn -s 3d:00.0
>>      3d:00.0 Non-Volatile memory controller [0108]: Intel Corporation SSD DC P4101/Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)
>>
>> Logs from Debian’s Linux 6.19.8:
> 
> Did you see this warning with the v6.18 kernel or earlier?

Yes, I did see it with earlier Linux versions. For the Dell XPS 13 9360 
with SK hynix controller I found logs with Linux 6.16:

     Okt 14 08:10:02 abreu kernel: Linux version 6.16.11+deb14-amd64 
(debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-14 (Debian 
14.3.0-8) 14.3.0, GNU ld (GNU Binutils for Debian) 2.45) #1 SMP 
PREEMPT_DYNAMIC Debian 6.16.11-1 (2025-10-07)
     […]
     Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
     Okt 15 21:02:49 abreu kernel: DMAR: [DMA Write NO_PASID] Request 
device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
not set
     Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
     Okt 15 21:02:49 abreu kernel: DMAR: [DMA Write NO_PASID] Request 
device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is 
not set
     Okt 15 21:02:49 abreu kernel: DMAR: DRHD: handling fault status reg 2
     Okt 15 21:02:49 abreu kernel: nvme nvme0: 4/0/0 default/read/poll 
queues

>>      [  726.138732] DMAR: DRHD: handling fault status reg 3
>>      [  726.138736] DMAR: [DMA Read NO_PASID] Request device [3d:00.0] fault addr 0xffffd000 [fault reason 0x06] PTE Read access is not set
>>      [  726.141470] nvme nvme0: 12/0/0 default/read/poll queue

Just for the record, as I missed it, that it’s fault reason 0x05 (PTE 
*Write* access) on the Dell XPS 13 9360, and 0x06 (PTE *Read* access) on 
the Dell XPS 15 7590.

>> It’d be great if this could be fixed.


Kind regards,

Paul


PS: The archive of Linux messages of the project Hardware for Linux [2] 
contains quite a lot of logs, but most of them are from systems, where 
no suspend/resume cycle was performed.


[1]: https://github.com/linuxhw/Dmesg
[2]: https://linux-hardware.org/

