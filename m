Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8191FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Dec 2021 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tX4BW8tO3yiuoufmISoaWGALW7upQj1MEMhts7JInbA=; b=kpxQC9CEvWwcM42SGlwvP8dgPi
	Azd9hTENJgSaLgr3zxKGX0sqH6UG+KVT8BC5FCUsYMk9qLbtlZcfrnuwkpQ/XkYiHLSn9Rj0qzhw8
	FyiHFqWTVIIFqYDcWJBRjFf996zNDK9mRwIL7UFaLxxsvDBVjLn25VDvRJqapq3qLfSyVCIYXSmkp
	H3d8fgKDpOnpXHBgIwYcCVr6Jb7hw6wWkoV0CIZ9/xCTTNGzHf2gYdXc4ad8ui3hmb0JVUMaDj6ff
	KkCNLOMPtebfJRjv7mrDK0PwDflu6YGLidER4plUVdec3q9tNPH7Q5OruViqHkZDKhQXBtnhN4vPv
	O1t3r2Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1msqJA-00DDCi-48; Thu, 02 Dec 2021 17:55:48 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msqJ7-00DDC1-P1
 for linux-nvme@lists.infradead.org; Thu, 02 Dec 2021 17:55:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E8024B82432;
 Thu,  2 Dec 2021 17:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BE5C00446;
 Thu,  2 Dec 2021 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638467742;
 bh=sdj0UvhBCfKVf0u/SdHPJuC64O6tsVkXn7OzWimaLzE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pVDPKhQjoQ+3xSuzopBIn53m45pKfNejP9gSc4SfM6eooYnBZ8jEKfiLY0BYwqEKw
 vcjqkoIJWFO7H6QFHGLsxqS/q1+aUI4EF//d3PShtRJLVZPqQVTeXkfBOOq4122zpR
 bO+6CyH/61JCPKNbweOuJY/97DFrps1po8tQ4sYG9WZFGjDXf8z0Iotj8o8RYeNJEE
 0EHP0ZCtdFhOpKaezXUOnQoTD2vbAaVYbBKLhDZQALB3s570uT0p8ryFrCYzjikvt8
 POx6Cm/0oqftjQ+evjx7NWUjY0S7OT7SqrydAix/2wegAkvCi4FiG/hf12StDCVGM8
 cwL57tSfmVmyw==
Date: Thu, 2 Dec 2021 09:55:39 -0800
From: Keith Busch <kbusch@kernel.org>
To: caojun <caojun@uniontech.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add Intel 760p/Pro 7600p nvme disk
Message-ID: <20211202175539.GC3836713@dhcp-10-100-145-180.wdc.com>
References: <20211202030230.17507-1-caojun@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202030230.17507-1-caojun@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211202_095546_136898_40C6BDDF 
X-CRM114-Status: GOOD (  19.90  )
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

On Thu, Dec 02, 2021 at 11:02:30AM +0800, caojun wrote:
> Signed-off-by: caojun <caojun@uniontech.com>

What is the purpose of this patch? All of this code already exists from
3 years ago.

> ---
>  drivers/nvme/host/core.c | 16 +++++++++-------
>  drivers/nvme/host/nvme.h |  5 +++++
>  drivers/nvme/host/pci.c  |  2 ++
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e64310f22..8e0dbfb6a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2155,14 +2155,16 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
>  	size_t nqnlen;
>  	int off;
>  
> -	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
> -	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
> -		strncpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
> -		return;
> -	}
> +	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
> +		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
> +		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
> +			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
> +			return;
> +		}
>  
> -	if (ctrl->vs >= NVME_VS(1, 2, 1))
> -		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
> +		if (ctrl->vs >= NVME_VS(1, 2, 1))
> +			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
> +	}
>  
>  	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
>  	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 276975506..5f5a91518 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -90,6 +90,11 @@ enum nvme_quirks {
>  	 * Set MEDIUM priority on SQ creation
>  	 */
>  	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
> +
> +	/*
> +	 * Ignore device provided subnqn.
> +	 */
> +	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d7cf3202c..fcac05528 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2713,6 +2713,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_MEDIUM_PRIO_SQ },
> +	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
> +		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
>  		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
>  	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> -- 
> 2.20.1
> 
> 
> 
> 

