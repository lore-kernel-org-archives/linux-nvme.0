Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44729E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hIQpEQ7AxQbsUv0QjslGeeaMGnrdngHtx1I14oJnta8=; b=31sFK+EbsGfNvd010YT/zjg6pL
	q6x6nhcC6Z08F/UcwbXADu0RQsUFz2iVO/2HokEWtnFY/QQQGD9IpDzbqIcyo32UDGqAdNrCLxq7B
	+GJOjqTyzKdx5vQXuaU/UBD3wmVoF40s7uY4hG/cuy3wzsq7wz9rSFsDEZjH7m/DXRupVNRonI3o4
	5P87xJ8lOPUpmiDOONnj/alJF1McoG/gJBQdvavE+kXyjwhywVvoCTkHVS0zZL3ORvajdTLPOdReQ
	6CduQWT074KbG0Ndonck60i/ytECcdqSwbgP60h0QWP0OIthF1Q1sUxvnRjMiuzzmZzADSyzWC8L6
	rydS/fig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOYVi-00000004Ifd-15B9;
	Fri, 20 Dec 2024 08:37:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOYVf-00000004If8-3Axd
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 08:37:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2A9445C6290;
	Fri, 20 Dec 2024 08:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453C8C4CECD;
	Fri, 20 Dec 2024 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734683842;
	bh=ftCOy6rBlbR19qyi83VAykTq2PpfGu3pQ08nFyHwmCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N8UEOfBdAwNnsQZdW5W8JFMu8JsS02iHjyYJ0l6hBXm3yHWsMwOBoIFrDIGjrhyaO
	 BFoL/uJmB1yQfHz6j5GEYUCHLsqTjsR0WFh3MpWZ9bFulQlSobh1M+NPF9DCHurpyy
	 FguqJPUkFKTNuJtW69G4o+E94nI754E6AHTy0kLz3NZ8/sC1pKZN3avr8cq+cg4FK5
	 ZatPN5c0Ypn2wEb5AuZlDjcO0LCJSmS9F4n4wjMTlZ8eex8whNlWHQMz2256xGve5G
	 nVRtvF+IkVruvhuinCyQrak7CiDe8vHlkgOU9yz4TVI7BF18JLWNHN7K30VdTMuIDm
	 MH+F8WXAgCN9w==
Message-ID: <5dd769dd-9ab8-4811-8394-24f1c8e17935@kernel.org>
Date: Fri, 20 Dec 2024 17:37:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-19-dlemoal@kernel.org>
 <20241220081428.k45ydh2sl3m3vnhl@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241220081428.k45ydh2sl3m3vnhl@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_003723_844010_B1790DE0 
X-CRM114-Status: GOOD (  15.42  )
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

On 12/20/24 17:14, Manivannan Sadhasivam wrote:
> On Fri, Dec 20, 2024 at 12:54:41PM +0900, Damien Le Moal wrote:
>> Add a documentation file
>> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
>> endpoint target driver. This provides an overview of the driver
>> requirements, capabilities and limitations. A user guide describing how
>> to setup a NVMe PCI endpoint device using this driver is also provided.
>>
>> This document is made accessible also from the PCI endpoint
>> documentation using a link. Furthermore, since the existing nvme
>> documentation was not accessible from the top documentation index, an
>> index file is added to Documentation/nvme and this index listed as
>> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
>> API index.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks.

> [...]
> 
>> +Configure the function using any device ID (the vendor ID for the device will
>> +be automatically set to the same value as the NVMe target subsystem vendor
>> +ID)::
>> +
>> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pci_epf
>> +        # echo 0xBEEF > nvmepf.0/deviceid
> 
> It'd be good to mention that the vendor id set with nvmet configfs will be
> reused here.

Please re-read the sentence above the commands. I added exactly that :)

-- 
Damien Le Moal
Western Digital Research

