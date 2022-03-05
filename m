Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7490AC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Mar 2022 05:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eYIf0CTh3souYhHSw2zpj9pEs2fEKkD4At2691RpuEc=; b=GhYuuXkmgS+AlHsQGwGS/FhW66
	JCCfqsatu8cR0Xx5Xn+DqJ+55QrFl62XuBhU6rE3A1CxucL11ycuAAKQAEEeQS2xGYDer4Qzobbgv
	pX8soHEeJmb/tRqO3IuH5LZfTMYumpVc3O8BE3L8Q9Dbh7YCOdgtT5JUTzUCUnZduL4NuCbZdunAX
	iCkF/XhZvz1TQIaujBaRKI2V0FdkGWxg/E3PT1omIx1L2YUVBHzGa32pVhg7ppU1K8Fb1cBJxR07B
	lGEnipu0kdN4iwfwfi3ZHEaH0Jn0t0FG9G9Lz1Kph4KboM5b1sZPiMbzf7Qw/S96Al//q6FoUVfeb
	yhdXjuLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQMpS-00CmFd-Ha; Sat, 05 Mar 2022 05:19:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQMpL-00CmFB-04
 for linux-nvme@lists.infradead.org; Sat, 05 Mar 2022 05:19:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BE57B68AFE; Sat,  5 Mar 2022 06:19:29 +0100 (CET)
Date: Sat, 5 Mar 2022 06:19:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
 kbusch@kernel.org, song@kernel.org, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220305051929.GA24696@lst.de>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304221255.GL3927073@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_211935_236306_0869AA5A 
X-CRM114-Status: GOOD (  15.21  )
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

On Sat, Mar 05, 2022 at 09:12:55AM +1100, Dave Chinner wrote:
> AFAICT, all the filesystem/IO path passthrough plumbing for hints is
> now gone, and no hardware will ever receive hints.  Doesn't this
> mean that file_write_hint(), file->f_write_hint and iocb->ki_hint
> are now completely unused, too?

No, for the reason tha you state below.  f2fs still uses it.

> AFAICT, this patch leaves just the f2fs allocator usage of
> inode->i_rw_hint to select a segment to allocate from as the
> remaining consumer of this entire plumbing and user API. Is that
> used by applications anywhere, or can that be removed and so the
> rest of the infrastructure get removed and the fcntl()s no-op'd or
> -EOPNOTSUPP?

I was told it is used quite heavily in android.

