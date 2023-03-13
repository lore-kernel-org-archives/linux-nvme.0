Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E82C74A4B
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iow+Rk7mguvoU8nAn5DriBCwp9r7sBTOkvWgY+OhMm0=; b=ZxmW3LDx/oiKudlUcLWhJFkykm
	uQe/zMiDJpqmlZwH2bZDFfGaXA5LD710lQRpjqn/Xx9SRMOjMaB/4rsqDeuK+I58KINH/szft32dL
	DFnaLcm49WmV7UdsXTNcCDTM7WyojGaBJB7bjZmMf8AVBC6+gQjQ9I8JBWcYveSvpS32Xq1hKraFp
	R5z6cQ7/lVW/e3pkexv90i7zwFu62OfzAugQZ/e4MCIGWHb35FVBTdiiuuUD6rp2Ky/PB2n0KhjLy
	oFJQtvVwQ+c94yuuoK/HPjuRtdISJ4eLwhjsMfn3iIKvsFFvIFj//uBhd3r/gwZFotnReY3hwrfX3
	USa7PGXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbluO-00758J-Az; Mon, 13 Mar 2023 17:24:28 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pblmO-0071ly-0V
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 17:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678727772; x=1710263772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xJ9KoSD/TV8rcvgEZPDVl3SdMu+lzNaTWrsJJ+fmNAI=;
  b=gtD72uCPXIlNwB/fIEPH276NuuVWEvI5efmwEe42knURdmcikXHMHAOn
   M8kHFv1QCjNEv3MlZ4DUJvKazMVK/HCumkRwzo01k1NrllzuJ48LDX1bj
   Ssbxevts+qBVmAcKfrCBJyBo4j84lBbZq8Wx1Mw/vrX+JOUOXlqYZFYqt
   8SdVpsrdEHusFe6NH3MMLCvzMMTpnvcu4m4M8qzQoU/QOFJ7aND4z5m0j
   EaJc2Vlc6g5ybC0KyEcFQHOqVLD038dM3uPh++tdz9wK8K3BQsQejH+JE
   KI8VIyz5WUHa2qQmw5uGMfaid04Z5TNav5iPeipOj3XA+uaVhmwQxKB/D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399799216"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="399799216"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="924581008"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="924581008"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.213.75.134]) ([10.213.75.134])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:16:06 -0700
Message-ID: <2b6163a8-61d5-729d-17a5-764e25ce1c07@linux.intel.com>
Date: Mon, 13 Mar 2023 22:46:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 "Khandelwal, Rajat" <rajat.khandelwal@intel.com>, javier.gonz@samsung.com,
 monish.kumar.r@intel.com
References: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
 <20230309151218.GA17235@lst.de>
 <ZAn6KwVXtp+7iy16@kbusch-mbp.dhcp.thefacebook.com>
 <1573badb-6741-73f8-17a5-8e9cd31d90e7@linux.intel.com>
 <ZAoWZFykm4F5wr+o@kbusch-mbp.dhcp.thefacebook.com>
 <bdc9d3d6-ad2e-7866-c74c-2a0f8db8eab2@linux.intel.com>
 <CGME20230313095802eucas1p2ed9a708d3fb0fb1fac05015a6fb06b7f@eucas1p2.samsung.com>
 <20230313094944.nsonmbtpmgh4rtng@blixen>
From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <20230313094944.nsonmbtpmgh4rtng@blixen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_101612_171566_592A8B02 
X-CRM114-Status: GOOD (  24.22  )
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

Hi,

On 3/13/2023 3:19 PM, Pankaj Raghav wrote:
> jn Thu, Mar 09, 2023 at 11:43:33PM +0530, Rajat Khandelwal wrote:
>>>>>>> I have tried 5.10 and 6.1.15 kernels.
>>>>>> So we have a quirk for a device called Samsung X5 in core.c, which is a
>>>>>> bit of an unusual match.  Can you check that it gets applied for the
>>>>>> device that you are testing?
>>>>>>
>>>>>> Also if it gets applied, can you test this patch?
>>>>> That won't help here. The driver should be bailing on the device
>>>>> nvme_pci_enable() before we do the ready check:
>>>>>
>>>>> static int nvme_pci_enable(struct nvme_dev *dev)
>>>>> {
>>>>> ...
>>>>>            if (readl(dev->bar + NVME_REG_CSTS) == -1) {
>>>>>                    result = -ENODEV;
>>>>>                    goto disable;
>>>>>            }
>>>>>
>>>>> It sounds like the bridge has a valid memory window, and the kernel assigned it
>>>>> to the device, but for some reason the device didn't apply it to its BAR. Maybe
>>>>> the device just doesn't support hotplug?
>>>> The issue is sporadic in nature, witnessed even during reboots with the device
>>>> attached.
>>>> Is such a scenario even possible (BAR not getting written by the hardware)?
>>> It's not supposed to be possible, but your analysis checking the BAR register
>>> with setpci seems pretty convincing that that is happening.
> A bit more context on this issue FWIW:
>
> Monish contacted me a while ago regarding this issue happening in
> Samsung X5. I failed to reproduce this issue in an Intel 6th gen
> (skylake) laptop. I tried hotplugging the device multiple times but the
> device came up without any issue. That laptop used a JHL6540 Thunderbolt 3
> Bridge. I get from your email that you started seeing this issue from Alderlake.
>
> To isolate if this is an issue with the device, I repeated the same
> steps on an Apple Mac M1 but couldn't reproduce this error.

Hi, Monish is part of our team who initiated this a while ago, yes.
This is probably the first time this has been put on the open forum to gather any
useful inputs/suggestions on the kernel end.

For the first part, the issue is witnessed during reboots (cold/warm).

IIRC, the SSD was provided to the core Linux team also for reproducibility tries,
and they were able to reproduce on reboots.

>
> Unfortunately this device is already EOL, so our Firmware team is unable
> to help here.
>
> --
> Pankaj

Since the point here being BARs getting a garbage value, can we expect any traction
on this bug (keeping in mind the f/w team may not be able to help here)?

AFAIK, this device is currently commercialized, and we would want to make a decision
on whether to proceed with this or not.

Thanks
Rajat


