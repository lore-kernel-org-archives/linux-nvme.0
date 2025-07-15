Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96790C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 23:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s9pXnUovRO5oAyyo4Yw5zJk4BP4THUK0LrspAsD3i5o=; b=1CjEeml7HDv3efV3bt44HipvUv
	dakmJuF3+Ft+Ok7dLJsbqSv59Ar5FsrMVSYDU+I8cZRmgo1thHMf/TWxV4JzorPvmSxY57nNZlGnL
	0OrWnLUo4U6PZIxxMj8DzRt19OG+AK1rqhdvq882g5bVcAemhSrZ1O9jX2JJ+09gDnZxj5kmfBUbJ
	/CGJPQPnYWblJjYAgcAsemOkCFoOlGrHNnWVgkILevltt2foVnu/+5qM9zghzHie61cTkNdsIlJGC
	p7CJLpZRhIk7KXIri7P43p7LekioWde+YmcZqj74lO/L1G66ItoWY3r0A/v0G+BTS/B94O5Esf5dP
	a+JKb6vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubowQ-00000006OFm-48Tl;
	Tue, 15 Jul 2025 23:20:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubor0-00000006No8-2dCg
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 23:14:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1C92FA572D0;
	Tue, 15 Jul 2025 23:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D17C4CEE3;
	Tue, 15 Jul 2025 23:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752621268;
	bh=rfBtyqXY8rhywUkEMeVOyTnMFXFkjdOjRkkh6U0nA9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YQ0U49AdhwuiL+X7IAQjAQibQKS2AGzVMrJwmq4TSZ4Zi0aKDgYzD4vHRhLmgPjNZ
	 8dMz7DD+C+cJPkzA+m/ZO782kZ9s2IE9mCobDNndNC7tlyNgqzYHjJFFVNXcv/sviD
	 gHuT4s1i1eCE/RK6eJBldvQ3VsJ86TxCuawBUDVfzyx5WQlKHY9nzbJeM2WJ+vNENN
	 DOicIUMX/OjIGzDrKkoxSWDW3IhF1Hjd42eR+K9qMwpA00NoDzfhGYbkpvWnBhfHSk
	 rUdXmErFAkTGKo46kY8GYXQFZrjNBKL92Ktn+5INf2M2DzaWEQBvzUTjKPja2DBYO9
	 UXES9geIEUmag==
Message-ID: <9a825e2c-7183-4c1e-afae-a8c55e27a70e@kernel.org>
Date: Wed, 16 Jul 2025 08:14:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_161430_809777_74211E5F 
X-CRM114-Status: GOOD (  25.48  )
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

On 7/15/25 18:18, Rick Wertenbroek wrote:
> Have nvmet_req_init() and req->execute() complete failed commands.
> 
> Description of the problem:
> nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
> e.g., unsupported opcode, which calls the "queue_response" callback,
> this results in nvmet_pci_epf_queue_response() being called, which will
> call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
> different than DMA_TO_DEVICE. This results in a double completion as
> nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
> when nvmet_req_init() fails.
> 
> Steps to reproduce:
> On the host send a command with an unsupported opcode with nvme-cli,
> For example the admin command "security receive"
> $ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096
> 
> This triggers a double completion as nvmet_req_init() fails and
> nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
> in the default state of "DMA_NONE" as set by default in
> nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
> Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
> called in nvmet_pci_epf_exec_iod_work() leading to a doubple completion.
> 
> This patch lets nvmet_req_init() and req->execute() complete all failed
> commands, and removes the double completion case in
> nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
> double completions occurred.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/nvme/target/pci-epf.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index a4295a5b8d28..aad828eb72d6 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1243,7 +1243,7 @@ static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
>  	iod->status = le16_to_cpu(req->cqe->status) >> 1;
>  
>  	/* If we have no data to transfer, directly complete the command. */

Maybe change this comment to:

	/*
	 * If the command failed or we have no data to transfer, complete
	 * the command immediately.
	 */

Other than this, this looks good, so feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> -	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
> +	if (iod->status || !iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
>  		nvmet_pci_epf_complete_iod(iod);
>  		return;
>  	}
> @@ -1604,8 +1604,13 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
>  		goto complete;
>  	}
>  
> +	/*
> +	 * If nvmet_req_init() fails (e.g., unsupported opcode) it will call
> +	 * __nvmet_req_complete() internally which will call
> +	 * nvmet_pci_epf_queue_response() and will complete the command directly.
> +	 */
>  	if (!nvmet_req_init(req, &iod->sq->nvme_sq, &nvmet_pci_epf_fabrics_ops))
> -		goto complete;
> +		return;
>  
>  	iod->data_len = nvmet_req_transfer_len(req);
>  	if (iod->data_len) {
> @@ -1643,10 +1648,11 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
>  
>  	wait_for_completion(&iod->done);
>  
> -	if (iod->status == NVME_SC_SUCCESS) {
> -		WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
> -		nvmet_pci_epf_transfer_iod_data(iod);
> -	}
> +	if (iod->status != NVME_SC_SUCCESS)
> +		return;
> +
> +	WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
> +	nvmet_pci_epf_transfer_iod_data(iod);
>  
>  complete:
>  	nvmet_pci_epf_complete_iod(iod);


-- 
Damien Le Moal
Western Digital Research

