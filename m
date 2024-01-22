Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E533C47DD3
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8g5YMSTL3rG3vD0yD6H3h1RiZSgKuW4uwVbM3LiLS0E=; b=vxB9N9YDwbmySs0yob9T5t3tlS
	0pngmcBq8+BNbAUO1sxDaY8iRH+Xh0kRIQlczifKeyJTtSAMfHDk3U0McQ3DnIOjzre64vCoOe3UN
	gLL5XUt6C8eu+LYlk+bDKS28Pblh7i5yflsU2nwyWYHr0hk8ETKOEyheffY2BgIGv6sydxASd4cc8
	ExX9OXwtppS+mCHFmMKeh+eIH9RZUeRCEx/Mn0WMS91s2BZ2WnhGpfFi/qPpHFxURMNWPhI8b3tev
	3IYEw7LUMM/HTFUZhD3ZUrPUMiDHRwDV9xeFrXkVeOJhLpIMw5unppXVj/fVpDU/4BjT7xPSf4ZNh
	I8yFPDjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRz13-00DWaL-0M;
	Mon, 22 Jan 2024 18:27:25 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRz10-00DWZR-0y
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 18:27:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 85607B81041;
	Mon, 22 Jan 2024 18:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52EDC433C7;
	Mon, 22 Jan 2024 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705948038;
	bh=PlJsX8lq4hlaXsdUus+uVis54Jh85qBVrYR1P5XnPmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWMOAhkwVSBJ3AEfqFEvKX11Hz05OIRqB4ABWsbho088Ga2Cx0RG7E35ba45no3Zi
	 zaVv5Mbe+zgWL0AuaZXj2BRHaCkBpS2ud8TZ6mGSu1KL+z2Z2fl97EIAZ03N6Fgjet
	 pEqGlVkThabnQoyFEJihfuPQMlFG0MD3qLx9Bck72plbi8mYijTgka0czNY7guWoii
	 Hro4Arm3HOAxnyL8Bkg+TTKXm7xK8G9Zm6zyrD/tWkTbQP+ZsD57U9EIWRhjfxq5qj
	 Xe66J+3zLwsB/OARPDDie1prAtn5Dt8SW4VDYZEc+n5vIAqh5PgUyuSKABGIXHv4jd
	 mL3mbpNpnldng==
Date: Mon, 22 Jan 2024 11:27:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
Message-ID: <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122173645.1686078-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_102722_536402_2FD9D5BC 
X-CRM114-Status: GOOD (  13.12  )
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

On Mon, Jan 22, 2024 at 06:36:35PM +0100, Christoph Hellwig wrote:
> @@ -174,23 +174,23 @@ static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
>  static ssize_t queue_discard_max_store(struct request_queue *q,
>  				       const char *page, size_t count)
>  {
> -	unsigned long max_discard;
> -	ssize_t ret = queue_var_store(&max_discard, page, count);
> +	unsigned long max_discard_bytes;
> +	ssize_t ret;
>  
> +	ret = queue_var_store(&max_discard_bytes, page, count);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (max_discard & (q->limits.discard_granularity - 1))
> +	if (max_discard_bytes & (q->limits.discard_granularity - 1))
>  		return -EINVAL;
>  
> -	max_discard >>= 9;
> -	if (max_discard > UINT_MAX)
> +	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
>  		return -EINVAL;
>  
> -	if (max_discard > q->limits.max_hw_discard_sectors)
> -		max_discard = q->limits.max_hw_discard_sectors;
> -
> -	q->limits.max_discard_sectors = max_discard;
> +	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> +	q->limits.max_discard_sectors =
> +		min_not_zero(q->limits.max_hw_discard_sectors,
> +			     q->limits.max_user_discard_sectors);

Shouldn't writing 0 disable discards?

