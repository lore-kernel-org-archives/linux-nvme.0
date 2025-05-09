Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B585C3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eEMgsWM53YzPC41T9DvvciIp8SgODo93SaGZ7vkuiiM=; b=oInLOjAlQtWiLN2f4osBw1wIjE
	oCnfYeR9UE0PG0I8n0vmcf4Ur7H7VNSswLpOeX1QwN7Nq5GUrJZS8DueBkSSlGj2AedB4d5exGppg
	ekDQVv7p6zT2y2gbtBV25gAvNhShAncijyAalyWGH07o5N/kYg0bj4m9Mb1SbkihjyIL5L1/w3M+Z
	iiC4CW4TT4m9ijED3EmrZE0GK41W9B9l/2YH0cOvVmtinB9+Lcob1NehAc6bDX4ejAYtDJf9iBKag
	mh+05CVGw3+C2d/s3tvxSBRnkVm1LBuFnB6xg+gwleLeUkEqnfGRKgFB/Ly1hKY6UwrU5ymb+wd/C
	GwqHDTow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDOXz-00000003vIR-23IO;
	Fri, 09 May 2025 14:17:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDNYN-00000003iS9-3Man
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 13:14:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 234D16111F;
	Fri,  9 May 2025 13:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D304C4CEE4;
	Fri,  9 May 2025 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746796454;
	bh=TPeN1c48PNnMFD5RRhKBJ3NUQ3fibBjZKqCzO2e9LmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNI8rZhFiKqq07rHriCM9qppSpUhiMl8MeR+kmhHJh6bu9FKQlFRke9RhDCWNbQCS
	 eYuRhx1StzBPN/21GsORy2xO9OyMTvyK5UjpczqrqqSH7Z8t7z9DvY6Bh63qlKuvkB
	 gdfP/tdVtqCv9LQDd9NEo08nvC0BV9XyyL4Ic0DRR7+TewdTAbBuhK1opXe/LqYMxJ
	 nZSRU+T242WuVaJMb35a0yj+nGTvkKkp9iiD9Qwm8B5leklO6eFufVoVitdTgIV33K
	 0OmXlaYJ+NYwSFCR1hIluu3fOyWDAc6huoqZGWFdkDIegK57vNjgeQEVKgOHRFxuHn
	 5p44ULAbMoLag==
Date: Fri, 9 May 2025 15:14:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/4] nvmet: pci-epf: Clear completion queue IRQ flag on
 delete
Message-ID: <aB3_ownuFAlmOH5J@ryzen>
References: <20250508065745.389199-1-dlemoal@kernel.org>
 <20250508065745.389199-2-dlemoal@kernel.org>
 <aBysgrz9R08PCwkR@ryzen>
 <457cdc67-443f-4fae-b029-7bbe5b66ff45@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457cdc67-443f-4fae-b029-7bbe5b66ff45@kernel.org>
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

On Fri, May 09, 2025 at 08:13:22AM +0900, Damien Le Moal wrote:
> On 5/8/25 10:07 PM, Niklas Cassel wrote:
> > On Thu, May 08, 2025 at 03:57:42PM +0900, Damien Le Moal wrote:
> >> The function nvmet_pci_epf_delete_cq() unconditionnally calls
> > 
> > s/unconditionnally/unconditionally/
> > 
> > 
> >> nvmet_pci_epf_remove_irq_vector() even for completion queues that do not
> >> have interrupts enabled. Furthermore, for completion queues that do
> >> have IRQ enabled, deleting and re-creating the completion queue leaves
> >> the flag NVMET_PCI_EPF_Q_IRQ_ENABLED set, even if the completion queue
> >> is being re-created with IRQ disabled.
> >>
> >> Fix these issues by calling nvmet_pci_epf_remove_irq_vector() only if
> >> NVMET_PCI_EPF_Q_IRQ_ENABLED is set and make sure to always clear that
> >> flag.
> >>
> >> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> >> ---
> >>  drivers/nvme/target/pci-epf.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> >> index 7fab7f3d79b7..d5442991f2fb 100644
> >> --- a/drivers/nvme/target/pci-epf.c
> >> +++ b/drivers/nvme/target/pci-epf.c
> >> @@ -1344,7 +1344,8 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
> >>  
> >>  	cancel_delayed_work_sync(&cq->work);
> >>  	nvmet_pci_epf_drain_queue(cq);
> >> -	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
> >> +	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
> >> +		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
> > 
> > I agree that we should only call nvmet_pci_epf_remove_irq_vector() if
> > NVMET_PCI_EPF_Q_IRQ_ENABLED is set.
> > 
> > However, it looks a bit weird to explicitly only clear only this flag bit.
> > What about the other flag bits?
> 
> NVMET_PCI_EPF_Q_LIVE is cleared in the same function in the same manner. The
> only other flag is NVMET_PCI_EPF_Q_IRQ_ENABLED, which this patch clears.
> 
> > I would have expected a memset() of flags, or flags = 0; in either
> > .create_cq/.create_sq, or in .delete_cq/.delete_sq.

You patch looks fine, I was just thinking that it would be slightly more robust
to do flags = 0; in e.g. .create_cq/.create_sq, or .delete_cq/.delete_sq.

That way, we remove the possibility of ever introducing a similar bug to what
this patch fixes. (I.e if we ever add a new flag, we will not need to remember
to also add code that explicitly clears the bit for that new flag, since
flags = 0; clears all flags in one go.)


Kind regards,
Niklas

