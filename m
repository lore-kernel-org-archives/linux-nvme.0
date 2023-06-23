Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDD6EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jun 2023 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+DoO2j6ppTVH/sLO0KR8iWARrKHt+dgeOh1uqfl/yb4=; b=mdJ8ugpvgEFJgeOz+0WN+4V/sE
	PYB96UPRAARo4iq4n4yfgR/QyZpscOwuoflMDBGhc9byNELXgaJdX1ao0ywk4xOfjEuXRB14wD05R
	AlHQ1atZDpqFMVM8Ur49YAYgkKn+IxCtkvuPdmvMRUdiv1rgj6ifAztONRa+N6lQIgep5iQhANqgA
	KREv4YRUu7XP2uyiUJMPDXolhIITXLwVygzH9Hwx4htB3MbSK5Y9CLSjXAItdGW6NHkI2md7d8nEw
	yRMzFZIV+Jb9t/Io9HwegBtU1q7dMeDvpy/3OzJpDxHQJHOQlGMLbiEvbAo3ohIyJ5Am6KoAI2gZN
	U5Zs9nPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCj1B-003zA3-1M;
	Fri, 23 Jun 2023 15:48:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCj19-003z9d-0e
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jun 2023 15:48:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AA75161A71;
	Fri, 23 Jun 2023 15:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1340C433C0;
	Fri, 23 Jun 2023 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687535289;
	bh=+DoO2j6ppTVH/sLO0KR8iWARrKHt+dgeOh1uqfl/yb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSmfhtczoujVSlpnvZ2S1Yq0GJaZbfq6GyIdHQnODXGohELbsJ0W8TOlnfV7ZXVPl
	 MmM3etdnGJkIxbzW9VI5QBnHUa7iPGzsmWFyBU2RBP3fVbyYbpC1qMiXlupgK7YXRw
	 aBPML8IM+FTp0iSYqPmrnkEeUMRrr5veRfYw4hcgDRGBS6BRYGtwcAZMAS2ggcrmH3
	 BaeRdelEGdJIOQsXyxN7a82YN2TmmsD23gMYXNOWlOVolHVdbGSyKJDLQMXVuKFB8m
	 cwfpJ3eAbgGt/vNXToZ5VYBqJcHoZ75uo+vOKq5+wU62kB8ndTTQX+0bzqV5/1eyum
	 vbyyctvep+qaw==
Date: Fri, 23 Jun 2023 09:48:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"smith, erik" <Erik.Smith@dell.com>,
	"Rose, Charles" <Charles.Rose@dell.com>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: What's the upstream disposition with nvme-stas?
Message-ID: <ZJW+toS0tyjMsJf+@kbusch-mbp.dhcp.thefacebook.com>
References: <b7f6bba3-30b0-8d55-e285-b922101a04f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f6bba3-30b0-8d55-e285-b922101a04f4@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_084811_344325_DF23AC57 
X-CRM114-Status: GOOD (  21.21  )
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

On Thu, Jun 22, 2023 at 01:41:30PM -0400, John Meneghini wrote:
> At LSFMM this year I spoke with privately with Keith Bush and others about
> the status of nvme-stas. When Keith and I spoke he told me that Dell had
> talked with him privately about nvme-stas and asked if the nvme-stas
> functionality can be merged into nvme-cli or otherwise accepted upstream.
> Keith said that he told Dell, after looking at the nvme-stas implementation
> (again), the answer was no.

It's not that I told anyone "no" on merging -stas with -cli, or that I
was asked to do so. That was a mutual conclusion. The two projects are
sufficiently unaligned for such a destiny. nvme-cli is a stateless,
one-shot command based utility, just like it wanted to be. Not that it
couldn't support the features; it'd just be done in a different way, but
there isn't interest (that I know of) in developing a fully flushed out
solution there.

While I personally don't like the tooling fragmentation or that -stas
can break things that don't subscribe to their way of configuration,
that's *their* problem to sort out with their users. I don't have such
hardware, so I haven't got a horse in that race.

> general purpose Linux utility used for discovering and managing nvme and
> nvme-of devices. This is the nvme-cli utility. This is what's "supported
> upstream" and I'd like to end any debate about whether or not the upstream
> community supports nvme-stas. Nvme-stas is supported by the upstream
> community to the extent that it uses the kernel and libnvme APIs to access
> nvme devices; just as any other third party user space application that
> exploits these kernel and user space APIs is supported. Other than this,
> nvme-stas is not "supported upstream".

I'm not sure we're all aligned on what "supported upstream" means.

The linux kernel has to support the interfaces it exposes to user space
no matter who's using them.

The tooling using these interfaces are independently developed, often
loosely organized. There's not really an individual authority that makes
decisions on what counts as "supported upstream". These things often
happen organically as developers and users converge on solutions to
common problems.

Dell is free to call their repo the supported upstream "nvme-stas"
utility if they want since they are apparently actively maintaining it.
That doesn't mean any 3rd party entities or greater linux-nvme community
are also backing the effort, though.

An OEM/IHV also can't really force distros to support their products
either. Usually those support decisions are based on some merits of
mutual benefits, and it's perfectly normal to conclude either way.

