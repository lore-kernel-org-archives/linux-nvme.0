Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C17C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Nov 2023 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ruZCJ4w6ZzHVFH1NvqWDx3d8Cn0lU9vwUEKIRfvHctg=; b=xlQACczAXtZ0AvsDK0YgiB8KsA
	R11LB0GqcKN5uFnLzTgRhgKfahRy2f/bjIz4aDxRFO8HxIwFPoc1nXKFCsiP4a1I15jKIVGMgwMlM
	0HWRmrbl7UEhleUAYB0me8oDfT3PZ19z25CrVFQ43Ubyxfm7fU8sMSxF0F4cl/LUj4zcJwcrBoINo
	lOKioXPVLFI3fL9v59Tlu0OCS9F/DKCxKk7YTLpaWYt+dMUNlNBhPhYWcTdJEvrz1ImnIiFHX1UXh
	ox5Th7wJtguLqIfQzZLGrQGJhP8TQ0PxDL5ZIkqXuqIL4ym92XIbjwiXh8chPhBayuuKGNtcsHAI2
	hPr74Ubg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyYHX-009b87-1j;
	Thu, 02 Nov 2023 14:02:47 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyYHS-009b6U-0P
	for linux-nvme@lists.infradead.org;
	Thu, 02 Nov 2023 14:02:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 58CB4B81CA1;
	Thu,  2 Nov 2023 14:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B93C433C9;
	Thu,  2 Nov 2023 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698933759;
	bh=fgOZjn0WdFzXtcn8lGgDLoPHzxr8QdP2NR/ys5t0Tbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SX4WtNKm5pDj9w492ahqKstWDnWh6M4sJIDEesfWnzHG+qb9Q4yNf6O/VTmBrzQ+B
	 J+lN6pLndYpPJ2///jW3lO8ULdP1cvkId8z0QLLU9SCD1Vn3MCh+blaB22zqDAiR/o
	 XR4l+VlEP7zQokYYie6zAycHpAphfEalcKMzDRGBY7DIFdzBxEoSIM1JcGC8CJxbij
	 F9Ali9mUj5nbbM9wS1hvCdR6/H4SvGkafHYkIN0s4b7pqOGcZS/Zcm6+PYMZJDJNev
	 2MmTfCZEAoTWDPXuEvghazEUvKAcFhgHBcECGGT8wd3jtYaMQqEyBmgULjji+2X7SU
	 nEdY57VcxKcNQ==
Date: Thu, 2 Nov 2023 08:02:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Ming Lei <tom.leiming@gmail.com>,
	Marek =?us-ascii?Q?Marczykowski-G'orecki?= <marmarek@invisiblethingslab.com>,
	Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZUOr-vp0yRkLyvyi@kbusch-mbp.dhcp.thefacebook.com>
References: <ZT/e/EaBIkJEgevQ@mail-itl>
 <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com>
 <ZUB5HFeK3eHeI8UH@mail-itl>
 <20231031140136.25bio5wajc5pmdtl@quack3>
 <ZUEgWA5P8MFbyeBN@mail-itl>
 <CACVXFVOEWDyzasS7DWDvLOhC3Hr6qOn5ks3HLX+fbRYCxYv26w@mail.gmail.com>
 <ZUG0gcRhUlFm57qN@mail-itl>
 <ZUHE52SznRaZQxnG@fedora>
 <ab02413f-4bf2-4d92-baf7-62fbd106f5df@suse.de>
 <ZUI1GSSL4vdsFVHq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUI1GSSL4vdsFVHq@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231102_070242_332583_7A682763 
X-CRM114-Status: GOOD (  21.51  )
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

On Wed, Nov 01, 2023 at 07:23:05PM +0800, Ming Lei wrote:
> On Wed, Nov 01, 2023 at 11:15:02AM +0100, Hannes Reinecke wrote:
> > > nvme_queue_rq() on the above request.
> > > 
> > And that is something I've been wondering (for quite some time now):
> > What _is_ the appropriate error handling for -ENOMEM?
> 
> It is just my guess.
> 
> Actually it shouldn't fail since the sgl allocation is backed with
> memory pool, but there is also dma pool allocation and dma mapping.
> 
> > At this time, we assume it to be a retryable error and re-run the queue
> > in the hope that things will sort itself out.
> 
> It should not be hard to figure out why nvme_queue_rq() can't move on.

There's only a few reasons nvme_queue_rq would return BLK_STS_RESOURCE
for a typical read/write command:

  DMA mapping error
  Can't allocate SGL from mempool
  Can't allocate PRP from dma_pool
  Controller stuck in resetting state

We should always be able to get at least one allocation from the memory
pools, so I think the only one the driver doesn't have a way to
guarantee eventual forward progress are the DMA mapping error
conditions. Is there some other limit that the driver needs to consider
when configuring it's largest supported transfers?

