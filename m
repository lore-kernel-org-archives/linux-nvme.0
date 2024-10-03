Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB7CF34CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 21:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TMC7yBvfVOcbOk7yxx8betDSeVItQf7ualX1r+D7Z/o=; b=AMS8HlB9sCKifvEndf96R1pp7h
	aq3agSlyy7QM8Yh/K6vmsgJzcr0q83pSkErwFknk1OlRAxnnzWClNja3Rki9iH66nZeHHmqffL3rT
	x4U0ST6zjypgVSZ1LThXL8nETqM+9QkEZR8eQFAMHENtRRRsCf9XzM6uh+omNLIJiKmEPPsYrJun7
	MaM+qmrgi+Qrw1+/ZAFU0Fx8COD8PP3ek1QErWjv91Kpo2YgAJX9uNeHQdoHSAbpzbxPmPFr6mDU4
	nNa0Wu/HqOpEdFtlclDnQ254gh06loazjuHlTyhEutl/b1mDYao1b3yg5kqrkug5MJfYVDW9g2X90
	1G5ylR+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swTgt-0000000AQWO-3UOg;
	Thu, 03 Oct 2024 21:48:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swTgr-0000000AQVy-0mrG
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 21:48:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 75C975C570F;
	Thu,  3 Oct 2024 21:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE120C4CEC5;
	Thu,  3 Oct 2024 21:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727992132;
	bh=4AzBG75BomVJ/TJ9cdnRW/C1hFEjYKKZnSLWMe4SVh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMjPkqbMwo6KWPI/vjV7wXJVcjwZU9LhSDuHlFJrl85NLpOnFN+mcoCL/a5A3Divj
	 z5qDWLrJ6MU/QyLV0Fuz2n1HOo03ima2F4T83y0nI6Fh5zPIyhsNCWSmFhB30vtOe4
	 3YPqLCzzxVHxYqHpqPa0hpTwTUzTJ9PM1AzSfnUMNATDYf3c2ZC6wsfyWZinLRZGe+
	 yQKSCwPkVxyhdwmkwz0NEQRcP0D4kibaGXmB7FbKPIF9yaCBxy9sDH6KEcMNvNMKAQ
	 /VdwNv6PEykXhqeNS5TogetQApSvcMFGBGRtQL7rDPNdm8sXMYnqH8nq0H7Aw4nqVq
	 DFXq83HxwBV1g==
Date: Thu, 3 Oct 2024 15:48:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	hare@suse.de, sagi@grimberg.me, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <Zv8RQLES1LJtDsKC@kbusch-mbp>
References: <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
 <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
 <20241002151949.GA20877@lst.de>
 <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
 <20241003125516.GC17031@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003125516.GC17031@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_144853_291797_AC69D76E 
X-CRM114-Status: GOOD (  17.91  )
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

On Thu, Oct 03, 2024 at 02:55:16PM +0200, Christoph Hellwig wrote:
> On Wed, Oct 02, 2024 at 11:34:47AM -0700, Bart Van Assche wrote:
> > Isn't FDP about communicating much more than only this information to
> > the block device, e.g. information about reclaim units? Although I'm
> > personally not interested in FDP, my colleagues were involved in the
> > standardization of FDP.
> 
> Yes, it is.  And when I explained how to properly export this kind of
> information can be implemented on top of the version Kanchan sent everyone
> suddenly stopped diskussion technical points and went either silent or
> all political.

The nominals can mean whatever you want. If you want it to mean
"temperature", then that's what it means. If you want it to mean
something else, then don't use this.

These are hints at the end of the day. Nothing locks the kernel into
this if a better solution develops. As you know, it was ripped out
before.

> So I think some peoples bonuses depend on not understanding the problem
> I fear :(

The only "bonus" I have is not repeatedly explaining why people can't
use h/w features the way they want.

