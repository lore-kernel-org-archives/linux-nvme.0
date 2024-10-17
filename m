Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46A5D1AD36
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HpQwYu6pvnexC4JbqbWhaiC9BUl8z4UgrL56wNne8Ko=; b=wNmQ1qtPLYzD6S0BEln+1/JUG9
	hLQJkDHx3+mEuwjMiSmujqJDuFrgRTvH+i83PWGd2jvN1gJabfR8sC/xlQAcx9VZGUerAzzg/9sRo
	t5sJW5BQh0Yyqx/Uqi8V4PGOVFCH3YQhr1KtB6rTewLqyFTq307iyk/5sOORbw4e22HK1QnTRE9Sx
	zY1jIVrFfDVLSY5kHZ2v21jGxRS/6WYh+MLKc5jIwcpJk33Ewc4akSC4r1Lwk3SVEklqAOS43TODJ
	ELLoRDZj9M6QBllBZ0U9yLOGqMqpkhT4MBnUuBDGunOJkpGo8B5cs9ANBb7uH5JpVdw4GTCnmSXqG
	ShoUWPlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lol-0000000EAnv-14oV;
	Thu, 17 Oct 2024 08:25:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lo2-0000000EAhw-1OYn
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:24:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A0E75227A8E; Thu, 17 Oct 2024 10:24:22 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:24:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 09/11] block: add support to pass user meta buffer
Message-ID: <20241017082422.GB28355@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113752epcas5p4c365819fce1e5d498fd781ae2b309341@epcas5p4.samsung.com> <20241016112912.63542-10-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-10-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_012426_576063_C11F4DFC 
X-CRM114-Status: GOOD (  19.88  )
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

On Wed, Oct 16, 2024 at 04:59:10PM +0530, Anuj Gupta wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> If an iocb contains metadata, extract that and prepare the bip.
> Based on flags specified by the user, set corresponding guard/app/ref
> tags to be checked in bip.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  block/bio-integrity.c         | 51 +++++++++++++++++++++++++++++++++++
>  block/fops.c                  | 44 +++++++++++++++++++++++-------
>  include/linux/bio-integrity.h |  7 +++++
>  3 files changed, 93 insertions(+), 9 deletions(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index d3c8b56d3fe6..24fad9b6f3ec 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -12,6 +12,7 @@
>  #include <linux/bio.h>
>  #include <linux/workqueue.h>
>  #include <linux/slab.h>
> +#include <uapi/linux/blkdev.h>
>  #include "blk.h"
>  
>  static struct kmem_cache *bip_slab;
> @@ -303,6 +304,55 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
>  	return nr_bvecs;
>  }
>  
> +static void bio_uio_meta_to_bip(struct bio *bio, struct uio_meta *meta)
> +{
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +	if (meta->flags & BLK_INTEGRITY_CHK_GUARD)
> +		bip->bip_flags |= BIP_CHECK_GUARD;
> +	if (meta->flags & BLK_INTEGRITY_CHK_APPTAG)
> +		bip->bip_flags |= BIP_CHECK_APPTAG;
> +	if (meta->flags & BLK_INTEGRITY_CHK_REFTAG)
> +		bip->bip_flags |= BIP_CHECK_REFTAG;
> +
> +	bip->app_tag = meta->app_tag;
> +}
> +
> +int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)

Just noticed this when looking at the seed situation:  Can you please
move bio_integrity_map_iter below bio_integrity_map_user as it is
a relatively thing wrapper for it? 


