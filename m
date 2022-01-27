Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FD7C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQVJJuqtdnHXL0mqOpjYcJUIzdDUPnyxdDiZdZ5LLtY=; b=vOi9TcYMc7sNCwmIqEDgyQgHiV
	zqJ1QcDQGbkp05SvVwovl9UxMYlBIIimtHSP1l/zn5WK3yYS8Cs6+yvn+iVBVPoAhhgnBNO7bXtJg
	vjRc+T3IY6xBp00lcAQufkgSV23I8KQPqXX61UBxjb62x6DpDB6udmcCazPGcyEgdUOn9IjztLVQP
	8Tzb+AUVlmiIAZdB5/j/0LB9zGZ4Psz6ec/Aru+ltDTG6Mbfs4tonK6ZM5yDJOQtxdL+IF4D3PGqI
	THxvhk3kAmXMDtfGGT8zgT1MuCZqTglGMu5Dz7UowQSnfM2dVtrvsSGeNGYwXyGEeAUnxB9YYfX6Q
	vqUJB1SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD1Ij-00EwvC-Ra; Thu, 27 Jan 2022 09:42:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD14O-00Ete1-Sy
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 09:27:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BF03F68AA6; Thu, 27 Jan 2022 10:27:46 +0100 (CET)
Date: Thu, 27 Jan 2022 10:27:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 joshiiitr@gmail.com
Subject: Re: [PATCH 1/2] block: introduce and export blk_rq_map_user_vec
Message-ID: <20220127092746.GA14431@lst.de>
References: <20220127082536.7243-1-joshi.k@samsung.com>
 <CGME20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef@epcas5p4.samsung.com>
 <20220127082536.7243-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127082536.7243-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_012757_155071_8E6E1344 
X-CRM114-Status: GOOD (  18.00  )
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

On Thu, Jan 27, 2022 at 01:55:35PM +0530, Kanchan Joshi wrote:
> Similiar to blk_rq_map_user except that it operates on iovec.
> This is a prep patch.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/blk-map.c        | 19 +++++++++++++++++++
>  include/linux/blk-mq.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 4526adde0156..7fe45df3e580 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -577,6 +577,25 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
>  }
>  EXPORT_SYMBOL(blk_rq_map_user);
>  
> +int blk_rq_map_user_vec(struct request_queue *q, struct request *rq,
> +		    struct rq_map_data *map_data, void __user *uvec,
> +		    unsigned long nr_vecs, gfp_t gfp_mask)
> +{
> +	struct iovec fast_iov[UIO_FASTIOV];
> +	struct iovec *iov = fast_iov;
> +	struct iov_iter iter;
> +	int ret;
> +
> +	ret = import_iovec(rq_data_dir(rq), uvec, nr_vecs, UIO_FASTIOV, &iov, &iter);
> +	if (unlikely(ret < 0))
> +		return ret;
> +	ret = blk_rq_map_user_iov(q, rq, NULL, &iter, gfp_mask);
> +	kfree(iov);
> +
> +	return ret;

I see very little point in adding this function vs just open coding it.

Also please don't add overly long lines.

