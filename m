Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9996BCCFA02
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dGFrbsqJ8CKkjY9qga1d96f2nx443JSUVFFvLuMecYs=; b=zHuGE2FkFk1T4J+Tf0FoxtHZ3z
	kwCYPe1XBeQeBZWysxkwI5Fizgz4DNo2TkZvvaZb0fIyi7UF2oj/H4vIHB/iAKoDq438AgfgGQdda
	nVBCDRx9AbB6KVTRU/JkGc1I8T8BBx/A6/KRXYI2B4EjSv9UkazPdIDQec9vxnh1yHyQyadUfykhe
	tCNmCAg8/f1+hzlmjuVgMRjN9mVl0XQc0mN5EjdgKqLf47mvahfjpAog9ChXqWjv5FDcjsJ8lucna
	qSAJpQC+bEfa3gbNjbTJzkH9rCFS0uGon6T9z9cymOfDvGnuK+LTeGRvBFPKOukZ1FbyInpiH2itg
	+eSOerVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEwVj-00000006oik-09dc;
	Fri, 31 Oct 2025 21:18:15 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEwVg-00000006oiK-1XCw
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 21:18:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cyv371rCVzlgqVY;
	Fri, 31 Oct 2025 21:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761945488; x=1764537489; bh=dGFrbsqJ8CKkjY9qga1d96f2
	nx443JSUVFFvLuMecYs=; b=MOiAucOtLaQV5ydR0jMixm2/LO5HKwhCk725AoCq
	kP5jZzcKz9VStvYIXn8A/uppBX7GevrouJXU2OudQtlRy8cZqEuEJRkEKiOmwQ+g
	e4ok5VRdxSfWBu6bJ+UnFaYCKKm7k/mwJC5gg5iwBdVLqnF0h06E4F1Qkw8kp2Hs
	mDWTRMt9ttsGlDL9Hk3V2VFZCT+yiLkmjUCI6TYbT5qmArNtW0y2SGqTjVCyKe8v
	EXZbvV2lwww8UCNufxlCKGXZwThSDpreQ/Gu+PQK2D1mi+hc04iSYLz/MI5i4k9h
	pFG/hWVlWs/phvYJXwwE4jHtxycyc7diQkKBMmExZGRl2A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Zfkrr6N_4YYx; Fri, 31 Oct 2025 21:18:08 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cyv2t1Hg1zlstRG;
	Fri, 31 Oct 2025 21:17:56 +0000 (UTC)
Message-ID: <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
Date: Fri, 31 Oct 2025 14:17:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_141812_492914_4A29EF6E 
X-CRM114-Status: GOOD (  16.42  )
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

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> Implement tracking of the runtime changes to zone conditions using
> the new cond field in struct blk_zone_wplug. The size of this structure
> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
> end of the structure. For zones that do not have a zone write plug, the
> zones_cond array of a disk is used to track changes to zone conditions,
> e.g. when a zone reset, reset all or finish operation is executed.

Why is it necessary to track the condition of sequential zones that do
not have a zone write plug? Please explain what the use cases are.

The zoned UFS device on my desk has 3420 sequential zones and zero
conventional zones. If the condition of zones that do not have a zone
write plug wouldn't be tracked that would save some memory.
> +static void blk_zone_set_cond(u8 *zones_cond, unsigned int zno,
> +			      enum blk_zone_cond cond)
> +{
> +	if (!zones_cond)
> +		return;
> +
> +	switch (cond) {
> +	case BLK_ZONE_COND_IMP_OPEN:
> +	case BLK_ZONE_COND_EXP_OPEN:
> +	case BLK_ZONE_COND_CLOSED:
> +		zones_cond[zno] = BLK_ZONE_COND_ACTIVE;
> +		return;
> +	case BLK_ZONE_COND_NOT_WP:
> +	case BLK_ZONE_COND_EMPTY:
> +	case BLK_ZONE_COND_FULL:
> +	case BLK_ZONE_COND_OFFLINE:
> +	case BLK_ZONE_COND_READONLY:
> +	default:
> +		zones_cond[zno] = cond;
> +		return;
> +	}
> +}
> +
> +static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
> +			       enum blk_zone_cond cond)
> +{
> +	u8 *zones_cond;
> +
> +	rcu_read_lock();
> +	zones_cond = rcu_dereference(disk->zones_cond);
> +	if (zones_cond) {
> +		unsigned int zno = disk_zone_no(disk, sector);
> +
> +		/*
> +		 * The condition of a conventional, readonly and offline zones
> +		 * never changes, so do nothing if the target zone is in one of
> +		 * these conditions.
> +		 */
> +		switch (zones_cond[zno]) {
> +		case BLK_ZONE_COND_NOT_WP:
> +		case BLK_ZONE_COND_READONLY:
> +		case BLK_ZONE_COND_OFFLINE:
> +			break;
> +		default:
> +			blk_zone_set_cond(zones_cond, zno, cond);
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +}

Why does blk_zone_set_cond() accept a zone number as second argument and
why does disk_zone_set_cond() accept a sector number as second argument?
The callers of disk_zone_set_cond() can be optimized if its second
argument would be changed from a sector number into a zone number.

Thanks,

Bart.

