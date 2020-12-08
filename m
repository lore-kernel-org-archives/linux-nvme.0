Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4190C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:22:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990A023AA7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990A023AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9pc1ieZAO8+uczHwl/KlIoE+dFUdHxJp/0MPNwRewAo=; b=OjWvPMXX2hEVKaGgoicI47Me5
	PFBv8bOPLGYtzSmhy6hV06MXqbb1P0riTOXyy68v00kljGKjCHwO8B/O8QHJJfhSYNhdVsVxYATt9
	CNgzMxRFqMfq9j0N8IF/s+PKhaxZBb/rIM7cw+GZa2n8VFmfRYfWfPr687VgmYfCoJWOrLzqII5xj
	qUkmqpNyHfZSxizqCXNtqVHLpWbT9H37TRBUl2cX79yBzNoZW2LXcx6eleABc8hufU4vSI3VSm/km
	pWgrZw7gKpWOZPMixeLaThSbo+yFZwkIHWU+HAh0S1w1VHn7dXE0eH0IAUMsWdc0+6hHb43qSOvSD
	MARFQlOMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kma8o-0002Cc-5K; Tue, 08 Dec 2020 10:22:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kma8l-0002C8-LJ
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 10:22:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607422958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CbRwXof5BfleheY9ylmF59cZ8VjqZIDWfRUHUpV3i68=;
 b=X9n+aHCSpDQudSgBodpLHQveaPVmfxYjf0sXWTMqVSt61ng6vQH3P5Sg+IUsvvRfE673af
 qNUKZJa9K11wS5tRA0WAw8vxWOW9IT6KYWFyNxSH41sjYUPwPcKXnLgieVVon7TAG8iQW8
 lJmmuSz6GRjV8k441euadb6frOpBFAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-BAOAnsQvOaSGOX-DanZ9aA-1; Tue, 08 Dec 2020 05:22:35 -0500
X-MC-Unique: BAOAnsQvOaSGOX-DanZ9aA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F36BC107ACE6;
 Tue,  8 Dec 2020 10:22:33 +0000 (UTC)
Received: from T590 (ovpn-12-237.pek2.redhat.com [10.72.12.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F6B260636;
 Tue,  8 Dec 2020 10:22:15 +0000 (UTC)
Date: Tue, 8 Dec 2020 18:22:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] block: add a hard-readonly flag to struct gendisk
Message-ID: <20201208102211.GC1202995@T590>
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207131918.2252553-4-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_052239_753188_D9DE3B7D 
X-CRM114-Status: GOOD (  32.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 07, 2020 at 02:19:15PM +0100, Christoph Hellwig wrote:
> Commit 20bd1d026aac ("scsi: sd: Keep disk read-only when re-reading
> partition") addressed a long-standing problem with user read-only
> policy being overridden as a result of a device-initiated revalidate.
> The commit has since been reverted due to a regression that left some
> USB devices read-only indefinitely.
> 
> To fix the underlying problems with revalidate we need to keep track
> of hardware state and user policy separately.
> 
> The gendisk has been updated to reflect the current hardware state set
> by the device driver. This is done to allow returning the device to
> the hardware state once the user clears the BLKROSET flag.
> 
> The resulting semantics are as follows:
> 
>  - If BLKROSET sets a given partition read-only, that partition will
>    remain read-only even if the underlying storage stack initiates a
>    revalidate. However, the BLKRRPART ioctl will cause the partition
>    table to be dropped and any user policy on partitions will be lost.
> 
>  - If BLKROSET has not been set, both the whole disk device and any
>    partitions will reflect the current write-protect state of the
>    underlying device.
> 
> Based on a patch from Martin K. Petersen <martin.petersen@oracle.com>.
> 
> Reported-by: Oleksii Kurochko <olkuroch@cisco.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201221
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  block/blk-core.c        |  2 +-
>  block/genhd.c           | 33 +++++++++++++++++++--------------
>  block/partitions/core.c |  3 +--
>  include/linux/genhd.h   |  6 ++++--
>  4 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ad041e903b0a8f..ecd68415c6acad 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -693,7 +693,7 @@ static inline bool should_fail_request(struct block_device *part,
>  
>  static inline bool bio_check_ro(struct bio *bio)
>  {
> -	if (op_is_write(bio_op(bio)) && bio->bi_bdev->bd_read_only) {
> +	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev))
>  		char b[BDEVNAME_SIZE];
>  
>  		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
> diff --git a/block/genhd.c b/block/genhd.c
> index c87013879b8650..878f94727aaa96 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1425,27 +1425,32 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
>  	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
>  }
>  
> -void set_disk_ro(struct gendisk *disk, int flag)
> +/**
> + * set_disk_ro - set a gendisk read-only
> + * @disk:	gendisk to operate on
> + * @ready_only:	%true to set the disk read-only, %false set the disk read/write
> + *
> + * This function is used to indicate whether a given disk device should have its
> + * read-only flag set. set_disk_ro() is typically used by device drivers to
> + * indicate whether the underlying physical device is write-protected.
> + */
> +void set_disk_ro(struct gendisk *disk, bool read_only)
>  {
> -	struct disk_part_iter piter;
> -	struct block_device *part;
> -
> -	if (disk->part0->bd_read_only != flag) {
> -		set_disk_ro_uevent(disk, flag);
> -		disk->part0->bd_read_only = flag;
> +	if (read_only) {
> +		if (test_and_set_bit(GD_READ_ONLY, &disk->state))
> +			return;
> +	} else {
> +		if (!test_and_clear_bit(GD_READ_ONLY, &disk->state))
> +			return;
>  	}
> -
> -	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
> -	while ((part = disk_part_iter_next(&piter)))
> -		part->bd_read_only = flag;
> -	disk_part_iter_exit(&piter);
> +	set_disk_ro_uevent(disk, read_only);
>  }
> -
>  EXPORT_SYMBOL(set_disk_ro);
>  
>  int bdev_read_only(struct block_device *bdev)
>  {
> -	return bdev->bd_read_only;
> +	return bdev->bd_read_only ||
> +		test_bit(GD_READ_ONLY, &bdev->bd_disk->state);
>  }
>  EXPORT_SYMBOL(bdev_read_only);

Maybe one inline version can be added for fast path(bio_check_ro()), and the approach
is good:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
