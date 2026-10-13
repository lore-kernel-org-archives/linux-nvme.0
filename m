Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286FACC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuEKs4xbOD0Ymx6z6GCF2PockKopMGRNzqpG6R9Bh+Y=; b=W0dGpxtOb05VDCESVcd2EVK0zJ
	0JRZT/8/gY7AmxfPn8myP6Ys2QfgdFOZoVwpqpw4Ppb46uwc+NZrPXOHw9lUK4PBkn/gxukAAgZTi
	a6oxonJsYUJsc29Y3H3ulu4sQ1v5S2aZtZbCdmJDRYBkRjVRPkp45/fmKPLeD+93r7bk6PWJoWYvR
	pmfWiTPqiUqAeDKW9b4TR7XTymK4c2dggNQ9cQedVVyAJY6DBeu+/YC+kWG1b8TXAUJiVtHYkKyfq
	drmkZujbD/kG+sakeYkFTKe9SD/REGpxIFtg/60dZhIl956jgM52oO/M0ehNZl5d33VbUnOMa67Ac
	B2YYGZAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeY4-0000000DMmM-2BiP;
	Tue, 13 Oct 2026 15:36:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeY2-0000000DMm0-26re
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:36:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EE9FF60A5A;
	Tue, 13 Oct 2026 15:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D221F00893;
	Tue, 13 Oct 2026 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905773;
	bh=cuEKs4xbOD0Ymx6z6GCF2PockKopMGRNzqpG6R9Bh+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J8FmKVBYw972xk4qMRXwm3J/s5ZTsQIULRdvuvViy/QoLWYVTPXY7qzAzULdlxVgV
	 w3BYUS6eIqygzlf1GxWiGOjmKR9zpXv76fQrmHsCgx1YTOa3Vk9ej9j1tQia9Arxyg
	 rdw0AKYsuH25UEZBQL1ohC516t5y+wy894CnCl79cpmh+5tP6MCDeZKPE6LfOrumrE
	 X1J3rm8kXafBEi3WkB4rpGOE+dFL/3alAfh4y8TQc1l8cfhE6FPEJhDhaX9rkD+fLi
	 Y81ADeeKtImboLqrS+EUt0Ps/Wqb8UecWVWkDuwgsPih7+0i+r9c8U/0JaqR8oH6VU
	 KHjTmMA9G08OA==
Date: Tue, 13 Oct 2026 09:36:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	loberman@redhat.com, Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-multipath: report "none" iopolicy for discovery
 subsystems
Message-ID: <as5P7PlWYWA8exrX@kbusch-mbp>
References: <20260930153658.4002-1-marting@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930153658.4002-1-marting@netapp.com>
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

On Wed, Sep 30, 2026 at 09:06:58PM +0530, Martin George wrote:
> A discovery subsystem never exposes namespaces, so it has no multipath
> head and no I/O paths to select between. Nevertheless the per-subsystem
> iopolicy attribute is registered unconditionally and reads back the
> driver-wide default which is 'numa' for the discovery subsystems too.
> This can be misleading as it suggests a path selection policy is in
> effect when nothing is ever selected, and writing the attribute silently
> mutates state that can never be used.
> 
> Report "none" instead for a discovery subsystem, and reject writes
> with -EOPNOTSUPP. Report "none" from iopolicies as well, so that the
> value read from iopolicy always remains a member of the set advertised
> by iopolicies; otherwise userspace validating the current policy
> against the available ones would reject its own subsystem.
> 
> And while at it, document iopolicies too, which was not covered when it
> was added previously.

Thanks, applied to nvme-7.4.

