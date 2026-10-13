Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2635CC6B15
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6qU1ZSKT3EYm2apw6pSjGkgiVUGlwMQJMShTmJx5qUk=; b=IoXXIROOv9zsoLCCiIU+a73MpL
	yrwpKm3KRMpwurIvhVybVDH2omFeeHNWJMDDxWVyYT5f+Wmv94KxllG6+O66KkJfSWy6AwclW4kpo
	mp/gsdaHKhyBK+jGTO4D2uUE/YQF9g3uenaT3QjYPXCC8qcolT0CmiUoUbJowyAyjf7OVRv+U2a4B
	3T7rE5WANKSxMT3LkZXAxQVFRNEt4GFpOJALceQVcEWDKn+y07m+uXxXP6vrpze923QegJ/VNxF0F
	+7zD77omqglttg84pl7SkC45xpHI6E7lPZ57e7eorXRKIAZ/8YRH6+ZJf+zQVRjJwxYONFaNTbKlf
	d0NQhDQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdTj-0000000D5pz-1VSo;
	Tue, 13 Oct 2026 14:27:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdTg-0000000D5nv-249R
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:27:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8506568AFE; Tue, 13 Oct 2026 16:27:36 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:27:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] nvmet: pci-epf: report transport errors in command
 completions
Message-ID: <20261013142736.GE14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-5-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-5-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_072740_800459_4E6470EE 
X-CRM114-Status: GOOD (  24.60  )
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

I think this looks good.  Damien/Niklas, can you test this on hardware?

On Mon, Oct 12, 2026 at 04:12:31PM +0200, Andrea Parri wrote:
> When the PCI endpoint target fails a command itself, the host receives a
> successful completion. This happens for a data length above MDTS,
> malformed PRPs or SGLs, a buffer allocation failure, an SQ that is not
> live, and a failed DMA of the command data. A write whose data cannot be
> fetched from the host is thus reported as written, though nothing was
> executed.
> 
> Each of these paths sets iod->status and calls
> nvmet_pci_epf_complete_iod(), which then reloads iod->status from
> iod->cqe.status. The nvmet core only fills that field when it completes
> the request, which these paths never do, so it is still zero and
> nvmet_pci_epf_cq_work() posts a success status to the host.
> 
> Drop the reload. Every path already sets iod->status before completion:
> nvmet_pci_epf_queue_response() copies it from the request's CQE, and
> the transport error paths set it themselves.
> 
> Found by code inspection. Build-tested only (x86_64, W=1): no PCI
> endpoint hardware was available to run it.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  drivers/nvme/target/pci-epf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index c683450df4227..4c5fff232fb99 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1152,7 +1152,6 @@ static void nvmet_pci_epf_complete_iod(struct nvmet_pci_epf_iod *iod)
>  	unsigned long flags;
>  
>  	/* Print an error message for failed commands, except AENs. */
> -	iod->status = le16_to_cpu(iod->cqe.status) >> 1;
>  	if (iod->status && iod->cmd.common.opcode != nvme_admin_async_event)
>  		dev_err(iod->ctrl->dev,
>  			"CQ[%d]: Command %s (0x%x) status 0x%0x\n",
> -- 
> 2.53.0
---end quoted text---

