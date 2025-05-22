Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F5C54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vBABipu/NDSETXU+oxE4oFvJF75IsCnFvybSs+sYl1M=; b=2nmYse6vYasRn2otfkr1AFsKPE
	t0tE8dMU5BXf9E2SidymB9ojPFYOaS3j/jbmqddWPcweLFy/G9K0mDTPvIFKMSZUnKGtIRfgIkl4c
	D4sh+mdURC5A/D114lh+wrou1O7IU82T86A7OfizkNoUuVMOibO2nDalNrYuo++pqU4VYwrpBR2+L
	zWdODqGc2HTKjXb9Jwm0WD+TOkWbvKuIyVjZMLHqDTkQUUQbo5mggFH22YM/gOY2dxFj+/lzP05QX
	StYpi8Favv3gPYrq2dp9eL6I6MoEZHDIk6zg4AqKjFXvQ0ftZv1qh+z732hTszUSxvywTGEJBZMAA
	f92U3wiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6RD-00000001BXz-453d;
	Thu, 22 May 2025 13:58:23 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6RA-00000001BWX-404v
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 13:58:22 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 336511F460;
	Thu, 22 May 2025 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBABipu/NDSETXU+oxE4oFvJF75IsCnFvybSs+sYl1M=;
	b=iZwkMGkZED54w+rC3frh8WGzriCDCcyyLoWKPCWAeOYBduvbp4YCYwYHWPD9X3Y2Nbop7/
	Gt0UkLoGku/82Or1mRl8nwQ8I2Re9ODY6J0j3jOgCJ3MY0yhG3up8AgcahXd6e61HZc1yK
	J3TmHOJfk5jEe1luFEenxmAXD/SgLXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBABipu/NDSETXU+oxE4oFvJF75IsCnFvybSs+sYl1M=;
	b=W0jLhzqPfZMTGTV3VhczPqtv2z3JWLpX0aOyivPq1t1+EG+0p6o1x35oD+H98IHi1S0EHp
	gDStYPK9v5chMSCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iZwkMGkZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W0jLhzqP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBABipu/NDSETXU+oxE4oFvJF75IsCnFvybSs+sYl1M=;
	b=iZwkMGkZED54w+rC3frh8WGzriCDCcyyLoWKPCWAeOYBduvbp4YCYwYHWPD9X3Y2Nbop7/
	Gt0UkLoGku/82Or1mRl8nwQ8I2Re9ODY6J0j3jOgCJ3MY0yhG3up8AgcahXd6e61HZc1yK
	J3TmHOJfk5jEe1luFEenxmAXD/SgLXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBABipu/NDSETXU+oxE4oFvJF75IsCnFvybSs+sYl1M=;
	b=W0jLhzqPfZMTGTV3VhczPqtv2z3JWLpX0aOyivPq1t1+EG+0p6o1x35oD+H98IHi1S0EHp
	gDStYPK9v5chMSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16E14137B8;
	Thu, 22 May 2025 13:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HZx6BHstL2gdDQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 May 2025 13:58:19 +0000
Message-ID: <4fdbe560-d646-496c-be51-49ea49d47449@suse.de>
Date: Thu, 22 May 2025 15:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block: add support for vectored copies
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-5-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250521223107.709131-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 336511F460
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_065821_139620_8A8FF739 
X-CRM114-Status: GOOD (  28.17  )
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

On 5/22/25 00:31, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Copy offload can be used to defrad or garbage collect data spread across

Defrag?

> the disk. Most storage protocols provide a way to specifiy multiple
> sources in a single copy commnd, so introduce kernel and user space
> interfaces to accomplish that.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/blk-lib.c         | 50 ++++++++++++++++++++++++----------
>   block/ioctl.c           | 59 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/blkdev.h  |  2 ++
>   include/uapi/linux/fs.h | 14 ++++++++++
>   4 files changed, 111 insertions(+), 14 deletions(-)
> 
Any specific reason why this is a different patch, and not folded into
patch 2? It really feels odd to continuously updating interfaces which
have been added with the same patchset...

> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index a538acbaa2cd7..7513b876a5399 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -424,26 +424,46 @@ static int __blkdev_copy(struct block_device *bdev, sector_t dst_sector,
>   }
>   
>   static int blkdev_copy_offload(struct block_device *bdev, sector_t dst_sector,
> -		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
> +		struct bio_vec *bv, int nr_vecs, gfp_t gfp)
>   {
> +	unsigned size = 0;
>   	struct bio *bio;
> -	int ret;
> -
> -	struct bio_vec bv = {
> -		.bv_sector = src_sector,
> -		.bv_sectors = nr_sects,
> -	};
> +	int ret, i;
>   
> -	bio = bio_alloc(bdev, 1, REQ_OP_COPY, gfp);
> -	bio_add_copy_src(bio, &bv);
> +	bio = bio_alloc(bdev, nr_vecs, REQ_OP_COPY, gfp);
> +	for (i = 0; i < nr_vecs; i++) {
> +		size += bv[i].bv_sectors << SECTOR_SHIFT;
> +		bio_add_copy_src(bio, &bv[i]);
> +	}
>   	bio->bi_iter.bi_sector = dst_sector;
> -	bio->bi_iter.bi_size = nr_sects << SECTOR_SHIFT;
> +	bio->bi_iter.bi_size = size;
>   
>   	ret = submit_bio_wait(bio);
>   	bio_put(bio);
>   	return ret;
> +}
> +
> +/**
> + * blkdev_copy_range - copy range of sectors to a destination
> + * @dst_sector:	start sector of the destination to copy to
> + * @bv:		vector of source sectors
> + * @nr_vecs:	number of source sector vectors
> + * @gfp:	allocation flags to use
> + */
> +int blkdev_copy_range(struct block_device *bdev, sector_t dst_sector,
> +		struct bio_vec *bv, int nr_vecs, gfp_t gfp)
> +{
> +	int ret, i;
>   
> +	if (bdev_copy_sectors(bdev))
> +		return blkdev_copy_offload(bdev, dst_sector, bv, nr_vecs, gfp);
> +
> +	for (i = 0, ret = 0; i < nr_vecs && !ret; i++)
> +		ret = __blkdev_copy(bdev, dst_sector, bv[i].bv_sector,
> +				bv[i].bv_sectors, gfp);
> +	return ret;
>   }
> +EXPORT_SYMBOL_GPL(blkdev_copy_range);
>   
>   /**
>    * blkdev_copy - copy source sectors to a destination on the same block device
> @@ -455,9 +475,11 @@ static int blkdev_copy_offload(struct block_device *bdev, sector_t dst_sector,
>   int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
>   		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
>   {
> -	if (bdev_copy_sectors(bdev))
> -		return blkdev_copy_offload(bdev, dst_sector, src_sector,
> -					nr_sects, gfp);
> -	return __blkdev_copy(bdev, dst_sector, src_sector, nr_sects, gfp);
> +	struct bio_vec bv = {
> +		.bv_sector = src_sector,
> +		.bv_sectors = nr_sects,
> +	};
> +
> +	return blkdev_copy_range(bdev, dst_sector, &bv, 1, gfp);
>   }
>   EXPORT_SYMBOL_GPL(blkdev_copy);
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 6f03c65867348..4b5095be19e1a 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -241,6 +241,63 @@ static int blk_ioctl_copy(struct block_device *bdev, blk_mode_t mode,
>   	return blkdev_copy(bdev, dst, src, nr, GFP_KERNEL);
>   }
>   
> +static int blk_ioctl_copy_vec(struct block_device *bdev, blk_mode_t mode,
> +		void __user *argp)
> +{
> +	sector_t align = bdev_logical_block_size(bdev) >> SECTOR_SHIFT;
> +	struct bio_vec *bv, fast_bv[UIO_FASTIOV];
> +	struct copy_range cr;
> +	int i, nr, ret;
> +	__u64 dst;
> +
> +	if (!(mode & BLK_OPEN_WRITE))
> +		return -EBADF;
> +	if (copy_from_user(&cr, argp, sizeof(cr)))
> +		return -EFAULT;
> +	if (!(IS_ALIGNED(cr.dst_sector, align)))
> +		return -EINVAL;
> +
> +	nr = cr.nr_ranges;
> +	if (nr <= UIO_FASTIOV) {
> +		bv = fast_bv;
> +	} else {
> +		bv = kmalloc_array(nr, sizeof(*bv), GFP_KERNEL);
> +		if (!bv)
> +			return -ENOMEM;
> +	}
> +
> +	dst = cr.dst_sector;
> +	for (i = 0; i < nr; i++) {
> +		struct copy_source csrc;
> +		__u64 nr_sects, src;
> +
> +		if (copy_from_user(&csrc,
> +				(void __user *)(cr.sources + i * sizeof(csrc)),
> +				sizeof(csrc))) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		nr_sects = csrc.nr_sectors;
> +		src = csrc.src_sector;
> +		if (!(IS_ALIGNED(src | nr_sects, align)) ||
> +		    (src < dst && src + nr_sects > dst) ||
> +		    (dst < src && dst + nr_sects > src)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		bv[i].bv_sectors = nr_sects;
> +		bv[i].bv_sector = src;
> +	}
> +
> +	ret = blkdev_copy_range(bdev, dst, bv, nr, GFP_KERNEL);
> +out:
> +	if (bv != fast_bv)
> +		kfree(bv);
> +	return ret;
> +}
> +
>   static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
>   		unsigned long arg)
>   {
> @@ -605,6 +662,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>   		return blk_ioctl_secure_erase(bdev, mode, argp);
>   	case BLKCPY:
>   		return blk_ioctl_copy(bdev, mode, argp);
> +	case BLKCPY_VEC:
> +		return blk_ioctl_copy_vec(bdev, mode, argp);
>   	case BLKZEROOUT:
>   		return blk_ioctl_zeroout(bdev, mode, arg);
>   	case BLKGETDISKSEQ:

And that makes it even worse; introducing two ioctls which basically do
the same thing (or where one is actually a special case of the other)
is probably not what we should be doing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

