Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB83C64EC4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrcUthBDiifCxXduLZvP14xdZgY9kSLG53gQnmi2i00=; b=oaaL3oDLjWj2Uq6850v9YCxCS0
	IOjIAE07rI16J6xkn3PW/OQIhGVRqKePdkXmbe/a7tuh+awQdF8LyPzQgOOjzM0g1QLNKpJw8XJGj
	tyoZayCrs5LuxkiwK+pxOM58/vdNJ4WCAWmawea6vvkKA+HOD9u6pj9l7Fxa013yYp5r/XUgCkhCT
	eidyZGxx07xD7OKbHtHenp9M9OZ7an0UZEFKOCNH4I17aWa+ouk6ncPSjYu+Yv1ZNqbJus4DoRDc2
	J4kOQ7ak/kFlgBMUOzTYIrgd6XBNec1Omp/KbXZlFqBgYnralXCnzPcMT0uYfwjt8w7PQqtZcA0Iy
	PjgJzvoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paKlu-00BWsN-K7; Thu, 09 Mar 2023 18:13:46 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paKls-00BWrQ-8Q
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 18:13:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678385624; x=1709921624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=miVvi1z7sC7pbBiuCsCa5FDvJ/aA/aYxGc1YQpvA8IM=;
  b=C2nkatHMMgq9WMJcmBmzE0f3iTkvuYv+ClEkIE9D67CPkgG9UYNiLAlE
   XSLGpUKTOHDmOgoeCYRqoKSUEHEUoYhQRFkx7GODQFqxvk+SzukAtItlC
   WqfL287PbyjWUcynfPw1TLMi+9iyzuqc2rB35godwrbiVTULLCp0Jp/fJ
   tA5McZEE++Z4BsykwsDMP3gk00CQ8n3sky3PmGAArIwiJvmqBagpHZaLg
   WpuztpLPVa1jP2Nj6nuL9vVZYCpJ9SuXjMfCiXRcUvuEBAIanIJf2NcTK
   68J35MstzyHT0uFOgc4LWcUFTR0Nfc/T2DxgUv2rf9bD2NKzqdaZFSxqz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="320373912"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="320373912"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="1006835311"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="1006835311"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.213.100.94]) ([10.213.100.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:13:36 -0800
Message-ID: <bdc9d3d6-ad2e-7866-c74c-2a0f8db8eab2@linux.intel.com>
Date: Thu, 9 Mar 2023 23:43:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org,
 "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
References: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
 <20230309151218.GA17235@lst.de>
 <ZAn6KwVXtp+7iy16@kbusch-mbp.dhcp.thefacebook.com>
 <1573badb-6741-73f8-17a5-8e9cd31d90e7@linux.intel.com>
 <ZAoWZFykm4F5wr+o@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <ZAoWZFykm4F5wr+o@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_101344_371457_05B8B297 
X-CRM114-Status: GOOD (  19.88  )
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

On 3/9/2023 10:54 PM, Keith Busch wrote:
> On Thu, Mar 09, 2023 at 10:36:04PM +0530, Rajat Khandelwal wrote:
>> On 3/9/2023 8:54 PM, Keith Busch wrote:
>>> On Thu, Mar 09, 2023 at 04:12:18PM +0100, Christoph Hellwig wrote:
>>>> On Thu, Mar 09, 2023 at 07:31:07PM +0530, Rajat Khandelwal wrote:
>>>>> Hi,
>>>>> I am seeking some help regarding an issue I encounter sporadically
>>>>> with Samsung Portable TBT SSD X5.
>>>>>
>>>>> Right from the thunderbolt discovery to the PCIe enumeration, everything
>>>>> is fine, until 'NVME_REG_CSTS' is tried to be read in 'nvme_reset_work'.
>>>>> Precisely, 'readl(dev->bar + NVME_REG_CSTS)' fails.
>>>>>
>>>>> I handle type-C, thunderbolt and USB4 on Chrome platforms, and currently
>>>>> we are working on Intel Raptorlake systems.
>>>>> This issue has been witnessed from ADL time-frame and now is seen
>>>>> on RPL as well. I would really like to get to the bottom of the problem
>>>>> and close the issue.
>>>>>
>>>>> I have tried 5.10 and 6.1.15 kernels.
>>>> So we have a quirk for a device called Samsung X5 in core.c, which is a
>>>> bit of an unusual match.  Can you check that it gets applied for the
>>>> device that you are testing?
>>>>
>>>> Also if it gets applied, can you test this patch?
>>> That won't help here. The driver should be bailing on the device
>>> nvme_pci_enable() before we do the ready check:
>>>
>>> static int nvme_pci_enable(struct nvme_dev *dev)
>>> {
>>> ...
>>>           if (readl(dev->bar + NVME_REG_CSTS) == -1) {
>>>                   result = -ENODEV;
>>>                   goto disable;
>>>           }
>>>
>>> It sounds like the bridge has a valid memory window, and the kernel assigned it
>>> to the device, but for some reason the device didn't apply it to its BAR. Maybe
>>> the device just doesn't support hotplug?
>> The issue is sporadic in nature, witnessed even during reboots with the device
>> attached.
>> Is such a scenario even possible (BAR not getting written by the hardware)?
> It's not supposed to be possible, but your analysis checking the BAR register
> with setpci seems pretty convincing that that is happening.

I see. Any suggestions on what can be done for further steps?

Thanks
Rajat


