Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731C6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 21:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1fcxWzFEzkvkxqTR3Ns2azafoRm60XdCJvowWLfMHKs=; b=q3EFHgjZYQDvBJbBwY5k64sRnU
	1pFsWqN0g2Lo/jWBHiZf7uius+v0g7e48F7PEWSuN7gltibXFoNeD2P4mq/4QKZgoJ9Cf97+KgZDZ
	K2LuHhVBJsCLUCS6c4JVTD6+gTFFCAIePKyEsuRWbUrmGsP30RgvZp4wRTY9x31AQan71Itxe4f5i
	Ly2TsULMEXZEHLcXN43V2amJgH/Xh8+P0uLIINhvOvEB4IBvjbgZpmXmBFXLlawuipj7Q5UChZ0Mc
	u2n2++HGh8YJ39uDetobbTTzO0xZ4SZmBP3w9a7eezAavlfHeqp5m0eLJeXSoPjUAQ51t5Fkhzm6O
	qZUJp1rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw9hZ-00CkRz-Ox; Tue, 31 May 2022 21:46:57 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw9hW-00CkQu-TT
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 21:46:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 3F877CE18AD;
	Tue, 31 May 2022 21:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B8DC385A9;
	Tue, 31 May 2022 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654033609;
	bh=5+TFnO/t+SNX2FQs/tWp2G1t5E0Wg0Jw7L9xutbcSx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqS1AVZdj1v2THvdN5o49UuqSVE0ivcHNaziY4gy+vgSfrRPl34d0Z31nZBvAiCHF
	 xT80VhojMYdYilIyAeDJTdmwDE33d/QwERifcS+YXhYk8jBxyrPOveGdpeLO5NYzV2
	 MpODlZC1eKld8CNXymiIYurnzJ1zRFsLaSUo+ivRyU2Jq8w0yWiDLiub5bjRkOht/a
	 mJaj/H5oAjKpeO7IMwENFfHGjScnoEBzVC2z+xr4XNmLh+2IJvDozVuhSF4c7wNqFo
	 MVd5h67AJaydzVyfrapaZSP8qaW8esJrmf530op+1cQP4bTKlPBb1puhuoqMard6DA
	 ExhOHqlrqVXNg==
Date: Tue, 31 May 2022 21:46:48 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@fb.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 09/11] block: introduce bdev_iter_is_aligned helper
Message-ID: <YpaMyCfOKK5NKgL+@gmail.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <20220531191137.2291467-10-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-10-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_144655_155476_3A7D8A8B 
X-CRM114-Status: GOOD (  15.11  )
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

On Tue, May 31, 2022 at 12:11:35PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide a convenient function for this repeatable coding pattern.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/linux/blkdev.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 834b981ef01b..583cdeb8895d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1370,6 +1370,13 @@ static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
>  	return queue_dma_alignment(bdev_get_queue(bdev));
>  }
>  
> +static inline bool bvev_iter_is_aligned(struct block_device *bdev,
> +					struct iov_iter *iter)
> +{
> +	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
> +				   bdev_logical_block_size(bdev) - 1);
> +}

"bdev", not "bvev".

- Eric

