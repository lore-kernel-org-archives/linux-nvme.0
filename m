Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35E9C982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZSWVr6kgAoWnv8ZtckKXMuc1UIbG+ZclBFMuo2l1TM=; b=S+zRmSe5kzs2kPy+ymbblAtA2P
	oGzmN+ys4u6DQdZI/+ZrqqFbJm3dCyYChJothiIg3VHMtdX+DAK6W7h+c/kcUI/a4FZHcweoDglBv
	vZSaqvnHYBUUpNf882cCZc5s3UZK6Idr8Ihk9JIsGeQSzueYmh05yUR5soQZMnfFIFS0g+gIIKtPF
	WchMjcyuuNrhxzkeqFi5qg+jaSjwDhN48OhgXOuqG+x3rlY6hBboKkMn7zqefzjOVSzNd68MdkRrQ
	GzSirCrUzhkxmZ6YH8mDY9hNkvsOtyMYshYQOEYpldRxEATgZR43GU3kr6KWWIiKR/xffMRveAbcF
	eq8p5YeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8hpn-00000002z1i-2bg6;
	Mon, 21 Sep 2026 17:29:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8hpm-00000002z1H-2IGn
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 17:29:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E028240347;
	Mon, 21 Sep 2026 17:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAD71F000FF;
	Mon, 21 Sep 2026 17:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790011781;
	bh=MZSWVr6kgAoWnv8ZtckKXMuc1UIbG+ZclBFMuo2l1TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dHqNl1eWJAQOzq5yDgCQSwEckv63xIsxSYjYDf7GqIHpgv5hIHdE4EAcUIADxnWZy
	 vRJ/1EdNroitqlZkVLzVQEZ6A2sYhj7myZE5degC7h6dvGu5GMbKdTZauE3sF1KWN3
	 UDDey3oE92yVNCdvMh1BU/fEjAZsUYE0UGrFFCTteL10UURE3v/6uopvCZGlF9uOXn
	 Yz4j+TKgjZbFaNlUCer/M3xCQLp61urojoJZfVf0LVfLYCyWbt0/cWSsvsf2J0eqKX
	 UbxeBtzB9GFNEwisdyAqckOMwDeI1qHgV0i2XeplsND85dPP/eL85eJfaaAWlKyfEY
	 CmJY4wdyrjYeQ==
Date: Mon, 21 Sep 2026 11:29:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
Message-ID: <arFphFDlyHpnCv0J@kbusch-mbp>
References: <20260903152623.614951-1-kbusch@meta.com>
 <db8c19f8-d087-4e3c-8424-6a90760cdf16@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8c19f8-d087-4e3c-8424-6a90760cdf16@suse.de>
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

On Mon, Sep 21, 2026 at 02:21:28PM +0200, Hannes Reinecke wrote:
> Interesting.
> We have so far refrained from similar attempts as the idea was that
> one CPU would be able to saturate the available bandwidth; additionally
> nvme_tcp_io_work() would be gobbling up any available data, so scheduling
> between two instances on the same queue would be pointless.

PCIe and RDMA can saturate the link with a single queue, but not TCP.
Note, this RFC specifically schedules multiple queues, not the same
queue. It is the same blk-mq hctx, but that fans out to different nvme
queues.
 
> So question would be: where does the speed up come from?

I have the workqueue unbounded, so if a batch of 4 requests comes in on
one thread, they get worked on in parallel on 4 different CPUs utilizing
different sockets. This also exploits NIC parallelisms via multiple RSS
buckets that wouldn't happen with single socket usage.

> In general not a bad idea. Especially if it helps to up our performance.
> But this really points to the same problem we're having with HW RAID
> HBAs: we have an issue if the per-queue I/O performance is below what
> the cpu can drive. Then it _does_ make sense to have more queues than\ CPUs,
> but the layout of which is beyond what blk-mq can handle.
> Ideally we should be able to handle that via blk-mq, too.

I'm still trying to see if we can achieve a similar result just by
making duplicate connections and letting the multipath policy handle the
spread. That does improve things significantly, but I'm getting worse
performance than this RFC, and I still don't know why yet. I didn't get
to work on this last week, so it's still on me to work out where it's
lacking.

> Nice topic for ALPSS ...

Thanks! We'll definitely touch on this next week.

