Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19DBC761A6
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4nrDerkWL8S2ADXJ9o3MXzPF4mnXbVDnimFylDUNQc=; b=pcPg/EMSlxC/lz+d21zj/vtWxr
	j7q7KKxomahivc165ahEHuF9DN38a29QHSOQ3zF5y0EgOgBrQWMp0qnuuB8JvHrvJM4bvmfXOLD4o
	vETnWgL/3CrfRkJLh4XpvUmLLiWSHJ/4KV6KOlPxGQz12T0OTd+9UrIMJJy+Q6QIC1hOdTHNsi5MK
	tMTssrs56h2i1rNdN3FDbQUh0j++hzXLGYyR9fXD9XQKR85dHz6em3YmcoZc7r6m/FOkFeI1zyHhx
	cyUya6suwuQRRp0lzC09WwJiSZKM3OTOZ+2+ItQIZCVy+66CUAhWxx/qby22itiJ+Gvssz9UGhuSz
	INZbbQmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phRez-00HEda-29;
	Wed, 29 Mar 2023 09:00:01 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phRev-00HEbh-2b
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 08:59:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680080397; x=1711616397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mpI+Cy2tgI3Sd1AkHMVOE9U08MyGWDToEs92pFOGeZg=;
  b=cOJ8Jv4uFLbtFoxOcMrEc1uiEIBKobppni6CNzVb+F9JEdkn0KxkjtD3
   ZljQMtufejDhUna/B/IszV+/zBmBdDPCdIBJDaGrOt4f/ywFPYFDtIyFD
   hKbvR0wydyitmoKPPilBj9+SW6gVzwfxhW0NLYtHj7jbI+mt+QLKoRHpF
   vZjdHGlvL30KYd4pcsZQXwWNgn7Ta7ay5I0LZ1k/KcXeG3UKWnvmU1mTY
   82cd7YTpNuz0GpB6wLoKiZ++8jvdA8RrcEO2JnOc1MiFoFL4w80sAHdH+
   NjBz2D2rNuQ4vs2B2F8Pf3UjLUPPBlrETEJOAuarh2+CACbB/cw2tEKkm
   g==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="225056545"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 16:59:56 +0800
IronPort-SDR: F9GaoZwR+1dIGQITPorw52dMhXfcIQ0nvzd3I2gsGsbddizyQbfEEQDaI1VueisLpjeEo/gvLu
 v+fCXybUYiihSrKrVYWcpzaYPkXgQ3xAHkco7VdqLqXlrGuyDhM9MJ7hJAoqg+qU6v6SmJOMdQ
 pHJrF4JPIKgFoJpG/Bzd1PryQhauGSIZ7VddtlIYx46Qtbc4ZDI4LlcDEHmZp5SS0vDEvFMfzB
 LW/GcoJ0735O0zHVZHK+6CDFh5dfq5I+EyrxXd6zyFAtBjB7I9QPg3FGMXdTyQYmsNGANUOZeG
 2YM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:10:26 -0700
IronPort-SDR: k0NmEhYbLNE5LKFEIrUvhuuPOtgxdtnR5cN6hjThzUtgsZH7Rzk7WokSJ6SCpOkJp2dXxetbqt
 1nHxYEGDrcEKiq3l350axGputEmhRZnQiDKpW56U30VofGlArq86HQ/k7+CiY0fiLEwSl9nrEd
 18lpSttjNV32/WWYWopcZ6wEenrQDn5zUtUWJbvqTpQd3841GhqjaZl1v0yCCG1nQ3O2GMV3BU
 /mZfK5b62/AI+slHOB/d9VfdsC687/lPl/+6g4DT1wW8l8XOx5/qqxfZtbvUNoHuTyjhq82OJP
 02Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:59:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PmgVN6YLFz1RtVn
	for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 01:59:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1680080395; x=1682672396; bh=mpI+Cy2tgI3Sd1AkHMVOE9U08MyGWDToEs9
	2pFOGeZg=; b=jcA6R8w0f8nggQrY15fdmioM4vd6K9ucvDPviggTbMcc5D+R+mz
	WxRE9kc+NB8WJ7XesRJdqSiZ7EEFQS6D8YVbMqCH7eYRq1KJmFV5g349K2+kGFG2
	sxEJol007A2MSQjSeUe5TU415ipKxEx4E3vHyRiRvtWF308X3dbIrFN55Epe2pH3
	sqLRzfNySW0Z6t6IcWt5hKhFmLfCevlB38k6ltXlF0A4xVQJ/poKNgtyXJh1BruG
	9pa9V6zHfPcX5kLwDWjOZkbyJ9nQTy8E5zz4Y8bEDiK7kdIdplZE1XoF3dTAI8re
	HqtBDKUrT5zHIF28yATUjlPVexijyfWNEig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dBkloBQ-UoGx for <linux-nvme@lists.infradead.org>;
	Wed, 29 Mar 2023 01:59:55 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PmgVH0M2xz1RtVm;
	Wed, 29 Mar 2023 01:59:50 -0700 (PDT)
Message-ID: <3b9adeb6-4295-6e6a-9e93-7c5a06441830@opensource.wdc.com>
Date: Wed, 29 Mar 2023 17:59:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 7/9] dm: Add support for copy offload.
Content-Language: en-US
To: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084312epcas5p377810b172aa6048519591518f8c308d0@epcas5p3.samsung.com>
 <20230327084103.21601-8-anuj20.g@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230327084103.21601-8-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_015957_884493_20EC3BEE 
X-CRM114-Status: GOOD (  32.06  )
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

On 3/27/23 17:40, Anuj Gupta wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 

Drop the period at the end of the patch title.

> Before enabling copy for dm target, check if underlying devices and
> dm target support copy. Avoid split happening inside dm target.
> Fail early if the request needs split, currently splitting copy
> request is not supported.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  drivers/md/dm-table.c         | 42 +++++++++++++++++++++++++++++++++++
>  drivers/md/dm.c               |  7 ++++++
>  include/linux/device-mapper.h |  5 +++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 7899f5fb4c13..45e894b9e3be 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1863,6 +1863,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
>  	return true;
>  }
>  
> +static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
> +				      sector_t start, sector_t len, void *data)
> +{
> +	struct request_queue *q = bdev_get_queue(dev->bdev);
> +
> +	return !blk_queue_copy(q);
> +}
> +
> +static bool dm_table_supports_copy(struct dm_table *t)
> +{
> +	struct dm_target *ti;
> +	unsigned int i;
> +
> +	for (i = 0; i < t->num_targets; i++) {
> +		ti = dm_table_get_target(t, i);
> +
> +		if (!ti->copy_offload_supported)
> +			return false;
> +
> +		/*
> +		 * target provides copy support (as implied by setting
> +		 * 'copy_offload_supported')
> +		 * and it relies on _all_ data devices having copy support.
> +		 */
> +		if (!ti->type->iterate_devices ||
> +		     ti->type->iterate_devices(ti,
> +			     device_not_copy_capable, NULL))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
>  				      sector_t start, sector_t len, void *data)
>  {
> @@ -1945,6 +1978,15 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  		q->limits.discard_misaligned = 0;
>  	}
>  
> +	if (!dm_table_supports_copy(t)) {
> +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> +		/* Must also clear copy limits... */

Not a useful comment. The code is clear.

> +		q->limits.max_copy_sectors = 0;
> +		q->limits.max_copy_sectors_hw = 0;
> +	} else {
> +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> +	}
> +
>  	if (!dm_table_supports_secure_erase(t))
>  		q->limits.max_secure_erase_sectors = 0;
>  
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 2d0f934ba6e6..08ec51000af8 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1693,6 +1693,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
>  	if (unlikely(ci->is_abnormal_io))
>  		return __process_abnormal_io(ci, ti);
>  
> +	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
> +			max_io_len(ti, ci->sector) < ci->sector_count)) {
> +		DMERR("Error, IO size(%u) > max target size(%llu)\n",
> +			ci->sector_count, max_io_len(ti, ci->sector));
> +		return BLK_STS_IOERR;
> +	}
> +
>  	/*
>  	 * Only support bio polling for normal IO, and the target io is
>  	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 7975483816e4..44969a20295e 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -380,6 +380,11 @@ struct dm_target {
>  	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
>  	 */
>  	bool needs_bio_set_dev:1;
> +
> +	/*
> +	 * copy offload is supported
> +	 */
> +	bool copy_offload_supported:1;
>  };
>  
>  void *dm_per_bio_data(struct bio *bio, size_t data_size);

-- 
Damien Le Moal
Western Digital Research


