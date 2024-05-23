Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA1FC25B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+d083vTZ9FoXPfO0liZk9kx7X2fClxBmWZ+HIUpbpIw=; b=0tQasKNf7zhvwDjVatG92R8gq4
	vKoBWxBIJj2Ptyy32nWdLZ/NEhDpiF2GE2dRlZbjb2UJrS+AWQTbipDzBZy4o4bBW0fxzzFpy/dsE
	AxYfyaBmuAoFmoRCeEUfqXAlo1CuFSu7E8imjYDTA2iussHQ1B+GqXydCkXJ4tXTU4q4ofGCIusGo
	UH2C3ZpYOjW2NguGqDBkG7KHC9SDr4of7mZZ9Hq0lNR5hzQC90m0mO6K3RwfZealqOUSxxhv4yO5r
	s9G13nYsGRMLsmUq4qs4tx3qi+Qsz/FG96ibVpMyRc9sJNkwgc2j+9B0zxLg9PIg6F2aN/Qh0DPXT
	qpMeQ8xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA9xj-00000006aXW-2Vy0;
	Thu, 23 May 2024 15:02:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA9xg-00000006aVb-3lDB
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 15:02:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5F7236284B;
	Thu, 23 May 2024 15:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72B7C4AF0F;
	Thu, 23 May 2024 15:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716476552;
	bh=+fqQrt3hnpTLrXUtBMaVQgmEA4TxFWCFPrnZ2/YboJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0qFl4ugfbmvzAbyrFeHsRuCpmntIbGcIh5M5Qh/0AVguwvyo4z7s8LPUrFIluhxF
	 dmXLjLhUIlEUe4nfbH4kvlfpta9jL+ZsEbPOr02eFs1x81BqhxQC8etUc+xTeMgesY
	 ucjpX3Z3SLc3/A5zHlVa8IiH9i/IGeLAMZq68Mkj+vCQ60H6hcWumBMsDhJ1lwLOvC
	 JTBRQbZbd9CTvKcW2+gHVqSZt7ZjxTGlM0+UaET/jCNZNBC5Z7G/GKJO5tW4Ks4V+g
	 sN272R/FWV9l9K8wAFR1nzaruz1CfH1FPa74ZdakqDkeG1C5YGGPBOFtRQcGTnpdVx
	 uOPgAqXqwfodA==
Date: Thu, 23 May 2024 09:02:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Message-ID: <Zk9ahlW3lbKTr7hZ@kbusch-mbp.dhcp.thefacebook.com>
References: <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
 <20240522162845.GA16783@lst.de>
 <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me>
 <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
 <20240523065412.GA29137@lst.de>
 <a643075c-a51a-413a-a0a0-7954049ad918@grimberg.me>
 <20240523123949.GA20758@lst.de>
 <4509c11d-b3ae-4be9-9904-5aaf2628f7f2@grimberg.me>
 <20240523131933.GA23660@lst.de>
 <535e843c-2617-40d4-9ced-009422b4973e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <535e843c-2617-40d4-9ced-009422b4973e@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_080233_093005_AF589851 
X-CRM114-Status: GOOD (  27.32  )
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

On Thu, May 23, 2024 at 04:45:37PM +0300, Sagi Grimberg wrote:
> 
> 
> On 23/05/2024 16:19, Christoph Hellwig wrote:
> > On Thu, May 23, 2024 at 04:02:43PM +0300, Sagi Grimberg wrote:
> > > I just want to have good testing before we touch these areas that
> > > are all done in ctrl reset and error recovery which historically manifest
> > > most of the issues...
> > > 
> > > and all this because lockdep complains on false-positives...
> > I still haven't seen any proof that it is a false-positive.
> > 
> 
> The explanation is that the nvme-pci timeout handler will only disable the
> device when either
> it is able to transition the ctrl state to RESETTING or if the ctrl state is
> terminal, and in both
> cases the reset_work is not running concurrently...
> 
> It was also proposed moving the call to nvme_disable_ctrl to a different
> context (returning BLK_RESET_TIMER from
> the timeout handler) such that blk_sync_queue() does not depend on it. But
> Keith said it won't solve the issue.
> 
> Keith spent more time thinking about this, so I'll defer to him. I just want
> it to stop bothering Shinichiro and
> others running blktests regularly...

Lockdep is complaining about the namespaces_rwsem taken from both
timeout_work and reset_work.

The only time namespaces_rwsem is taken from timeout work is if
timeout_work successfully transitions controller state to RESETTING. But
the controller is already in the RESETTING state because reset_work
wouldn't be running here if we weren't. So timeout_work never locks the
rwsem if reset_work is already attempting to "cancel" that work.

Nevermind the fact that both are using the read lock, so it's not even a
problem if they both attempt to lock it. The only potential problem
could be if someone requests the write lock inbetween. At nearly the
same time, pciehp has to transition the state to DEAD in order for the
special "terminal" condition to apply for the timeout_work to attempt
some kind of recovery, but the removal doesn't take the write lock until
after the reset_work is flushed, so how would the write lock sneak in?

A potential interaction with scan_work while the timeout, reset, and
hotplug run concurrently might be the only part I'm not 100% sure about,
but I haven't found any concerning path so far.

