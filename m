Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9295BC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 06:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P2z/LFrpUod4EQohAwYfd01URT3cRlVCm2VHTnvRW44=; b=LGkYE6CzL17SbFrbJssa8vGEqw
	LyALCWx0NieTulX4K0shsPttEJ1CgS78qqHrUlejQGj0HZu9KlY2Wkc1ZnxoVDrNmW7kpq/4DuXii
	zmgdqR7li4p7AijaGPbDtKBLQqD3hV78svdtTuUimhi14nWfWxpVv3yh+i3IOwGz30H64wWo+ews4
	eXKptqfo9GPBWuVi8rAFyfYxb9t0TPIEMgSXu8vmvsFwkJATORXYPfEKsO+gj5JhW+xCGrZWUC1jI
	mEvhemE5G9J+QJerhpfJz321j0ER97fZTBhv2fcGOKcuxn41ZMnopq4WE8xxFnpn/NEEceGDCU61y
	nK/Kqguw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMjIk-0045GS-1F;
	Mon, 08 Jan 2024 06:39:58 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMjId-0045Fq-2T
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 06:39:53 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d4df66529bso2264795ad.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Jan 2024 22:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704695990; x=1705300790; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2z/LFrpUod4EQohAwYfd01URT3cRlVCm2VHTnvRW44=;
        b=LyEDs8rJQhPQW7zJy+2ATZjyU3351tbxzFTDmlfsTuZoR5xsOORedcYUI8q7vMp5WS
         hOxgJTZJzhyo2u+4X6f5+xhkCJM4N19XHIqB4Tz2MqkA9PAKPuTpeFE3wy6lWKi1xguL
         q4hPn4r8k1nSa5kWMIYor+MJLgtCUAn+7pSDM3n4/M/3Loc8wHN4G0m2BRO8G6u/YNVO
         qkAVgXpIrbUU625hMupXcVGLErd4ZZ5KApGDG5ibkiauZGy48leeAUmZB1PJ6Psr++S5
         tmxH5lwtb9djpuK7cOXXbvGcAdJ7lpndhImQqCF49zXuRX2+9vazxQME+BTu+aK6Ut/L
         tVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704695990; x=1705300790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2z/LFrpUod4EQohAwYfd01URT3cRlVCm2VHTnvRW44=;
        b=DxeovTIiNdM/IV+DAIjKCp96XZNY55MlHgfib0AyzjO5Pd7VKAaMwpL0OqOmT2mJ2A
         7m8nQEDEvWXRBdF9CWmcG5DIxidSMLQqOJ6xbmLwhpQ7vOlHQKUkJ8XwgdcFIGuon/fz
         UaBStT/yTUD1jK7pjOnvJFmF3oSpAV4gzOlPu3rYcxtdZ4AE355NV3SvXkG4e7BqgfPM
         5ud2620OouyUH9NexT98Qkf04/IYeeOLEDdQBvLwQxnJnMxMb1Sq7ngvgvuTCOB20tLL
         o/mp3jfC2oO92XjxHRoKICZPazAODYmB/gBAV7sN7rFPxOa9peSQNOjzKCc0FsPfmVBg
         TFWg==
X-Gm-Message-State: AOJu0Yzcc9IktkLzmWFTQNsN1AgQIY70JIO1abnELPK7azIY9K1jw/U+
	gNkVJBNkofehLLEOkO5A83RRqwQy18XL7w==
X-Google-Smtp-Source: AGHT+IEd5DltWMH/+FqCfCYBhgKXl9nxlvdK57zqowQUpnyKj7XaJTN1HbiuX5Fx9BCEtBJDAymiig==
X-Received: by 2002:a17:902:be13:b0:1d4:3d04:cdd with SMTP id r19-20020a170902be1300b001d43d040cddmr791720pls.32.1704695990264;
        Sun, 07 Jan 2024 22:39:50 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001d4e05828a9sm5421115plx.260.2024.01.07.22.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:39:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rMjIY-007WiN-2y;
	Mon, 08 Jan 2024 17:39:46 +1100
Date: Mon, 8 Jan 2024 17:39:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZuYspqO7bZUE3vG@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZcgXI46AinlcBDP@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240107_223952_141057_734ED743 
X-CRM114-Status: GOOD (  45.62  )
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

On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> This is primarily a _FILESYSTEM_ track topic.  All the work has already
> been done on the MM side; the FS people need to do their part.  It could
> be a joint session, but I'm not sure there's much for the MM people
> to say.
> 
> There are situations where we need to allocate memory, but cannot call
> into the filesystem to free memory.  Generally this is because we're
> holding a lock or we've started a transaction, and attempting to write
> out dirty folios to reclaim memory would result in a deadlock.
> 
> The old way to solve this problem is to specify GFP_NOFS when allocating
> memory.  This conveys little information about what is being protected
> against, and so it is hard to know when it might be safe to remove.
> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> even when they could use GFP_KERNEL because there's no risk of deadlock.

There are many uses in XFS where GFP_NOFS has been used because
__GFP_NOLOCKDEP did not exist. A large number of the remaining
GFP_NOFS and KM_NOFS uses in XFS fall under this category.

As a first step, I have a patchset that gets rid of KM_NOFS and
replaces it with either GFP_NOFS or __GFP_NOLOCKDEP:

$ git grep "GFP_NOFS\|KM_NOFS" fs/xfs |wc -l
64
$ git checkout guilt/xfs-kmem-cleanup
Switched to branch 'guilt/xfs-kmem-cleanup'
$ git grep "GFP_NOFS\|KM_NOFS" fs/xfs |wc -l
21

Some of these are in newly merged code that I haven't updated the
patch set to handle yet, others are in kthread/kworker contexts that
don't inherit any allocation context information. There isn't any
big issues remaining to be fixed in XFS, though.

> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> memalloc_nofs_restore().  These should be called when we start a
> transaction or take a lock that would cause a GFP_KERNEL allocation to
> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> can see the nofs situation is in effect and will not call back into
> the filesystem.

Note that this is the only way to use vmalloc() safely with GFP_NOFS
context...

> This results in better code within your filesystem as you don't need to
> pass around gfp flags as much, and can lead to better performance from
> the memory allocators as GFP_NOFS will not be used unnecessarily.
> 
> The memalloc_nofs APIs were introduced in May 2017, but we still have

For everyone else who doesn't know the history of this, the scoped
GFP_NOFS allocation code has been around for a lot longer than this
current API. PF_FSTRANS was added in early 2002 so we didn't have to
hack magic flags into current->journal_info to defermine if we were
in a transaction, and then this was added:

commit 957568938d4030414d71c583bc261fe3558d2c17
Author: Steve Lord <lord@sgi.com>
Date:   Thu Jan 31 11:17:26 2002 +0000

    Use PF_FSTRANS to detect being in a transaction

diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index 08a17984..282b724f 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -396,16 +396,11 @@ linvfs_release_buftarg(

 static kmem_cache_t * linvfs_inode_cachep;

-#define XFS_TRANS_MAGIC 0x5452414E
-
 static __inline__ unsigned int gfp_mask(void)
 {
         /* If we're not in a transaction, FS activity is ok */
-        if (!current->journal_info) return GFP_KERNEL;
-        /* could be set from some other filesystem */
-        if ((int)current->journal_info != XFS_TRANS_MAGIC)
-                return GFP_KERNEL;
-        return GFP_NOFS;
+        if (current->flags & PF_FSTRANS) return GFP_NOFS;
+       return GFP_KERNEL;
 }

> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
> really sad).  This session is for filesystem developers to talk about
> what they need to do to fix up their own filesystem, or share stories
> about how they made their filesystem better by adopting the new APIs.
> 
> My interest in this is that I'd like to get rid of the FGP_NOFS flag.

Isn't that flag redundant? i.e. we already have mapping_gfp_mask()
to indicate what gfp mask should be used with the mapping
operations, and at least the iomap code uses that.

Many filesystems call mapping_set_gfp_mask(GFP_NOFS) already, XFS is
the special one that does:

	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));

so it doesn't actually use GFP_NOFS there.

Given that we already have a generic way of telling mapping
operations the scoped allocation context they should run under,
perhaps we could turn this into scoped context calls somewhere in
the generic IO/mapping operation paths? e.g.
call_read_iter()/call_write_iter()

> It'd also be good to get rid of the __GFP_FS flag since there's always
> demand for more GFP flags.  I have a git branch with some work in this
> area, so there's a certain amount of conference-driven development going
> on here too.

Worry about that when everything is using scoped contexted. Then
nobody will be using GFP_NOFS or __GFP_FS externally, and the
allocator can then reclaim the flag.

> We could mutatis mutandi for GFP_NOIO, memalloc_noio_save/restore,
> __GFP_IO, etc, so maybe the block people are also interested.  I haven't
> looked into that in any detail though.  I guess we'll see what interest
> this topic gains.

That seems a whole lot simpler - just set the GFP_NOIO scope at
entry to the block layer and that should cover a large percentage of
the GFP_NOIO allocations...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

