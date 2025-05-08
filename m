Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41A0C3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4gcAd88/jOC7VHOZ/3MLcaOblJf/fZzvni2G2SdXdkQ=; b=4Abopb3K2v/77EghMGJESIWlzB
	fnjDcpxnOEsKOv0sHlqy/CTDFPKgocUwkBHUFk1beqV1TN+opYW7BViUdkd7pto+PKM0NUyzxGJY+
	ziAAxbTJBEY9Mut2JXb12Tf5df1+4+9Bsdk8H289agmRzeQfyvQT2SMVvuzwsrof227jH3Fv5gU2a
	1Du176L0SaGNRWxkvU9ilRi+0tEwnVhfL+3uDcY9JIM62Ti1u9jZYt0tO4d2+eoEaCGUqg8mxcd3E
	GhjCf0ACstOS4ssPhV0LNJmXMxen7zpFflXz2ayDriq19oO70e/KQ81I4T+kbPt9WQkdbRldeVbUM
	4E0zmSHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAT2-00000001xzw-3P4K;
	Thu, 08 May 2025 23:15:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDASY-00000001xvM-3hEl
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:15:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0F5AC5C64DD;
	Thu,  8 May 2025 23:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415BBC4CEED;
	Thu,  8 May 2025 23:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746122;
	bh=OTgnUUpeKrOn7DTJSXRTW1Nb6k4mpBNtajXELx9izXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OF5VnZjnygJ2WKlDfF6ip5gzB7n24ge46Y4FY6lIky8qhAVjIh+OpWVCQ8NZTk+rs
	 87EvY7BbIZiHZTCfhqFyt35jYaj6NpXD7fogIjzE2o30bQisa+QOsNa45Q2tFf0lI8
	 jyFNQ4h6QkC/c6Hem5tU4CpXdO4Lse/Y7F8ytkPIXIu9sNYFiVbyWKpWW4w79pqPlT
	 k9rG7sJm99j1ZzcC/5O1W6Q2iM0K/ZLOunGiawDCfqq/fJbTsczAxQfT9Vwo6R/ShC
	 lKlnGpmlYEfu9YakexPG/V45pUgw0FPl0dHlRjTsMAVQHgCofWfg/xNtpuGZG+YkCu
	 1w7XmZFxHGv0g==
Message-ID: <12036050-6afa-44ed-b545-bbaeb096b8d5@kernel.org>
Date: Fri, 9 May 2025 08:14:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvmet: pci-epf: Do not fall back to using INTX if not
 supported
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20250508065745.389199-1-dlemoal@kernel.org>
 <20250508065745.389199-3-dlemoal@kernel.org> <aBysjC5PEovQwgEs@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aBysjC5PEovQwgEs@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_161522_964728_20447CDE 
X-CRM114-Status: GOOD (  10.90  )
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

On 5/8/25 10:07 PM, Niklas Cassel wrote:
> On Thu, May 08, 2025 at 03:57:43PM +0900, Damien Le Moal wrote:
>> Some endpoint PCIe controllers do not support raising legacy INTX
>> interrupts. This support is indicated by the intx_capable field of
>> struct pci_epc_features. Modify nvmet_pci_epf_raise_irq() to not
>> automatically fallback to trying raising an INTX interrupt after an MSI
>> or MSI-X error if the controller does not support INTX.
>>
>> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Hm..
> 
> 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver") was first
> included in v6.14-rc1.
> 
> 4b313c69a38e ("PCI: endpoint: Add intx_capable to epc_features struct") was first
> included in v6.15-rc1.
> 
> Perhaps add a:
> Cc: stable+noautosel@kernel.org # depends on patch introducing intx_capable flag
> 
> So that it is not automatically backported.

Good catch. Will drop the Fixes tag. No point in it.

-- 
Damien Le Moal
Western Digital Research

