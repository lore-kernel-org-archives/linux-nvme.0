Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86408C021B8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEh+agfphvQ5/XpjnYt8nu+nU57I3fj38+iFh610c0I=; b=BtCE+8CdspLMZnivVJYRvdN2Jj
	CSmt9vlZIF0fX0rnyDOgIn8Vaf47jg/ER5XgR7FLXdSfAYFZtSzK7HVeOa8YjefLiwFRLj/6Nce5A
	x+0kYFn5mqQ1w45Frcf5xWGM64VTkI8znAQlOjENfi/POgl9R++ptVdjq7NMyuqy7/tzIsj8qkrG5
	04A8vaDBKSHPNu8sLTiC7JLropY3cH6NicbbchIIeAZqTPEe98hofMWEZzUlTD8+0JanNpRoQ7EOX
	4Wm/8cTiRG/2/4JrQFVGmPy+tKUTHsBW8LwB7dQV2MymbrekiQ9sg8GsBO8C2uQB/Cf7Q525KJ0+e
	QnWH7y6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmy1B-00000000LkS-0zqX;
	Tue, 25 Feb 2025 16:42:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmwW1-000000001Hc-05tt
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 15:06:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 15B3268D07; Tue, 25 Feb 2025 16:06:27 +0100 (CET)
Date: Tue, 25 Feb 2025 16:06:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, anuj1072538@gmail.com,
	nikh1092@linux.ibm.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	dm-devel@lists.linux.dev, M Nikhil <nikhilm@linux.ibm.com>
Subject: Re: [PATCH v1 1/3] block: Fix incorrect integrity sysfs reporting
 for DM devices
Message-ID: <20250225150626.GA6099@lst.de>
References: <20250225044653.6867-1-anuj20.g@samsung.com> <CGME20250225045514epcas5p10d06ab361a4125a94933fa8235fe3fa8@epcas5p1.samsung.com> <20250225044653.6867-2-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225044653.6867-2-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_070633_200209_E1A1FDF3 
X-CRM114-Status: GOOD (  26.07  )
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

On Tue, Feb 25, 2025 at 10:16:51AM +0530, Anuj Gupta wrote:
> The integrity stacking logic in device-mapper currently does not
> explicitly mark the device with BLK_INTEGRITY_NOGENERATE and
> BLK_INTEGRITY_NOVERIFY when the underlying device(s) do not support
> integrity. This can lead to incorrect sysfs reporting of integrity
> attributes.
> 
> Additionally, queue_limits_stack_integrity() incorrectly sets
> BLK_INTEGRITY_DEVICE_CAPABLE for a DM device even when none of its
> underlying devices support integrity. This happens because the flag is
> blindly inherited from the first base device, even if it lacks integrity
> support.
> 
> This patch ensures:
> 1. BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY are set correctly:
>    - When the underlying device does not support integrity.
>    - When integrity stacking fails due to incompatible profiles.
> 2. device_is_integrity_capable is correctly propagated to reflect the
> actual capability of the stacked device.
> 
> Reported-by: M Nikhil <nikhilm@linux.ibm.com>
> Link: https://lore.kernel.org/linux-block/f6130475-3ccd-45d2-abde-3ccceada0f0a@linux.ibm.com/
> Fixes: c6e56cf6b2e7 ("block: move integrity information into queue_limits")
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/blk-settings.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c44dadc35e1e..c32517c8bc2e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -861,7 +861,8 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
>  
>  	if (!ti->tuple_size) {
>  		/* inherit the settings from the first underlying device */
> -		if (!(ti->flags & BLK_INTEGRITY_STACKED)) {
> +		if (!(ti->flags & BLK_INTEGRITY_STACKED) &&
> +		    (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)) {
>  			ti->flags = BLK_INTEGRITY_DEVICE_CAPABLE |
>  				(bi->flags & BLK_INTEGRITY_REF_TAG);
>  			ti->csum_type = bi->csum_type;

Hmm.  I wonder if this is the correct logic.  Basically we do not want to
allow mixing integrity capable and not integrity devices, do we?

So maybe the logic should be more something like:

	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
		return true;

	if (ti->flags & BLK_INTEGRITY_STACKED) {
		/* check blk_integrity compatibility */
	} else {
		ti->flags = BLK_INTEGRITY_STACKED;
		/* inherit blk_integrity, including the empty one  */
	}


