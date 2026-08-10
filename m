Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503FAC5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2kgdte3d/F5SbB7TlyLxgnUaJPtVrt40lEUouBS2b7A=; b=W6Qx0Eecym0Ru0l2eYnzjGYTwJ
	kmu1tD8MYMPD5ksBOSnbMaBuY3h9GOcWdnb7b3hiJCv3AuvKpts1O1N25AVkpjwEN3LmT1IKMqknd
	pbCLxP+uM4fw0/BedADg09J8gQjHDltA4rwRRb/RT4GGKAiiinB5eKWmbE27EjiIG7Khbus1wOkZU
	Dg73d6xTCyE4nAdjGEvSQ7RCH+h6/1h8qT+8G2pc1X/9FjPDJfBj4vsMYNUqz+kzpKsyHSlyD6ELf
	ymzBOYwKkl+yFNh1QS7D1/b0yMVodxFPMF8RC1efLzmfdT3AJl0VE8Mlt8ZImRWzdM6Ht1y5o+AY/
	hY/XTYbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtXSn-0000000CtgQ-1TY9;
	Mon, 10 Aug 2026 21:23:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtXSl-0000000CtgG-3wEA
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 21:23:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5FACA4070C;
	Mon, 10 Aug 2026 21:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6441F000E9;
	Mon, 10 Aug 2026 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786396995;
	bh=2kgdte3d/F5SbB7TlyLxgnUaJPtVrt40lEUouBS2b7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxpR9Ytj7c3rannud1kYocXuJPUPzR24edw3YEB782bt2r4e1EWbVj1p1uGImBaa3
	 WauI0ZkztesLQBtt3KCeNdKS0PiIkD17cTKwyNLb0AwJStgv4Q3T5V7BU9kOUGKSgs
	 WwGyBrBWmOvXgJo9cj3hemeLgHvld63zyYyQqwuQslTSZ5YROqzC4TDylmrjTc3Dae
	 ltcitqfnOhVucNFwweG2y56t7ONT6rDpckqOhAEmEE9arB+IKKXq5hp6Pu3TYgAOh9
	 mmqh5Uk7Cf0iFZvpW9BuEodswHK8N5gfyhy04y+rzrz8C8nfuX41PHG6PxmiAlF7/K
	 w6ACu7kRT0a5Q==
Date: Mon, 10 Aug 2026 15:23:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chris S <coshi036@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	tom.leiming@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered
 context
Message-ID: <anpBQXfo7eGNU2-v@kbusch-mbp>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-4-kbusch@meta.com>
 <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com>
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

On Mon, Aug 10, 2026 at 05:12:45PM -0400, Chris S wrote:
> Keith, I checked this patch against the nvme_setup_rw() WARN I reported
> (the second link in your cover letter).  __bio_split_to_limits() is
> called from blk_mq_submit_bio() after bio_queue_enter(), on both the
> cached-request path and the newly-allocated-request path, so the bounds
> check is now serialized against the freeze window in
> nvme_update_ns_info_block().  With the capacity forced to 0, the bio is
> failed here and can no longer reach nvme_queue_rq(), which is exactly
> the race I hit.  Thanks for picking it up, and sorry for the slow reply.
> 
> I'll drop my own "nvme: don't WARN on I/O to a namespace revalidated to
> unusable metadata" patch in favour of this.

I'll need to revisit this approach as it is dependent on something in
the stack calling the split to limits functions, as well as the upper
layers error handling for a catching the end-of-device condition later
than before.

