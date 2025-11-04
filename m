Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFE6CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O3l1MxQaDwEKoq0PoBALoyKOWwHm9r/hEUgACEUi8s8=; b=NujhPCI3XT4uiRkutOf9DF20lh
	vR8vYH/UUwkp7MtXQVd5zQbXhRyrvNs3hRoJCjcSJACHD7usdXiM4rqXFVHNpQQneMGBVFT2FCdJK
	dXgsz9Hc79LgG5i6w320t2sFFd3OTLXkTM8LCK2bAMrBoQ+UVBVdvalFXx9r/VZVgIjSchHfP3BDi
	jrYWltY9pbZiRkb5Xo+aWLNkQKJik41qr4dmyHO06C0Jl+9XV9JwcmoYw+ajYQmvMTeBPcwFUABjC
	AEU5DjCxCe0RL/k7ECA85OofbLFuJ0awkjHT/Hh4R9CuqSjRe5JEf07VwilNcuKicUxa10GxzUxzo
	iNCDCPXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGO8D-0000000CZso-2xud;
	Tue, 04 Nov 2025 20:59:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGO8C-0000000CZsb-0WHy
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 20:59:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 29A08601EF;
	Tue,  4 Nov 2025 20:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA585C116B1;
	Tue,  4 Nov 2025 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762289994;
	bh=ZbevVTsyzkuKwdQrJJOdeX7YrKTFidZKoeeACl1fcI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aHU1/+NxHTGcstCciKvN0HOtfqbZvcKPFHaJAIxHidNwzrAUH57pju/VvROjFT57e
	 9rImaFQb4z8LuzRklIxZLJF2VrGAH+JLi7zsSFkq1D6Np4PjBtNYScd1PR0ri1TAtO
	 C8/TJ5vEMM3KUaF2iZ2FJtiFVDHMxidEJ0H/ZcmFov1S5b28kv2BMp+H+YUgVLxQEb
	 fODPu/xN0+jxDzu5/ZHF6J2R+epjSqAVdQcC4nlJyvr175SaM5q8EYEdPQE5eXwQUE
	 yVevNDW2NW1iLpxmhZ7XasSauPf7KOKeLRcqsgrgXv3zRMqhAJjr+vy5jphrmBIYO6
	 gnqNNZ4ccEsBQ==
Message-ID: <9f899cd8-7187-4878-b294-337d964c9587@kernel.org>
Date: Wed, 5 Nov 2025 05:59:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Introduce cached report zones
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104144158.GA27416@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251104144158.GA27416@lst.de>
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

On 11/4/25 23:41, Christoph Hellwig wrote:
> I just threw this into my xfstests setup, and it seems this version
> is broken somehow.  Running on emulated ZNS devices with XFS I get
> a lot of failures with warnings like this:
> 
> [   30.068652] XFS (nvme1n1): empty zone 1 has non-zero used counter (0x1).
> 
> [   49.316873] XFS (nvme0n1): empty zone 2 has non-zero used counter (0x10).
> 
> so it seems like it's not tracking WPs correctly, probably when using
> zone append and unmount/remounting.

Aouch ! I totally missed that !

First problem, trivial, I am missing this in the xfs patch:

diff --git a/fs/xfs/libxfs/xfs_zones.c b/fs/xfs/libxfs/xfs_zones.c
index b0791a71931c..b40f71f878b5 100644
--- a/fs/xfs/libxfs/xfs_zones.c
+++ b/fs/xfs/libxfs/xfs_zones.c
@@ -95,6 +95,7 @@ xfs_zone_validate_seq(
        case BLK_ZONE_COND_IMP_OPEN:
        case BLK_ZONE_COND_EXP_OPEN:
        case BLK_ZONE_COND_CLOSED:
+       case BLK_ZONE_COND_ACTIVE:
                return xfs_zone_validate_wp(zone, rtg, write_pointer);
        case BLK_ZONE_COND_FULL:
                return xfs_zone_validate_full(zone, rtg, write_pointer);

Second problem is a little more subtle: when disk_insert_zone_wplug() is called
from blk_revalidate_disk_zones() callback for a non empty zone, the zone
condition is set to BLK_ZONE_COND_NOT_WP if we do not have a disk zones_cond
array. But we never have that on the first call to blk_revalidate_disk_zones()
since that function sets it at the end of the revalidation. So we need this
change to also avoid mount errors after a reboot for an FS with partially
written zones:

 diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bf6495f0d49f..bba64b427082 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -527,12 +527,20 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
                        return false;
                }
        }
+
+       /*
+        * Set the zone condition: if we do not yet have a zones_cond array
+        * attached to the disk, then this is a zone write plug insert from the
+        * first call to blk_revalidate_disk_zones(), in which case the zone is
+        * necessarilly in the active condition.
+        */
        zones_cond = rcu_dereference_check(disk->zones_cond,
                                lockdep_is_held(&disk->zone_wplugs_lock));
        if (zones_cond)
                zwplug->cond = zones_cond[zwplug->zone_no];
        else
-               zwplug->cond = BLK_ZONE_COND_NOT_WP;
+               zwplug->cond = BLK_ZONE_COND_ACTIVE;
+
        hlist_add_head_rcu(&zwplug->node, &disk->zone_wplugs_hash[idx]);
        atomic_inc(&disk->nr_zone_wplugs);
        spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);

I will integrate these fixes in v5 and resend.




-- 
Damien Le Moal
Western Digital Research

