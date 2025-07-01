Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF69FC83030
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 00:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9S/rI2DP6ziUNoOKWS9p7/JEJc/Y9YU6z4mbK8KnjNs=; b=bldLDBF7JXO514Pz0vAZhcdRuk
	kC2dq6WXkKmpm5MX5SffQ2oo4/ppdw0M+v7Y23cd0u5aDLaTCa5QG66oxOF820WDqk6uwK2l3IskZ
	PoI6Ua/BxbcYXB1ENf/kn/MjBDcOOJm6A3inzyh/o8LI0Xl0hOV4TPTHksbQtIJOAyFTIb0jUED9y
	TnssIatOxUoonW6tvsIlGy2624EcSZLJzF3yGVWl7+S19WCu8Ag8nx53GTJuNgypqbgBwgO72q26w
	HBDQMAuh3xhWs8PQmEPnCa4Q2UvjEqTYbppaJ4FdUWOvyY7JOi84sAVrE/ro5EQUg7mKncQaMa0/V
	yQph224Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWOyr-00000003k4Q-3ZAc;
	Tue, 01 Jul 2025 00:36:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWOyp-00000003k4K-49nx
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 00:36:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 27C4D6112D;
	Tue,  1 Jul 2025 00:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ADAC4CEE3;
	Tue,  1 Jul 2025 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751330170;
	bh=bp85Nb1SqHOkZt8dKzTMcsAOLOjBh44N/vR/2utVHaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nc/5SMAS1+bbub/Krsn3J35YjtGboTAnFJ1fIl3LGz/1WqPpVZo/EpxH2gfh7yNUQ
	 KgNfkerkmSCK7Dq8zDv4x7qDyv4HsdKDxzG10lanRdBKsnTGB6xRtiYw+Hvno8U9BH
	 cYNcgxPuOKKyoy5PYJT9aGfZ89P0Xraj/GNXWFsT+sLT2/wCjugb6T3wGGu9hRsErf
	 K0VwnNmcZn7XVAkp4veu9RRibGzEkZoOM2dzTkJZM0GWhKZVt9EoXVuyB9zCyT4D9Q
	 t4qkeoL+DYLN6+y5kwyN8lobp/O4rv2djgAr8Qu7jDt6NhkfsCRJQUsn3NJdwEwHbQ
	 s3zUmTj7ddXXA==
Message-ID: <132c1bdf-e100-4e3a-883f-27f9e9b78020@kernel.org>
Date: Tue, 1 Jul 2025 09:34:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: Make blksize_shift configurable
To: Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kch@nvidia.com, sagi@grimberg.me,
 hch@lst.de, upstream+nvme@sigma-star.at
References: <20250630191341.1263000-1-richard@nod.at>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250630191341.1263000-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/1/25 4:13 AM, Richard Weinberger wrote:
> Currently, the block size is automatically configured, and for
> file-backed namespaces it is likely to be 4K.
> While this is a reasonable default for modern storage, it can
> cause confusion if someone wants to export a pre-created disk image
> that uses a 512-byte block size.
> As a result, partition parsing will fail.
> 
> So, just like we already do for the loop block device, let the user
> configure the block size if they know better.

Hmm... That fine with me but this explanation does not match what the patch
does: you allow configuring the block size bit shift, not the size. That is not
super user friendly :)

Even if internally you use the block size bit shift, I think it would be better
if the user facing interface is the block size as that is much easier to
manipulate without having to remember the exponent for powers of 2 values :)

> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Changes since v1 (RFC)[0]:
> 
> - Make sure blksize_shift is in general within reason
> - In the bdev case and when using direct IO, blksize_shift has to be
>   smaller than the logical block it the device
> - In the file case and when using direct IO try to use STATX_DIOALIGN,
>   just like the loop device does
> 
> [0] https://lore.kernel.org/linux-nvme/20250418090834.2755289-1-richard@nod.at/
> 
> Thanks,
> //richard
> ---
>  drivers/nvme/target/configfs.c    | 37 +++++++++++++++++++++++++++++++
>  drivers/nvme/target/io-cmd-bdev.c | 13 ++++++++++-
>  drivers/nvme/target/io-cmd-file.c | 28 ++++++++++++++++++-----
>  3 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index e44ef69dffc24..26175c37374ab 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -797,6 +797,42 @@ static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
>  }
>  CONFIGFS_ATTR(nvmet_ns_, resv_enable);
>  
> +static ssize_t nvmet_ns_blksize_shift_show(struct config_item *item, char *page)

As mentioned above, I think this should be nvmet_ns_blksize_show().

> +{
> +	return sysfs_emit(page, "%u\n", to_nvmet_ns(item)->blksize_shift);

And you can do:

	return sysfs_emit(page, "%u\n",
			  1U << to_nvmet_ns(item)->blksize_shift);

> +}
> +
> +static ssize_t nvmet_ns_blksize_shift_store(struct config_item *item,
> +		const char *page, size_t count)

Similar here: nvmet_ns_blksize_store()

> +{
> +	struct nvmet_ns *ns = to_nvmet_ns(item);
> +	u32 shift;
> +	int ret;
> +
> +	ret = kstrtou32(page, 0, &shift);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Make sure block size is within reason, something between 512 and
> +	 * BLK_MAX_BLOCK_SIZE.
> +	 */
> +	if (shift < 9 || shift > 16)
> +		return -EINVAL;

And this would be simpler:

	if (blksz < SECTOR_SIZE || blksz > BLK_MAX_BLOCK_SIZE ||
	    !is_power_of_2(blksz))
		return -EINVAL;

> +
> +	mutex_lock(&ns->subsys->lock);
> +	if (ns->enabled) {
> +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
> +		mutex_unlock(&ns->subsys->lock);
> +		return -EINVAL;
> +	}
> +	ns->blksize_shift = shift;

and here:

	ns->blksize_shift = ilog2(blksz);

> +	mutex_unlock(&ns->subsys->lock);
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_ns_, blksize_shift);
> +
>  static struct configfs_attribute *nvmet_ns_attrs[] = {
>  	&nvmet_ns_attr_device_path,
>  	&nvmet_ns_attr_device_nguid,
> @@ -806,6 +842,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>  	&nvmet_ns_attr_buffered_io,
>  	&nvmet_ns_attr_revalidate_size,
>  	&nvmet_ns_attr_resv_enable,
> +	&nvmet_ns_attr_blksize_shift,
>  #ifdef CONFIG_PCI_P2PDMA
>  	&nvmet_ns_attr_p2pmem,
>  #endif
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index eba42df2f8215..be39837d4d792 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -77,6 +77,7 @@ static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
>  
>  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  {
> +	int bdev_blksize_shift;
>  	int ret;
>  
>  	/*
> @@ -100,7 +101,17 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  	}
>  	ns->bdev = file_bdev(ns->bdev_file);
>  	ns->size = bdev_nr_bytes(ns->bdev);
> -	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> +	bdev_blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> +
> +	if (ns->blksize_shift) {
> +		if (ns->blksize_shift < bdev_blksize_shift) {
> +			pr_err("Configured blksize_shift needs to be at least %d for device %s\n",
> +				bdev_blksize_shift, ns->device_path);
> +			return -EINVAL;
> +		}
> +	} else {
> +		ns->blksize_shift = bdev_blksize_shift;
> +	}

Nit: to avoid the indented if, may be write this like this: ?

	if (!ns->blksize_shift)
		ns->blksize_shift = bdev_blksize_shift;

	if (ns->blksize_shift < bdev_blksize_shift) {
		pr_err("Configured blksize needs to be at least %u for device %s\n",
			bdev_logical_block_size(ns->bdev),
			ns->device_path);
		return -EINVAL;
	}

Also, if the backend is an HDD, do we want to allow the user to configure a
block size that is less than the *physical* block size ? Performance will
suffer on regular HDDs and writes may fail with SMR HDDs.

>  
>  	ns->pi_type = 0;
>  	ns->metadata_size = 0;
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 2d068439b129c..a4066b5a1dc97 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -49,12 +49,28 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  
>  	nvmet_file_ns_revalidate(ns);
>  
> -	/*
> -	 * i_blkbits can be greater than the universally accepted upper bound,
> -	 * so make sure we export a sane namespace lba_shift.
> -	 */
> -	ns->blksize_shift = min_t(u8,
> -			file_inode(ns->file)->i_blkbits, 12);
> +	if (ns->blksize_shift) {
> +		if (!ns->buffered_io) {
> +			struct block_device *sb_bdev = ns->file->f_mapping->host->i_sb->s_bdev;
> +			struct kstat st;
> +
> +			if (!vfs_getattr(&ns->file->f_path, &st, STATX_DIOALIGN, 0) &&
> +			    (st.result_mask & STATX_DIOALIGN) &&
> +			    (1 << ns->blksize_shift) < st.dio_offset_align)
> +				return -EINVAL;
> +
> +			if (sb_bdev && (1 << ns->blksize_shift < bdev_logical_block_size(sb_bdev)))
> +				return -EINVAL;

I am confused... This is going to check both... But if you got STATX_DIOALIGN
and it is OK, you do not need (and probably should not) do the second if, no ?

Also, the second condition of the second if is essentially the same check as
for the block dev case. So maybe reuse that by creating a small helper function ?

> +		}
> +	} else {
> +		/*
> +		 * i_blkbits can be greater than the universally accepted
> +		 * upper bound, so make sure we export a sane namespace
> +		 * lba_shift.
> +		 */
> +		ns->blksize_shift = min_t(u8,
> +				file_inode(ns->file)->i_blkbits, 12);
> +	}

It feels like this entire hunk should be a helper function as that would allow
making it a lot more readable with early returns. This code here whould be
something like:

	ret = nvmet_file_set_ns_blksize_shift(ns);
	if (ret)
		return ret;

>  
>  	ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
>  			mempool_free_slab, nvmet_bvec_cache);


-- 
Damien Le Moal
Western Digital Research

