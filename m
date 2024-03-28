Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1403C54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 04:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H7qcrMbZsPO5jmA3p7euov0rN/PcsUnve31Hjy8q+sg=; b=kImqgvZq1RWdUKYgp6mET9CQBQ
	06i7ypgriEoZJWkXPsd4a2RMTZh/Y3eDH6N1Oqs5MOc6ZrDCWGZlhx2OTR12hUneMMG2j+kZ2bGoL
	QRiGr/x7oCjfqX/1jVnmSoclASlVBKzRl3nSWB0Ei9gtW3fQ0cRX7XSrDwJRGqAsRvnAzOy+PtS7A
	FiObGMDjXZo85QIohiA7AbV6tdaAcQMc0rMsSl7hLw/RlKMLeY4tLuR5ilz3IByT7vEjIpZvbuP1y
	YJOUCY+sSd4GnyAkOI6KT0SA+VXHpsQYQjYPvD+4zoM2GcbsvrThDH7FLdwLzPWGD+W1qdfFTVA/S
	pDpppf8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphPE-0000000COWj-2jaC;
	Thu, 28 Mar 2024 04:30:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphPB-0000000COW5-2Isd
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 04:30:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80AD268B05; Thu, 28 Mar 2024 05:30:16 +0100 (CET)
Date: Thu, 28 Mar 2024 05:30:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
Message-ID: <20240328043016.GA13701@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-10-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-10-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_213021_783443_A5B4BC0A 
X-CRM114-Status: GOOD (  18.76  )
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

I think this should go into the previous patch, splitting it
out just causes confusion.

> +static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
> +{
> +	struct gendisk *disk = zwplug->disk;
> +	unsigned long flags;
> +
> +	if (zwplug->flags & BLK_ZONE_WPLUG_NEEDS_FREE) {
> +		kfree(zwplug);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
> +	list_add_tail(&zwplug->link, &disk->zone_wplugs_free_list);
> +	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
> +}
> +
>  static bool disk_insert_zone_wplug(struct gendisk *disk,
>  				   struct blk_zone_wplug *zwplug)
>  {
> @@ -630,18 +665,24 @@ static struct blk_zone_wplug *disk_get_zone_wplug(struct gendisk *disk,
>  	return zwplug;
>  }
>  
> +static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
> +{
> +	struct blk_zone_wplug *zwplug =
> +		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
> +
> +	disk_free_zone_wplug(zwplug);
> +}

Please verify my idea carefully, but I think we can do without the
RCU grace period and thus the rcu_head in struct blk_zone_wplug:

When the zwplug is removed from the hash, we set the
BLK_ZONE_WPLUG_UNHASHED flag under disk->zone_wplugs_lock.  Once
caller see that flag any lookup that modifies the structure
will fail/wait.  If we then just clear BLK_ZONE_WPLUG_UNHASHED after
the final put in disk_put_zone_wplug when we know the bio list is
empty and no other state is kept (if there might be flags left
we should clear them before), it is perfectly fine for the
zwplug to get reused for another zone at this point.

