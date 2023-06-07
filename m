Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25422C7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1Rl1qGqvM4Z5x8Xq+CyMv3eUpGokjis8a1uEGHT2oM=; b=1rgPiOoSzXlFDg0ZVUFhcvMDmt
	xpeYGoOadiCl/CJ/oz5hut/3x5zoHT1HCMkH/wjXOA5hqY4seiZDfbNBqT0rzCvRkRA0RceC+fxuC
	gIaSHaMLS8TuJsD9d/aFuqN1+4iyIaB8UFWTofjtlFDNWDTtE285fIE0xp8SMnhgy8sxd0sB1/GoF
	p92M9qwOZzelQm508RetVW0RvA2W53yV20z9d3ujCoZngNCmMZVE4RjzTPFcEaX22PuyCQxpA/WAB
	UnruUFGKcY/iVG/TSdFMqvUqt4Rg64wZX4IBVOcMMeAclW8yuhlCadNfqyW7ebP8UawvBS1mEiF7t
	BppleD2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s9n-005qax-1Z;
	Wed, 07 Jun 2023 12:20:55 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s9j-005qYB-3C;
	Wed, 07 Jun 2023 12:20:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBB84219E0;
	Wed,  7 Jun 2023 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686140450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1Rl1qGqvM4Z5x8Xq+CyMv3eUpGokjis8a1uEGHT2oM=;
	b=NtfJezGisqgVMGMlpHu5h7lKBliQJSnIU40FJjYFHclq1pJ2yccwB2gCrQVYr/XEAgBe//
	SwWqpD3W1ozsd6dyaotuzbIDg6Oacufyt0jV/rrLR+MxmjDwaQJv56xVitpaNX1eUWndRD
	n4xYwVUPyj+t5hxm3UfoFljrLDNuTx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686140450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1Rl1qGqvM4Z5x8Xq+CyMv3eUpGokjis8a1uEGHT2oM=;
	b=zQ5xWW4Z2foG7bGxNOdFosbyzeVEHPlunA2KDXAT7USZKkViaz3OAfkcgfavN420ThY0SP
	Jl33OjNpQS/R7bCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7586A13776;
	Wed,  7 Jun 2023 12:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id DOJsHCJ2gGSBQQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:20:50 +0000
Message-ID: <bb59f7f1-0d12-ed28-9754-7027959ada0b@suse.de>
Date: Wed, 7 Jun 2023 14:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/31] block: remove the unused mode argument to ->release
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
 <20230606073950.225178-11-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_052052_182210_F0DD8766 
X-CRM114-Status: GOOD (  12.38  )
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
> The mode argument to the ->release block_device_operation is never used,
> so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/ubd_kern.c          |  4 ++--
>   arch/xtensa/platforms/iss/simdisk.c |  2 +-
>   block/bdev.c                        | 14 +++++++-------
>   drivers/block/amiflop.c             |  2 +-
>   drivers/block/aoe/aoeblk.c          |  2 +-
>   drivers/block/ataflop.c             |  4 ++--
>   drivers/block/drbd/drbd_main.c      |  4 ++--
>   drivers/block/floppy.c              |  2 +-
>   drivers/block/loop.c                |  2 +-
>   drivers/block/nbd.c                 |  2 +-
>   drivers/block/pktcdvd.c             |  4 ++--
>   drivers/block/rbd.c                 |  2 +-
>   drivers/block/rnbd/rnbd-clt.c       |  2 +-
>   drivers/block/swim.c                |  2 +-
>   drivers/block/swim3.c               |  3 +--
>   drivers/block/z2ram.c               |  2 +-
>   drivers/cdrom/gdrom.c               |  2 +-
>   drivers/md/bcache/super.c           |  2 +-
>   drivers/md/dm.c                     |  2 +-
>   drivers/md/md.c                     |  2 +-
>   drivers/mmc/core/block.c            |  2 +-
>   drivers/mtd/mtd_blkdevs.c           |  2 +-
>   drivers/mtd/ubi/block.c             |  2 +-
>   drivers/nvme/host/core.c            |  2 +-
>   drivers/nvme/host/multipath.c       |  2 +-
>   drivers/s390/block/dasd.c           |  2 +-
>   drivers/s390/block/dcssblk.c        |  4 ++--
>   drivers/scsi/sd.c                   |  3 +--
>   drivers/scsi/sr.c                   |  2 +-
>   include/linux/blkdev.h              |  2 +-
>   30 files changed, 41 insertions(+), 43 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


