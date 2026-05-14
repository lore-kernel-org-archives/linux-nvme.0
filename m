Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9242CD4F39
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLBa0eCGlK23Uh8Va98YC010ZS+trfxb66awnxnwHIc=; b=pISecWW6gTgz/xxodnV1mvEq7l
	Kw4wB/IQeBYbLk5MKk9vnZP9u58aaxBSuQyeL7GXJUzvhx5Ymu/WlkRojaslxVQTD14ib3KSP3tuX
	NwC7qwk1EwqFV9byaV9XFB4f7Fxy9tkooazG2hwIP0TmTxU5w+bpKT04W1fDNM/8svUHVPhj2+pzG
	go+nj1/xuaZElObPOaJrT0eKyh9WnqrtQ0MgcWiM23d+m4L7CiQoGPz+XsdRW1hc4CrJAr0Xh9o5h
	SndgXxHHXj9aTnWdDoD+ga5sLoh7HKw8pn+KfpU6299Evp+UOvLxY3aKIijfAKFpyqhGtnXOEd/7U
	2mqAcrcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNVhb-00000005XZD-10gn;
	Thu, 14 May 2026 13:02:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNVhZ-00000005XYt-1lE7;
	Thu, 14 May 2026 13:02:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AE9ED60132;
	Thu, 14 May 2026 13:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F8CC2BCB3;
	Thu, 14 May 2026 13:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778763728;
	bh=6XkcIGEtELfy3FNPsRMpEtSIdSkCha1v4oFloaN5a2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SH6sGKX8F7y134uKrqajCxGs00yhXlupBiuPqzVIUY36b/thUbq9Z21AkAvVUCz/1
	 DYaZoMbeTIMQngQ/t6kQnkyY90yRlBGAWBF08CXB/kw0DXsGLRkOvUp0Vj6+Fz4oX6
	 4QQOFrS4Qb2Is1u7tQKJIBMa3deSDa3h4XZbMrFw=
Date: Thu, 14 May 2026 15:02:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
Subject: Re: [PATCH] nvme-apple: Reset q->sq_tail during queue init
Message-ID: <2026051400-concert-cartridge-e96b@gregkh>
References: <20260514-nvme-apple-sq-reset-v1-1-8931e455281e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-nvme-apple-sq-reset-v1-1-8931e455281e@gmail.com>
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

On Thu, May 14, 2026 at 08:54:59PM +0800, Nick Chan wrote:
> Fixes controller reset on Apple A11 / T8015.
> 
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Suggested-by: Yuriy Havrylyuk <yhavry@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/nvme/host/apple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 423c9c628e7b..c692fc73babf 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1009,6 +1009,7 @@ static void apple_nvme_init_queue(struct apple_nvme_queue *q)
>  	unsigned int depth = apple_nvme_queue_depth(q);
>  	struct apple_nvme *anv = queue_to_apple_nvme(q);
>  
> +	q->sq_tail = 0;
>  	q->cq_head = 0;
>  	q->cq_phase = 1;
>  	if (anv->hw->has_lsq_nvmmu)
> 
> ---
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> change-id: 20260514-nvme-apple-sq-reset-53e22e88c7b0
> 
> Best regards,
> -- 
> Nick Chan <towinchenmi@gmail.com>
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

