Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DE9FCD0C3
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Yz3GYM6AgusV4j7/th1diQ6CNomYMLLOMCrvFUOvIc=; b=ZsmktvTsvDhVZTgY6i+WznqUJn
	B67CcpAVjMKjURT7MsI3I7BUg8lTS++90zFgPF4ZmceQgl3Hp9qc0y8A3k3ymHmjhy4Itlaw3JAUu
	u44NPdlECTkLC1ccmg6AVjQoyZX1+RwXVY4gpj+v5wrgSe5uB2+VI30TzLvlbG047NmAbfxHn4+05
	iLtRaYHoTabwAtkamKBQ+in1IIA9h8ZqVVyYLw1swzgc+sp4w4psLfH43ztps2dQWjRHTxyEFL1/x
	edlJESpKxJrZzCJCMN0oGULZj4KAON0bXZaPCXkX/KWgDPOHd1jaj4UwEAHabj6nlvNi0J+Y9ZlKI
	LHQ+1nbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2kdM-00000007syx-3tsB;
	Wed, 18 Mar 2026 06:44:00 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2kdK-00000007syc-33QJ
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 06:44:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773816239; x=1805352239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k+/aIjON1w3XB49p4mTcj8eoPlBg7zpImJv+IVIjRMc=;
  b=c6zQjy9Pz0OjASqQFGDqa18R7ouWbPoQOF9EEkhpeuKNW0uIfpwOuP4j
   3xU+P9P7SoaileA0wvPwfrIEF4+6Tqo4kmyJL4QOLhG1nsaTEh3pnWMmh
   BVOLmjapPAWGHIYS/ta0gQPmnd5IDfL/NL1j+dYPr/UD0dclXViqVD+z3
   EKTlYhmXaODDfUN3gRCeYPpiEFmyc45DNVvHsHmHQJ2FwSUiBz5zajy9l
   QS80rYVIxClT5JexL1WCj5w9P8y0OgOIvozwU1pZ0RpmB+oSAm6eq9uHW
   NAkbtMaLm48yKCthoxt/enqdQfu8awyHWaUel7WxCkR5bhMlRpv6nRcmw
   w==;
X-CSE-ConnectionGUID: VJzsCdNkTmecZyGqBYxllQ==
X-CSE-MsgGUID: NnfCajC1SaywRdrlwXt7Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="97471348"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="97471348"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:43:57 -0700
X-CSE-ConnectionGUID: uG7nyVY4SGu/cL4EV2HQBg==
X-CSE-MsgGUID: AJyHP0++QdClngc+/2NzzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227199465"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:43:54 -0700
Message-ID: <8665ed69-9364-4f8a-9238-6adf9b5590a0@linux.intel.com>
Date: Wed, 18 Mar 2026 14:42:52 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <311a59f3-10bb-4a43-b86d-2f1ef316a01c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_234358_814296_2867BA55 
X-CRM114-Status: GOOD (  15.55  )
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

On 3/16/26 22:54, Paul Menzel wrote:
>>> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the error 
>>> below:
>>>
>>>      [17959.189315] ACPI: EC: event unblocked
>>>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>>>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device 
>>> [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>>>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device 
>>> [3c:00.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>>>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>>>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
>>>
>>> 3c:00.0 is the NVMe controller/device.
>>>
>>>      $ lspci -nn -s 3c:00.0
>>>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 
>>> NVMe Solid State Drive 512GB [1c5c:1284]
>>>
>>> This seems to happen only *sometimes* when resuming from ACPI S3.
>>>
>>> To my knowledge, this is *not* a new problem. Please find the log 
>>> messages attached. (Ignore the other DMAR error for now.)
>>
>> These IOMMU DMA faults are triggered when the NVMe controller attempts
>> DMA writes to system memory address 0x0. The IOMMU hardware blocked
>> these accesses because the system software has not granted the device
>> permission to write to this specific address. It's unlikely a bug or
>> problem in the iommu driver as far as I can see.
> I am seeing the same issue on a Dell XPS 15 7590 with Intel NVMe 
> controller:
> 
>      $ lspci -nn -s 3d:00.0
>      3d:00.0 Non-Volatile memory controller [0108]: Intel Corporation 
> SSD DC P4101/Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)
> 
> Logs from Debian’s Linux 6.19.8:

Did you see this warning with the v6.18 kernel or earlier?

> 
>      [  726.138732] DMAR: DRHD: handling fault status reg 3
>      [  726.138736] DMAR: [DMA Read NO_PASID] Request device [3d:00.0] 
> fault addr 0xffffd000 [fault reason 0x06] PTE Read access is not set
>      [  726.141470] nvme nvme0: 12/0/0 default/read/poll queue
> 
> It’d be great if this could be fixed.

Thanks,
baolu

