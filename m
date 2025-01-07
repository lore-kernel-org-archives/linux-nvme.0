Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194DAE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LPVp9E6rtAY476SAaqM3VbsKdf4h7smTI80wZewJalw=; b=1N6nq6zGDsBlIrSWAvH7ds8AJy
	v/JF2uFIbVQfY+2jPhh2eLXv7PTekOTjb6ciffBtKRZ9ReE1qn+dupWNiDfkJCsuKi6AGZM7M7zQN
	2U71eRemAJDx8vD0zS+I19Qkki/zsg00i3OGlcR2lzYDhmWT4K8SoH/H1Ot8Zex2api5FJ6Lypz/Y
	N/wZzeytCx4QPnCcivRoPorv+0QGScXsTHDq9R2VPlQ9ZC7yY2lUNzQEKoEEV0jdK8dQIR4l/csBh
	IjkKG3ErVncrZvj9q4ko6H/PWj2kxNUMjHIH77Sal6FVFXGu3WVz28N0+j7H3j6Xb40fiCIaUUN4J
	TRGYEVMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4rq-00000003uiG-1X77;
	Tue, 07 Jan 2025 08:23:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4rm-00000003uet-1lDm
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 08:23:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1282468AFE; Tue,  7 Jan 2025 09:23:07 +0100 (CET)
Date: Tue, 7 Jan 2025 09:23:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 4/8] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250107082306.GC15960@lst.de>
References: <20250107063120.1011593-1-hch@lst.de> <20250107063120.1011593-5-hch@lst.de> <Z3zXANbFk6GBZg_z@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3zXANbFk6GBZg_z@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_002310_750194_F38FBBCE 
X-CRM114-Status: GOOD (  19.25  )
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

Hi Ming,

this is a friendly reminder to reply without quoting the entire mail.
I did not find any content after scrolling half a dozend page of
full quote and gave up.

> > +	.attr		= { .name = _name, .mode = 0644 },	\
> > +	.show		= _prefix##_show,			\
> > +	.store_limit	= _prefix##_store,			\
> > +}
> > +
> >  #define QUEUE_RW_LOAD_MODULE_ENTRY(_prefix, _name)		\
> >  static struct queue_sysfs_entry _prefix##_entry = {		\
> >  	.attr		= { .name = _name, .mode = 0644 },	\
> > @@ -441,7 +422,7 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
> >  
> >  QUEUE_RW_ENTRY(queue_requests, "nr_requests");
> >  QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
> > -QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
> > +QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
> >  QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
> >  QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
> >  QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
> > @@ -457,7 +438,7 @@ QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
> >  QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
> >  QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
> >  QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
> > -QUEUE_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
> > +QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
> >  QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
> >  
> >  QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
> > @@ -477,11 +458,11 @@ QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
> >  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
> >  
> >  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
> > -QUEUE_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
> > +QUEUE_LIM_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
> >  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
> >  QUEUE_RW_ENTRY(queue_poll, "io_poll");
> >  QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
> > -QUEUE_RW_ENTRY(queue_wc, "write_cache");
> > +QUEUE_LIM_RW_ENTRY(queue_wc, "write_cache");
> >  QUEUE_RO_ENTRY(queue_fua, "fua");
> >  QUEUE_RO_ENTRY(queue_dax, "dax");
> >  QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
> > @@ -494,10 +475,10 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
> >  	.show = queue_logical_block_size_show,
> >  };
> >  
> > -QUEUE_RW_ENTRY(queue_rotational, "rotational");
> > -QUEUE_RW_ENTRY(queue_iostats, "iostats");
> > -QUEUE_RW_ENTRY(queue_add_random, "add_random");
> > -QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
> > +QUEUE_LIM_RW_ENTRY(queue_rotational, "rotational");
> > +QUEUE_LIM_RW_ENTRY(queue_iostats, "iostats");
> > +QUEUE_LIM_RW_ENTRY(queue_add_random, "add_random");
> > +QUEUE_LIM_RW_ENTRY(queue_stable_writes, "stable_writes");
> >  
> >  #ifdef CONFIG_BLK_WBT
> >  static ssize_t queue_var_store64(s64 *var, const char *page)
> > @@ -695,7 +676,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
> >  	struct request_queue *q = disk->queue;
> >  	ssize_t res;
> >  
> > -	if (!entry->store)
> > +	if (!entry->store_limit && !entry->store)
> >  		return -EIO;
> >  
> >  	/*
> > @@ -706,11 +687,24 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
> >  	if (entry->load_module)
> >  		entry->load_module(disk, page, length);
> >  
> > -	blk_mq_freeze_queue(q);
> >  	mutex_lock(&q->sysfs_lock);
> > -	res = entry->store(disk, page, length);
> > -	mutex_unlock(&q->sysfs_lock);
> > +	blk_mq_freeze_queue(q);
> 
> Order between freeze and ->sysfs_lock is changed, and it may cause new
> lockdep warning because we may freeze queue first before acquiring
> ->sysfs_lock in del_gendisk().
> 
> 
> thanks,
> Ming
---end quoted text---

