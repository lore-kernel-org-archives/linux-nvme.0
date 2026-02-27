Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96E7FD9E2D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 02:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yEwwtiVhwUGkFbzJAnkF9rOkvcdcUt8uTcYcVRkVw4g=; b=H1epupw3qs7rT1NIKVOXysGozE
	0g44eFita5CF58JON+W/TNBtJyVHeaa7Lg+SKSxx82G+sI9S6OlkX+Vu031/UcsN6Icx7wzkReDk0
	LiiG6vNTusWU2lfuTiS/u+9PMlJkEXczoNXxbXKychrk1qV2665D9UeOHD/d5W8DP/bg0uImRzGNt
	moj7dR2ITvI6BXVMlgiKgEK5v1/OTgVu8KdjxiOZTwGPuzTLkMTeCHq+6eVYQSySEuqU9ErY6tRoH
	TL588/sJ0pcT5AldDWmLc6FWtbsbUJFDErjRtNnYiJPzuQFWliUud19rVqJZlDHanHoqqWeKAiWWI
	zMNjcKiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvnWG-00000007XhF-2d2V;
	Fri, 27 Feb 2026 02:23:56 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvnW9-00000007Xga-2iO3
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 02:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772159030; x=1803695030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IqH0hcEoWlP5eHsUoZbwB3m+r8sXCdOO5V0jhCXqXfA=;
  b=md4BCavjKMmWFDKm5wn+HsOArMKVDPnYoFIdhizIBZq0/ZXerryBCtOf
   fFlrWVJVVvj+BMmQ28hRqRTzaBXnY9j1sjcOpre5Zg8bkF8B1LQD6gARK
   690LwhvpFKvg+7d8Ew7/iGPcmgclqWVE0tbJiz9sh2HP4kGTynZqHC0b5
   PGU1aeO2ls4BY2ZLMPKJSIy8SSxX+xiLDeY8pg5gk9HM3fQMEFFmtoyMD
   G76ASsF9F9HgzvBChES3uOczr53c38U2E3IheJX8ggdyW8Am8XJgFi+UP
   ZZF8EQseagSezFie4P7bVIO1lFmCX1j6MyH4R2BypS/ntR16kr3ldT3OL
   Q==;
X-CSE-ConnectionGUID: gW7INEhLSQimuF/FGm6w8Q==
X-CSE-MsgGUID: oxHJ7G1UT7y19GZr3QFC/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84591455"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="84591455"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 18:23:44 -0800
X-CSE-ConnectionGUID: noRFRGkWTHOGEzQ8MYP6Rg==
X-CSE-MsgGUID: Yto6NlIiQ++5zkhqioBREA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="221380703"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 18:23:43 -0800
Message-ID: <d38a2cda-4b29-43ec-ab08-b55c79714810@linux.intel.com>
Date: Fri, 27 Feb 2026 10:23:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux error `[DMA Write NO_PASID] Request device [3c:00.0] fault
 addr 0x0 [fault reason 0x05] PTE Write access is not set`
To: Paul Menzel <pmenzel@molgen.mpg.de>, David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <88e33b0c-e89f-47a2-9125-d85693d4816f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_182350_005628_B5AD7032 
X-CRM114-Status: GOOD (  13.36  )
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

On 2/8/26 03:10, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Intel Kaby Lake laptop Dell XPS 13 9360, Linux logs the error below:
> 
>      [17959.189315] ACPI: EC: event unblocked
>      [17959.197876] DMAR: DRHD: handling fault status reg 2
>      [17959.197882] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] 
> fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>      [17959.198366] DMAR: DRHD: handling fault status reg 2
>      [17959.198369] DMAR: [DMA Write NO_PASID] Request device [3c:00.0] 
> fault addr 0x0 [fault reason 0x05] PTE Write access is not set
>      [17959.198923] DMAR: DRHD: handling fault status reg 2
>      [17959.201477] nvme nvme0: 4/0/0 default/read/poll queues
> 
> 3c:00.0 is the NVMe controller/device.
> 
>      $ lspci -nn -s 3c:00.0
>      3c:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe 
> Solid State Drive 512GB [1c5c:1284]
> 
> This seems to happen only *sometimes* when resuming from ACPI S3.
> 
> To my knowledge, this is *not* a new problem. Please find the log 
> messages attached. (Ignore the other DMAR error for now.)

These IOMMU DMA faults are triggered when the NVMe controller attempts
DMA writes to system memory address 0x0. The IOMMU hardware blocked
these accesses because the system software has not granted the device
permission to write to this specific address. It's unlikely a bug or
problem in the iommu driver as far as I can see.

> Kind regards,
> 
> Paul

Thanks,
baolu

