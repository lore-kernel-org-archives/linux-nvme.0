Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097CECD11C2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6rbAxhTU3trm8omv2Bw7/7acDjs036CDj3MB035wsvw=; b=w8ULpE9j52NsAnOQzHBwLOumus
	ZeMe/DlLvM0rCWLmYBk54jjOzbclrMX+s+xkyLvsqlxXNhMy9CrZnKedloMG8NdIY7QA0XF5uIU93
	BUhQbNPBZFdw2u6nC7Dm9io5vF1MNNexk4DeLHOMIjoEfLQyRINaXGjLgI610SlTQ0ONfYmAwtP4+
	iMPiwN546tUSc/Lp05S4F1feQSZJGU51RubAXTuTWLZcXjzA4lw55aGyOpBmkVAbebadYVlWZuO0e
	gugNWD4+cIXK7VP0Cgz9Cur1UJ8BX09b+h5qs9mND1ZIhWOe62CNF4IJKt1de5xJxc24uYFGYLzEZ
	uXi4Uylg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rslmN-00000007prT-1SMB;
	Fri, 05 Apr 2024 15:46:59 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rslmJ-00000007pmb-1OGf
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 15:46:57 +0000
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4345f35daa7so2091031cf.0
        for <linux-nvme@lists.infradead.org>; Fri, 05 Apr 2024 08:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332006; x=1712936806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rbAxhTU3trm8omv2Bw7/7acDjs036CDj3MB035wsvw=;
        b=VqMA3Tz+odj49aqEcj0LfFl1Io3fktDUwrTaRWUUgp5KWTDbpR9wW6+G0DPDSakYqU
         xlWEFIVgYQISLsTqv8Y4O/ezqcetwysK8GYcf0lZ6xXxt9wPLtHSl664bmVgVbGXwoHH
         Lh46YEvQ9k02G4uMTfg8rFi/bwdPE9w06o7Jojr13RHQSWL7zROy/BQ6g2POThuDxJp9
         oUs52I7RV7vfS/Ev8l88+g5A04ImO5z1Wy6tmRJdQIGtJbW6aA08wRXCPz/IBemRgW2c
         6oKrsWM/YAt6BFLKLV3Gjbd0SukXyR8TyoGufA7Rip10QXGFbFHOqbHh9LUh1fbEu4cn
         SG1g==
X-Forwarded-Encrypted: i=1; AJvYcCVQF+VOE9ceL8clTJRy4zQdZzV1j0NlI2PUxZx+OzQm5vEhgWDh8HS39nPJ1PWUAAu/bInPNu29Y7hURi3Cd2nntz6Nit0VqUmvirylpNE=
X-Gm-Message-State: AOJu0YwD167/Oa7GPSKnie0692mIymdQ0uUBD4aRjufnfmGZuAAAPiSC
	+El7HJRU+QInXZNTWDoSFIdG1ETKXFAtAFeHcz6LxpGA8rZG1j3h/UXU0+zF1w==
X-Google-Smtp-Source: AGHT+IEXwj4lJiAs5E/QO+Sa6vdj5AXAThaYh2DQXIrBkzcrcg7oaujlyRW+rioUqrlHYgkWfdpcnQ==
X-Received: by 2002:a05:622a:5e8d:b0:434:61bc:9e22 with SMTP id er13-20020a05622a5e8d00b0043461bc9e22mr1787408qtb.24.1712332005953;
        Fri, 05 Apr 2024 08:46:45 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bw9-20020a05622a098900b004330090b874sm852109qtb.95.2024.04.05.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:46:45 -0700 (PDT)
Date: Fri, 5 Apr 2024 11:46:44 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 12/28] dm: Use the block layer zone append emulation
Message-ID: <ZhAc5JL9KwoDdiOO@redhat.com>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
 <20240405044207.1123462-13-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405044207.1123462-13-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_084655_489419_74BD2DFE 
X-CRM114-Status: GOOD (  30.44  )
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

On Fri, Apr 05 2024 at 12:41P -0400,
Damien Le Moal <dlemoal@kernel.org> wrote:

> For targets requiring zone append operation emulation with regular
> writes (e.g. dm-crypt), we can use the block layer emulation provided by
> zone write plugging. Remove DM implemented zone append emulation and
> enable the block layer one.
> 
> This is done by setting the max_zone_append_sectors limit of the
> mapped device queue to 0 for mapped devices that have a target table
> that cannot support native zone append operations (e.g. dm-crypt).
> Such mapped devices are flagged with the DMF_EMULATE_ZONE_APPEND flag.
> dm_split_and_process_bio() is modified to execute
> blk_zone_write_plug_bio() for such device to let the block layer
> transform zone append operations into regular writes.  This is done
> after ensuring that the submitted BIO is split if it straddles zone
> boundaries. Both changes are implemented unsing the inline helpers
> dm_zone_write_plug_bio() and dm_zone_bio_needs_split() respectively.
> 
> dm_revalidate_zones() is also modified to use the block layer provided
> function blk_revalidate_disk_zones() so that all zone resources needed
> for zone append emulation are initialized by the block layer without DM
> core needing to do anything. Since the device table is not yet live when
> dm_revalidate_zones() is executed, enabling the use of
> blk_revalidate_disk_zones() requires adding a pointer to the device
> table in struct mapped_device. This avoids errors in
> dm_blk_report_zones() trying to get the table with dm_get_live_table().
> The mapped device table pointer is set to the table passed as argument
> to dm_revalidate_zones() before calling blk_revalidate_disk_zones() and
> reset to NULL after this function returns to restore the live table
> handling for user call of report zones.
> 
> All the code related to zone append emulation is removed from
> dm-zone.c. This leads to simplifications of the functions __map_bio()
> and dm_zone_endio(). This later function now only needs to deal with
> completions of real zone append operations for targets that support it.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
>  drivers/md/dm-core.h |   2 +-
>  drivers/md/dm-zone.c | 476 ++++---------------------------------------
>  drivers/md/dm.c      |  72 ++++---
>  drivers/md/dm.h      |   4 +-
>  4 files changed, 94 insertions(+), 460 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index eb9832b22b14..174fda0a301c 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -226,41 +154,32 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
>  static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  {
>  	struct gendisk *disk = md->disk;
> -	unsigned int noio_flag;
>  	int ret;
>  
> -	/*
> -	 * Check if something changed. If yes, cleanup the current resources
> -	 * and reallocate everything.
> -	 */
> +	/* Revalidate ionly if something changed. */

Just noticed this ionly typo ^ Please fix.

Thanks,
Mike

