Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24A3C76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQFr/eTG5PKOz8JxO+gbkJmWPAIh7Pr6SkFdj3NoNLY=; b=wLEOtA9w9wk4webkAr6ckL8+n7
	W8mB2XKiSE/2a9G5nxt4HRvtxZ94k9LT+xyi7r0lR4SbtapOTdk4eAuKgdGFl+dPS+w0tq02oiDR9
	oRa7mdpy3OSo5HSW08gWo++uZYyykM+EjBBwZvGVC7gt6dkGWMDhZ9r2P/AfElV2fIw50kmpWhcKd
	TNOEOfo8+APEKlG0+wBwjAj298AY9LTi272VHPiEjpaA0q1++HBm3mGTtw1aEumRzDMnqG61pHUd/
	lJI2aPpOSZ2xg3VN9rBslXmAnvlx4GxJCBpIXlWAYV8LUNwPVMuBo4TLFs4IC8m1Ulslvn4iyBFhw
	wWxHmthw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkrn2-00AzUQ-0p;
	Fri, 07 Apr 2023 19:30:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkrn0-00AzTs-0W
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 19:30:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 47A826101A;
	Fri,  7 Apr 2023 19:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28326C433EF;
	Fri,  7 Apr 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680895824;
	bh=3ywzi95ZmiScAxaAds75UKy6vqGW+xnG6LmWrRIr+BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6x8fviM6g7mbuOCJ9TcclQ6RWAvhdNJDv0A1AAXoY68HnRvxycuAAiXOqVLzdy/3
	 +63WSI1xyX/KF6uvPfEssmGEt1vr9Ym2GbxqZHAePE8k8TmxJVilCEhW+i4laLRBgk
	 g1IQamVkm/eQkwKgWYG/RQs0j8Lg6hvKTSnY1qV3EKiQjBnZAsDQfuxC4x7zne68La
	 uH8sMiN8ZJX+VfnB1L8sJqhBbYGc9JpnIVDcxJJQwT8toNvAFmgFt2eccGeW/Zlgpy
	 GJnmBnOdibL2k/iARUqtCErLXWH5TdJwt5eA9Unc9eWzjzsuTr24l6Qj2wnWIRNdmO
	 al6dQyJxlfLdg==
Date: Fri, 7 Apr 2023 13:30:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lei Lei2 Yin <yinlei2@lenovo.com>
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: Re: [PATCH] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Message-ID: <ZDBvTS1j26d3392/@kbusch-mbp.dhcp.thefacebook.com>
References: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_123026_262151_8A4CBBC3 
X-CRM114-Status: GOOD (  11.89  )
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

On Thu, Apr 06, 2023 at 04:18:18PM +0000, Lei Lei2 Yin wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 53ef028596c6..c1cc384f4f3e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -450,8 +450,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>  	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>  				"Cancelling I/O %d", req->tag);
>  
> -	/* don't abort one completed request */
> -	if (blk_mq_request_completed(req))
> +	/* don't abort one completed or idle request */
> +	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
>  		return true;

I was suspicious about this path too, and had the same change long ago, but
shelved it when I couldn't produce any errors there. But the change makes sense
to me!

Reviewed-by: Keith Busch <kbusch@kernel.org>

