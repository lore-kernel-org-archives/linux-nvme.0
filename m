Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB10CA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NIcxvp11jXUFmUM+qFjZXCJNh/lwbxU0v3cJxOdWABM=; b=gIICXH7T4TOVoP+tX3JE/eREVz
	9GK3gAPbPp9r6UiIp6ceRF1a8OdyFnLuSCHeF/JtqEd8uI66FwMndDNJUh2d29G7mrW649NgjrnBy
	QvNdaNAtHzQTiKf7fh5OWUk3itM5S22xtC5CLL9c/Lw70I5r9vtSwrlNvvAogDk/SWOq9eqHx5gSY
	fLR/WgyMocVhh8aQwYHZY5RbM7FxCKDEqCw7F6DftJntdmJwuHdDyDHV0Hu399OC/T8CjaZKl8439
	ryr1alXj3LFH4FchTvphbTKZ13jjryXooTlg1ip39U08zeGdmZycK43KN7FyDGDVAbPb9LQi74Nhn
	OCLsy9Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uos1a-0000000FAA8-3fkq;
	Wed, 20 Aug 2025 23:15:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uooO4-0000000Ekoi-3D5q
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 19:22:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2906144350;
	Wed, 20 Aug 2025 19:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5C9C4CEE7;
	Wed, 20 Aug 2025 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755717740;
	bh=nawA7cYxMgTGk3717d4LDLFaPbkaJzVudqPw3UlMoFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJ/d+A7oXtpLOuON7gDLjFxOkgPHYYnE8z2tiFAV5urzXSGkyCyG0AkC7Z+Z2Tyy9
	 dKRsO2Np0klI+38IrfJoJdiYr5KgoyKFGkcpdN8kSdlIXdw9pBOOH+fTnYrGy4hyeG
	 lKDrp+xDqhuvlanuCK39i2UndokQ8mx4/5TBIF4t9MMK1ghlJe0rV+uNgZIV48oYPb
	 ULMqzPslbR3H/eL1ng+hExUawKFajvVfxOnXgSSiFUjMN0tLQPZc30KdFplk1W8cUE
	 RGBVyXoUb+grq7ytHEv67FYQ1QLLKosmEWSbo8a4D1DtQ1oQlkXpmsTD7kAIJ5X06y
	 Ww3Q9ALJg1c5A==
Date: Wed, 20 Aug 2025 13:22:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aKYgacJZCQEx1kf1@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <20250806145621.GC20102@lst.de>
 <aJN4b6GS30eJdQLd@kbusch-mbp>
 <20250810143112.GA4860@lst.de>
 <aJoL1rsvI5bXkod_@kbusch-mbp>
 <20250811161756.GA25496@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811161756.GA25496@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_122220_823984_3DCC9BA2 
X-CRM114-Status: GOOD (  18.77  )
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

On Mon, Aug 11, 2025 at 06:17:56PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 11, 2025 at 09:27:18AM -0600, Keith Busch wrote:
> > I initially tried to copy the nsegs usage in the request, but there are
> > multiple places (iomap, xfs, and btrfs) that split to hardware limits
> > without a request, so I'm not sure where the result is supposed to go to
> > be referenced later. Or do those all call the same split function later
> > in the generic block layer, in which case it shouldn't matter if the
> > upper layers already called it?
> 
> Yes, we'll always end up calling into __bio_split_to_limits in blk-mq,
> no matter if someone split before.  The upper layer splits are only
> for zone append users that can't later be split, but
> __bio_split_to_limits is stilled called on them to count the segments
> and to assert that they don't need splitting.

Zone write plugging presents a problem. For the same reason that
"__bi_nr_segments" exists, I have to stash this result somewhere in the
bio struct. I mentioned earlier I just need one byte, and there's a byte
hole in the bio already, so won't need to increase the size.

