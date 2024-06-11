Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4206BC25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlq2gdoPw6hCWcQCFBbD9VlMILogm10DHk+N/qip1n4=; b=NXJmRTqZFLuxVd6xJYj+wKf2ec
	HJqH5bKFVJ26a052bT7/RezGzR6jtCGPOCJo2NXHNCLSUwpuR8gD4Q+1997a5ON7ubWfcaqnPP2Pp
	YJ40K2NbDwvwv+Uv0QESODd4ESpJ+jkYf67Zt86zDd8YWBOogrnTBz8uk2RfNey4LVyw4gWwz4mY4
	mtpbX/ZHrXCtHplMMQlcDBoAvTZw0raAoS56e5YDUBXcmgKnqQezjx7oQGf3PZH7guiuFZMBHDTyD
	RtWJkG+qcKY2O3ZUBOO3kbJL9klVVttUc5tVRdNsUF6wJgfTO0/Af2ptzmTl1wRy0T6AoM9Cz4IvI
	SwwFY1Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH2Y5-000000099n6-2jEy;
	Tue, 11 Jun 2024 14:32:33 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH2Y1-000000099mh-2DYZ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 14:32:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 39774CE10F6;
	Tue, 11 Jun 2024 14:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3C9C2BD10;
	Tue, 11 Jun 2024 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718116346;
	bh=rZ/NuJfOI0JR9xwj3mE1q/DDVmd9Is6ptZwLU3m7Upg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GeHNbzhzDvJo/a7xM7kZub9+mNbzeneJ2fU3vVxSTNerqnqG48aFFO2ndE0R6V/Bm
	 8MfMpN+yyyzNrHYluL8bZUEXI/oyMIAMMG4RTEC6ZYX8uxMChfBA7gYkSFTrNZ7DjQ
	 9IzDGR8F1V+5/HHiduvjP2rjlrWTeRME6USFKzniLLtdyZUVwSxOd6geEZCyEP9D3z
	 eELVsLimq5xSY1lb9s3KwLGHsbqb1zgGpF1bg5d+8dvM3JSMXJ7MvIhSYI6SeNIxT5
	 DLvBGNgYc1bmWnHNC611Gj7AHMxm+XhKAXH2c3T7vqBWOq9V3721AmekfKRIIGwePA
	 PyCzqogMH8HMA==
Date: Tue, 11 Jun 2024 08:32:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	javier.gonz@samsung.com, bvanassche@acm.org, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v2] nvme: enable FDP support
Message-ID: <Zmhf9-CaUe4gD9Kl@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com>
 <20240528150233.55562-1-joshi.k@samsung.com>
 <ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
 <20240608051740.GA24010@lst.de>
 <5e686875-21de-869d-4b19-bdd9e272d690@samsung.com>
 <yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com>
 <20240610115541.GB19495@lst.de>
 <ZmcTHMWb-T78Crfn@kbusch-mbp.dhcp.thefacebook.com>
 <20240611054726.GA2680@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611054726.GA2680@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_073229_967643_18B82BEC 
X-CRM114-Status: GOOD (  22.85  )
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

On Tue, Jun 11, 2024 at 07:47:26AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 10, 2024 at 08:52:12AM -0600, Keith Busch wrote:
> > I agree the FDP setup is complicated, but none of that is taken on by
> > the driver. It just discovers the capabilities and maps an arbitrary
> > software "hint" to an arbitrary device "hint". It's up to the
> > application to use those optimally; the driver just performs the
> > requested mapping.
> > 
> > Is it because the names of those hints indicate data lifetime? These are
> > just arbitrary numbers used by applications to separate placement. If
> > they were called HINT_A, HINT_B, HINT_C, would that make this ok?
> 
> No, the other problem is that FDP very much has an implicit contract
> that the host actually aligns to it resources units, and actually
> has a really complicated mangement.  It's not a simple throw a
> lifetime hint at the drive.  Note that the implicit is indeed very
> implicit - it is a really horrible spec with a lot of assumptions
> but nothing actually enforcing it.  If you just use it for dumb
> lifetime hints changes are that you actually increase write
> amplificiation.

NVMe has various features that recommend many things, but none of them
are enforced (see NOWS, NPDA, NPWA, etc...). We expect applications to
act in good faith, but nothing is enforced at the protocol level because
it is difficult to bring on useful software otherwise. You just won't
maximize benefits if you don't align, and FDP is no different.

The fact that setting up a device to use FDP is such a pain is a clear
indication of the user's intentions and responisibilities for using
it. Yeah, a degenerate application abusing FDP semantics is worse for
performance and device wear than doing nothing at all, but why should
anyone care about that?

One thing FDP got right was mandating the Endurance Log: the drive must
provide a feedback mechanism for the host to know if what they're doing
is helpful or harmful. If you're just blindly throwing random fcntl
hints, then you're not the target audience for the feature; you're
expected to iterate and tweak your usage.

