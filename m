Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDAEC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 21:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BxlHwbfSGEjrkkVnaAj0TZ6ec/J3+GptfegL4fCvQFY=; b=cbPrqY4BoRb+rCCsewSbwsZfbR
	6doKEZa3B0ejPYzNQeRc/kWUdGMc2CU3oMMJLcSQ84OtxtJHampmLRtuK0b6/IIx99ayQ+ihHM5cw
	5Zbd1IZklXZBuTAI3/0Gz0kN2E/cf5j6k57GyAoGiaYcvB5njWn/GDX27w/27sGtxwzMwWPbb6Hn0
	DpI3FwveAdtGtVpNsw9ldMKO0q96o106Ipn8Ap/LSvBnLvZjEUAj6BAwZdYYf+GbtU1RxTFTPexj4
	gKaccvGj5Kg5S6kNzc5kootRRwxcj+TWkTw9o38AE/m1N12+0Z9vf8+fmXqoRwTki12zDUS7I+cwF
	nvnhswQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdFbp-00000007ofk-1mrk;
	Wed, 29 Jan 2025 21:28:29 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdFat-00000007oV1-3O5s
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 21:27:33 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so29891766b.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jan 2025 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738186049; x=1738790849; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BxlHwbfSGEjrkkVnaAj0TZ6ec/J3+GptfegL4fCvQFY=;
        b=fnpzUw5XicjJaAATQC6JbtYSCI2fXcIUxu3tq/uJhiUl4oqVcnVJD4LT0Rbdb5rHyp
         9c/jKEy8R4hKBWqy2t8WceVN+xLSKoX5jUaQ6RnVNkq4Nk6XjXAcY0fxbJa8z+FGJ2Db
         IGBW45JB6xU3qGL6gG2TI9znje1ndUpxezjLdpr07dhmuHQlbj/jFQZRfQZlFARTYnBK
         I6mJS/38f1HMS+7lTL4pM+zQOxGfAKV6jocH7AqK8c3bhKmDjDLe8ejOU9ydm4dAekk5
         irBOeSDt44diEFOh0okjeh6pMzwyu6130cBlJQht77SVSBXZ7ZVIVy/lJMiYDQgkmRTJ
         KedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738186049; x=1738790849;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxlHwbfSGEjrkkVnaAj0TZ6ec/J3+GptfegL4fCvQFY=;
        b=UPkQczHLBHgI/zKyAmdoX1kL8WRGHsRTs6deRAnSURU84EO1QSrrt6ahi8P8KrUfEv
         3iPukM3g14vKQZrCyZS5SQD8t9QZwP5oK6IBLBRPJAo1ilgWSSpEag3ATqlIYBtTtr5W
         ORfnZkXq4gPmaJ8F66FLg/0UUUCY5AT0gdLFHIwZnJSptJ/C72yZs55p4k6x5bdBes67
         K/rLBKGaIjD+dFV6JSfDG/9s6BodrpgnbplP4rHKpKP/p/a7wiJplSoAPuNvLPfWTvKQ
         7TDCq6yPVVjLd8ij19IRUI8uITwg0U4HbWM6d4+yXXnqFGj6KjaCSO8FYYxpz+KTycJG
         ctwA==
X-Forwarded-Encrypted: i=1; AJvYcCWOCLprVIEdYN1MV1cUoIAcBJcfnR6N50jebdZIscXw70lDSNozmYb62QnKFpHTkCGesfmPCj1ri72c@lists.infradead.org
X-Gm-Message-State: AOJu0YwrhzVHAnutcQUH62EGGZTet1XFWkc2DOwsjOQjEicCxh1vpS5C
	zaZz3xejAqREgScRWp4Kepesc9IXt/ISI1Sc0K/bAegdeNXlHqDRz0mVDP9nlFE=
X-Gm-Gg: ASbGncteJY+ScQJQo0fq97pBDTIQJjKBlYKLbNBID+MUQjgAB5/Y2Wp8+8kzr/0oQjr
	EfmzaQqBAZvoVbqjVyuhZtol9oFNu7wAg4mAeBbMxc0rpPhJ29Vz2ltM5PqsCe6kiIw68wLMuoX
	QnYmsZA07ldWr2+qn+RNmniefIeUzffWO+VpGQLTQd91PeX/BaoAfNV/0Gd6pQ1rF95O+ibF++g
	Agq79L/oBj1nkswyY4d7pCNlIZA6R+VhOkx1DtenwPjv7bj1iiqYBMtW73t72iStVlx8l4kaD+o
	KG4q5PUdihbZN7K4wgB+k6Y3WJfOl5sSI/3LE72gdxg=
X-Google-Smtp-Source: AGHT+IEpIWE2AAWpA2ZWCGob7gY0bijDoMnVMcEuI+RD3B3UsRx0bqmo4fQhG7Xj0B3HeC2e+ytIQA==
X-Received: by 2002:a17:907:1188:b0:ab6:d452:2315 with SMTP id a640c23a62f3a-ab6d45223e6mr300711766b.14.1738186049172;
        Wed, 29 Jan 2025 13:27:29 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331efafsm445825ad.217.2025.01.29.13.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 13:27:28 -0800 (PST)
Message-ID: <1660f35a-3cee-4a67-a4fc-c26b7b2dbd24@suse.com>
Date: Thu, 30 Jan 2025 07:57:22 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] btrfs: add checksum offload
To: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
 dsterba@suse.com, clm@fb.com, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20250129140207.22718-1-joshi.k@samsung.com>
 <CGME20250129141044epcas5p422461bd3630814884c91fc0f4207edde@epcas5p4.samsung.com>
 <20250129140207.22718-4-joshi.k@samsung.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250129140207.22718-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_132731_850408_8526D631 
X-CRM114-Status: GOOD (  25.54  )
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



在 2025/1/30 00:32, Kanchan Joshi 写道:
> Add new mount option 'datsum_offload'.
> 
> When passed
> - Data checksumming at the FS level is disabled.
> - Data checksumming at the device level is enabled. This is done by
> setting REQ_INTEGRITY_OFFLOAD flag for data I/O if the underlying device is
> capable.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>


Just as mentioned by Christoph, the change on csum tree is an on-disk 
format change, which requires extra incompat flags.
I believe that's fine because this is only a prototype.

But my concern is, this lack of csum tree has the following problems:

- Require all devices in the btrfs has the same capacity
   E.g. you can no longer add a devices without REQ_INTEGRITY_OFFLOAD
   capability.
   This can be a very big problem, especially if one just wants to
   migrate the fs to another device.

- Less versatile compared to nodatacsum flags/mount option
   For NODATACSUM flag it can be set on a per-inode basis, but the new
   no-datacsum flag is bound to hardware storage.

And finally my question on why to remove btrfs datacsum.

I understand the device's own checksum is super fast and efficient, but 
that doesn't mean different checksum at different layers are exclusive.

Yes, it cause some extra workload, but since it's handled by hardware 
there is no obvious penalty.

On the other hand, it is adding one extra layer of protection, upon the 
existing btrfs' checksum.

Thus if the end user is fully trusting the hardware's protection, then 
they can just use nodatasum mount option and call it a day.
The benefit you shown is really just the benefit from "nodatasum" 
behavior, and that's more or less expected due to the COW overhead.

So I really prefer to let the end user to choose what they want.

If they want to fully rely on the hardware's internal checksum, then 
configure the block device to do it, and create a btrfs with nodatasum.

If they want both btrfs and the hardware checksum, just do the usual way.

Thanks,
Qu

> ---
>   fs/btrfs/bio.c   | 12 ++++++++++++
>   fs/btrfs/fs.h    |  1 +
>   fs/btrfs/super.c |  9 +++++++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 7ea6f0b43b95..811d89c64991 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/bio.h>
> +#include <linux/blk-integrity.h>
>   #include "bio.h"
>   #include "ctree.h"
>   #include "volumes.h"
> @@ -424,6 +425,15 @@ static void btrfs_clone_write_end_io(struct bio *bio)
>   	bio_put(bio);
>   }
>   
> +static void btrfs_prep_csum_offload_hw(struct btrfs_device *dev, struct bio *bio)
> +{
> +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +
> +	if (btrfs_test_opt(dev->fs_info, DATASUM_OFFLOAD) &&
> +	    bi && bi->offload_type != BLK_INTEGRITY_OFFLOAD_NONE)
> +		bio->bi_opf |= REQ_INTEGRITY_OFFLOAD;
> +}
> +
>   static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
>   {
>   	if (!dev || !dev->bdev ||
> @@ -435,6 +445,8 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
>   	}
>   
>   	bio_set_dev(bio, dev->bdev);
> +	if (!(bio->bi_opf & REQ_META))
> +		btrfs_prep_csum_offload_hw(dev, bio);
>   
>   	/*
>   	 * For zone append writing, bi_sector must point the beginning of the
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 79a1a3d6f04d..88e493967100 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -228,6 +228,7 @@ enum {
>   	BTRFS_MOUNT_NOSPACECACHE		= (1ULL << 30),
>   	BTRFS_MOUNT_IGNOREMETACSUMS		= (1ULL << 31),
>   	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1ULL << 32),
> +	BTRFS_MOUNT_DATASUM_OFFLOAD		= (1ULL << 33),
>   };
>   
>   /*
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7dfe5005129a..d0d5b35c2df9 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -121,6 +121,7 @@ enum {
>   	Opt_treelog,
>   	Opt_user_subvol_rm_allowed,
>   	Opt_norecovery,
> +	Opt_datasum_offload,
>   
>   	/* Rescue options */
>   	Opt_rescue,
> @@ -223,6 +224,7 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
>   	fsparam_string("compress-force", Opt_compress_force_type),
>   	fsparam_flag_no("datacow", Opt_datacow),
>   	fsparam_flag_no("datasum", Opt_datasum),
> +	fsparam_flag_no("datasum_offload", Opt_datasum_offload),
>   	fsparam_flag("degraded", Opt_degraded),
>   	fsparam_string("device", Opt_device),
>   	fsparam_flag_no("discard", Opt_discard),
> @@ -323,6 +325,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>   		}
>   		break;
> +	case Opt_datasum_offload:
> +		btrfs_set_opt(ctx->mount_opt, NODATASUM);
> +		btrfs_set_opt(ctx->mount_opt, DATASUM_OFFLOAD);
> +		break;
>   	case Opt_datacow:
>   		if (result.negated) {
>   			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
> @@ -1057,6 +1063,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>   		seq_puts(seq, ",degraded");
>   	if (btrfs_test_opt(info, NODATASUM))
>   		seq_puts(seq, ",nodatasum");
> +	if (btrfs_test_opt(info, DATASUM_OFFLOAD))
> +		seq_puts(seq, ",datasum_offload");
>   	if (btrfs_test_opt(info, NODATACOW))
>   		seq_puts(seq, ",nodatacow");
>   	if (btrfs_test_opt(info, NOBARRIER))
> @@ -1434,6 +1442,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
>   	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
>   	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
>   	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
> +	btrfs_info_if_set(info, old, DATASUM_OFFLOAD, "setting datasum offload to the device");
>   	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
>   	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
>   	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");


