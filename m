Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03697CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9cAOI1mYtHQzG386s1BPM+lriS63xv6fZXqwy14TR0=; b=vyxhX8hGP58kHgAPZM3cSUYLD7
	4JiwGjaf4J2h0KGyrsGxiZfTuY54GOUwbxE3Ppe0nqOE+8hCrwf/DHZi+Y1PCrWHRispSyCnRfz7O
	n637lRLQERpyDyoOvp/wcHeYaxfqergKuzQKPnHT9k790p9wfwVaxQR+rRgHB/aaPy3csxiaoFpFX
	9TMsVbE1No5Yn2+fhZfIzCYGT8QiHXMiJV933fpUGT7pwdytZp+gEnn5cIEMj6UB4ZqsI4ar8C5zO
	9Cm7eNyVgelHLy/W9dNJ1fRrfnGooUhr2TIGOkh+lCsM6o7GNPSFfp3R9i6pIhdxnQ7xIM9H8gJwA
	gAu6hWtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgkR-0000000Byun-38b1;
	Tue, 02 Apr 2024 16:12:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgkO-0000000Bypz-2yma
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 16:12:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63DDF68BFE; Tue,  2 Apr 2024 18:12:13 +0200 (CEST)
Date: Tue, 2 Apr 2024 18:12:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 07/28] block: Introduce zone write plugging
Message-ID: <20240402161213.GB3527@lst.de>
References: <20240402123907.512027-1-dlemoal@kernel.org> <20240402123907.512027-8-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402123907.512027-8-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_091228_930069_9C705C89 
X-CRM114-Status: GOOD (  16.53  )
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

> +	/* We can remove zone write plugs for zones that are empty or full. */
> +	return !zwplug->wp_offset ||
> +		zwplug->wp_offset >= disk->zone_capacity;

Nit: this condition easily fits onto a single line.

> +static inline struct blk_zone_wplug *
> +disk_lookup_zone_wplug(struct gendisk *disk, sector_t sector)
> +{
> +	unsigned int zno = disk_zone_no(disk, sector);
> +	unsigned int idx = hash_32(zno, disk->zone_wplugs_hash_bits);
> +	struct blk_zone_wplug *zwplug;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[idx], node) {
> +		if (zwplug->zone_no == zno)
> +			goto unlock;
> +	}
> +	zwplug = NULL;
> +
> +unlock:
> +	rcu_read_unlock();
> +	return zwplug;
> +}

Did we lose an atomic_inc_unless_zero here?  This now just does a lookup
under RCU, but nothing to prevent the zwplug from beeing freed?

> +	/* Resize the zone write plug memory pool if needed. */
> +	if (disk->zone_wplugs_pool->min_nr != pool_size)
> +		return mempool_resize(disk->zone_wplugs_pool, pool_size);

Note that a mempool_resize to the current size work just fine.  It takes
a pointless lock, but given that this is something that doesn't happen
frequently that probably doesn't matter.

> +#include <linux/mempool.h>

> +	mempool_t		*zone_wplugs_pool;

Please use struct mempool_s here so that you only need a forward
declaration instead of pulling in another header.

