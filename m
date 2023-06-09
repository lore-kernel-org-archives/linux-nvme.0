Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8843C7EE2F
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwirhtabGvCDuiR1jxZAiR7OdtCbwijcduPp+mqjcaE=; b=ghqxXBMul7FdWipzof100UeWdu
	cJf7kvd98+rukRVYLg6tiX7E6fBXnAEEAOgym+PZsztOurdxfsiOO9O/fPpPZLYtj3aqJksxFC7my
	EI7aYM9d9FCDqvJus5ToeBdw4oUagCZnmOIJnzeq+G6WVHTO2zqIVYNJRyVRMyHYp6qkK1B/Y8Ui0
	BZXCz5akwOeZ5kXIK72P3+CvrkPY4MtMGQ8sajJO61/8wpoj5YVhiD027KB1gbyIlPa+Bxl/BpZmY
	+7QJ+JfufRCYQjvr+/oAzPU5GKsyMzlD/Ik6Fuo96gb06hd+K/b7KmkQrLKPNNGFp8duYqp0sTj6b
	tSa4TCuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Vo2-00BuQY-1L;
	Fri, 09 Jun 2023 06:41:06 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Vny-00BuOL-2o;
	Fri, 09 Jun 2023 06:41:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87DF021A01;
	Fri,  9 Jun 2023 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686292861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwirhtabGvCDuiR1jxZAiR7OdtCbwijcduPp+mqjcaE=;
	b=ehZ0672Jmg/d0MyG6AB71GZgF+CyZ7aCz0fEPEWeIM2+pQ9Yx7bDj7sHuPrhdKIDHah+B4
	x1845pdOYRa2De2VoQdmA0KAKObSWeKv9fEnhF1iOao6dTuYXRa5ZfsQfydIP8CefTEFZO
	h1zXrLjKHTLXFAO3wTXo8ujyMLb7Ym8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686292861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwirhtabGvCDuiR1jxZAiR7OdtCbwijcduPp+mqjcaE=;
	b=tO7zUW+BGSFLyYxsGBGSKkQs6Pyd8vG0aztlZWiq/wA+rE6rLQYQ4enb0147Vn3wZhl3U9
	epRQIH1KZsrj8BAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69262139C8;
	Fri,  9 Jun 2023 06:41:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mrFJGHzJgmR1OAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 09 Jun 2023 06:41:00 +0000
Message-ID: <61eab396-8424-ba7c-3ea1-7973330e0c57@suse.de>
Date: Fri, 9 Jun 2023 08:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [dm-devel] [PATCH 27/30] block: replace fmode_t with a
 block-specific type for block open flags
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvme@lists.infradead.org,
 Phillip Potter <phil@philpotter.co.uk>, Chris Mason <clm@fb.com>,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Pavel Machek <pavel@ucw.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Jack Wang <jinpu.wang@ionos.com>, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 linux-pm@vger.kernel.org, linux-um@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Christian Brauner <brauner@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
References: <20230608110258.189493-1-hch@lst.de>
 <20230608110258.189493-28-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230608110258.189493-28-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_234103_060408_C896150E 
X-CRM114-Status: GOOD (  13.81  )
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

On 6/8/23 13:02, Christoph Hellwig wrote:
> The only overlap between the block open flags mapped into the fmode_t and
> other uses of fmode_t are FMODE_READ and FMODE_WRITE.  Define a new
> blk_mode_t instead for use in blkdev_get_by_{dev,path}, ->open and
> ->ioctl and stop abusing fmode_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jack Wang <jinpu.wang@ionos.com>		[rnbd]
> ---
>   arch/um/drivers/ubd_kern.c          |  8 +++---
>   arch/xtensa/platforms/iss/simdisk.c |  2 +-
>   block/bdev.c                        | 32 +++++++++++-----------
>   block/blk-zoned.c                   |  8 +++---
>   block/blk.h                         | 11 ++++----
>   block/fops.c                        | 32 +++++++++++++++++-----
>   block/genhd.c                       |  8 +++---
>   block/ioctl.c                       | 42 +++++++++--------------------
>   drivers/block/amiflop.c             | 12 ++++-----
>   drivers/block/aoe/aoeblk.c          |  4 +--
>   drivers/block/ataflop.c             | 25 +++++++++--------
>   drivers/block/drbd/drbd_main.c      |  7 ++---
>   drivers/block/drbd/drbd_nl.c        |  2 +-
>   drivers/block/floppy.c              | 28 +++++++++----------
>   drivers/block/loop.c                | 22 +++++++--------
>   drivers/block/mtip32xx/mtip32xx.c   |  4 +--
>   drivers/block/nbd.c                 |  4 +--
>   drivers/block/pktcdvd.c             | 17 ++++++------
>   drivers/block/rbd.c                 |  2 +-
>   drivers/block/rnbd/rnbd-clt.c       |  4 +--
>   drivers/block/rnbd/rnbd-srv.c       |  4 +--
>   drivers/block/sunvdc.c              |  2 +-
>   drivers/block/swim.c                | 16 +++++------
>   drivers/block/swim3.c               | 24 ++++++++---------
>   drivers/block/ublk_drv.c            |  2 +-
>   drivers/block/xen-blkback/xenbus.c  |  2 +-
>   drivers/block/xen-blkfront.c        |  2 +-
>   drivers/block/z2ram.c               |  2 +-
>   drivers/block/zram/zram_drv.c       |  6 ++---
>   drivers/cdrom/cdrom.c               |  6 ++---
>   drivers/cdrom/gdrom.c               |  4 +--
>   drivers/md/bcache/bcache.h          |  2 +-
>   drivers/md/bcache/request.c         |  4 +--
>   drivers/md/bcache/super.c           |  6 ++---
>   drivers/md/dm-cache-target.c        | 12 ++++-----
>   drivers/md/dm-clone-target.c        | 10 +++----
>   drivers/md/dm-core.h                |  7 +++--
>   drivers/md/dm-era-target.c          |  6 +++--
>   drivers/md/dm-ioctl.c               | 10 +++----
>   drivers/md/dm-snap.c                |  4 +--
>   drivers/md/dm-table.c               | 11 ++++----
>   drivers/md/dm-thin.c                |  9 ++++---
>   drivers/md/dm-verity-fec.c          |  2 +-
>   drivers/md/dm-verity-target.c       |  6 ++---
>   drivers/md/dm.c                     | 10 +++----
>   drivers/md/dm.h                     |  2 +-
>   drivers/md/md.c                     |  8 +++---
>   drivers/mmc/core/block.c            |  8 +++---
>   drivers/mtd/devices/block2mtd.c     |  4 +--
>   drivers/mtd/mtd_blkdevs.c           |  4 +--
>   drivers/mtd/ubi/block.c             |  5 ++--
>   drivers/nvme/host/core.c            |  2 +-
>   drivers/nvme/host/ioctl.c           |  8 +++---
>   drivers/nvme/host/multipath.c       |  2 +-
>   drivers/nvme/host/nvme.h            |  4 +--
>   drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>   drivers/s390/block/dasd.c           |  6 ++---
>   drivers/s390/block/dasd_genhd.c     |  3 ++-
>   drivers/s390/block/dasd_int.h       |  3 ++-
>   drivers/s390/block/dasd_ioctl.c     |  2 +-
>   drivers/s390/block/dcssblk.c        |  4 +--
>   drivers/scsi/sd.c                   | 19 ++++++-------
>   drivers/scsi/sr.c                   | 10 +++----
>   drivers/target/target_core_iblock.c |  5 ++--
>   drivers/target/target_core_pscsi.c  |  4 +--
>   fs/btrfs/dev-replace.c              |  2 +-
>   fs/btrfs/super.c                    |  8 +++---
>   fs/btrfs/volumes.c                  | 16 +++++------
>   fs/btrfs/volumes.h                  |  4 +--
>   fs/erofs/super.c                    |  2 +-
>   fs/ext4/super.c                     |  2 +-
>   fs/f2fs/super.c                     |  2 +-
>   fs/jfs/jfs_logmgr.c                 |  2 +-
>   fs/nfs/blocklayout/dev.c            |  5 ++--
>   fs/ocfs2/cluster/heartbeat.c        |  3 ++-
>   fs/reiserfs/journal.c               |  4 +--
>   fs/xfs/xfs_super.c                  |  2 +-
>   include/linux/blkdev.h              | 30 ++++++++++++++++-----
>   include/linux/cdrom.h               |  3 ++-
>   include/linux/device-mapper.h       |  8 +++---
>   kernel/power/swap.c                 |  6 ++---
>   mm/swapfile.c                       |  2 +-
>   82 files changed, 334 insertions(+), 315 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


