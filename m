Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343BFE776F0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ooj5opOVHIwgURbYHsqEuHjzPOZm9+/sqc6i3NhKBcw=; b=IamgXtOn51qvrVvbKPwKov02PY
	BNVOxPbSs9ptrDAHH7L2cvGmWJqtjIyW+5soarnoY5XwdJ3o2WI8oBdHiVIvWAWAM9YXTNAU2qskh
	RKkCoDIrtvdABTGjEhrzgIlekX7RYKXFFUcnRtPdrmDjS09SIsoYxr3xdtRw6eUXQXbpjeEiubS+c
	FCFJmoA9lxZAIVA+4MI/8WoH/n6BEUz0FgIIQSvs9L0etMr3aIgehnJ0V/NlreL7TKd6eUheCDhbP
	WgzKSgpaqHf7KvRcKmM0iCx4IgGhBzjN6/Krmn73Jfbu6HhiCKvtnfu5Pc0ZakfNygLbvRZtZP8IJ
	mhh0vtpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnVdx-00DhQm-20;
	Tue, 03 Oct 2023 03:00:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnVdv-00DhP2-0s
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 03:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 628C5CE0E97;
	Tue,  3 Oct 2023 03:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F59DC433C8;
	Tue,  3 Oct 2023 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696302011;
	bh=6G/ueFuWEcQKsuh5W2JpGGX6FBNexvvd8Q/l4pQONpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmJCYlni//qtXa3x5SP4sdoXhy9qmyQDPjVd3ebmxA+B4S9VST1efkK0rr/t+Oacz
	 tAoY/Qma7ocW7DcbYlr5p24LZKBAekgEWj50hV9UBZ8IpXEJkYY3R7UM9EiFib36XM
	 az/ES8zcAkj8lhqtUuJ3lXp9XaDdigowNFxcgfEETJmTvjj7Uv27TTTYhTKdrvessb
	 sfxlxGWrcaXrGG+RoHKR7eJEMgi/j/VqRh/5QFGXJMuErowsTaKXyDaJYONyFdCQ6i
	 j7Khz/yMEwyhtjr9riThwbcESL7OmpqTmkrHfHOlGdpz7zDX4uwkFpKnIM/V1C1Ah+
	 FqqNI6nnb/Ypg==
Date: Mon, 2 Oct 2023 20:00:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 11/21] fs: xfs: Don't use low-space allocator for
 alignment > 1
Message-ID: <20231003030010.GE21298@frogsfrogsfrogs>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-12-john.g.garry@oracle.com>
 <ZRtrap9v9xJrf6nq@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRtrap9v9xJrf6nq@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_200015_483329_AFB4344A 
X-CRM114-Status: GOOD (  19.91  )
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

On Tue, Oct 03, 2023 at 12:16:26PM +1100, Dave Chinner wrote:
> On Fri, Sep 29, 2023 at 10:27:16AM +0000, John Garry wrote:
> > The low-space allocator doesn't honour the alignment requirement, so don't
> > attempt to even use it (when we have an alignment requirement).
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > index 30c931b38853..328134c22104 100644
> > --- a/fs/xfs/libxfs/xfs_bmap.c
> > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > @@ -3569,6 +3569,10 @@ xfs_bmap_btalloc_low_space(
> >  {
> >  	int			error;
> >  
> > +	/* The allocator doesn't honour args->alignment */
> > +	if (args->alignment > 1)
> > +		return 0;
> > +
> 
> How does this happen?
> 
> The earlier failing aligned allocations will clear alignment before
> we get here....

I was thinking the predicate should be xfs_inode_force_align(ip) to save
me/us from thinking about all the other weird ways args->alignment could
end up 1.

	/* forced-alignment means we don't use low mode */
	if (xfs_inode_force_align(ip))
		return -ENOSPC;

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

