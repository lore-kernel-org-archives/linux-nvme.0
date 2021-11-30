Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6DDC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yem1BuocKOhMVeqzyfrh2xHWUe/qu8v7SAxDnEJ+uaI=; b=47Z2HjecKuBu55fmE1lTkEnQ8t
	iwCikbkgFvJ6PYkSFwsCfofS/3seBAh6fjd1uW8kcnLXA11XSrOueKFijlnjj3I9phYm4GRzN9Tve
	hjv+7GQiKC6+zbgDU0YQ8pqphv2zNV60T6UJZk+VgWh3er3a60CpOrdaVwIgKPnKMQ253Z1T/bfbZ
	ghU1jHUFKh3xipCWA05GCB77e9hvouBPlGuTLURyYIDsYdt7dUEqrG/qqZBm2Ea78gx4VlhyekX31
	NVRC9GPrIIxzfFXChaDdMLqxzi7QOfv5CcJoe3uAFvE908kdLsvVef4roA+Vai4paNARvEe+UCcGv
	me0Wjo+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms5MS-005zej-2E; Tue, 30 Nov 2021 15:48:04 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms5MO-005zdo-OV
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 15:48:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E41D3CE1A47;
 Tue, 30 Nov 2021 15:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCE6C53FC7;
 Tue, 30 Nov 2021 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638287277;
 bh=ht1w0Zxz/2n1bifQGvJqnd2/yqA1jDA28G0XH75K4fs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cxyq76XGheE0psrKTWB/ikTksRmK2Ysik36of6t7Wtq8yMabfKT4tj3cKULpXU6cg
 FCiUrCm+Od2E1G71M+X8wnb+Kc3INGhzCQX9rpO7oXH/IJGcv8goXBWLTxEz8/kqm+
 mxmExAQ4kXuIlUEVZ5hPafxzTqn05fMffocZULgnBuTx6h8cd21A9k6Fhowtf/HTEQ
 Sc2vcc1FtrfrtSCZ6LjMvORgA6NFUJfBvxGzckTdkz5ifN2rqOPlT7CWCUsnVjVqX2
 4e1ZaNLEanWh7P2fhT6gUYFrujGwvf5IrbysNqgbxiJWso68tAaPerZ69T7aEqIu/p
 xzHUj+p0yBEMQ==
Date: Tue, 30 Nov 2021 07:47:54 -0800
From: Keith Busch <kbusch@kernel.org>
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: nvme: fix missing error code
Message-ID: <20211130154754.GA3627665@dhcp-10-100-145-180.wdc.com>
References: <20211130135015.1818325-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130135015.1818325-1-mudongliangabcd@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_074800_993583_F1D1D477 
X-CRM114-Status: GOOD (  20.30  )
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

On Tue, Nov 30, 2021 at 09:50:14PM +0800, Dongliang Mu wrote:
> Smatch reports:
> 
> drivers/nvme/host/multipath.c:865
> nvme_mpath_init_identify() warn: missing error code 'error'
> 
> In one error handling path of nvme_mpath_init_identify(Line 865), error
> is not initialized as an errno.
> 
> Fix this by assigning error to -EINVAL.

Nak, the code is correct as-is. Returning a negetive error will abort
the initialization process. We don't need ANA support in order to manage
this controller, so failing a controller for an optional condition
isn't helpful.

The other parts of this function returning negetive errors should be
fixed to return 0, though.
 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/nvme/host/multipath.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7f2071f2460c..2cbeb6d6b064 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -862,6 +862,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  			"ANA log page size (%zd) larger than MDTS (%zd).\n",
>  			ana_log_size, max_transfer_size);
>  		dev_err(ctrl->device, "disabling ANA support.\n");
> +		error = -EINVAL;
>  		goto out_uninit;
>  	}
>  	if (ana_log_size > ctrl->ana_log_size) {
> -- 
> 2.25.1
> 

