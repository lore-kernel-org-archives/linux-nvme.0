Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B74C3ABC0
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=deeLb9nbMUdQiKeVKd0YcpDwVWcq18I9SoDqvfZqc7U=; b=Dx+kZNncVxAmG9+5ZmTxFjtaig
	YuTMq2cOL1aaf9isPDiMn5klluqH2Yd/JgzlBjbBW+YyY/sjPz78Ph0JMeecikwA5LE+P0iuTd/bT
	/JFuSFvijwBWKSSn73+O6bRwIgYDE1eawwu6Gr8pRMEKWFAbP8mXkAMaIp+TnoXqfyDByub80sPNG
	M9iczqIBzn3FdIQzULPPr5fKsJR9vmK6fs/PyGd102Tim0bsGPZcgDc08EFAhJs97y00H0AMiRDdK
	6FgBkdRR5FnlUly0Lo20HgIZJORpnWp0WhYp/ACobXn1AuC4qRw2UXWDO9Fc/jZFoC8UTulZGU3LJ
	zO77pE/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD23A-00000000spz-3C8p;
	Thu, 08 May 2025 14:16:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0yZ-00000000i60-0dev
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 13:07:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 94C48629EC;
	Thu,  8 May 2025 13:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85C6C4CEE7;
	Thu,  8 May 2025 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746709666;
	bh=fPe9F/L7tb3q8R2DGAqsHhyeDt6WMax68uKXBKe7p1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bw7OJ17kHOpzpcGwAhY61BX9P72ipBp3x9WcdavtXOvlMUNJrVleWDlIL6ziO3MJ3
	 gI5jLEEOFSsK32qubXGYUq2ZopoBmSoBO7HaPFOuNXEnK5I1Z48CZ4TvVXD5NwvWc8
	 W/ZFqZWcc3TZXrDCQUoxyIr06SpH4SbrZNnrhgcT6jxoTruUU1UU2TbukckEmTwv9q
	 rQDwGIU0pmxN79xtaRr+BqAoIFgiz7La9+//vDOp5mz6FLmFw7bDY9SR243yBbx+SC
	 V3Kwli7VdWfu5dBLrO9pz11rW6EzfA7FwFQfrjBJiiCCSnmPykUgzTTthbm22vCLg0
	 ISBzZISo2LnBQ==
Date: Thu, 8 May 2025 15:07:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 3/4] nvmet: pci-epf: Cleanup nvmet_pci_epf_raise_irq()
Message-ID: <aBysnmAu_ik89fse@ryzen>
References: <20250508065745.389199-1-dlemoal@kernel.org>
 <20250508065745.389199-4-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508065745.389199-4-dlemoal@kernel.org>
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

On Thu, May 08, 2025 at 03:57:44PM +0900, Damien Le Moal wrote:
> There is no point in taking the controller irq_lock and calling
> nvmet_pci_epf_should_raise_irq() for a completion queue which does not
> have IRQ enabled (NVMET_PCI_EPF_Q_IRQ_ENABLED flag is not set).
> Move the test for the NVMET_PCI_EPF_Q_IRQ_ENABLED flag out of
> nvmet_pci_epf_should_raise_irq() to the top of nvmet_pci_epf_raise_irq()
> to return early when no IRQ should be raised.
> 
> Also, use dev_err_ratelimited() to avoid a message storm under load when
> raising IRQs is failing.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/nvme/target/pci-epf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 859953041da8..34dd73d6457c 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -596,9 +596,6 @@ static bool nvmet_pci_epf_should_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
>  	struct nvmet_pci_epf_irq_vector *iv = cq->iv;
>  	bool ret;
>  
> -	if (!test_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
> -		return false;
> -
>  	/* IRQ coalescing for the admin queue is not allowed. */
>  	if (!cq->qid)
>  		return true;
> @@ -625,7 +622,8 @@ static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
>  	struct pci_epf *epf = nvme_epf->epf;
>  	int ret = 0;
>  
> -	if (!test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
> +	if (!test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags) ||
> +	    !test_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
>  		return;
>  
>  	mutex_lock(&ctrl->irq_lock);
> @@ -658,7 +656,9 @@ static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
>  	}
>  
>  	if (ret)
> -		dev_err(ctrl->dev, "Failed to raise IRQ (err=%d)\n", ret);
> +		dev_err_ratelimited(ctrl->dev,
> +				    "CQ[%u]: Failed to raise IRQ (err=%d)\n",
> +				    cq->qid, ret);
>  
>  unlock:
>  	mutex_unlock(&ctrl->irq_lock);
> -- 
> 2.49.0
> 
> 

Nit: since we no longer perform the NVMET_PCI_EPF_Q_IRQ_ENABLED check in
nvmet_pci_epf_should_raise_irq(), should we rename the function to something
else? nvmet_pci_epf_irq_allowed() ? Any ideas ?

Reviewed-by: Niklas Cassel <cassel@kernel.org>

