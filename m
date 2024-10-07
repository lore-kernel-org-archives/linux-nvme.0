Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6ADCFB43F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JL0ewdEm8PcUYnyrMtj4oDNrU0y+tw4PPmJ3L8L76fQ=; b=WcJhHBcnbJ6TDdWFtrPG4W4R9i
	3xaJSguWUm8d+EQkTci2JD+R7UOISpAHWqVkaZQZIlayL1bv5rb7jQ2caEBPP2gyspxupHt6Itlgl
	es4eluqrvamZ/9l+0FnNOMuRwI0yMQc3cmswQ7z9AsCcwIFKbNMgLqcZi2tGE4LFz4yKF9k5+pHfs
	czDu2QUwylTNoB0GzWWhRr6OJv9LMoawH3Uwhv+G77FSO4JD+cNRHPa92JVMcWYvRrQHJOS3aGWyE
	fGGtnk/44L11nRzsBu3F/G2ujQZMX6Iz3FLEauZ5o4E2oab1IzVxP/urfI6LvDD7pTQiS1N6xvvMA
	cjsKochg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkxM-000000023Dz-0qTl;
	Mon, 07 Oct 2024 10:27:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkwy-0000000239z-08Pe
	for linux-nvme@bombadil.infradead.org;
	Mon, 07 Oct 2024 10:26:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JL0ewdEm8PcUYnyrMtj4oDNrU0y+tw4PPmJ3L8L76fQ=; b=rcrGoyaxwRuKQJL70KnyZ7Snh7
	Hd0IV1IcoIuqZ2+vpbRHXumJyu9j0d7fQgcsvjKoJpabEZIlEOimhuYGNP4Cf3TlhjvAL354HC6k3
	ZhMZjYU/SLXt9KzUI6gxvN2TYEhRVUMUdxunE83CetoEkuvDXaiufKeR9AUtmVHBXDrKzU9zD40ml
	bG5Zn7+80jSszr6BHUFHqF4k7OMW9HvmFu6PrfyyVq7OVduGt4O09EBl4M46N4e/y8b/dC5kNFLE1
	V2+oXOgFaLOvrX5qFXd4hmiHScd5YnY4YPAuoaJbGyRbyIOtjxt194oZM4Tq1NQxjMqx0I0vzM/ws
	HQNbIi6g==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkwu-00000004P5E-2en1
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 10:26:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 34D5A5C5D00;
	Mon,  7 Oct 2024 10:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E34C4CECD;
	Mon,  7 Oct 2024 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728296800;
	bh=xWZeCv2t+ngHlYtflR8W7eMTpOtQGRpThgYWysiR5Hc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h+KsTa4+UQ+Vo1rgTyXC+TNHLP4/dFB+3i4AFcn3FVgjcz4jDsxQsp9xxDoptKkNX
	 4L4ig9ybBwbyr1lWDIsoNuI6XYM3Ha/D0BZvmmSC0VrsAMyT/Lq/qDrT1og/lmJ2GD
	 5pNSsHHqseLFIogddZj3uiNkrVrPKe1bsvdKdi9OORxWpIeTWrlV8Q95xzfcArRLpP
	 fR0cICN3WlPw5su4IgGlQwne5qCXwRCEUX9UY3r4XLOt267w5ChltBxYoEGdQBjrT1
	 Hk/F/ZxrMHs1/G/ul/FZBF+Qxd2DMoAsHdVOWWjweKw7PtxADmfCjzGc43hfyN/CFY
	 s6Zd05kvGsefg==
Message-ID: <8b1c846d-6c86-43ea-bc73-aef619094267@kernel.org>
Date: Mon, 7 Oct 2024 19:26:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241007044351.157912-1-dlemoal@kernel.org>
 <20241007044351.157912-5-dlemoal@kernel.org> <ZwO0H0WCnORq9EzQ@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZwO0H0WCnORq9EzQ@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_112644_977413_AC1979E2 
X-CRM114-Status: GOOD (  15.00  )
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

On 10/7/24 19:12, Niklas Cassel wrote:
> On Mon, Oct 07, 2024 at 01:43:50PM +0900, Damien Le Moal wrote:
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> (snip)
> 
>> Early versions of this driver code were based on an RFC submission by
>> Alan Mikhak <alan.mikhak@sifive.com> (https://lwn.net/Articles/804369/).
>> The code however has since been completely rewritten.
> 
> Here you state that the code has been completely rewritten...
> 
> 
>>
>> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  MAINTAINERS                                   |    7 +
>>  drivers/pci/endpoint/functions/Kconfig        |    9 +
>>  drivers/pci/endpoint/functions/Makefile       |    1 +
>>  drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 +++++++++++++++++
>>  4 files changed, 2506 insertions(+)
>>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c
> 
> (snip)
> 
>> --- /dev/null
>> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
>> @@ -0,0 +1,2489 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe function driver for PCI Endpoint Framework
>> + *
>> + * Copyright (C) 2019 SiFive
> 
> ...yet here you claim Copyright (C) SiFive.
> 
> *If* the code has been completely rewritten, then you probably should
> put yourself and/or your current employeer as the copyright holder.

Oops. One thing I forgot to rewrite :)
Will change the copyright in v2.

> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research

