Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0C3CD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 18:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9U54RUAdkZyZ07sY4j66HIyeAc7HfOdJglXCmF2TRzg=; b=pqbxsv8kpsL4o4oIdTmPSHBwIw
	FtswzLFadlp+V4nmewcdoprPgB8w7/p9thOQw9RtxXQmnOdgM63QOzFOs1ESM2siEcDvB87SVeUWr
	jCiFrQ8gsHr9Z5HI/1C9t5LaIUJir8VV95F1flD5hqG4IgBoUKPlM9CYBpiWqwZHNx0XMC0FCFeKZ
	xNtPB4UM36V6q9PSSLT5Sdh00UfR7T9nSupETV2L9SJzh0+TG6pFycaYI2fCpRTlRQhtTyMkQZKhO
	ou1USho7dMI4uaFYaTwY0pOW7SsfjA2nBh+cWfrGrSCaEuTvcElWMZ3DntAYp3val6z5qnmcOaNx3
	yStIOQAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsRs5-00000003qpN-1xtK;
	Thu, 04 Apr 2024 18:31:33 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsRs2-00000003qoP-1thP
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 18:31:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V9VZ94bCjzlgTGW;
	Thu,  4 Apr 2024 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712255483; x=1714847484; bh=9U54RUAdkZyZ07sY4j66HIye
	Ac7HfOdJglXCmF2TRzg=; b=izqsw0Noej8uUBNstBrjtyH+0urCNSIw0S3CK18n
	WBmYIdk43WSKrLOY4KYgxGqu/kfQAQcCK4OnyzhT2D/pKJ7mi9J8JrYZzWl3mH2f
	eVK/aWiYUHyjx+8Mzm/V5OvxrajFu6S8jD8I05cBM9dWryHEiUiX8Ft7TbVXizzU
	0G29GahTVaquUzqsvCCLS2tH5uPrtDIYY2zFRHrqZF5A0DS0UndVS3NZftFIPup4
	/VBJjdHcNcQ4bL7NmvM7LYiBIVc+HHRQirm1qASzNrRoxTsiABe1AapuU4hLy4r2
	2+BpDpOSIQtbfx27rTejCdfz/hXCraYjKr6v1MfXKlJHfw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vAwPbDjo4E8x; Thu,  4 Apr 2024 18:31:23 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V9VZ073Q0zlgTHp;
	Thu,  4 Apr 2024 18:31:20 +0000 (UTC)
Message-ID: <c3bbe9ac-690c-43a7-bc75-3634af5cfe7a@acm.org>
Date: Thu, 4 Apr 2024 11:31:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/28] block: Introduce zone write plugging
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240403084247.856481-1-dlemoal@kernel.org>
 <20240403084247.856481-8-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240403084247.856481-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_113130_597878_C4E35A06 
X-CRM114-Status: GOOD (  27.77  )
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

On 4/3/24 01:42, Damien Le Moal wrote:
> diff --git a/block/bio.c b/block/bio.c
> index d24420ed1c4c..127c06443bca 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1576,6 +1576,12 @@ void bio_endio(struct bio *bio)
>   	if (!bio_integrity_endio(bio))
>   		return;
>   
> +	/*
> +	 * For write BIOs to zoned devices, signal the completion of the BIO so
> +	 * that the next write BIO can be submitted by zone write plugging.
> +	 */
> +	blk_zone_write_bio_endio(bio);
> +
>   	rq_qos_done_bio(bio);

The function name "blk_zone_write_bio_endio()" is misleading since that
function is called for all bio operation types and not only for zoned
write bios. How about renaming blk_zone_write_bio_endio() into 
blk_zone_bio_endio()? If that function is renamed the above comment is
no longer necessary in bio_endio() and can be moved to above the
blk_zone_bio_endio() definition.

> @@ -1003,6 +1007,13 @@ static enum bio_merge_status bio_attempt_front_merge(struct request *req,
> +	/*
> +	 * A front merge for zone writes can happen only if the user submitted
> +	 * writes out of order. Do not attempt this to let the write fail.
> +	 */

"zone writes" -> "zoned writes"?

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 88b541e8873f..2c6a317bef7c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -828,6 +828,8 @@ static void blk_complete_request(struct request *req)
>   		bio = next;
>   	} while (bio);
>   
> +	blk_zone_write_complete_request(req);

Same comment here as above: the function name 
blk_zone_write_complete_request() is misleading since that function is
called for all request types and not only for zoned writes. Please
rename blk_zone_write_complete_request() into
blk_zone_complete_request().

> +	/*
> +	 * If the plug has a cached request for this queue, try use it.
> +	 */

try use it -> try to use it (I know this comes from upstream code).

> +	if (blk_queue_is_zoned(q) && blk_zone_write_plug_bio(bio, nr_segs))
> +		goto queue_exit;

The order of words in the blk_zone_write_plug_bio() function name seems
unusual to me. How about renaming that function into
blk_zone_plug_write_bio()?

> +/*
> + * Zone write plug flags bits:

Zone write -> zoned write

> + *  - BLK_ZONE_WPLUG_PLUGGED: Indicate that the zone write plug is plugged,

Indicate -> Indicates

> +static bool disk_insert_zone_wplug(struct gendisk *disk,
> +				   struct blk_zone_wplug *zwplug)
> +{
> +	struct blk_zone_wplug *zwplg;
> +	unsigned long flags;
> +	unsigned int idx =
> +		hash_32(zwplug->zone_no, disk->zone_wplugs_hash_bits);
> +
> +	/*
> +	 * Add the new zone write plug to the hash table, but carefully as we
> +	 * are racing with other submission context, so we may already have a
> +	 * zone write plug for the same zone.
> +	 */
> +	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
> +	hlist_for_each_entry_rcu(zwplg, &disk->zone_wplugs_hash[idx], node) {
> +		if (zwplg->zone_no == zwplug->zone_no) {
> +			spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
> +			return false;
> +		}
> +	}
> +	hlist_add_head_rcu(&zwplug->node, &disk->zone_wplugs_hash[idx]);
> +	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
> +
> +	return true;
> +}

The above code can be made easier to read and more compact by using
guard(spinlock_irqsave)(...) instead of spin_lock_irqsave() + 
spin_unlock_irqrestore().

> +static struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
> +						  sector_t sector)
> +{
> +	unsigned int zno = disk_zone_no(disk, sector);
> +	unsigned int idx = hash_32(zno, disk->zone_wplugs_hash_bits);
> +	struct blk_zone_wplug *zwplug;
> +
> +	rcu_read_lock();
> +
> +	hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[idx], node) {
> +		if (zwplug->zone_no == zno &&
> +		    atomic_inc_not_zero(&zwplug->ref)) {
> +			rcu_read_unlock();
> +			return zwplug;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return NULL;
> +}

The above code can also be made more compact by using guard(rcu)()
instead of rcu_read_lock() + rcu_read_unlock().

> +/*
> + * Get a reference on the write plug for the zone containing @sector.
> + * If the plug does not exist, it is allocated and hashed.
> + * Return a pointer to the zone write plug with the plug spinlock held.
> + */

Holding a spinlock upon return is not my favorite approach. Has the
following alternative been considered?
- Remove the spinlock flags argument from this function and instead add
   two other arguments: prev_plug_flags and new_plug_flags.
- If a zone plug is found or allocated, copy the existing zone plug
   flags into *prev_plug_flags and set the zone plug flags that have been
   passed in new_plug_flags (logical or).
- From blk_revalidate_zone_cb(), pass 0 as the new_plug_flags argument.
- From blk_zone_wplug_handle_write, pass BLK_ZONE_WPLUG_PLUGGED as the
   new_plug_flags argument.

Thanks,

Bart.

