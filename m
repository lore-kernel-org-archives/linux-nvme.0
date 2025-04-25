Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6F8C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 01:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YCNEDUurMObuouH0O8IYbz6Apgf3YpahCk5K/Tw4znw=; b=2sDcP51K3K6cBIZGJIc+QfN8NF
	CbYfp6kYoZTlDlPLS/LRu8hmUb69KdMPUaoJu/yHajAMY3Jr68viym80eEigI/DCZWzdOTZkMc0bL
	9dv0yNlr/jlVdmT9TqHFiccDiCcet8ADmDUYaY7GnpU1e8P+NCnnPUffRH/84FQBu8vKXozYJIgYj
	6fst00zbymtBKpZsuTscWnbnraYWyc/b1B6wsTflQAu744tF3mI3a1jMOEKAqxTsqV1dftLdiKb04
	xxayKUH5AAtLsmZ5s9MV/7VbfJ+I2YGjXVkbsFE/AAlhL0BRCE1+JdR+B4LoizubVHqzW1nzHj8es
	ObTrF+Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u87mK-0000000Fgre-2SLs;
	Fri, 25 Apr 2025 01:22:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u87mI-0000000Fgr0-31qz
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 01:22:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8DDF85C652A;
	Fri, 25 Apr 2025 01:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33308C4CEE3;
	Fri, 25 Apr 2025 01:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745544173;
	bh=kmDfHiFbALleIbAHQhluydhAUtDhAwUCVGdzqFGg68E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SMYSLdHX3QAqGatY0Kxu18RKmaCdN0vFiaRyfUx8tc91dZNcfiVxVi5Lpo5OtoQee
	 O0aiPA5javpAsEs6IftDvMeLdapt0J7X3ii/dhN5T0mcx/VPuFSkf2a3tinAETlqwa
	 kI1nC+8gTxZLQ6kSYaBmQDAUQIP09m890xj95J4XnIoFtqL9cUaHUNnIccfMqVq7tB
	 XNnV8EWV8qUqmDhJt4PC2qJH3LAzYdBf9mCCa5YH50qUDM6sHa2AAYS9H5ZgFbIqik
	 hhVgMT/oi6LoaoIDPPr9GUABx/f12Khd6pimju0g3nICDrfC+3lV8W08o9IcOcSkId
	 OUAYlAKUCXh/g==
Message-ID: <0c068b61-afc6-4458-9a64-47e76778c895@kernel.org>
Date: Fri, 25 Apr 2025 10:22:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] pci: nvmet: support completion queue sharing by
 multiple submission queues
To: Niklas Cassel <cassel@kernel.org>,
 Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, alistair.francis@wdc.com,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
 <aAo5xgVOgf0HeFl6@x1-carbon>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aAo5xgVOgf0HeFl6@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_182254_818243_D33FFA86 
X-CRM114-Status: GOOD (  24.46  )
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

On 4/24/25 22:16, Niklas Cassel wrote:
> Hello Wilfred,
> 
> On Thu, Apr 24, 2025 at 03:13:48PM +1000, Wilfred Mallawa wrote:
>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>
>> Hi all,
>>
>> For the NVMe PCI transport, the NVMe specification allows different
>> submission queues (SQs) to share completion queues (CQs), however,
>> this is not supported in the current NVMe target implementation.
>> Until now, the nvmet target implementation enforced a 1:1 relationship
>> between SQs and CQs, which is not specification compliant for the NVMe
>> PCI transport.
> 
> Perhaps it is a bit too harsh to say that we are non-spec compliant.
> We don't implement every feature in the NVMe spec in the Linux drivers
> on purpose, because there is a lot of feature creep in NVMe.
> 
> Perhaps rephrase this to something like:
> "While the nvmet target implementation only supports a 1:1 relationship
> between SQs and CQs, the NVMe over PCIe Transport Specification does not
> have this restriction."
> 
> 
>>
>> This patch series adds support for CQ sharing between multiple SQs in the
>> NVMe target driver, in line with the NVMe PCI transport specification.
>> This series implements reference counting for completion queues to ensure
>> proper lifecycle management when shared across multiple submission queues.
>> This ensures that we retain CQs until all referencing SQs are deleted
>> first, thereby avoiding premature CQ deletions.
> 
> The patches themselves look nice, however, I do think this cover letter is
> missing the answer to the question "why?".
> 
> If you need to modify the host-side Linux kernel even to test this feature,
> why are we doing this?
> 
> Is because we want to be nice to other host-side operating systems or NVMe
> stacks, e.g. SPDK, with might actually use this feature?

Yes. The Linux nvme pci host driver does not use CQ sharing, but other OSes may.

There is no urgency with this as no-one complained about this mandatory feature
not being supported. But it does not hurt to have this as it also adds nice
checks on the fabrics side to make sure that IO queues are being created and
deleted correctly.

-- 
Damien Le Moal
Western Digital Research

