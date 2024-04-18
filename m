Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B14C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g3KgCBSPjJjHJWSvgaQ+tLi0sPj4Jqug93DUuT/lNU4=; b=U6laG4nGysvQA1A3QWnRcNG7dn
	Qs50MtGrCINPFNEBsCvtKr8t/RzFE3MpAwLCujmQydsrCpSviAoB+RbejKE2RFuzDNIn6wlrdaIYM
	1M39vNpOmEeBRDUYhWRnzsjpLZOXJqSpPz6LHlCNHaF7X2sKf/v1uDcvHx+cRKvaa2lSF4DGFWEsg
	J3I6FJAwZwAJGd07Tqunj2qfcXgp+fMAArXAvfQrij0Cq/P89bCy5HounF+gXvOrYRDxbYOARGNLH
	YiONl0ZzF0+iD6Srb6G9oHERqYPdVUHLmjo5lMXVXRhdvugQzUvFQJhv0r+g8UTgGvvyEpUE4M6Mm
	bEYCHpTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxSzt-00000002fcb-1BYA;
	Thu, 18 Apr 2024 14:44:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxSzp-00000002fc2-424g
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 14:44:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3C8BC617A9;
	Thu, 18 Apr 2024 14:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5003BC3277B;
	Thu, 18 Apr 2024 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713451455;
	bh=FwSHfbLOthjLP4yDU0g9jAkfCHoZwXby3PDjf5/OVng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lddLMscUCQs2lg/GoK5dmxr/U5yIlpaCKZIelRdGd4ePp7BubPkafwDdMfNlqBxkB
	 5s9krvFlOo35WlslIRv4da/OBhRDg7VgHnOZoAc9VlvvQX0QGjsuIxddTsCGDumsOZ
	 xjayuUutX1lIVIbRQUQjEQua1qOSBcwHxygBPEfkpNuEEYrJc3p4fEsNhR3svyt508
	 /2F3RXGHs2jDbT+TseXR4pCK9QKwu3bmOaPhfa22msXEcQmTiGy1GdGhGcL60pECv+
	 Gxcj9vL+hc3U3sDqECmx97YMIC4pVem3jf9JLxXKOnJUwVcBklxgzwzN3bgk7Y5VrJ
	 BaJNboGEvF8AA==
Date: Thu, 18 Apr 2024 08:44:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <dwagner@suse.de>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Tomasz Zawadzki <tomasz.zawadzki@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-cli spdk plugin
Message-ID: <ZiExvFvUPk4HOt3d@kbusch-mbp>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
 <20240417142610.GA31809@lst.de>
 <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
 <09b3d5e9-0ead-44b0-8517-2a1954026784@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09b3d5e9-0ead-44b0-8517-2a1954026784@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_074418_080816_4F3D6F1D 
X-CRM114-Status: GOOD (  29.46  )
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

On Thu, Apr 18, 2024 at 08:25:45AM +0200, Hannes Reinecke wrote:
> On 4/17/24 16:31, Jens Axboe wrote:
> > On 4/17/24 8:26 AM, Christoph Hellwig wrote:
> > > On Wed, Apr 17, 2024 at 10:33:17AM +0200, Daniel Wagner wrote:
> > > > There is a PR [1] pending, adding a spdk plugin for nvme-cli. The
> > > > problem this new plugin tries to solve is, that with the recent change
> > > > to use sysfs only for discovering the nvme subystem, nvme-cli
> > > > lost support for spdk.
> > > > 
> > > > My question is, should we have a special plugin for 'list' and
> > > > 'list-subsystem' or should we try to get this somehow integrated into
> > > > the existing code? So that 'list' just works?
> > > 
> > > І don't think nvme-cli should deal with anything that is not driven
> > > by the kernel nvme driver.
> > 
> > Exactly, why on earth would we care about spdk at all in the first
> > place, nvme-cli or not.
> > 
> 
> And that depends on the direction of development we want to take.
> Do we want nvme-cli to become a 'general' nvme management tool, then
> we should investigate in having an spdk plugin.
> Or do we want to have nvme-cli as the cli for the linux nvme kernel driver,
> then clearly we wouldn't need an spdk plugin.
> That, I guess, is the real discussion.
> 
> Personally I would vote for the first option. But I'm sure others have
> other opinions.

I don't actively maintain this right now, so I think it's really up to
Daniel. It made sense to me from a design stand point that this utility
should have OS-agnostic abstractions. It's not a priority for me, but if
people are willing to maintain non-linux kernel environments, and as
long as that doesn't interfere with Linux kernel development or break
existing kernel usage, then I don't see why not.

