Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE9C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:49:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010D861405
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010D861405
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=sRvs5Fjcj7pmPFPXGB26fo2RKBlWhVnqSrQN7N0GuNw=; b=lCOkuAayhP9gZ7s0ZYaa63MwNn
	f715ujZJ1dhIrvdeNgybj/suHoMasmjEk8fiDND3ZBpSzLQC2xShXIwjVWpDECqR/Sq0ZQ4YJbAHG
	mylHtoNy1Bj7LCmyVBGjcYnYYRV5ug42oB5n1sRniAfZfmS287imZfIvGCy1wWJ2Yz4VOK/v5667Y
	rO3SmmZYrqkJnFxjOae63cGIIaodHS7hs+xu0syZO+fjBcvfxjJzjIv8HPuwbRpIxRr7pfdfp+gLr
	wHXmRpcs+GrBdr/HiFvVFe+/EPp3HRvdoa+nTOEuj94h2sEHSt8A6Zmb9Nxc0V6SM4M9VRlDyGdaJ
	O6ctt0Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llHVQ-001rVV-6k; Mon, 24 May 2021 20:48:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkqqS-004c2d-67
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 16:20:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=iFkWHMko4nu73I8bffz46LtF778hJacVhJlqbZzQwF8=; b=h5xsu6AENDzLe0U+qj0KqtflXV
 ygva7/JLOJ+2/gUSsgVfC9SPgaZMRmsZFXrBwy/ODsxJQBIjTPQJ+es6e9f7i/iYBizCOvRJZpeGx
 /fjqLjjeveUAL6/jxJLrZ9yGcJ5xzWS08r2s9iOv1nasuAv7FIvxd5i050BdlFixkWNumJxA/03Dq
 /kT+/aHJcoQmTbMl5iRE3Phc9FWSW25tIbOs//OY8LgwtZ7CWnpwwJsaUCgHhwTTnTJ+PkT7uuaS1
 9ib+iXamhVGY85OXZRtnSyYmqaJKKOviPoBI4XKwlyDonWtYdqbuK7jtMJGNWqXPmpQ4YPYm5B29K
 mKwCEcKA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkqqP-000Ufs-D3
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 16:20:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621786845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFkWHMko4nu73I8bffz46LtF778hJacVhJlqbZzQwF8=;
 b=xIMCLEuwtEJ3ZYLVT1jAFLSlmekHbIbar2TdYds2f7pJgux+ASXt64k09tx/I3VzYVSQbd
 jYbEua8uhBBK1QtJJhgUBirelGonk+/REbn1EZdyuTOztWNmc/243wGZRrn0BpiSJnEF/k
 3o6nC8QrS3eMOcehdY1jqcN3GUtqNzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621786845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFkWHMko4nu73I8bffz46LtF778hJacVhJlqbZzQwF8=;
 b=OjWXQORh1AHg1yI5pLimYhJCE0/GNAVfRs6jLZKfmf7Vpd71K+gfdYi9LvcDAJhupXh6Tf
 ZrcrurNwYt+dptBg==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DA2BFAAFD;
 Sun, 23 May 2021 16:20:44 +0000 (UTC)
Subject: Re: [PATCH 12/26] bcache: convert to blk_alloc_disk/blk_cleanup_disk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
 Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-13-hch@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <19e05358-abc2-a577-d3bd-d4ae89f6316e@suse.de>
Date: Mon, 24 May 2021 00:20:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-13-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_092049_764504_BC4C1D43 
X-CRM114-Status: GOOD (  18.96  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/21/21 1:51 PM, Christoph Hellwig wrote:
> Convert the bcache driver to use the blk_alloc_disk and blk_cleanup_disk
> helpers to simplify gendisk and request_queue allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>

Thanks.


Coly Li

> ---
>  drivers/md/bcache/super.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index bea8c4429ae8..185246a0d855 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -890,13 +890,9 @@ static void bcache_device_free(struct bcache_device *d)
>  		if (disk_added)
>  			del_gendisk(disk);
>  
> -		if (disk->queue)
> -			blk_cleanup_queue(disk->queue);
> -
> +		blk_cleanup_disk(disk);
>  		ida_simple_remove(&bcache_device_idx,
>  				  first_minor_to_idx(disk->first_minor));
> -		if (disk_added)
> -			put_disk(disk);
>  	}
>  
>  	bioset_exit(&d->bio_split);
> @@ -946,7 +942,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
>  		goto err;
>  
> -	d->disk = alloc_disk(BCACHE_MINORS);
> +	d->disk = blk_alloc_disk(NUMA_NO_NODE);
>  	if (!d->disk)
>  		goto err;
>  
> @@ -955,14 +951,11 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  
>  	d->disk->major		= bcache_major;
>  	d->disk->first_minor	= idx_to_first_minor(idx);
> +	d->disk->minors		= BCACHE_MINORS;
>  	d->disk->fops		= ops;
>  	d->disk->private_data	= d;
>  
> -	q = blk_alloc_queue(NUMA_NO_NODE);
> -	if (!q)
> -		return -ENOMEM;
> -
> -	d->disk->queue			= q;
> +	q = d->disk->queue;
>  	q->limits.max_hw_sectors	= UINT_MAX;
>  	q->limits.max_sectors		= UINT_MAX;
>  	q->limits.max_segment_size	= UINT_MAX;
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
