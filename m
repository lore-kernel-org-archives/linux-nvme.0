Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADC6C19F2A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Aug 2022 00:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v4cfjUSTOhsLHVGXhw3cHrwhbRn0K4RRtZJ4a6f4MUQ=; b=Hi0Bqn8vuuL0V38/wv7ALUe5Gh
	1sBgcE9p9P78gjwcwBPpJVlYaOwbUKCzRizOeDOAjTJNRGr9I6PFI3PK44fETc0L20amb9DbF+c3t
	xVBv2Z7Y39TZP1Ngn3iVRieAwVMxJ9C+uNnq9CUziPEx5DXpFQbdXy0iXez6GH4kU8eqMnp59IVA0
	QPUIpKbH54sB/9mvOVKO4hTv5w6u/edSUsU06lRi4I4qlH4qo6z+jWbSweoqH46ig8YdwHlghnFtM
	Yg6Iyu7CPa6cOsj8P6sfRuBMDycstNBsNK27OnquSWA9i2So10VzJTSpBO/udaPFSa4mzmnr+eBME
	9/V1Drsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKqXT-004XDa-2o; Mon, 08 Aug 2022 00:22:35 +0000
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKqWa-004Wlp-EL
	for linux-nvme@lists.infradead.org; Mon, 08 Aug 2022 00:22:04 +0000
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
	by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9FFFB62CFF2;
	Mon,  8 Aug 2022 10:21:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1oKqWK-00ARYL-Dl; Mon, 08 Aug 2022 10:21:24 +1000
Date: Mon, 8 Aug 2022 10:21:24 +1000
From: Dave Chinner <david@fromorbit.com>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/7] file: add ops to dma map bvec
Message-ID: <20220808002124.GG3861211@dread.disaster.area>
References: <20220805162444.3985535-1-kbusch@fb.com>
 <20220805162444.3985535-3-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805162444.3985535-3-kbusch@fb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62f0570e
	a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
	a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
	a=_eoJad-yVWRv8vzf4-wA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
	a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_172144_868581_2E5B248C 
X-CRM114-Status: GOOD (  33.99  )
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

On Fri, Aug 05, 2022 at 09:24:39AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The same buffer may be used for many subsequent IO's. Instead of setting
> up the mapping per-IO, provide an interface that can allow a buffer to
> be premapped just once and referenced again later, and implement for the
> block device file.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/fops.c       | 20 ++++++++++++++++++++
>  fs/file.c          | 15 +++++++++++++++
>  include/linux/fs.h | 20 ++++++++++++++++++++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 29066ac5a2fa..db2d1e848f4b 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -670,6 +670,22 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	return error;
>  }
>  
> +#ifdef CONFIG_HAS_DMA
> +void *blkdev_dma_map(struct file *filp, struct bio_vec *bvec, int nr_vecs)
> +{
> +	struct block_device *bdev = filp->private_data;
> +
> +	return block_dma_map(bdev, bvec, nr_vecs);
> +}
> +
> +void blkdev_dma_unmap(struct file *filp, void *dma_tag)
> +{
> +	struct block_device *bdev = filp->private_data;
> +
> +	return block_dma_unmap(bdev, dma_tag);
> +}
> +#endif
> +
>  const struct file_operations def_blk_fops = {
>  	.open		= blkdev_open,
>  	.release	= blkdev_close,
> @@ -686,6 +702,10 @@ const struct file_operations def_blk_fops = {
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= blkdev_fallocate,
> +#ifdef CONFIG_HAS_DMA
> +	.dma_map	= blkdev_dma_map,
> +	.dma_unmap	= blkdev_dma_unmap,
> +#endif
>  };
>  
>  static __init int blkdev_init(void)
> diff --git a/fs/file.c b/fs/file.c
> index 3bcc1ecc314a..767bf9d3205e 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1307,3 +1307,18 @@ int iterate_fd(struct files_struct *files, unsigned n,
>  	return res;
>  }
>  EXPORT_SYMBOL(iterate_fd);
> +
> +#ifdef CONFIG_HAS_DMA
> +void *file_dma_map(struct file *file, struct bio_vec *bvec, int nr_vecs)
> +{
> +	if (file->f_op->dma_map)
> +		return file->f_op->dma_map(file, bvec, nr_vecs);
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +void file_dma_unmap(struct file *file, void *dma_tag)
> +{
> +	if (file->f_op->dma_unmap)
> +		return file->f_op->dma_unmap(file, dma_tag);
> +}
> +#endif
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9f131e559d05..8652bad763f3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2092,6 +2092,10 @@ struct dir_context {
>  struct iov_iter;
>  struct io_uring_cmd;
>  
> +#ifdef CONFIG_HAS_DMA
> +struct bio_vec;
> +#endif
> +
>  struct file_operations {
>  	struct module *owner;
>  	loff_t (*llseek) (struct file *, loff_t, int);
> @@ -2134,6 +2138,10 @@ struct file_operations {
>  				   loff_t len, unsigned int remap_flags);
>  	int (*fadvise)(struct file *, loff_t, loff_t, int);
>  	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
> +#ifdef CONFIG_HAS_DMA
> +	void *(*dma_map)(struct file *, struct bio_vec *, int);
> +	void (*dma_unmap)(struct file *, void *);
> +#endif
>  } __randomize_layout;

This just smells wrong. Using a block layer specific construct as a
primary file operation parameter shouts "layering violation" to me.

Indeed, I can't see how this can be used by anything other than a
block device file on a single, stand-alone block device. It's
mapping a region of memory to something that has no file offset or
length associated with it, and the implementation of the callout is
specially pulling the bdev from the private file data.

What we really need is a callout that returns the bdevs that the
struct file is mapped to (one, or many), so the caller can then map
the memory addresses to the block devices itself. The caller then
needs to do an {file, offset, len} -> {bdev, sector, count}
translation so the io_uring code can then use the correct bdev and
dma mappings for the file offset that the user is doing IO to/from.

For a stand-alone block device, the "get bdevs" callout is pretty
simple. single device filesystems are trivial, too. XFS is trivial -
it will return 1 or 2 block devices. stacked bdevs need to iterate
recursively, as would filesystems like btrfs. Still, pretty easy,
and for the case you care about here has almost zero overhead.

Now you have a list of all the bdevs you are going to need to add
dma mappings for, and you can call the bdev directly to set them up.
THere is no need what-so-ever to do this through through the file
operations layer - it's completely contained at the block device
layer and below.

Then, for each file IO range, we need a mapping callout in the file
operations structure. That will take a  {file, offset, len} tuple
and return a {bdev, sector, count} tuple that maps part or all of
the file data.

Again, for a standalone block device, this is simply a translation
of filep->private to bdev, and offset,len from byte counts to sector
counts. Trival, almost no overhead at all.

For filesystems and stacked block devices, though, this gives you
back all the information you need to select the right set of dma
buffers and the {sector, count} information you need to issue the IO
correctly. Setting this up is now all block device layer
manipulation.[*]

This is where I think this patchset needs to go, not bulldoze
through abstractions that get in the way because all you are
implementing is a special fast path for a single niche use case. We
know how to make it work with filesystems and stacked devices, so
can we please start with an API that allows us to implement the
functionality without having to completely rewrite all the code that
you are proposing to add right now?

Cheers,

Dave.

[*] For the purposes of brevity, I'm ignoring the elephant in the
middle of the room: how do you ensure that the filesystem doesn't
run a truncate or hole punch while you have an outstanding DMA
mapping and io_uring is doing IO direct to file offset via that
mapping? i.e. how do you prevent such a non-filesystem controlled IO
path from accessing to stale data (i.e.  use-after-free) of on-disk
storage because there is nothing serialising it against other
filesystem operations?

This is very similar to the direct storage access issues that
DAX+RDMA and pNFS file layouts have. pNFS solves it with file layout
leases, and DAX has all the hooks into the filesystems needed to use
file layout leases in place, too. I'd suggest that IO via io_uring
persistent DMA mappings outside the scope of the filesysetm
controlled IO path also need layout lease guarantees to avoid user
IO from racing with truncate, etc....

-- 
Dave Chinner
david@fromorbit.com

