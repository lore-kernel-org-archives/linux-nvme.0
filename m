Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708CACFC52C
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wX/xkyhUn/z9eOO/fWD/0e1hMVuSpK+bD0sVy4lkZuQ=; b=LldExqby43ix/RnDfKiwnJt7DQ
	D5UgtlE75/sh6T4bCEXqhE5XDwBvyq6A/3o93mfaWg48CBA0maXuC2EFwmoojWFAIsczpvbKm/PQN
	LOu8v9j12V+FTAJX1rrNDVybRowAb9oN0tnF3f5RLu6MDiJhTiiEudShPCIk8jSsEp2G3MylDlt0o
	J4OwY29UFjjl2N5qQpi9SysuzeOwzj8o5zSQ8gir8d+0EmZi3td1sRqO0eCDfeXOfrqdgRY646UjD
	ps8mG/yWq2jVYkVR6synYfKE3cswpAH0/4jngjjip9LlE4Dh5K1NlRS3XZSCGTHPj4xGUagPIrDJU
	lq1bexaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0HRb-00000004XQO-1M3z;
	Mon, 14 Oct 2024 09:32:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0H7a-00000004SNK-04UC
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 09:12:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EBB455C59A1;
	Mon, 14 Oct 2024 09:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46244C4CEC3;
	Mon, 14 Oct 2024 09:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897129;
	bh=opZczmtnmAC46lzsiMq5o6DHbppnV5C1bXWNocZ2GT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYw2BJcV5MYv0VOc4XtiMyTpD06KJORp1C0uGNyEpo495rD3VwUtSfZ7mQ/sASKfL
	 7qtgJQLT4BkTHush3lmtKhq29iKTQ+9lyVH671GG3g9Jwtp23a+Ftebo7K/ufD/LiN
	 uJeyPBiyLZUq1XBd6dYDwy5AjtcdVcfPI7B3zuolf46xx6Qt5EU3Ja9+fT1SoEvZyb
	 0KA3WJT7mzus2QBolm2mdY+rQXWObVzPNj+VoeeRwnybWURjc5pZBE0pFRlJTTb4wh
	 SfSoEg+t9RD3swROV2Ih3OjS9WTDkbOqTta2KZv9x9pMib1JrasbG9dCvZnV6FhfpF
	 gbMhSp3tUDe2Q==
Message-ID: <afabc1b5-e1c8-4b45-ba9a-57e0481d6d87@kernel.org>
Date: Mon, 14 Oct 2024 18:12:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvmef: Introduce the NVME_OPT_HIDDEN_NS option
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
 <20241011121951.90019-4-dlemoal@kernel.org> <20241014084258.GB23780@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241014084258.GB23780@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_021210_132997_E4E08508 
X-CRM114-Status: GOOD (  13.12  )
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

On 10/14/24 17:42, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 09:19:49PM +0900, Damien Le Moal wrote:
>> Introduce the NVME fabrics option NVME_OPT_HIDDEN_NS to allow a host
>> controller to be created without any user visible or internally usable
>> namespace devices. That is, if set, this option will result in the
>> controller having no character device and no block device for any of its
>> namespaces.
>>
>> This option should be used only when the nvme controller will be
>> managed using passthrough commands using the controller character
>> device, either by the user or by another device driver.
> 
> That doesn't make any sense whatsover.  Why would you create a
> passthrough controller to support PCIe?

PCIe is handled by the PCI endpoint driver and that driver only passes the nvme
commands it gets to the local fabrics controller that is being used (which can
be a loopback or tcp or whatever nvmf supports).


-- 
Damien Le Moal
Western Digital Research

