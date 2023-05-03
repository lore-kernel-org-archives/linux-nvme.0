Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD7EC77B75
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 22:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SZlTdG04TqTF7+/hzp5sSJRuB5EmsmvAFGgc3K+3F0Y=; b=11s2hftxrwvhbfX3GuaqwllXhJ
	1Ep2KcaX4hi5/smcNBZgMtCy7TfeAuuZ7Bp250urwvsbe9B5OUhB4gY5lCTQkphGxh/ScKqcpvBJ7
	IhqghIp6CqM6KpFhAYXX6MMtYB8D7BmRfCVa0QyMV9EKb0TDbZ9ihodlZrF4FZ6w2THFDWvMmWwue
	3djDo+J4WDQSrDt47GBjfz65AMGIm1/skYtLBenOVMErNLtyL7tVpXfUOaCkfc3LBdn888scsuDGC
	LiZWUE7w/IZFxVKoaL7VC5v2fCN6wBf63qP1avfHguNsCpLguGyCGJobzkR102LtTEBHhxMAx5WEv
	kCoGdmgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKnO-005xhy-17;
	Wed, 03 May 2023 22:17:58 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKnL-005xhD-14
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 22:17:56 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aafa03f541so40955935ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 May 2023 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683152273; x=1685744273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZlTdG04TqTF7+/hzp5sSJRuB5EmsmvAFGgc3K+3F0Y=;
        b=39WVkULqHXRDJ4WUYe73OzFA/R2wak2Byvue6BmOkCk/OUZ7TIFexiujMgqDtXjhoJ
         vY8UhclcPr7rl4Zv2wbm/zdzS0ni41dpAUltS0ZIuTMSWKNEFldMe8omTChgh7JjGHw9
         rVsx1Yw28FjKmAmsO5frsdqvSKA4ZJrGU5Gp+Q9w3fCsWnJVySoTDQBrKpXRB+VVwMsd
         2mP535YsEeeVtqm0f04weAqu0Ix/cKqOgjAhn6wHaEI53Xkx+scS9ruET4oev/lz/RR9
         HuYeHautziBafZRfpxfmTZFWObUFN65QoOJpAc8Hd0Mv9bIad3zclXTZRNBKp80hSzAf
         fzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683152273; x=1685744273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZlTdG04TqTF7+/hzp5sSJRuB5EmsmvAFGgc3K+3F0Y=;
        b=XR5oDBvB/gZ98Z6ASNSPvQU0Bs8MwJh1Em+yWTCarBb1OEzbw8Ne3IguLU0n5+1MaF
         ejPI95LuvVCXeEU04abj+vRPc/Rtrb8umocPaLmYdZgjcQ13nE7TgwkdsAP54/Inf7hl
         NhZnq1nu/WwMlUWR7B2GfZ2R5v1GFETznQhnmbNXDtuv0sZUfgPy7gchxVTJa0Wnm9OG
         O7zf5FF9LzenC5o21Nq/ubmJ484MiiZm+z9K0odT8smOCJMctvlJHqWnwt7uyjuJmv3y
         UJhAMs6CTQ5xcFcx0sQU7Uq5m1jzh30D0IIZbNNKCgxw4sCJxXArV1ti/OLjYUtMP9Ws
         F/TQ==
X-Gm-Message-State: AC+VfDygJCjV8aeUqhe7YVk6rZh0cXu7SLgO7gZzrLm/YFZrn7vDg7eJ
	YWn4FLtABCHlSVzJk0LcH/oqyw==
X-Google-Smtp-Source: ACHHUZ6w6FNkuZBKWIHG+izk4/mp1lXBQ8ap+jb9gyt4ryTRiawSHwELQjohp4JJfay700Tr/2IfyQ==
X-Received: by 2002:a17:902:be08:b0:1a6:d8a3:3346 with SMTP id r8-20020a170902be0800b001a6d8a33346mr1422648pls.31.1683152272764;
        Wed, 03 May 2023 15:17:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902bd8700b001a6ff7bd4d9sm22112696pls.15.2023.05.03.15.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:17:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1puKnF-00B0ur-4U; Thu, 04 May 2023 08:17:49 +1000
Date: Thu, 4 May 2023 08:17:49 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jejb@linux.ibm.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH RFC 03/16] xfs: Support atomic write for statx
Message-ID: <20230503221749.GF3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-4-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503183821.1473305-4-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_151755_373634_11BC8449 
X-CRM114-Status: GOOD (  23.27  )
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

On Wed, May 03, 2023 at 06:38:08PM +0000, John Garry wrote:
> Support providing info on atomic write unit min and max.
> 
> Darrick Wong originally authored this change.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 24718adb3c16..e542077704aa 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -614,6 +614,16 @@ xfs_vn_getattr(
>  			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>  			stat->dio_offset_align = bdev_logical_block_size(bdev);
>  		}
> +		if (request_mask & STATX_WRITE_ATOMIC) {
> +			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +			struct block_device	*bdev = target->bt_bdev;
> +
> +			stat->atomic_write_unit_min = queue_atomic_write_unit_min(bdev->bd_queue);
> +			stat->atomic_write_unit_max = queue_atomic_write_unit_max(bdev->bd_queue);

I'm not sure this is right.

Given that we may have a 4kB physical sector device, XFS will not
allow IOs smaller than physical sector size. The initial values of
queue_atomic_write_unit_min/max() will be (1 << SECTOR_SIZE) which
is 512 bytes. IOs done with 4kB sector size devices will fail in
this case.

Further, XFS has a software sector size - it can define the sector
size for the filesystem to be 4KB on a 512 byte sector device. And
in that case, the filesystem will reject 512 byte sized/aligned IOs
as they are smaller than the filesystem sector size (i.e. a config
that prevents sub-physical sector IO for 512 logical/4kB physical
devices).

There may other filesystem constraints - realtime devices have fixed
minimum allocation sizes which may be larger than atomic write
limits, which means that IO completion needs to split extents into
multiple unwritten/written extents, extent size hints might be in
use meaning we have different allocation alignment constraints to
atomic write constraints, stripe alignment of extent allocation may
through out atomic write alignment, etc.

These are all solvable, but we need to make sure here that the
filesystem constraints are taken into account here, not just the
block device limits.

As such, it is probably better to query these limits at filesystem
mount time and add them to the xfs buftarg (same as we do for
logical and physical sector sizes) and then use the xfs buftarg
values rather than having to go all the way to the device queue
here. That way we can ensure at mount time that atomic write limits
don't conflict with logical/physical IO limits, and we can further
constrain atomic limits during mount without always having to
recalculate those limits from first principles on every stat()
call...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

