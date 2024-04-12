Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA101C4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jkgbyu8KXQDKdXtSlYSiH21++HTJoaEl4z1b0zvQEf8=; b=acLzPvQ1pBNSgTIE72ULef2ksW
	FolUCrRBMVbHd0gLCNHb7d5l6IefKX7zS5j3yZ3ps6D0CDRL6ccjf4q3ufN6H3JZ6Umi+FRxssO0Q
	7Jj/w3t7TQzVln3IEhWxpCTcPKAEl6QxaTjp8CtVrsBAKF6D2lb+ZrhQSQGHg4tfIC08MmA+FK8ox
	Cc8Ld9ZjyfBGH3zdM97CrcK/weNeRY/Ow7HqQoFD8wIpFke3rfDUnmhAIrSafTpRYi/iCPiEGMzAZ
	glgk8MoOvhGo0tVeZMaJz37HgBd95knXefgiVk7/T9iix+hDA4fEhMjT5/ozHmAJvoLOxYb1i37EM
	uz+Jg3sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvIlR-00000000Dnu-2KZX;
	Fri, 12 Apr 2024 15:24:29 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvIlP-00000000Dn8-16fG
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 15:24:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 76706CE3960;
	Fri, 12 Apr 2024 15:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F00FC113CC;
	Fri, 12 Apr 2024 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712935464;
	bh=NWBY8Xi/7G/iirnu6Mw/60mc/htaj8sawp6gS840vPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAAGYBOzdEXGRplTCs5I+PgkflKoKKlmPBnvU9lVSUfUE31pbyih/p7afOnx6J3GH
	 QPnR3F8HUQfYkFkm4qhuOeik7iKmMgvmbv+7nw+f/QqRw7y8drkpnDJ69BzWcVCMX8
	 UraR/WHIhXHNlw78hjYWuAjKY+mgyoi92PdTgTPFzy00NvstKA35hssc8a1ATL2HCI
	 KgyTSHfJDXXWxsRqwzv0FmfarI+RcZMAe1sMh489j/3798frVVnzfVHJABrj++kMN3
	 7a+DMWx0/nktukVA6zPrMnKlW6wwXLNScH3OVjBr1+VnjktAad9kbxLuwsQ5Ta8J0B
	 hlHaa0DTyW2Ug==
Date: Fri, 12 Apr 2024 09:24:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6]  nvme-fabrics: short-circuit connect retries
Message-ID: <ZhlSJcTwGVrlk8OP@kbusch-mbp.dhcp.thefacebook.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <ZhiBzXBvjTeDuHbS@kbusch-mbp.dhcp.thefacebook.com>
 <vbptto5zefkdadnpyhcjelfrsgadb2stjh3sole6n6mdd4h7dq@lrdxk5p5qh6w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbptto5zefkdadnpyhcjelfrsgadb2stjh3sole6n6mdd4h7dq@lrdxk5p5qh6w>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240412_082427_515595_DDF12958 
X-CRM114-Status: GOOD (  21.93  )
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

On Fri, Apr 12, 2024 at 09:24:04AM +0200, Daniel Wagner wrote:
> On Thu, Apr 11, 2024 at 06:35:25PM -0600, Keith Busch wrote:
> > On Tue, Apr 09, 2024 at 11:35:04AM +0200, Daniel Wagner wrote:
> > > The first patch returns only kernel error codes now and avoids overwriting error
> > > codes later. Thje newly introduced helper for deciding if a reconnect should be
> > > attempted is the only place where we have the logic (and documentation).
> > > 
> > > On the target side I've separate the nvme status from the dhchap status handling
> > > which made it a bit clearer. I was tempted to refactor the code in
> > > nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
> > > with something nice yet. So let's keep this change at a minimum before any
> > > refactoring attempts.
> > > 
> > > I've tested with blktests and also an real hardware for nvme-fc.
> > 
> > Thanks, series applied to nvme-6.9.
> 
> Thanks! I have an updated version here which addresses some of Sagi's
> feedback, e.g. using only one helper function. Sorry I didn't send out
> it earlier, I got a bit side tracked in testing because of the 'funky'
> results with RDMA.
> 
> Do you want me to send a complete fresh series or patches on top of this
> series? I'm fine either way.

Oh sorry, I didn't notice the discussion carried on after the "review"
tag. Please send me the update, I'll force push.

