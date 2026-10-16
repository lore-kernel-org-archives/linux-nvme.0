Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A258CCA462
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 12:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3WG0HkUN3jcdi4rkmt2NaJ+vQmzZ6jloPYj8KROWO48=; b=fIteMicYbVHqSVsav+t/OvsySx
	hobs3PrEHW5A2JSHFqZKEXsKgYAz1gu/6lzeDymsJq5tpJoRb/tP946nJlgeUGikM8GUySPvJiOw6
	kB1vpV1V3EOrM03vrCqqsk5CFQvdTvDIjretlkiC/Me5ihgjUG+0IV/WyLKgCJE6dcIctB/XjULQG
	WqJA/EaDkeCO8+wlbOEaniuy5Y8aTnr2Cp2d+Mi7YqKmbaF/WmLVvj/g+vJeeLR46+ejbIUF7BiX5
	B5un0NYzR06pbvngaM+CoztdHI7dNEbjoIquO2O84qSAnagha8KCsIpmh0OHU1TmxMO6bFZ/Ik13P
	FfAFFkOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHh3I-00000002sGC-27mZ;
	Fri, 16 Oct 2026 12:28:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHh3E-00000002sEI-2Di7
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 12:28:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F16B68D0D; Fri, 16 Oct 2026 14:28:36 +0200 (CEST)
Date: Fri, 16 Oct 2026 14:28:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj1072538@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	asml.silence@gmail.com, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
Message-ID: <20261016122836.GB3555@lst.de>
References: <20261016103453.1129150-1-anuj1072538@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016103453.1129150-1-anuj1072538@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_052844_714156_328858C1 
X-CRM114-Status: GOOD (  19.32  )
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

On Fri, Oct 16, 2026 at 04:04:20PM +0530, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Allow registering a dma-buf against an NVMe namespace character device
> and using it as the data buffer of fixed uring_cmd passthrough I/O.
> 
> io_uring_cmd_import_fixed() now accepts dma-buf buffers and attaches
> the current map. blk_rq_map_user_iov() maps dma-buf iterators directly,
> since they cannot fall back to a bounce copy.

This really needs to be split into blk, io_uring and nvme parts, with
a good commit log for each part.

> +/* Prepare a bio for passthrough I/O from a directly mapped iterator. */
>  static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)

And adding a comment to an otherwise unrelated function probably also
wants a comment..

> +	if (iov_iter_is_dmabuf_map(iter)) {
> +		if (map_data || (iov_iter_alignment(iter) & align))
> +			return -EINVAL;
> +		ret = blk_rq_map_user_bvec(rq, iter);
> +		return ret == -EREMOTEIO ? -EINVAL : ret;

The error value remapping could probably also use a comment (and be
turned into an if to stand out).

> +static int nvme_ns_chr_init_dma_buf_io_ctx(struct file *file,
> +					   struct dma_buf_io_ctx *ctx)
> +{
> +	struct nvme_ns *ns = container_of(file_inode(file)->i_cdev,
> +					  struct nvme_ns, cdev);
	struct nvme_ns *ns =

>  }
>  
> +void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd)
> +{
> +	io_detach_dmabuf_map(cmd_to_io_kiocb(ioucmd));
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_detach_dmabuf);

Add a comment on when this should be used?

>  		return -EINVAL;
>  
> -	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
> +	ret = __io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags,
> +				  IO_REGBUF_IMPORT_ALLOW_DMABUF);
> +	if (ret)
> +		return ret;
> +	return io_attach_dmabuf_map(req, iter, issue_flags);

No new here, but maybe io_import_reg_buf should take the flags argument
instead of the spurious __variant given how few users there are?


