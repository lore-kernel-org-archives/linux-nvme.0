Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBDEE7E0CD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SwjHN8bGovo0Q3YfaXuFxwXgd8+9Xdq2avfc0XqKgLk=; b=37zQXs4jD90k/egSMGVwdVEuwK
	WSO7ZX9TfkjtsM42eo5kC7win7KkSKvnP5hNEmGCPKd6h92uxGJSrX3UVB/RQh2+lgs6ldwHzjMPw
	P4YWRkyKZrwu6LPWuIKXJWi1S+m+gOjZXqKG5IbVMmV+sGu2h2//1Ydsxa1HmlPiFUz9N/sHEAjYm
	80GuYmEVPYChA9TwINqOir/7pF/5VoHLtqqFhJAZgNHOx6g7LW8d018MOyNdxLUu7dVuRzpACxZrL
	v1aYYsD0UB+747X+wBS5RIP1JnteVFcvPI6oiKcKwPzyARtoB+TXLuDcfP+9Vy4IMe9i07wYysRLH
	zWgs7Ywg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpV8S-0000000FmRi-43yY;
	Mon, 09 Feb 2026 17:33:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpV8Q-0000000FmRB-3WX1;
	Mon, 09 Feb 2026 17:33:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1E282402E4;
	Mon,  9 Feb 2026 17:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502B0C116C6;
	Mon,  9 Feb 2026 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770658398;
	bh=2Hb+UNIiEGocniymuKs6cMDcwekIGmDxi7MXI9H+xkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHnD3ZUYfRfwaMMY95GtqybyB4h3KN+nllONBz6jjwKHHN1hRec5/D9habNfjOlmK
	 vc/ODRS8TdWtgQw/I62uM6WlvAPsTKofYjwUnZAW/JrRad/LoRS2k6c389YCy51lz0
	 WwcpUT3rJiPFmrHW3u8Gch3xM4nLYsgpOU0nMJBvMZczPWZyzrAj8VH3WUXuKFFrjd
	 8E9P/FAyJa2QLp6hTzW7qz3Kxk/9dQ/ATXX+zTBvG0mK/8DoDu1ZZ4/8KzBj0zSzP3
	 mmx032WZh9Osrd9KZ6L4dxH5k4M35Qu8tWlReInMP3lQW1EpD7ALsV3qPTdgqjBpYt
	 BR/oSSGLXNAXg==
Date: Mon, 9 Feb 2026 10:33:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, sven@kernel.org, j@jannau.net,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com,
	neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs
 file creation
Message-ID: <aYoaWwI-sl5hK6s_@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-5-yukuai@fnnas.com>
 <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_093318_920355_D66A1702 
X-CRM114-Status: GOOD (  20.44  )
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

On Mon, Feb 09, 2026 at 08:40:29AM -0800, Bart Van Assche wrote:
> On 2/9/26 12:29 AM, Yu Kuai wrote:
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index faeaa1fc86a7..03583d0d3972 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> >   				 const struct blk_mq_debugfs_attr *attr)
> >   {
> >   	lockdep_assert_held(&q->debugfs_mutex);
> > -	/*
> > -	 * Creating new debugfs entries with queue freezed has the risk of
> > -	 * deadlock.
> > -	 */
> > -	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> >   	/*
> >   	 * debugfs_mutex should not be nested under other locks that can be
> >   	 * grabbed while queue is frozen.
> 
> The above looks fine to me.
> 
> > @@ -628,9 +623,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> >   	if (IS_ERR_OR_NULL(parent))
> >   		return;
> > +	/*
> > +	 * Avoid creating debugfs files while the queue is frozen, wait for
> > +	 * the queue to be unfrozen and prevent new freeze while creating
> > +	 * debugfs files.
> > +	 */
> > +	if (blk_queue_enter(q, 0))
> > +		return;
> > +
> >   	for (; attr->name; attr++)
> >   		debugfs_create_file_aux(attr->name, attr->mode, parent,
> >   				    (void *)attr, data, &blk_mq_debugfs_fops);
> > +
> > +	blk_queue_exit(q);
> >   }
> 
> This is not clear to me. Why are concurrent queue freezes not allowed
> while debugfs attributes are created? I don't see any code in debugfs
> that calls back into the block layer while creating debugfs attributes?
> Did I perhaps overlook something?

I had to look up the original commit that introduced the WARN,
65d466b629847. The commit message says "Creating new debugfs entries can
trigger fs reclaim", so that must be the path that enters back into the
blaock layer request_queue.

