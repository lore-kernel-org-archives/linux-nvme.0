Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6715BC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 20:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZviQqgVcq2tRc3p4TWEA+VfgMFTGON5OotgVwwOHF4=; b=mfdy6JhqlvxIf0qMLV4txAt6ju
	XLJk+F0a/RJNlDGBV5OsTRK/6u0wXldwWXRBHNcu1d4zCd1+bHIEAbHa0MC+QtrqnRCc3TuEwoNW8
	DblN169V1x94Ojb3KlxOJCCbVUcBUW265KGeJlYsEoWycnai0mGQn6ZT1Ez2HG8kb0bBsO0JC0G1u
	vacrDpFHQWcYRhY6sPa5HZP3CEaBMS/pT3kbNA77vo/DWCl9rBWfto9AbHXCKq2XkAPTuRBnz7a9m
	BsFKvhf0UokSGogJQxzAdxeoOuN2/mHEpI0Lb9vbp5wPxRjXTKUxcn4Lz4pTk8PD0xt23crmPP3zg
	4M5iJV6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSNY9-000Pr7-0Z;
	Tue, 23 Jan 2024 20:39:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSNY5-000Pq5-2d
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 20:39:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706042349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZviQqgVcq2tRc3p4TWEA+VfgMFTGON5OotgVwwOHF4=;
	b=CbXrdpmFs4TQUIcF32wb5YWwaS69sqlpZHge0Qe7wOHEPV1GHX3gufTw2+LZwyouVJrnso
	UefbgKNL2TYjr2HKHCcBWl2Gzy+WV9cyHimFPhmhMdNoWXtRLmRxJwd/k4+5Fbpsu4Ps+u
	5e1VEVCRLKdrVzyAqATz0WyQdqxL3ZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-4b7BRzuFOe-EJjmvnNvwOg-1; Tue, 23 Jan 2024 15:39:04 -0500
X-MC-Unique: 4b7BRzuFOe-EJjmvnNvwOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 088278828C2;
	Tue, 23 Jan 2024 20:39:03 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC2462026D66;
	Tue, 23 Jan 2024 20:39:02 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id D9D7030A79CB; Tue, 23 Jan 2024 20:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id D72613FB4E;
	Tue, 23 Jan 2024 21:39:02 +0100 (CET)
Date: Tue, 23 Jan 2024 21:39:02 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
cc: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
    Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
    David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
    Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
    linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, 
    linux-nvme@lists.infradead.org, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
In-Reply-To: <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
Message-ID: <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com> <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_123909_925189_B4680CC9 
X-CRM114-Status: GOOD (  21.31  )
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



On Tue, 23 Jan 2024, Johannes Thumshirn wrote:

> Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
> zonefs_zone_mgmt().
> 
> As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
> from a place that can recurse back into the filesystem on memory reclaim,
> it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 93971742613a..63fbac018c04 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
>  
>  	trace_zonefs_zone_mgmt(sb, z, op);
>  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
> -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
> +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
>  	if (ret) {
>  		zonefs_err(sb,
>  			   "Zone management operation %s at %llu failed %d\n",
> 
> -- 
> 2.43.0

zonefs_inode_zone_mgmt calls 
lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex); - so, this 
function is called with the mutex held - could it happen that the 
GFP_KERNEL allocation recurses into the filesystem and attempts to take 
i_truncate_mutex as well?

i.e. GFP_KERNEL -> iomap_do_writepage -> zonefs_write_map_blocks -> 
zonefs_write_iomap_begin -> mutex_lock(&zi->i_truncate_mutex)

Mikulas


