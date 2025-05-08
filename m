Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10637C3ABC5
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lVAaoRca/vwpbmlZNBU7duKd8jYBGQ/6sw94YjFa/ns=; b=O9egI1Y+nw4u7zgT3ES7UuRpqc
	/OiyKmMkNv5DZQQXUjhz1R1ccP8B1B4hBLdr7Jvg5ijQgKr66AbagkgTrSIDNazfe3G4NLoxCAmYb
	jVGG50KsjvS519MgH2GSy6d7ORDNBTFmPIG87Gsp586gf0mtjnL8yJIzT56BwkJrXh8Px3SWJE3Y4
	TEwEON/9lJc++O41rfiKoNI94ib9St8nrhm8Oo3j0pp1OWCjt3/6QvfMuHCJMCD4yNa78q8auRvHQ
	rWlQjtvx7iJPDKSAUL+P840+rOn7OwTCmuX7FQX0T9585qZHI3KFkkj6zxi0d6WNRvvmbEJpLA9tV
	MjmlZalA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAT2-00000001xzU-0jE9;
	Thu, 08 May 2025 23:15:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDARn-00000001xr3-1Zoz
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:14:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A757942BA8;
	Thu,  8 May 2025 23:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4865C4CEE7;
	Thu,  8 May 2025 23:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746073;
	bh=lF43TtyYm3bX/73qdqe+ODN0kPWwaiPoU5pYYiyZLgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rvofp8XK5b+NnL9HfqE8K+MbPZ84vCOlgGwNlnprmHoRYvvEqDT3XkUax9unbZN8U
	 ZrMGGXP9VHRqkfavxaJd5nYKAM/haXd8DTt3OaQcaFm8VG5jVuw98yGru2VuwgBcOW
	 /fP9vkPRDkXxOJqaaVgY5y9R4qAbU5PwfCqsCyw3BIq0omnjbUSAoBUwmN2feJRGCz
	 odQkXSk8c+8M3c+TWbDx55qEqwV1QfA4BgOuVelBX7984+SmDm3tsCjEkLuTCAXrWz
	 EcONKDNozcJzlLg/A7RX95/R2d3asyaGg9MmZv5fQ8P+P8SvcesLq7/xkuBIoikEhE
	 qbCWHY5cJLO7A==
Message-ID: <457cdc67-443f-4fae-b029-7bbe5b66ff45@kernel.org>
Date: Fri, 9 May 2025 08:13:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvmet: pci-epf: Clear completion queue IRQ flag on
 delete
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20250508065745.389199-1-dlemoal@kernel.org>
 <20250508065745.389199-2-dlemoal@kernel.org> <aBysgrz9R08PCwkR@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aBysgrz9R08PCwkR@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_161435_437660_87FD7B2F 
X-CRM114-Status: GOOD (  20.97  )
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
> On Thu, May 08, 2025 at 03:57:42PM +0900, Damien Le Moal wrote:
>> The function nvmet_pci_epf_delete_cq() unconditionnally calls
> 
> s/unconditionnally/unconditionally/
> 
> 
>> nvmet_pci_epf_remove_irq_vector() even for completion queues that do not
>> have interrupts enabled. Furthermore, for completion queues that do
>> have IRQ enabled, deleting and re-creating the completion queue leaves
>> the flag NVMET_PCI_EPF_Q_IRQ_ENABLED set, even if the completion queue
>> is being re-created with IRQ disabled.
>>
>> Fix these issues by calling nvmet_pci_epf_remove_irq_vector() only if
>> NVMET_PCI_EPF_Q_IRQ_ENABLED is set and make sure to always clear that
>> flag.
>>
>> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/nvme/target/pci-epf.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
>> index 7fab7f3d79b7..d5442991f2fb 100644
>> --- a/drivers/nvme/target/pci-epf.c
>> +++ b/drivers/nvme/target/pci-epf.c
>> @@ -1344,7 +1344,8 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
>>  
>>  	cancel_delayed_work_sync(&cq->work);
>>  	nvmet_pci_epf_drain_queue(cq);
>> -	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
>> +	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
>> +		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
> 
> I agree that we should only call nvmet_pci_epf_remove_irq_vector() if
> NVMET_PCI_EPF_Q_IRQ_ENABLED is set.
> 
> However, it looks a bit weird to explicitly only clear only this flag bit.
> What about the other flag bits?

NVMET_PCI_EPF_Q_LIVE is cleared in the same function in the same manner. The
only other flag is NVMET_PCI_EPF_Q_IRQ_ENABLED, which this patch clears.

> I would have expected a memset() of flags, or flags = 0; in either
> .create_cq/.create_sq, or in .delete_cq/.delete_sq.
> 
> And it also seems that flag NVMET_PCI_EPF_Q_IS_SQ is unused, so that flag
> can probably be dropped.

Good catch. Will add a patch to drop it.


-- 
Damien Le Moal
Western Digital Research

