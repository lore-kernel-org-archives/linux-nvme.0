Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F07ACAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y70PT2yFgDfz6OxYRMSTROEGUchZVkAf2GG0bPr0CUk=; b=PILM4D8RQWnh+XumLhhNRi+ThE
	BjOsYyGJfPN5dlfI80xyOCKbv/lFqei31gfA+bvhDVz9zm3g44xhW9pwDlX7Q/XPUHoLtMP4LjR6k
	rqMAr2jj8Xc8XV04McOE6BOYkiuGHxzDdA54VNQul9Pl6m6Kw7yTaL2yMn8W3rFkFzemfrw05bB91
	YCV2bvZc1BrKmOHvThJ6tFz384WunuxWQWKPXUjtINAoeBpcb4FcTqmhmVZjQ6sxwKGAPNkLFuO0I
	ouaL5gdjuEV7JxUJrAIta8CLsiZiKm/cb8akYNiXQAcpztB9WN4sRpioqn19IkFLvnnLGVAmmtilC
	yesWS01g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kQJ-0000000B92Q-3ZSZ;
	Mon, 22 Sep 2025 17:33:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kQH-0000000B8zh-11sN
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:33:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A96E2227AAF; Mon, 22 Sep 2025 19:33:53 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:33:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 2/3] nvmet: use port's tr_ops in nvmet_disable_port
Message-ID: <20250922173353.GB14393@lst.de>
References: <20250920234943.4959-1-mgurtovoy@nvidia.com> <20250920234943.4959-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920234943.4959-2-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_103357_454736_E5B48F6A 
X-CRM114-Status: GOOD (  18.80  )
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

On Sun, Sep 21, 2025 at 02:49:42AM +0300, Max Gurtovoy wrote:
> Use the port's tr_ops pointer when disabling a port, instead of looking
> up the ops by the transport type. An enabled port is guaranteed to have
> a valid reference to its fabrics ops.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/nvme/target/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 9f5159f04bbd..f31c7fa70740 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -388,10 +388,11 @@ void nvmet_disable_port(struct nvmet_port *port)
>  	if (!port->enabled)
>  		return;
>  
> +	ops = port->tr_ops;
> +

Please assign ops in the line declaring it.

Otherwise this looks fine.

