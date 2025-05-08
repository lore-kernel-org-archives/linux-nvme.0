Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA6EC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+FIg8YtjlMTnEOveJEwOZ6S7RUswTWqbNWSaXoN6QHk=; b=FPBC9A1SLk7Ck9d98TmooH7jbw
	aQsQlOBq54NLqgg1rTSj0THD84sxgJ9GuwEQ7vRJJsmqsftNVcFV1DBtEiKGp/c71yTOOq3+zVrrN
	iIK3zLcMWd/a6yyLbDYcB6CFr7qD9zdt3OwiNuNTKVwPTXq1UM5mp5ofBdSnF01cQlZAfBErsnjqZ
	QnsBueQEnC/9oTRh8gImxyVYE1+hd9Vs/SCBozsh6Jz6CSwIbAc2pNDZHwmxM38Gm9ArEpae/0XjX
	qxWNIBwsj6ysWo0N0IASkJ4Y2JmE+BVEyLmFVmQfHr/r1XVFPnjmuc13Nl7WWV9Fx8FgRwiqcsrkw
	oRd4JYtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0yR-00000000i46-1wsO;
	Thu, 08 May 2025 13:07:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0yQ-00000000i3k-1JVc
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 13:07:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BCC23629EC;
	Thu,  8 May 2025 13:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C38DC4CEE7;
	Thu,  8 May 2025 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746709657;
	bh=RaL9h7Ugwj4zZA4KoxOjAeX4eV6bqlOKTEteM+rVwz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sg6bp5yS2bPw4XVF1yosg93a52q1FjEMnGtnpBSX7IioFh5n0IDGp4BgxywdELBZq
	 yH23IKAlW57JJtxAdG5vXlJZthrET3tpQdaRMoosffxmT8AayRvRQpPmk2aAM3nf4B
	 KL+qv3DjD3b3rsOQwhpFzKyede6KJwr6PYY0ncc9sfZQqIsiy7wIbXcsTGOfBGWxWd
	 9rl1Ns2aEJuapdu+znUw0JF81g3HLLWn0nMxkUV6pRufnj3ImThuAaY7Gs7MJGw4qt
	 Tm64yJ9IUTpsbJPEdz0UAUJD8KTLYn0Tv/duBrdDVj/Pprjr60uvyIzuXxJ8U7d8GU
	 ONDDGEnduEwwA==
Date: Thu, 8 May 2025 15:07:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 4/4] nvmet: pci-epf: Improve debug message
Message-ID: <aByslRmpE_-iHr9x@ryzen>
References: <20250508065745.389199-1-dlemoal@kernel.org>
 <20250508065745.389199-5-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508065745.389199-5-dlemoal@kernel.org>
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

On Thu, May 08, 2025 at 03:57:45PM +0900, Damien Le Moal wrote:
> Improve the debug message of nvmet_pci_epf_create_cq() to indicate if a
> completion queue IRQ is disabled.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/nvme/target/pci-epf.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 34dd73d6457c..bd79e059e066 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1321,8 +1321,14 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
>  
>  	set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
>  
> -	dev_dbg(ctrl->dev, "CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
> -		cqid, qsize, cq->qes, cq->vector);
> +	if (test_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
> +		dev_dbg(ctrl->dev,
> +			"CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
> +			cqid, qsize, cq->qes, cq->vector);
> +	else
> +		dev_dbg(ctrl->dev,
> +			"CQ[%u]: %u entries of %zu B, IRQ disabled\n",
> +			cqid, qsize, cq->qes);
>  
>  	return NVME_SC_SUCCESS;
>  
> -- 
> 2.49.0
> 
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

