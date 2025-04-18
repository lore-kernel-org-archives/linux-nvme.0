Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26548C369C9
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aMEgKWEmHCmspTsrgy9agJmQi73D9fcQwl+nWN+32SY=; b=2GIWmS8uU9W8Qv0JCeeBJBbb/m
	eqPwZh7PFV2xxIWhj5w50Yiec3+pgwub96slgKNNFzFX+pRt8rAMx/Fx5+f5rLx2QRjqJVP+8HYD+
	bsCNdsGJnGmF3EuQduFfuGMc2S6uEC7euWy9yVGdp32BqMtj0/x4wtPmS1pSYLWs1iF4voS3VupLa
	jHtziODawRsbWr52eSRsKOh5IDb+RIoCWd2yyy1grGCz7uDnLZHWdSSd1iHRLaPiPNWnROR/O2T67
	VbrNqh0DSxcfVkSAybvOj/Uq92YWv8dLgmYo0qjQfhIUwhDSW4wekVP9lNzH7XetHK67anka5T2ic
	4f+mQbtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5i9x-0000000Flp0-19lk;
	Fri, 18 Apr 2025 09:37:21 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5i9u-0000000FloY-2t0e
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 09:37:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 96850A4B3DE;
	Fri, 18 Apr 2025 09:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E214C4CEE2;
	Fri, 18 Apr 2025 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744969037;
	bh=U2qVuo/RpKSkmtroRaqI+s1mXX43CzeMJ3Wnjjr7Dag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=paoItzaU9isehD2ywFP7hzAMAUXiRrArBqI3hsWK936mylQH+GA/ZdAJpHvOWh4hg
	 l8QKlbr1JVvjIqDOhvu3bhwB9PYZk/UKGKfBf5b5tisDE4wlRGijoAnZ7T7oSVVBPt
	 XGosINofvYmi8xC3+xTkfHacjaAL63o4FKDniRKQ/Tw6W9DBPOzh46JXt46OObaJIc
	 XVXw85AOM9iejPbtN/oM18kqY7B6bkLefQkfFAde5feJ1TPbUNN8oAx3tNx8Saa6A5
	 6smM8ItFny8EuOfF8AT+w0/6+Y0WxKBI44/N6127Gx/VnJe9t8gZ+HRFESxb/dy8Et
	 bJ6qZOYeKmkzQ==
Message-ID: <0e61c6e9-10bc-4272-b446-31e0d67547ce@kernel.org>
Date: Fri, 18 Apr 2025 18:37:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvmet: Make blksize_shift configurable
To: Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kch@nvidia.com, sagi@grimberg.me,
 hch@lst.de, upstream+nvme@sigma-star.at
References: <20250418090834.2755289-1-richard@nod.at>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250418090834.2755289-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_023718_863182_A84F7392 
X-CRM114-Status: GOOD (  24.83  )
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

On 4/18/25 18:08, Richard Weinberger wrote:
> Currently, the block size is automatically configured, and for
> file-backed namespaces it is likely to be 4K.
> While this is a reasonable default for modern storage, it can
> cause confusion if someone wants to export a pre-created disk image
> that uses a 512-byte block size.
> As a result, partition parsing will fail.
> 
> So, just like we already do for the loop block device, let the user
> configure the block size if they know better.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/nvme/target/configfs.c    | 30 ++++++++++++++++++++++++++++++
>  drivers/nvme/target/io-cmd-bdev.c |  4 +++-
>  drivers/nvme/target/io-cmd-file.c | 15 +++++++++------
>  3 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index e44ef69dffc2..2fd9cc3b1d00 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -797,6 +797,35 @@ static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
>  }
>  CONFIGFS_ATTR(nvmet_ns_, resv_enable);
>  
> +static ssize_t nvmet_ns_blksize_shift_show(struct config_item *item, char *page)
> +{
> +	return sysfs_emit(page, "%d\n", to_nvmet_ns(item)->blksize_shift);
> +}
> +
> +static ssize_t nvmet_ns_blksize_shift_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_ns *ns = to_nvmet_ns(item);
> +	u32 shift;
> +	int ret;
> +
> +	ret = kstrtou32(page, 0, &shift);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&ns->subsys->lock);
> +	if (ns->enabled) {
> +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
> +		mutex_unlock(&ns->subsys->lock);
> +		return -EINVAL;
> +	}
> +	ns->blksize_shift = shift;
> +	mutex_unlock(&ns->subsys->lock);
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_ns_, blksize_shift);
> +
>  static struct configfs_attribute *nvmet_ns_attrs[] = {
>  	&nvmet_ns_attr_device_path,
>  	&nvmet_ns_attr_device_nguid,
> @@ -806,6 +835,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>  	&nvmet_ns_attr_buffered_io,
>  	&nvmet_ns_attr_revalidate_size,
>  	&nvmet_ns_attr_resv_enable,
> +	&nvmet_ns_attr_blksize_shift,
>  #ifdef CONFIG_PCI_P2PDMA
>  	&nvmet_ns_attr_p2pmem,
>  #endif
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 83be0657e6df..a86010af4670 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -100,7 +100,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  	}
>  	ns->bdev = file_bdev(ns->bdev_file);
>  	ns->size = bdev_nr_bytes(ns->bdev);
> -	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> +
> +	if (!ns->blksize_shift)
> +		ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));

If the user set logical block size is smaller than the block dev logical block
size, this is not going to work... No ? Am I missing something ?

>  
>  	ns->pi_type = 0;
>  	ns->metadata_size = 0;
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 2d068439b129..5893b64179fb 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -49,12 +49,15 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  
>  	nvmet_file_ns_revalidate(ns);
>  
> -	/*
> -	 * i_blkbits can be greater than the universally accepted upper bound,
> -	 * so make sure we export a sane namespace lba_shift.
> -	 */
> -	ns->blksize_shift = min_t(u8,
> -			file_inode(ns->file)->i_blkbits, 12);
> +	if (!ns->blksize_shift) {
> +		/*
> +		 * i_blkbits can be greater than the universally accepted
> +		 * upper bound, so make sure we export a sane namespace
> +		 * lba_shift.
> +		 */
> +		ns->blksize_shift = min_t(u8,
> +				file_inode(ns->file)->i_blkbits, 12);

This will work for any block size, regardless of the FS block size, but only if
ns->buffered_io is true. Doesn't this require some more checks with regards to
O_DIRECT (!ns->buffered_io case) ?

> +	}
>  
>  	ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
>  			mempool_free_slab, nvmet_bvec_cache);


-- 
Damien Le Moal
Western Digital Research

