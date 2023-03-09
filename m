Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1337C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fSJ7XujkwNeTe74onsws4mPI+kIReuAbBAnzcmjM8dA=; b=Jj9P0O95IxUp8D1TS4Ism15D5m
	pUE7+hpDA7awHesapwmLzbIkSCvfCZ3sSTVk8vlsZhL4N60RCPe91B9jS+90FcNwkbxiTi8grTUcO
	7hNCvbiNYiUWyRoy82tWKw6pRNzAiTPv43hQPPD94NhEzV2WRuunJOXBTwMM7+NxzKz6omJpXFV/l
	lck/Wl2073VLQM2Baw4BzcAPY2x1bajVIR1xQu89Gj8OJoWHyGrgaLakSCAuQ18d6Ax35B3s2aziW
	R9bWY7zQLcs5Jr3JDlJx/A00xd6r2thH7YklyBTYdL3X0n15o0QGINYefQ0+oII2A77AcWk5G03J7
	muBymQgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paJmX-00BNad-HA; Thu, 09 Mar 2023 17:10:21 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paJmV-00BNZF-0h
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 17:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678381818; x=1709917818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qQz09ZcxZB568O4xICTmhUuFyTMXxGlpnQunZfnhLgw=;
  b=WymX9z8oUPIvXHOPihrfusbh9zo5/00rG5cyhi0tZD+dPK4+9q9pRhCO
   2iwkLHayysDxG2IJO7puLL7gBP6FKfRtIf/SDplWwnWeP81JTpDdS748w
   4ybA3B4hMprEcCw5jqNkaV0fGgJQMUKX+W0LX42t7qVI85ZwqFIm/Ndtz
   TzDq2OtJtGdST2NaDm4NSwdZMO85l9LUaNIqSjP3vvdqKxEjS9ryZLyN4
   HcTFy8/8qVCMo1Ph/G5hya6CavmWrc5/2o4BbYqElBBIrB8tbKgsF2TAr
   PmZqmgpTVllny9m7x2BxY1kUMPw6Nd7NfijHd0tKyXia9/ogBDRCFa8Rt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="316896662"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="316896662"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="741629167"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="741629167"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.213.100.94]) ([10.213.100.94])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:06:07 -0800
Message-ID: <1573badb-6741-73f8-17a5-8e9cd31d90e7@linux.intel.com>
Date: Thu, 9 Mar 2023 22:36:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
References: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
 <20230309151218.GA17235@lst.de>
 <ZAn6KwVXtp+7iy16@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <ZAn6KwVXtp+7iy16@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_091019_122841_F100921E 
X-CRM114-Status: GOOD (  20.69  )
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

On 3/9/2023 8:54 PM, Keith Busch wrote:
> On Thu, Mar 09, 2023 at 04:12:18PM +0100, Christoph Hellwig wrote:
>> On Thu, Mar 09, 2023 at 07:31:07PM +0530, Rajat Khandelwal wrote:
>>> Hi,
>>> I am seeking some help regarding an issue I encounter sporadically
>>> with Samsung Portable TBT SSD X5.
>>>
>>> Right from the thunderbolt discovery to the PCIe enumeration, everything
>>> is fine, until 'NVME_REG_CSTS' is tried to be read in 'nvme_reset_work'.
>>> Precisely, 'readl(dev->bar + NVME_REG_CSTS)' fails.
>>>
>>> I handle type-C, thunderbolt and USB4 on Chrome platforms, and currently
>>> we are working on Intel Raptorlake systems.
>>> This issue has been witnessed from ADL time-frame and now is seen
>>> on RPL as well. I would really like to get to the bottom of the problem
>>> and close the issue.
>>>
>>> I have tried 5.10 and 6.1.15 kernels.
>> So we have a quirk for a device called Samsung X5 in core.c, which is a
>> bit of an unusual match.  Can you check that it gets applied for the
>> device that you are testing?
>>
>> Also if it gets applied, can you test this patch?
> That won't help here. The driver should be bailing on the device
> nvme_pci_enable() before we do the ready check:
>
> static int nvme_pci_enable(struct nvme_dev *dev)
> {
> ...
>          if (readl(dev->bar + NVME_REG_CSTS) == -1) {
>                  result = -ENODEV;
>                  goto disable;
>          }
>
> It sounds like the bridge has a valid memory window, and the kernel assigned it
> to the device, but for some reason the device didn't apply it to its BAR. Maybe
> the device just doesn't support hotplug?

The issue is sporadic in nature, witnessed even during reboots with the device
attached.
Is such a scenario even possible (BAR not getting written by the hardware)?

Thanks
Rajat


