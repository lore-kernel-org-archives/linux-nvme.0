Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEBCC7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+NXFD7tK19U/km1dvM1TqrNDaxi8TnBZKN3pwKYh7bg=; b=qsNZmYcXd5Y8D4xqLfhun6Qboh
	9Dc5rTsPU2z1edTIuoteeufmM7YJj7xqpaNbdfGn0vH9QEmf3Q5VzDQlV3JJL7IiNtBIiizTMKNva
	iHwqyFdnSzGZa177arvW8rpLWEcRYw/lQsR7eosChQW3HCa/CmXP2Ja9kE8rZnxguvMhI5rXnmukm
	ID95tk9c4opY7a1MIbQ/jkomfFKDI8AtjqqD+Di4o1im5EtImda1jCXUZhuDSGxx1Ok/KCZgkX/A6
	WB0YF+g0gm0mbKymbjC4NuSrxaJYDF0plCbcAW3jF5fi5kWaA2ApecZfqRV1Uwiu3q1wCARLWRuJz
	0gXR/h2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sHo-005txY-0u;
	Wed, 07 Jun 2023 12:29:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sHl-005tvm-13;
	Wed, 07 Jun 2023 12:29:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B91C219E0;
	Wed,  7 Jun 2023 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686140947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NXFD7tK19U/km1dvM1TqrNDaxi8TnBZKN3pwKYh7bg=;
	b=D+bVusfixROdFRhZj7Gm32vf6nTWDMSSzJfTRi50B/2LNNRitehn0JGhZsGotTAyYt87Bx
	NWYyvr9Ov4qnxE9QA80piLbIwqsP6xLCWfFFOEfdtYTV7w8CCMXeEmox8sfL1yHMjHzwBw
	89mLO0+2N8iDZa/tZ7q2dCVCM1RS6Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686140947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NXFD7tK19U/km1dvM1TqrNDaxi8TnBZKN3pwKYh7bg=;
	b=kIiNhRufIqKqREi/FFsC6HuCVpqDds10Ql5+QSsqZIqvjGBGRBJM3qVyYeDSJ+qeyfv1Ec
	jELBtRQvTWOS0fCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 520DB13776;
	Wed,  7 Jun 2023 12:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cBHGEhN4gGTwRQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:29:07 +0000
Message-ID: <a17bacdb-3fa2-3b81-8852-efc06f788885@suse.de>
Date: Wed, 7 Jun 2023 14:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 16/31] block: use the holder as indication for exclusive
 opens
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-um@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-17-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_052909_515018_0B6AB774 
X-CRM114-Status: GOOD (  16.76  )
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

On 6/6/23 09:39, Christoph Hellwig wrote:
> The current interface for exclusive opens is rather confusing as it
> requires both the FMODE_EXCL flag and a holder.  Remove the need to pass
> FMODE_EXCL and just key off the exclusive open off a non-NULL holder.
> 
> For blkdev_put this requires adding the holder argument, which provides
> better debug checking that only the holder actually releases the hold,
> but at the same time allows removing the now superfluous mode argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bdev.c                        | 37 ++++++++++++++++------------
>   block/fops.c                        |  6 +++--
>   block/genhd.c                       |  5 ++--
>   block/ioctl.c                       |  5 ++--
>   drivers/block/drbd/drbd_nl.c        | 23 ++++++++++-------
>   drivers/block/pktcdvd.c             | 13 +++++-----
>   drivers/block/rnbd/rnbd-srv.c       |  4 +--
>   drivers/block/xen-blkback/xenbus.c  |  2 +-
>   drivers/block/zram/zram_drv.c       |  8 +++---
>   drivers/md/bcache/super.c           | 15 ++++++------
>   drivers/md/dm.c                     |  6 ++---
>   drivers/md/md.c                     | 38 +++++++++++++++--------------
>   drivers/mtd/devices/block2mtd.c     |  4 +--
>   drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>   drivers/s390/block/dasd_genhd.c     |  2 +-
>   drivers/target/target_core_iblock.c |  6 ++---
>   drivers/target/target_core_pscsi.c  |  8 +++---
>   fs/btrfs/dev-replace.c              |  6 ++---
>   fs/btrfs/ioctl.c                    | 12 ++++-----
>   fs/btrfs/volumes.c                  | 28 ++++++++++-----------
>   fs/btrfs/volumes.h                  |  6 ++---
>   fs/erofs/super.c                    |  7 +++---
>   fs/ext4/super.c                     | 11 +++------
>   fs/f2fs/super.c                     |  2 +-
>   fs/jfs/jfs_logmgr.c                 |  6 ++---
>   fs/nfs/blocklayout/dev.c            |  4 +--
>   fs/nilfs2/super.c                   |  6 ++---
>   fs/ocfs2/cluster/heartbeat.c        |  4 +--
>   fs/reiserfs/journal.c               | 19 +++++++--------
>   fs/reiserfs/reiserfs.h              |  1 -
>   fs/super.c                          | 20 +++++++--------
>   fs/xfs/xfs_super.c                  | 15 ++++++------
>   include/linux/blkdev.h              |  2 +-
>   kernel/power/hibernate.c            | 12 +++------
>   kernel/power/power.h                |  2 +-
>   kernel/power/swap.c                 | 21 +++++++---------
>   mm/swapfile.c                       |  7 +++---
>   37 files changed, 183 insertions(+), 192 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


