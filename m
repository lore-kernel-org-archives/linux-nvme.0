Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D4ECCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 06:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJwP3EFKtGLfyCl6claJfBrvvbJ8eQwcaQby7zXlNwU=; b=EUchsVURAXXwBCFRhygPzMkDh+
	2SyQEld+om2QqQt3AZ5LOH9CnAYk5XrrRBX3RTIY18JBshxn/PZ4ntZaAnw8ebrmb5vUQU+IJNC3t
	kDt63mJgu9PuWEJn4BLcRA3fdD4IHUgS/IPMR3hSw/R+ymrhBZZ+NcmiW453GbInKVR3HWAmDP6xB
	o3xWq/I5JwY5mvxRoSJu4LfBm5sq7JLVM6+/UJlenc4yBoZW15h6yDqBKGMAfaO9HDmS+IEt2/0tt
	im+XJyrOsTApLjyjdq8QG463XmQ/bZ4Tyd9RYwPZ0dDgQrdxTjK09Iw4O3/2lGw/blh6dB7IklW4l
	0SbyzrLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnh3-00000009GfV-0iea;
	Mon, 03 Nov 2025 06:05:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnh1-00000009GfP-2Ks2
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 06:05:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8888A601A6;
	Mon,  3 Nov 2025 06:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A5CC4CEE7;
	Mon,  3 Nov 2025 06:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149926;
	bh=nWA8qJYrPGGOaVXd+KfXLqzdVcWq+LCTObq2L0yNLPM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QIiFTEcx51FVNJKpbXtL1eDcqXXbYaxsHDUrIsqQzMTz6V8pP9IsaJnIawZoSyGbS
	 75v6GWjQJ2duN2QVDdw3y4Cw9lImt4Sb/glPO8VdNIlcjCiUVW79X9+C2zNZ0VAGlW
	 XRynqC2H+Maxg1XFUX/ZP32yN4FKTBP/5r4+EpIDLw2XON37n7Pqi8HjK95+7ecxRd
	 y3lYk4wzYtLAzBEJEfPjn0ogID4UVyGri7IgHs3NPh9rqfQK5Z9P4PKrmbHXM/aZuF
	 j2RPquxU46JqgCpBu1OuVBY0mxgVUN/ZaHq01UG5MTV81VLo0UHo2MqjFjv29o3QUl
	 FXSVi0qroaFYA==
Message-ID: <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
Date: Mon, 3 Nov 2025 15:05:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
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

On 11/1/25 06:17, Bart Van Assche wrote:
> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>> Implement tracking of the runtime changes to zone conditions using
>> the new cond field in struct blk_zone_wplug. The size of this structure
>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>> end of the structure. For zones that do not have a zone write plug, the
>> zones_cond array of a disk is used to track changes to zone conditions,
>> e.g. when a zone reset, reset all or finish operation is executed.
> 
> Why is it necessary to track the condition of sequential zones that do
> not have a zone write plug? Please explain what the use cases are.

Because zones that do not have a zone write plug can be empty OR full.

> 
> The zoned UFS device on my desk has 3420 sequential zones and zero
> conventional zones. If the condition of zones that do not have a zone
> write plug wouldn't be tracked that would save some memory.

That would really be "some"... Not a lot. Your memory usage will be less than a
mem page...

>> +static void blk_zone_set_cond(u8 *zones_cond, unsigned int zno,
>> +			      enum blk_zone_cond cond)
>> +{
>> +	if (!zones_cond)
>> +		return;
>> +
>> +	switch (cond) {
>> +	case BLK_ZONE_COND_IMP_OPEN:
>> +	case BLK_ZONE_COND_EXP_OPEN:
>> +	case BLK_ZONE_COND_CLOSED:
>> +		zones_cond[zno] = BLK_ZONE_COND_ACTIVE;
>> +		return;
>> +	case BLK_ZONE_COND_NOT_WP:
>> +	case BLK_ZONE_COND_EMPTY:
>> +	case BLK_ZONE_COND_FULL:
>> +	case BLK_ZONE_COND_OFFLINE:
>> +	case BLK_ZONE_COND_READONLY:
>> +	default:
>> +		zones_cond[zno] = cond;
>> +		return;
>> +	}
>> +}
>> +
>> +static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
>> +			       enum blk_zone_cond cond)
>> +{
>> +	u8 *zones_cond;
>> +
>> +	rcu_read_lock();
>> +	zones_cond = rcu_dereference(disk->zones_cond);
>> +	if (zones_cond) {
>> +		unsigned int zno = disk_zone_no(disk, sector);
>> +
>> +		/*
>> +		 * The condition of a conventional, readonly and offline zones
>> +		 * never changes, so do nothing if the target zone is in one of
>> +		 * these conditions.
>> +		 */
>> +		switch (zones_cond[zno]) {
>> +		case BLK_ZONE_COND_NOT_WP:
>> +		case BLK_ZONE_COND_READONLY:
>> +		case BLK_ZONE_COND_OFFLINE:
>> +			break;
>> +		default:
>> +			blk_zone_set_cond(zones_cond, zno, cond);
>> +			break;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +}
> 
> Why does blk_zone_set_cond() accept a zone number as second argument and
> why does disk_zone_set_cond() accept a sector number as second argument?
> The callers of disk_zone_set_cond() can be optimized if its second
> argument would be changed from a sector number into a zone number.

How so ? all the callers have a BIO sector or a zone start sector on hand, not a
zone number. On the other hand, blk_zone_set_cond() is always used in places
where the zone number is already available.

So this calling convention makes sense to me as it is.

-- 
Damien Le Moal
Western Digital Research

