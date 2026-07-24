Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B83EC531C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NdIIWNJ3ERJGsJjiN9AEhl+dFqQlbhp2u6CVyCyiXJU=; b=WrBZ5RyIStawtbWPUn2ZmnrFw8
	QMvf240bcqvCvSkz8T3irFCVWlSDigzUK6smSy10RGpeYVTe9WAwpfdQy1ZNcXdXwcj/NLNFY1iCc
	hZzuFI5vZpr6RPbtwQVoUUCTTV5hRgQk0xrTW7OqSzATHWQCMr1oGpP7/sbQMgvZqsFNOp5bsnMmf
	vhH19drHl7veFhYtWYKU1qKF0CXB8mHj5uCli9iQT1WnYPVBf4bIT+XTkwsi7tOwsf4AJ9yok6s/e
	hbRh17QhblKSV+0NbwQVv/vmSKk6r6bfsBkYtpAw37q1jmAsi91ukIiutkiGq6iy9k4UVdQ1/5k8V
	y5LEAjww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnFHq-0000000GPnt-1InB;
	Fri, 24 Jul 2026 12:45:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnFHp-0000000GPnh-3Ytu
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 12:45:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F292600AA;
	Fri, 24 Jul 2026 12:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40BD1F000E9;
	Fri, 24 Jul 2026 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784897156;
	bh=NdIIWNJ3ERJGsJjiN9AEhl+dFqQlbhp2u6CVyCyiXJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aW1LGXubKWmZ7lNn4RAQkojiORE442GPtMZOnI+ff9putpeT4OLQArHbUv+Z3m2t/
	 sTZe3vn3/ZJLnMLrzGTfsCaZfmH7m+ABSiKImPhyYFoEW+rZpoI7Bcy+UM98M/p167
	 HMnlvyXKaj6cAfPHq3eNsfsBUVJR3tl0A0hNuZbcB+lchr4vUg70/dBf2g981DWeg3
	 WctRX3oUyoARZeD8xVcg/cm8pEJpc2PLl6noZZAgK4odMxP5ICpnsnYLIyNNecu4AC
	 c4+zx3tP4oLcG/Y9PDFLM7mYuupMcuUrNh+rlcT3XzXgR3Fjgb7jdotTLpVBIFF4wF
	 +1b29CjCDk+7Q==
Date: Fri, 24 Jul 2026 06:45:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
Message-ID: <amNegPEvRX99EvPN@kbusch-mbp>
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
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

On Fri, Jul 24, 2026 at 08:09:51AM +0100, John Garry wrote:
> On 24/07/2026 06:01, Christoph Hellwig wrote:
> > On Tue, Jul 21, 2026 at 11: 45: 53AM +0000, John Garry wrote: > Setting as an
> > RFC as adding this extra bio field is not acceptable, but I > can't see how to
> > lookup the original partition. In general it is not, but you should mark this a
> > 
> > 
> > On Tue, Jul 21, 2026 at 11:45:53AM +0000, John Garry wrote:
> > > Setting as an RFC as adding this extra bio field is not acceptable, but I
> > > can't see how to lookup the original partition.
> > 
> > In general it is not, but you should mark this a block patch so that
> > Jens can better cream at you :)
> > 
> > I'm also not sure that supporting per-partition diskstats on a multipath
> > device makes too much sense, but then again there's a lot of setups
> > that are crazy and actually used..
> > 
> 
> It just seems to me that we should have same behaviour as if it were not
> multipath.
> 
> So we can't use bi_private as that can be set by original bio submitter. I
> was thinking that this bdev pointer could be temp stashed in bi_next (as it
> should be originally NULL), but that it dodgy and maybe won't even work.

Failover is corner case to consider here. We always reset the bio bdev
to the part0, so your stats will be incorrect when that happens. I think
you can quickly fix that in your proposal with the "bi_orig", though.

Can we just thread through partitions for the bio's block_device instead
of assuming part0? I know the hidden path devices skip partition
scanning, but maybe if we let it happen, then those will have the same
partition setup as the head gendisk. Then we can go right to the
disk->part_tbl for what we provide to bio_set_dev() for both submission
and failover, and everything should work out from there.

