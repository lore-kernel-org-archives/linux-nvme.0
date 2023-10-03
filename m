Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDCBE776ED
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 01:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8V805m7ttXbTthUXmXdTXgnda0hJbi48S1GO+p1UKEU=; b=h6KqsqFCIwE5Qsg3r6P4gaabf+
	ei4RWtqH+uQo7DJK1KNT/sTAVibpIE0MjqFlUktGryD8Agx97VbfeYfzmq81zAHKWo0++LT3jqHcZ
	xiXGrBaUyWgIfGZVKMCBfZZDMJsWEc6a9PyHRsvbyYNCxDxbiormvYbegcFMbWdY2ak1iEe/E4rZL
	zvdrapXWaZdYJeqB4iZ3mfIwEoHIlmnjXpO2A9i2q9iI2/o+e+6sk6ChcV212lnuYi5d8x0Ltsq1q
	LIIimr6Y+ItGX5l7TCvaBIOdMVa+L1kYryuKQx+bXxcDBBKjp6Fsc9ICvSIp0nW/R3f0Do8T8l2Bj
	gywnNNlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnURB-00DdgS-2h;
	Tue, 03 Oct 2023 01:43:01 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnUR8-00DdfE-18
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 01:42:59 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-584bfb14c59so233979a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 18:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696297376; x=1696902176; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8V805m7ttXbTthUXmXdTXgnda0hJbi48S1GO+p1UKEU=;
        b=2SOVbTQXfZBOORJU4yTzFOLgBjbbpe/BkvhSbP0LrwlN1ldZxbZ2oLQTcBbNzPGbdj
         GftE1lYIE+K3MONUAdeChBMW+oeZPrnGttU8hq3xWNF+cJc9Mkw7HzLXNqtX/NIch4b7
         iMmkbBZ7aCTekvtt2jgiq9JrOhH8lgv469pm+IA6or74IENBkjsgpvL+LX7e2CFlI0Hm
         vIl5m05VEB/YSifdL5kY7Wg2Y98tPcvxfpzW1WIAJ5qDI76UznMRyTPS8PyBXrq7UR9d
         EQ6ee7Lps8lKuguqN2ET845Leklu4ZBKt9INifzuePasjAX0KJU6WTA5UCQCo05lQNYf
         cCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696297376; x=1696902176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8V805m7ttXbTthUXmXdTXgnda0hJbi48S1GO+p1UKEU=;
        b=NaZmQcukB/F3QKQYhuTpd8g8WmEqX4qbiABMk9DXAbfSKh7jIsc4V7itHzbUzQsM5R
         PAvbOxO39TxWdBkJTUmHeSafHRh6NWzAqwxVb4vjGDMqowd9B6Zph4DAQZyOrl5jPMGL
         mZb9K2TMviJH3L8ieNL7vPCv1FxP7C1Ghh+ZFYtXMPQ5OQKNFXCX+h5zMLL1TElmKRHm
         rTDe+fQ/WnOIeBnLd5SKJqmcWAFF3PDHlmlmSJ+VwzEKTwLr4Ye5gNIRKgLqfRyJEIjm
         CMjoASl9fRthoE5vvqQU84Ne9YuJWefKais6Xu3Q2NVZelACce1k/EDZ+eLP/11FbJ4r
         0IFg==
X-Gm-Message-State: AOJu0YwJPKGgCTsuoe0FfLMOwZ8LZGfxnGkqUL+i2zB6MqiDM+6fMitD
	hY6vdMt4whZsuYh3JMgo72xOTg==
X-Google-Smtp-Source: AGHT+IH1MMBNEn/3axN7rieR3Ka9rd9cKkhqHZcuCTJaLw3uXvLw0daIzmInBxIrIYUS3hte/ESRZw==
X-Received: by 2002:a05:6a20:734a:b0:15d:641b:57b6 with SMTP id v10-20020a056a20734a00b0015d641b57b6mr12536153pzc.5.1696297376470;
        Mon, 02 Oct 2023 18:42:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b001b895336435sm133951plk.21.2023.10.02.18.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 18:42:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qnUR3-008hoD-0v;
	Tue, 03 Oct 2023 12:42:53 +1100
Date: Tue, 3 Oct 2023 12:42:53 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 13/21] fs: xfs: Make file data allocations observe the
 'forcealign' flag
Message-ID: <ZRtxnc7LpOlxZnON@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-14-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-14-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_184258_414167_6DE2E76C 
X-CRM114-Status: GOOD (  34.81  )
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

On Fri, Sep 29, 2023 at 10:27:18AM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> The existing extsize hint code already did the work of expanding file
> range mapping requests so that the range is aligned to the hint value.
> Now add the code we need to guarantee that the space allocations are
> also always aligned.
> 
> XXX: still need to check all this with reflink
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Co-developed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 22 +++++++++++++++++-----
>  fs/xfs/xfs_iomap.c       |  4 +++-
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 328134c22104..6c864dc0a6ff 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3328,6 +3328,19 @@ xfs_bmap_compute_alignments(
>  		align = xfs_get_cowextsz_hint(ap->ip);
>  	else if (ap->datatype & XFS_ALLOC_USERDATA)
>  		align = xfs_get_extsz_hint(ap->ip);
> +
> +	/*
> +	 * xfs_get_cowextsz_hint() returns extsz_hint for when forcealign is
> +	 * set as forcealign and cowextsz_hint are mutually exclusive
> +	 */
> +	if (xfs_inode_forcealign(ap->ip) && align) {
> +		args->alignment = align;
> +		if (stripe_align % align)
> +			stripe_align = align;
> +	} else {
> +		args->alignment = 1;
> +	}

This smells wrong.

If a filesystem has a stripe unit set (hence stripe_align is
non-zero) then any IO that crosses stripe unit boundaries will not
be atomic - they will require multiple IOs to different devices.

Hence if the filesystem has a stripe unit set, then all forced
alignment hints for atomic IO *must* be an exact integer divider
of the stripe unit. hence when an atomic IO bundle is aligned, the
atomic boundaries within the bundle always fall on a stripe unit
boundary and never cross devices.

IOWs, for a striped filesystem, the maximum size/alignment for a
single atomic IO unit is the stripe unit.

This should be enforced when the forced align flag is set on the
inode (i.e. from the ioctl)


> +
>  	if (align) {
>  		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>  					ap->eof, 0, ap->conv, &ap->offset,
> @@ -3423,7 +3436,6 @@ xfs_bmap_exact_minlen_extent_alloc(
>  	args.minlen = args.maxlen = ap->minlen;
>  	args.total = ap->total;
>  
> -	args.alignment = 1;
>  	args.minalignslop = 0;
>  
>  	args.minleft = ap->minleft;
> @@ -3469,6 +3481,7 @@ xfs_bmap_btalloc_at_eof(
>  {
>  	struct xfs_mount	*mp = args->mp;
>  	struct xfs_perag	*caller_pag = args->pag;
> +	int			orig_alignment = args->alignment;
>  	int			error;
>  
>  	/*
> @@ -3543,10 +3556,10 @@ xfs_bmap_btalloc_at_eof(
>  
>  	/*
>  	 * Allocation failed, so turn return the allocation args to their
> -	 * original non-aligned state so the caller can proceed on allocation
> -	 * failure as if this function was never called.
> +	 * original state so the caller can proceed on allocation failure as
> +	 * if this function was never called.
>  	 */
> -	args->alignment = 1;
> +	args->alignment = orig_alignment;
>  	return 0;
>  }

Urk. Not sure that is right, it's certainly a change of behaviour.

> @@ -3694,7 +3707,6 @@ xfs_bmap_btalloc(
>  		.wasdel		= ap->wasdel,
>  		.resv		= XFS_AG_RESV_NONE,
>  		.datatype	= ap->datatype,
> -		.alignment	= 1,
>  		.minalignslop	= 0,
>  	};
>  	xfs_fileoff_t		orig_offset;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 18c8f168b153..70fe873951f3 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -181,7 +181,9 @@ xfs_eof_alignment(
>  		 * If mounted with the "-o swalloc" option the alignment is
>  		 * increased from the strip unit size to the stripe width.
>  		 */
> -		if (mp->m_swidth && xfs_has_swalloc(mp))
> +		if (xfs_inode_forcealign(ip))
> +			align = xfs_get_extsz_hint(ip);
> +		else if (mp->m_swidth && xfs_has_swalloc(mp))
>  			align = mp->m_swidth;
>  		else if (mp->m_dalign)
>  			align = mp->m_dalign;

Ah. Now I see. This abuses the stripe alignment code to try to
implement this new inode allocation alignment restriction, rather
than just making the extent size hint alignment mandatory....

Yeah, this can be done better... :)

As it is, I have been working on a series that reworks all this
allocator code to separate out the aligned IO from the exact EOF
allocation case to help clean this up for better perag selection
during allocation. I think that needs to be done first before we go
making the alignment code more intricate like this....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

