Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F616C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 23:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYacebUnv+qVfwFBaCCck/Am3I4UN5z5dk1Geqs0ZPM=; b=veOnXePNMY7cBCod3E27PTQQ15
	PUzY9/Vf4/MxdB6PBPGwCkw3mVkEMvPKz2a/HFuL7G/r+pmAh1zU4DfrTWfxjIFwMvMCA/Cl4f6/r
	ncrPu83orkDLr90275bgQ9Wqo3JEKpYbQmCW1THj5Rx2kXOjDnszdIfWedfdpg78WgIhrDYBpuaEP
	+yk3m7Q6oy6bJYJWNdq16NAYSx1n76DEaEQFJNRo/hVQ5FB5/trSqLRkQWVJl+HehcV9F2tEzN6TO
	MKbO7TLGjFaN0cUNQC57idkOodgPLQoMHw94mxSTOwWU1KCHAZqTVUuRfsqXf+Rt9lY5J3XGxLYtF
	9XT0meuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSQEe-000pZ9-2J;
	Tue, 23 Jan 2024 23:31:16 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSQEb-000pY7-2Z
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 23:31:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A6472CE307E;
	Tue, 23 Jan 2024 23:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F9C433C7;
	Tue, 23 Jan 2024 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706052670;
	bh=5IKCI89izY9q7OnAbvvB4vyI9VWaIqEYhVeW69cwKBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=msTHDUvykvzFCBJnKtqkfMnJkhCV4e1CWKyluOEIj1Qy17EJpTXSHTeb5+mROq8wc
	 RQhoZ8shAfLx5k88DQXJX8bx/UFxML65CH+qDuFsfun+R0Tkz3P7qY1d2LtdEdF7cK
	 +VfPtaqJG4NgOMJiwMlU+9wqG4FVcDhKNvh5WzwN6DWM+BH7uFAjWOWs+jxAaysQb6
	 mtP+GPGpeeLUVX/oW0VjbXqKyXEWl0r+yZ9Fiq7ozko2SMkoqocAjhpq6zfnKDyqqY
	 oFeXFGIDddZpbotoXXZxw/1sKXOG8gM5jeAjiedV5py8EDl4olJY48Vy/4O2c1b0OR
	 FpL2Ka9boi3Rw==
Message-ID: <a08be89b-6825-4559-a909-632f9571d387@kernel.org>
Date: Wed, 24 Jan 2024 08:31:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@lists.linux.dev, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
 <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
 <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>
 <ZbBKC3U3/1yPvWDR@dread.disaster.area>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZbBKC3U3/1yPvWDR@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_153114_207025_9B061902 
X-CRM114-Status: GOOD (  17.67  )
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

On 1/24/24 08:21, Dave Chinner wrote:
> On Tue, Jan 23, 2024 at 09:39:02PM +0100, Mikulas Patocka wrote:
>>
>>
>> On Tue, 23 Jan 2024, Johannes Thumshirn wrote:
>>
>>> Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
>>> zonefs_zone_mgmt().
>>>
>>> As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
>>> from a place that can recurse back into the filesystem on memory reclaim,
>>> it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>  fs/zonefs/super.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>>> index 93971742613a..63fbac018c04 100644
>>> --- a/fs/zonefs/super.c
>>> +++ b/fs/zonefs/super.c
>>> @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
>>>  
>>>  	trace_zonefs_zone_mgmt(sb, z, op);
>>>  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
>>> -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
>>> +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
>>>  	if (ret) {
>>>  		zonefs_err(sb,
>>>  			   "Zone management operation %s at %llu failed %d\n",
>>>
>>> -- 
>>> 2.43.0
>>
>> zonefs_inode_zone_mgmt calls 
>> lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex); - so, this 
>> function is called with the mutex held - could it happen that the 
>> GFP_KERNEL allocation recurses into the filesystem and attempts to take 
>> i_truncate_mutex as well?
>>
>> i.e. GFP_KERNEL -> iomap_do_writepage -> zonefs_write_map_blocks -> 
>> zonefs_write_iomap_begin -> mutex_lock(&zi->i_truncate_mutex)
> 
> zonefs doesn't have a ->writepage method, so writeback can't be
> called from memory reclaim like this.

And also, buffered writes are allowed only for conventional zone files, for
which we never do zone management. For sequential zone files which may have
there zone managed with blkdev_zone_mgmt(), only direct writes are allowed.

> 
> -Dave.

-- 
Damien Le Moal
Western Digital Research


