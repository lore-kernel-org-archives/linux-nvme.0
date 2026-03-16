Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132E4F506E1
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kpujCZ/vSDw4zCDORT12rvenxa81S2ppy1fA8VhaSLY=; b=f+OFgPUEXGi0TjQES6Rp672uEv
	xukTcgZmndZMw2RAxlgJgHj7okbb/XSZKOwd8pksV42izXt60+XxSVk4j2catElm+2zhUZCgxs5Wn
	Spq1v4jyW/AXtO84yhg96wGs+AEo67oDRIYMlIAeAPOQU2OSbq/IKQtTzQQ8nL0mxnBY0QALmjC+E
	4rOWkEzu1Tx3B//7QKE3bY02V96plozaVElxB7mspZKWDP5O5Murb9IPqgePBozok5VpCUpktPWgV
	aPSvVHq/rHEDUWjtKdxfW9326zk5+OOHsLhaOxvW6bBkrqc7ArgzRdL3SRaEtdBoErRPLwfbYKJNT
	2Nh3F3jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w29M9-00000004GGO-3uXM;
	Mon, 16 Mar 2026 14:55:45 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w29M6-00000004G8h-4A0R
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 14:55:44 +0000
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id ECB6C4C4430024;
	Mon, 16 Mar 2026 15:54:33 +0100 (CET)
Message-ID: <311a59f3-10bb-4a43-b86d-2f1ef316a01c@molgen.mpg.de>
Date: Mon, 16 Mar 2026 15:54:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux error `[DMA Write NO_PASID] Request device [3c:00.0] fault
 addr 0x0 [fault reason 0x05] PTE Write access is not set`
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
 <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_075543_182682_6BE3F902 
X-CRM114-Status: GOOD (  14.77  )
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

Dear Baolu, dear Linux folks,


Thank you for looking into this.

Am 27.02.26 um 03:23 schrieb Baolu Lu:
> On 2/8/26 03:10, Paul Menzel wrote:

>> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the error 
>> below:
>>
>>      [17959.189315] ACPI: EC: event unblocked
>>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
>>
>> 3c:00.0 is the NVMe controller/device.
>>
>>      $ lspci -nn -s 3c:00.0
>>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe Solid State Drive 512GB [1c5c:1284]
>>
>> This seems to happen only *sometimes* when resuming from ACPI S3.
>>
>> To my knowledge, this is *not* a new problem. Please find the log 
>> messages attached. (Ignore the other DMAR error for now.)
> 
> These IOMMU DMA faults are triggered when the NVMe controller attempts
> DMA writes to system memory address 0x0. The IOMMU hardware blocked
> these accesses because the system software has not granted the device
> permission to write to this specific address. It's unlikely a bug or
> problem in the iommu driver as far as I can see.
I am seeing the same issue on a Dell XPS 15 7590 with Intel NVMe controller:

     $ lspci -nn -s 3d:00.0
     3d:00.0 Non-Volatile memory controller [0108]: Intel Corporation 
SSD DC P4101/Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)

Logs from Debian’s Linux 6.19.8:

     [  726.138732] DMAR: DRHD: handling fault status reg 3
     [  726.138736] DMAR: [DMA Read NO_PASID] Request device [3d:00.0] 
fault addr 0xffffd000 [fault reason 0x06] PTE Read access is not set
     [  726.141470] nvme nvme0: 12/0/0 default/read/poll queue

It’d be great if this could be fixed.


Kind regards,

paul

