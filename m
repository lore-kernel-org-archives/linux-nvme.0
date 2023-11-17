Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7C5C197A0
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BrMevhEC+HBsYKCclRMK+YLRfR26OsglMgWcETLYBFU=; b=XsF5xU/HkR+wRJtnMnpk7JWkI1
	kaQG1o+Ox4jarHI/VcEkZBu9BHE+f+Ct5Sl4OQ16/8NKhttG2TppT+pMYzNx/xG6pOlcev6Nid9Vy
	BKav3zY6ETzVFamB3L//c3xVvisvvVKo07sUpe2gxRJxSCH1KpIBs+4QFDIR//iPYWognhYmYO57o
	8pvpUR4gdJzYFt3/fw5hwvMfPeOJtia6n9htbJqmSaYHNZk2+1I7ghdP0sG67dI7h8sRtykiuyr5S
	mUDDrX+tzpzJvCMRy5nNEPVku38JNGLJLSgx1aUmKa5qJyX1hgypVIOsiilu2fo37bfweu/taXCtY
	Lo6tc+/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r41rO-006wti-2P;
	Fri, 17 Nov 2023 16:38:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r41rM-006wtL-0n
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 16:38:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 316F661DC3;
	Fri, 17 Nov 2023 16:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5364FC433C7;
	Fri, 17 Nov 2023 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700239102;
	bh=3MM1YohxYnrQgmM0ptEo/aF7UCmmakmOqrWmEGOq100=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VI8dahV4Mt0aY7x/ngOvr+2O7q+DqJZgFPITlqGN6kga6t4ypIugxms7RHZOhxEv1
	 JkDYnVg2PVDJyIUEv2y/Ii0A8sqySjXpSII87E+YfOhcKCMM0vlaF1lUGVFGWmXtrU
	 PcDpF0ZJrghl4yYSN30/cNQjnW25ejKQDt/j8d0vctLksqV1wKj7VyzgwIgRQW70wR
	 K/DUNX+GHW1ueSkLasPnQVMvJbsKAUM+MvCC/9yr7CehEEkJQEgcZr0Gu9FmZegk9E
	 +ZS9hlCxcpv30PbAfASky84LZCztOoFsfg3eWzlJl2qLlPMhY11MRdrSL4DzIYqcwl
	 O0gtb5ivexILg==
Date: Fri, 17 Nov 2023 09:38:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yuanyuan Zhong <yzhong@purestorage.com>, Jens Axboe <axboe@kernel.dk>,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, randyj@purestorage.com,
	hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com>
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
 <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
 <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
 <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
 <20231117132846.GB7867@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117132846.GB7867@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_083824_345166_70175138 
X-CRM114-Status: GOOD (  24.07  )
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

On Fri, Nov 17, 2023 at 02:28:46PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 15, 2023 at 10:52:01PM -0500, Keith Busch wrote:
> > 
> > Yes, in section 5.16.1.6, "Commands Supported and Effects":
> > 
> >   This log page is used to describe the commands that the controller
> >   supports and the effects of those commands on the state of the NVM
> >   subsystem.
> > 
> > Oddly enough, Figure 202 says the scope of the log page is "Controller"
> > rather than "Subsystem". Sounds like ECN potential. You can memcmp the
> > effects log from each controller for a sanity check if you think some
> > subsystem controllers messed that up.
> 
> If we really want to be 111% sure we could read the effects for all
> controllers and do a logical OR of them, but I think the reason for the
> per-controller scope is that for odd subsystems where different
> controllers don't actually access the same namespaces these flags
> could be different, i.e. one that only does KV, one that does ZNS,
> one that does NVM and one that is just an administrative controller.

The effects log is per-CSI so different command sets won't create
conflicts.

Namespaces that are not shared don't really matter here because this
problem is unique to mulitpath.

It doesn't make sense for effects logs to be different per-controller
for the same shared namespace. The spec doesn't seem to explicitly
prevent that, but hints that all hosts should be seeing the same thing
no matter which controller they're connected to:

"
  If the namespace is attached to multiple controllers, the host(s)
  associated with those controllers should coordinate their commands to
  meet the Command Submission and Execution requirements
"

That couldn't be a reliable suggestion if the hosts observe diverging
effects. For the controllers that a host does see, though, I agree we
should use the most cautious effects reported with logical OR of them.

