Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03ECD15DAD
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l9aa/J9ZT3SCMDM2/0+w7GugFXiGNyerVbAvGvGQxKw=; b=gv0Kk02CFajYubCUMgYE3ZEYHJ
	u6JAVhdpAkV+TDdwugPNfe5MXhWZI6cyyVZ1xF8YlD/iDPqUlz0VFkpWiCzGlsAGveAMmoQy9qLr8
	nc74VuEu6cpUMkHpOpL+xrLUUG9Zz4Mq7xEouR93h62Yj2wlWR6eqrRCaK5UyiDnjDxR537EfRKRX
	GyN/CdVS8KL+Hn11TVu4ooEdZKcmm+xpUsdkBxG6oN+H8mfAVpRoE0I6J2M0y5JW+F6Fmj4CAT0Dq
	DSZpNb+QwgysZqaogemup2YLVxa4ZphxqWTGnl10DiEkSIo2f3Bi8NSPkab1qDBRwFZ1EZGtF/Pal
	ttVN4wCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uIy-00000007mPA-4BDI;
	Mon, 21 Oct 2024 15:26:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2tvY-00000007iSv-1mQ4
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 15:02:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B725B5C56A1;
	Mon, 21 Oct 2024 15:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4832EC4CEC3;
	Mon, 21 Oct 2024 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729522954;
	bh=ivc/NfFpIbuGRB4e7IdO3MFJVP/dJCSBQVsvP8nDRjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHx0tdqcLsCN6ZYjBhiW2ta6o+5/39EOcU5LbPsZdTPJDcBWiIY023jVthh2WAV1L
	 c+lE3wKMeTbMobExWq41ouI/1r5ArXwUeDzDTwrFmuTlVb2RuEoOC6oMHJv2ctoTKS
	 7b0BpYbjaBZ8Ddg8whr8WxaXj5pgJqstJkXO+B9BjAkg2Zv7i7Fu6Ok1HD5tWVJ1ob
	 PoAhcqKnZWM1AsuzHmS/84+vB3B8kypDbYsoXvRipatkmbfIB5UHdkXFPJWnf3A0Z+
	 rHIyCkNVPY79YXzNAKdoYQ3f5TiVmRN14ECBeL9G5uLsU82JNfTAlt0fbpK7pGbDiw
	 V9PZqczIRrdXw==
Date: Mon, 21 Oct 2024 09:02:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCHv8 3/6] block: introduce max_write_hints queue limit
Message-ID: <ZxZtCFNvPlIE8xgV@kbusch-mbp>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-4-kbusch@meta.com>
 <57798ab7-fc67-4606-900e-d221e028bd8f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57798ab7-fc67-4606-900e-d221e028bd8f@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_080236_533596_75C7B6BB 
X-CRM114-Status: GOOD (  19.95  )
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

On Fri, Oct 18, 2024 at 09:18:34AM -0700, Bart Van Assche wrote:
> On 10/17/24 9:09 AM, Keith Busch wrote:
> > Drivers with hardware that support write hints need a way to export how
> > many are available so applications can generically query this.
> 
> Something is missing from this patch, namely a change for the SCSI disk
> (sd) driver that sets max_write_hints to sdkp->permanent_stream_count.

Shouldn't someone who cares about scsi do that? I certainly don't care,
nor have I been keeping up with what's happening there, so I'm also
unqualified.
 
> > +What:		/sys/block/<disk>/queue/max_write_hints
> > +Date:		October 2024
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RO] Maximum number of write hints supported, 0 if not
> > +		supported. If supported, valid values are 1 through
> > +		max_write_hints, inclusive.
> 
> That's a bit short. I think it would help to add a reference to the
> aspects of the standards related to this attribute: permanent streams
> for SCSI and FDP for NVMe.

The specs regarding write hints have not historically been stable, so
I'd rather not tie kernel docs to volatile external specifications.

> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index a446654ddee5e..921fb4d334fa4 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -43,6 +43,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
> >   	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> >   	/* Inherit limits from component devices */
> > +	lim->max_write_hints = USHRT_MAX;
> >   	lim->max_segments = USHRT_MAX;
> >   	lim->max_discard_segments = USHRT_MAX;
> >   	lim->max_hw_sectors = UINT_MAX;
> > @@ -544,6 +545,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >   	t->max_segment_size = min_not_zero(t->max_segment_size,
> >   					   b->max_segment_size);
> > +	t->max_write_hints = min(t->max_write_hints, b->max_write_hints);
> > +
> >   	alignment = queue_limit_alignment_offset(b, start);
> 
> I prefer that lim->max_write_hints is initialized to zero in
> blk_set_stacking_limits() and that blk_stack_limits() uses
> min_not_zero().

How is a device supposed to report it doesn't support a write hint if 0
gets overridden?

