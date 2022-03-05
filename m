Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99904C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Mar 2022 21:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3RDDzFFcsVFqDTU6+6tljJIJguIScfrlilO76gWIj1g=; b=cuRf/mkDZc4ezIx1qF7UuDYtvc
	HxkxfbcNMECHgjwXI1b8iKYe149fxqHQgAYmDFjK0/oa0uihKQO40Br54tFV36/XcFEAsAm+Jp5kU
	nFdejHbM3225LyEc+a9AOJlCV7NPwVPD0K70K1CB4If43vNA2XkqwkumUyG5K2d/6N5Pq2iiLd6P6
	1ihBqysLCczxByuPUiCvDJwRcbWlI1e4oTeiyGaC1+4IbnvuTqijrzKq7s43IoWR4eLy9lOjoZOoP
	FZDr+oys2cSVeubxM13I+tm968HbhrjwrifmQvUup4qcPA3Wu6XXZ7qnMtDEFDiixqVJ0aelwtFcG
	aSv2XOLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQc9A-00DsN6-KU; Sat, 05 Mar 2022 21:41:04 +0000
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQc96-00DsMN-Qr
 for linux-nvme@lists.infradead.org; Sat, 05 Mar 2022 21:41:02 +0000
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au
 [49.186.17.0])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 91F0F53071C;
 Sun,  6 Mar 2022 08:40:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1nQc92-001xlk-2s; Sun, 06 Mar 2022 08:40:56 +1100
Date: Sun, 6 Mar 2022 08:40:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220305214056.GO3927073@dread.disaster.area>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305051929.GA24696@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6223d8ea
 a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
 a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
 a=PBs3jEgWuutBivueVwoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220305_134101_061684_79FD0E5B 
X-CRM114-Status: GOOD (  19.73  )
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

On Sat, Mar 05, 2022 at 06:19:29AM +0100, Christoph Hellwig wrote:
> On Sat, Mar 05, 2022 at 09:12:55AM +1100, Dave Chinner wrote:
> > AFAICT, all the filesystem/IO path passthrough plumbing for hints is
> > now gone, and no hardware will ever receive hints.  Doesn't this
> > mean that file_write_hint(), file->f_write_hint and iocb->ki_hint
> > are now completely unused, too?
> 
> No, for the reason tha you state below.  f2fs still uses it.

My point is that f2fs uses i_write_hint, not f_write_hint or
ki_hint. IOWs, nothing in the IO path use the iocb or file write
hints anymore because they only ever got used to set the hint for
bios. It's now unused information.

According to the io_uring ppl, setup of unnecessary fields in the
iocb has a measurable cost and they've done work to minimise it in
the past. So if these fields are not actually used by anyone in the
IO path, why should we still pay the cost calling
ki_hint_validate(file_write_hint(file)) when setting up an iocb?

> > AFAICT, this patch leaves just the f2fs allocator usage of
> > inode->i_rw_hint to select a segment to allocate from as the
> > remaining consumer of this entire plumbing and user API. Is that
> > used by applications anywhere, or can that be removed and so the
> > rest of the infrastructure get removed and the fcntl()s no-op'd or
> > -EOPNOTSUPP?
> 
> I was told it is used quite heavily in android.

So it's primarily used by out of tree code? And that after this
patch, there's really no way to test that this API does anything
useful at all?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

