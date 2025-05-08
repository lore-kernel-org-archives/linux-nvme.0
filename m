Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DDEC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 13:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8BNaULpYy8Kc0PeBC4EhZlKyFFAzRxTztmR570bAEv8=; b=KqCM1pNfSuFrz8mRNMlSBuXICg
	HPcCmLxBBVdTwB18Ofp8fRu1tx5SMhKeoJeErnJ3KSpge6eEG3kNRSeYECsIieZx8gnwzUPi2OcGx
	AusFBa8U+cS4iCxC5Ka2Y2TurLLcNJwC5fmF/fEDTlfZbvRZ+YCnx9qOQY5PIlBKRzotDjZOVyKck
	1ooj8ks7oX2IcYB5WtiJ+CwXh787rCZqZpRB09bb4urGB3ZrNisjK+5JRZyB/yijK5DmvVzK8TDKd
	fDkohzUTD3qg32c/AqKZy5/sso3kMB8II+I0dpNfC6WbAEukHu4QYY8JQBhvB1UqkV6jPMTNg/Z5a
	7uunaw5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0y9-00000000hyH-03OM;
	Thu, 08 May 2025 13:07:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0y7-00000000hxf-1UXj
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 13:07:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C0A8A629EC;
	Thu,  8 May 2025 13:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24500C4CEE7;
	Thu,  8 May 2025 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746709638;
	bh=1cqU1HIuPXt7RPpgDva6eZBv7amUVelxZWNa+HfnPgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAr6sxQUopdJgf7v4HoVtKvNosCXNv0piOzHBd5T94o1FUYD9Ds3o5Vv1UAtgqsel
	 iHyE71INWJyj1ZD6PNga4QN6uJvDlMJiGyVReA9HO26sgbGoI/ifgyHEb7W8Wx2FrZ
	 RMbDuZY65oDfk0TVqoT/9fkJMGCMlzw2XRTJtYTYgw1aM1CfSbfEeoWTXaYgR7yd5y
	 qd4cr0eWoNY6lbXDdubmTTBqrBEPDtOUfThdZqWTqCJnUV0wCCPudVqq+fho62/kho
	 CuHh2zo99X6No9GJO9iFtxFpB+Ps8mGelwyo5/GX6CPq2v5z0TeuTgTtacIKhqVqnv
	 OWAt1ZBJ40YEQ==
Date: Thu, 8 May 2025 15:07:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/4] nvmet: pci-epf: Clear completion queue IRQ flag on
 delete
Message-ID: <aBysgrz9R08PCwkR@ryzen>
References: <20250508065745.389199-1-dlemoal@kernel.org>
 <20250508065745.389199-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508065745.389199-2-dlemoal@kernel.org>
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

On Thu, May 08, 2025 at 03:57:42PM +0900, Damien Le Moal wrote:
> The function nvmet_pci_epf_delete_cq() unconditionnally calls

s/unconditionnally/unconditionally/


> nvmet_pci_epf_remove_irq_vector() even for completion queues that do not
> have interrupts enabled. Furthermore, for completion queues that do
> have IRQ enabled, deleting and re-creating the completion queue leaves
> the flag NVMET_PCI_EPF_Q_IRQ_ENABLED set, even if the completion queue
> is being re-created with IRQ disabled.
> 
> Fix these issues by calling nvmet_pci_epf_remove_irq_vector() only if
> NVMET_PCI_EPF_Q_IRQ_ENABLED is set and make sure to always clear that
> flag.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/nvme/target/pci-epf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 7fab7f3d79b7..d5442991f2fb 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1344,7 +1344,8 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
>  
>  	cancel_delayed_work_sync(&cq->work);
>  	nvmet_pci_epf_drain_queue(cq);
> -	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
> +	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
> +		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);

I agree that we should only call nvmet_pci_epf_remove_irq_vector() if
NVMET_PCI_EPF_Q_IRQ_ENABLED is set.

However, it looks a bit weird to explicitly only clear only this flag bit.
What about the other flag bits?

I would have expected a memset() of flags, or flags = 0; in either
.create_cq/.create_sq, or in .delete_cq/.delete_sq.

And it also seems that flag NVMET_PCI_EPF_Q_IS_SQ is unused, so that flag
can probably be dropped.


Kind regards,
Niklas

