Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944F7C47258
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 00:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asRrt4K/U1GCRlX6PV7rQpW4mzdpGhQdpcB6mlrvSFc=; b=Mvotau4T2grhTQewH2WqmBJjdp
	duozhMwigVeO0q9NLl2NSPS3Em41rHFG2b1waIOzEd84HZu0mI5VqmXCWbFi7phfMRk9kCYH4bmxe
	Vk5YUsJRmAjICI0+6HtSNnSR6SSEqF/rF21gaJ6CoZBGsRI9hHrI0TgEQTaVoHqEhpfNaTIQPojxG
	KqXm20JoL3KJrkaU6Wm05ybmWwgSwceap6Ev5k3/HelC+AifeAyL7p90RWPIGtmnIA7H5Nz+04ce1
	ht3bITtHp73zMWe+sDFFRoRznEv3Uzsw/AfgLuACrwXxXWiX/MNSyo0lhYX+TrKt6K+lrwJQRMRf3
	UZWGYk5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVL45-000000066HE-24pn;
	Thu, 01 Feb 2024 00:36:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVL42-000000066Gn-3APo
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 00:36:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DC30661A7C;
	Thu,  1 Feb 2024 00:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93251C433F1;
	Thu,  1 Feb 2024 00:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747781;
	bh=0JtscoZzimQzp2qkEcWvxbxxzEjKJfAvKpp5ErN+JRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hdj1O3eTlMJ5bNCLIljTMwhz4Ww4bqYUMvrHtpjmot/k5qbNGF93N1onIpUznJnrO
	 IDiPQsEdl5HfbfFEXnJLRN5YhAYMvgEExsGwNC2xH26C3zwYrnE51VGmkLnZbLkhO6
	 agMEGfcAZjUvB+EdBye9rmc3W9mTqLPwifIi1FYb5h/Ea/WqpHmSZ1o0FwrZuHMC9w
	 SXmURZUVXViiBF49/ionbkWJ81ktopVaeqppc3Qh6F/kkGxu9ua8C+nmutT+Gmy7uy
	 zANJK1OLoEkjbjwuXhnVOMdJATbKPqLFserhHWxntsKFLkWFI5uHhPicWpgTMkCtCg
	 YBy4P1/MEwX9g==
Date: Wed, 31 Jan 2024 17:36:18 -0700
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
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Message-ID: <ZbrngpaAisIJGQ0T@kbusch-mbp.dhcp.thefacebook.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131130400.625836-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_163622_859853_DF2D0F87 
X-CRM114-Status: GOOD (  13.03  )
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

On Wed, Jan 31, 2024 at 02:03:51PM +0100, Christoph Hellwig wrote:
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

s/min_not_zero/min

Otherwise the whole series looks pretty good! And with that:

Reviewed-by: Keith Busch <kbusch@kernel.org>

