Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C10606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fyigYjSP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlO7CNL1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=edbmsg+SXMT9ETX6k0GJ0LfN9Rw1n6a802qt5QeYJPQ=; b=fyigYjSPzvL79glha7dJpHVMcV
	DsXiZnJQesMXA/dUQFEhu2AxJbst2iw5JZBCRBhqzO7TsifOhMOkGImnb3eif1QzRa+b/m9MsDgrq
	G6/VO+girR0CWTemGVCFJbCLZZsh/W5nImN/LcDvK6rsFUmtgpNTvoQQOI2+cD4wF9fVN1Mk+uX1V
	/vOPQ6YWgmZeC/ebsqH1ZyvHD9WptM48yhwPjrku215bWuNHKSoaOtBCN8/IG+6HlYoLHpsks77lu
	lB1ZHHKuTS19Mt4baVCv3ufG9mjvYts1YtVMlyzlJ1nZlqIEQcZB0NlR4CJ8FhJQ5k2J/YDn9jf9I
	e9sGdUQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5tm-00000007SfK-2wh9;
	Wed, 28 Oct 2026 15:49:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5tk-00000007Sf7-331Y
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:49:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF76760207;
	Wed, 28 Oct 2026 15:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1CF1F01825;
	Wed, 28 Oct 2026 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202547;
	bh=edbmsg+SXMT9ETX6k0GJ0LfN9Rw1n6a802qt5QeYJPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HlO7CNL1Qk37N6+hq78SEKcytJ/+BhELqmY5BaVwQo4o7hdhenlCyh+BskLFOh6He
	 DnkU9U2R4UA8DfNVEVawUzx8HaCCN8dPHljzdNWAEhrDG/Xy4BCWzcrp2Xayb6Fw4t
	 wij2DD0B6ItnAs+lx+tlV8SDFSch5ZRbjysLz8gjP+4n//aUwVG95CG8bTtTYN8NM1
	 fReZaQQbGPd+qwizrHDgklKv2sFWrHl+cysERdpXzLU/lk9wOjatzWGY01pB2JwiY1
	 e3OVsKcdUI57S6iZAO7U9Rjf7ofdfm3Ii4Yv4nkbAe9f/H++gM+cfFGvUiy13A97pF
	 DTAu3Bcch64pw==
Date: Wed, 28 Oct 2026 09:49:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: Finish the blk plug when integrity allocation
 fails
Message-ID: <auIZcZ-icgA2152t@kbusch-mbp>
References: <20261028064436.550665-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028064436.550665-1-kanie@linux.alibaba.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 02:44:36PM +0800, Guixin Liu wrote:
> nvmet_bdev_execute_rw() starts a plug before building the bios, but
> the two error exits taken when nvmet_bdev_alloc_bip() fails return
> without calling blk_finish_plug().  current->plug is left pointing
> at the stack frame of the returned function, so the next
> blk_flush_plug() walks a stale list.
> 
> Route both failures through a common exit that finishes the plug.

Thanks, applied to nvme-7.4.

