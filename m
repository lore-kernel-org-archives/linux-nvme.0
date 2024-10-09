Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDCDCED62B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 08:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHsCkNL5A1OZWWXNfJcEmE7ewGesAuJ0ZYvKYw7TW2U=; b=0QR41AAdS2C0kus+Op5T29xOX7
	USI2sC8aoUBZuK4BzeMHAe9ZpbMBE7AmQBIyPiUob78u93dFNqJVDfqMfIgw0LdAlDGXdSEsHte9N
	tCizif7XE7hWxSRTTU/g2yAOWr8SruozoKGEvaDhovMiKa+pI/uUvO5nLpU/piQylU3/bcieaFSx/
	K2Ot0exf48PbV0ZpBArBj6rjCxh8O43xGQ/egwJqeeMPPnKb0SAAlp9fkgs3vrFT60qV5yPm39v+n
	swBKkooPrP/ilOjmr1sHIyC+IOOfZSpHcwZ6WpiliAOO2KW9ac8v77Tw3Yyv0Y4RgkXsu08De5Pnz
	3NijmaBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syRu7-00000008PZx-2aUa;
	Wed, 09 Oct 2024 08:18:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syRsU-00000008P4O-18K2
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 08:17:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B4AA85C4357;
	Wed,  9 Oct 2024 08:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2A1C4CEC5;
	Wed,  9 Oct 2024 08:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728461820;
	bh=B+SM6erZaNO4b0mIjZjP2ripiTOGmpQnP56439FrrtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qGGTSzQKbjdvvQRPCido3DFwGRhbSp4ecf1GA7J0SEHAGRcMj73eK0/TWSarf5R5h
	 LAh3y2ZkHy/EP0HeqIu0URrMmHyHcZyhP//5niHn3eGOJ8/UwLcopWMhrkX+mmr0Yr
	 ZpEBi5mx5Ayx2m6tcSYOAhc9morzlvPkz2/kom0t50sTmqdagJVOn56g8+zfK3h0sc
	 VIvWS7EzqsQjQ1gl67UHYi5ybXYJM6JPHAmt8I0MxXdz+FJ9cjWnKIVJd9h4OC4KIz
	 LoQa+ZVLh04JkB1uIGvaEytDRQfKT2jhhvRJW2/ketniWc9ifh1dXy0nRcckP88kXV
	 nVxYiudn+MgGg==
Message-ID: <3c017172-c8ba-450d-902a-e937a76d11ad@kernel.org>
Date: Wed, 9 Oct 2024 17:16:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org
References: <20241007044351.157912-1-dlemoal@kernel.org>
 <20241007044351.157912-5-dlemoal@kernel.org> <ZwO0H0WCnORq9EzQ@ryzen>
 <8b1c846d-6c86-43ea-bc73-aef619094267@kernel.org>
 <CAAEEuhqpthLsNX70WWCn6+udPaNhks41d=oCZRKpPSHKnRc-AQ@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAAEEuhqpthLsNX70WWCn6+udPaNhks41d=oCZRKpPSHKnRc-AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_011702_453782_F7FC3379 
X-CRM114-Status: GOOD (  19.05  )
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

On 10/9/24 16:28, Rick Wertenbroek wrote:
> On Mon, Oct 7, 2024 at 12:26 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 10/7/24 19:12, Niklas Cassel wrote:
>>> On Mon, Oct 07, 2024 at 01:43:50PM +0900, Damien Le Moal wrote:
>>>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>
>>> (snip)
>>>
>>>> Early versions of this driver code were based on an RFC submission by
>>>> Alan Mikhak <alan.mikhak@sifive.com> (https://lwn.net/Articles/804369/).
>>>> The code however has since been completely rewritten.
>>>
>>> Here you state that the code has been completely rewritten...
>>>
>>>
>>>>
>>>> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>> ---
>>>>  MAINTAINERS                                   |    7 +
>>>>  drivers/pci/endpoint/functions/Kconfig        |    9 +
>>>>  drivers/pci/endpoint/functions/Makefile       |    1 +
>>>>  drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 +++++++++++++++++
>>>>  4 files changed, 2506 insertions(+)
>>>>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c
>>>
>>> (snip)
>>>
>>>> --- /dev/null
>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
>>>> @@ -0,0 +1,2489 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * NVMe function driver for PCI Endpoint Framework
>>>> + *
>>>> + * Copyright (C) 2019 SiFive
>>>
>>> ...yet here you claim Copyright (C) SiFive.
>>>
>>> *If* the code has been completely rewritten, then you probably should
>>> put yourself and/or your current employeer as the copyright holder.
>>
>> Oops. One thing I forgot to rewrite :)
>> Will change the copyright in v2.
> 
> Hello Damien.
> Thank you for acknowledging my contributions in the commit message. I
> would appreciate it if you could add both our names in the copyright
> for the v2, I don't mind not being in the MODULE_AUTHOR() but I would
> appreciate a mention in the header comment of the file, thank you.

Sure, no problem. Would a copyright with your name only (no affiliation) be OK ?

> 
> Best regards,
> Rick
> 
>>
>>>
>>>
>>> Kind regards,
>>> Niklas
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research

