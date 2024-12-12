Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB22E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 06:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jU/Ky83a9AuGCmTke3KpDI5DyOZtl++YAKhPeSf4WBM=; b=wQE4vlNHtWpqcHbeYf35Q+80s+
	g8NbKKRo6OgETnxYXDcrRCp+KytmvaxSzm8BRF8yQwzYFgTPGxU63NWeV0l+KOWQ62py1w2O1WztQ
	msvv87R54HiTdoWElxANspzUjcOhEmbFIujZbaKFg+xZYwUefNIkERrRwrVimE2tnqSJ3ev8hBb8h
	98PhLzK5KYUDAlw3E801cLutdxKJ6OtNJTi2HKdWTR4wqD2afH0wgn5DjwhKzroUmCew2CEXe3KM+
	7VlCsyNmFl3Jm6kFEhhRNGyPAT723/g6IKCDnp0qdlaC75H9oVoM++qpPWveiNQXO4qKg2OrVl6BF
	/Z90FRHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcgz-0000000H37E-1WXX;
	Thu, 12 Dec 2024 06:28:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcgx-0000000H36W-1p3J
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 06:28:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E389168D07; Thu, 12 Dec 2024 07:28:52 +0100 (CET)
Date: Thu, 12 Dec 2024 07:28:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Add error path for xa_store in nvme_init_effects
Message-ID: <20241212062852.GB5718@lst.de>
References: <20241202153921.55766-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202153921.55766-1-keisuke.nishimura@inria.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_222855_609440_3BE71963 
X-CRM114-Status: GOOD (  14.59  )
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

On Mon, Dec 02, 2024 at 04:39:22PM +0100, Keisuke Nishimura wrote:
>  	if (!ctrl->effects) {
> +		struct nvme_effects_log *effects, *old;
> +
> +		effects = kzalloc(sizeof(*effects), GFP_KERNEL);
> +		if (effects)
>  			return -ENOMEM;
> +
> +		old = xa_store(&ctrl->cels, NVME_CSI_NVM, effects, GFP_KERNEL);
> +		if (xa_is_err(old)) {
> +			kfree(effects);
> +			return xa_err(old);
> +		}
> +		ctrl->effects = effects;

Please split this into a helper now that is becoming rather complex.

Otherwise this looks fine to me.

