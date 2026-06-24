Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8284CDB479
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZ7P6x0uVaMNQmDhu5KfMAfMzMZBFhtl1uMICs1hfBg=; b=qMt2LbFP/XisNsego13rNawNFN
	xSRquzgNGVB2ckWIc92wJNFjAkAJimgtZMmoEI+2lIG3Z58GEoa9xDcRDFBpm+slmWWZK4fFUed1V
	/6KR7P/42cQ3MWTR4H+ROmnALyfAEy7+bqqF5TulqA78HY5dUH76eSoguOdX/m9FEFI63VG//qdm/
	csfFA6jYguZl8Iz5EwZ9PBTQ2tV/sUULUDMNAOkVBx7QNzP6AI6dKJuhDSBZBZbeALQNTVlULpMi0
	c3Zsl3dr097Os036quacfmbAiEK9p4feg42BvMDDaDqOBUd+0o0I8b76yF9xzPKbPjQdlgVKAGb4+
	mXAayZdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcVtP-00000008ONx-39o8;
	Wed, 24 Jun 2026 22:16:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcVtO-00000008ONn-1ePV
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 22:16:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3863260018;
	Wed, 24 Jun 2026 22:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0C01F00A3E;
	Wed, 24 Jun 2026 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339379;
	bh=YZ7P6x0uVaMNQmDhu5KfMAfMzMZBFhtl1uMICs1hfBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A47U5WQmp85bx4BlCi3DS/oP6Hc0aEm9F40ZTtYyh11oDBCk7qx3nQpVhvIyYR69a
	 qlEzcz6cWqID8zMwpUw+CVMKJMfrZFTk9JbdAujrdjiUQdzdelAG5VHWJbkW5bGKg8
	 Z74uqb/ivloCpT92S5ecsAF7poEeqEOVAy1sAHzzR0Lofl+n/7F0w8qCuIrYzJNwkQ
	 8ZdvmnYFwjo6yu0dtYzbXe/5MOQu1ZiYbnXtJLH6uQHmDEN+OdWGmYAQagQS8T8vfS
	 FE8vJttCwxVUzEfJIzHVe/itoOk+1MsAiq5mdGQG0NZzN0zZGV7bwXi+3jnepSU4c5
	 5Ck3abhBjAoRQ==
Date: Wed, 24 Jun 2026 16:16:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
	John Meneghini <jmeneghi@redhat.com>,
	Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de,
	chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, emilne@redhat.com,
	bgurney@redhat.com
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
Message-ID: <ajxXMblhuipjnbtS@kbusch-mbp>
References: <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp>
 <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp>
 <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
 <ajRpWLqaEyA6cwkJ@kbusch-mbp>
 <531aa19b-a9ae-44f7-82ce-3714621ceee8@suse.de>
 <ajWOWdD0P5ri9bWY@kbusch-mbp>
 <d46493a3-3c9c-4799-bd63-e8759f04463c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46493a3-3c9c-4799-bd63-e8759f04463c@suse.de>
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

On Mon, Jun 22, 2026 at 09:15:16AM +0200, Hannes Reinecke wrote:
> But then you'll have to delay the (re-)scan until the very last reference is
> gone, otherwise the nsid the scan is about to create
> will be blocked by the nsid still pending to be deleted.

It's not about the last reference. Either something changed or there was
some previous misunderstanding when that kobj name uniqueness was
introduced to this driver. We just need to wait for del_gendisk to
complete, which is usually already serialized in the same scan_work. It
doesn't appear to matter if a reference is held on a kobj waiting to be
deleted.
 
> In general I fail to see the issue here.
> Any modern distro should be using persistent device links to access
> devices, so the actual device name is pretty much irrelevant.
> We on our side haven't had any issues here since ages.

I agree there's not a real issue here. The suggestion is purely a
quality-of-life improvement to provide a visual clue that aligns with
people's expectations, reducing any surprises. There are people and
documentation that still think the "n1" in the nvme0n1 means it's NSID
1. If we can easily align to that, then why not? But I'm not exactly
needing this feature either, so if you think there are some "gotcha's"
here that may destablize the current scanning, then I have no
problem shelving this one.

