Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC905D1CDC6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 06:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PI/dc15sIV1cnkuVfJAQA2OPBmPQGWPj/Ybe5XN0HGk=; b=LLI0QVwk8+uEQlt5ObgBKleEsI
	39h2be/HoL/VwDb2ul0FAAPZa+M68eNZ8CZjJkp5WiCia2UK4FNVDZNvQSP4fDhyJcFQbKwFCcpAV
	vXXsFnsDf/Y4JMMjANpMtNyJkVJic5Nk7YyVVCQ4JbQGJNI+jwq1dOa3midkYcJpzfruovT+R/Ys3
	OX4lvYkEjevdcpYidlyrdBjXio8/QyQ46JHI4cK6fds+MF48lBvtPORV2OrQFrAvxUdnWhKe7MGRW
	/HFWvdFu3N1SzZZGtfpF/dhCaRX8Mp+GfhFv815qvOTnpNJT2Cp1omL76LTyeJ5NrNJZ68fcy5fS0
	PA9bA1Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSreQ-0000000Dv0n-0ZEB;
	Tue, 09 Dec 2025 06:56:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSreL-0000000DuyY-2xNg;
	Tue, 09 Dec 2025 06:56:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D29A4423C;
	Tue,  9 Dec 2025 06:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B74C4CEF5;
	Tue,  9 Dec 2025 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765263400;
	bh=quZ4ePEejJ/v56bJo7+xw5JlJt6hVQjFZUg0aioFOzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mh2lEhntDrWHFMndpdS7620G82z6B+4ORoHPUempGKaW8ETRAh27mll2d2fBvUE6O
	 C1Bf6n8jjBX8XExWhMXeDs+DohLaorXzgqx4SpSDDk30mSGWPV/C0cXuuZjyMyLK5r
	 vm0FBKdAZgTTtU9Ts1avBERBqrYxXgSIiJmoyhZUUH23V+Qqt5k4s5kAHq0fQTBqkV
	 W32om+yZWERYPYBjz8m21VrQRpNE/RMLuM0oxz6ZPbE7AnGxDRLGpBOt0qdTKMdnXr
	 DANnylJZCFtTIO/oeLxSCLw/vldM7yoIa05rJbC9kY6G9rLVialvrtVRGU9ZRhzRGO
	 jGoBxJl4NRHnQ==
Message-ID: <f9107db3-491e-4224-a337-821a89f99132@kernel.org>
Date: Tue, 9 Dec 2025 15:52:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <20251208-dma_prep_config-v1-5-53490c5e1e2a@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251208-dma_prep_config-v1-5-53490c5e1e2a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_225641_769213_EF317F7A 
X-CRM114-Status: GOOD (  16.06  )
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

On 12/9/25 2:09 AM, Frank Li wrote:
> dmaengine_terminate_sync() cancels all pending requests. Calling it for
> every DMA transfer is unnecessary and counterproductive. This function is
> generally intended for cleanup paths such as module removal, device close,
> or unbind operations.
> 
> Remove the redundant calls.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> This one also fix stress test failure after remove mutex and use new API
> dmaengine_prep_slave_sg_config().
> ---
>  drivers/nvme/target/pci-epf.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2e78397a7373a7d8ba67150f301f392123db88d1..85225a4f75b5bd7abb6897d064123766af021542 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -420,8 +420,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  		ret = -EIO;
>  	}
>  
> -	dmaengine_terminate_sync(chan);

If the above dma_sync_wait failed, we better call this here as we have no idea
why we got the failure, no ?
For success case, we indeed may want to remove it.

> -
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> 


-- 
Damien Le Moal
Western Digital Research

