Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB714C9EC8D
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dN85ePjbmA8cBVwNBJs/0K+M664zzuZ8n5sp75jGcq8=; b=gMzJFMIpJ55waaoZx4cES2g++P
	Kd3iQd6EPKW16D/nc0KXWF23Z9Dc4TFml9plRk25w0ZnPvxOPgM7kiSsEdaIZs0jcApO1/HjRlESk
	U2R91Ctt6PtbtZ/UB/efmuXwoxwBapiHsAXvuO8727ksQk25RtbesViVQMasVibQGHTWk17dDHx+R
	ye9r3ye7Zx0EAk776NdVzOBfjyrQT58oeQ1icgsHAR05j4wp8oqQP+G3QytBpFve0woOunx2lE0c3
	Da7soOtDUd/TXdmRuZp/8eL69uuVB2PIS+DRX1TvKRfwkL+OZrN3Di/RPjp3jeFKzkJQtgdoG06fJ
	daRFDgtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIb8-00000005UXX-27eN;
	Mon, 12 Jan 2026 14:08:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIb6-00000005UX1-29Eg
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 14:08:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EC8C36000A;
	Mon, 12 Jan 2026 14:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AD2C16AAE;
	Mon, 12 Jan 2026 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768226922;
	bh=p/kjIc8I2+thlOWEzjWlS6wT9qgXJ4+hBaLNZAIGnkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D7NIPlFdPgQQBj5p1cViX2P+6mpdYN29mGZZBfHelGeyaGbph1nSlmx4QspeiyZv4
	 1rrO1XNfd4UM4pQuE6c4dOrgM+N/FPtas45xk2wuOV96FIXFJrfmjjGoHV/W+1Cc7/
	 Fq1vOlEZjWH11itW6ZTcN9y+qWIbGwe54EYWOGia6IpxNufW4/g8k1nxIuSMehQWUD
	 ec6JbaYv3w9ad1N/HTf/BI244pQkfLf1CcJryVWwaPuagfziAyrBvE1SiRnO0klHoQ
	 SwrHwfMqXMrDL+aKosF8i9w8N89JkqI+RcJ20CUr26rlkBgkc4jGnh/b9tf4IqEffX
	 MGdMpNoplzccg==
Message-ID: <5b07dbce-2644-4079-a768-9167cbe3e25a@kernel.org>
Date: Mon, 12 Jan 2026 15:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: blk_rq_dma_map_iter_next is no longer using
 iova state
To: Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: nitheshshetty@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260112135736.1982406-1-nj.shetty@samsung.com>
 <CGME20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d@epcas5p4.samsung.com>
 <20260112135736.1982406-2-nj.shetty@samsung.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260112135736.1982406-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 1/12/26 14:57, Nitesh Shetty wrote:
> DMA IOVA state is not used inside blk_rq_dma_map_iter_next
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  drivers/nvme/host/pci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3b528369f5454..065555576d2f9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -823,7 +823,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  
>  	if (iter->len)
>  		return true;
> -	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
> +	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))

Hu... Why is this not squashed with the previous patch ? If only patch 1 is
applied, this will not compile, right ?

>  		return false;
>  	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
>  		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
> @@ -1010,8 +1010,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
>  		}
>  		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
>  		iod->total_len += iter->len;
> -	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, &iod->dma_state,
> -				iter));
> +	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
>  
>  	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
>  	if (unlikely(iter->status))


-- 
Damien Le Moal
Western Digital Research

