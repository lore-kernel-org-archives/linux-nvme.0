Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A630C7619A
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Mar 2023 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6l4EeE6MD4sdLf17QJiMOlFp4EvO2Ju0jo20xsSHbTo=; b=Pm55OHC/nje1bLfgNRl3iJNFXW
	9pQSytZRY/doj9F3P3mOiOGBExnKSpMvxYkZUOUSt93w3/s6IlYcjiZB/3hw431WqiwT/bQlL4VSc
	QCFfZz89MsUpJoURN9tdSS7Az54mLV5EoYh9wzmjISUgw4ppCeW4wT2oo+g/2I7BhGC1PMSpp8Suw
	CXrLravgiccQTYAW/KYU4wmHx5pVeGw3IRIxtL4V+0uZ65EB1TYH8Jjabu+vZqVkB6Lf++oOt5Jvu
	Q7UhjPDtj3AW5i94awM8nYG9MZAXIJ39TeAr3vBAZmg1zyp7fably76d0fDaBoJQSdtSsexfWt5aZ
	tvQMtOGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgZbI-009KFh-0z;
	Sun, 26 Mar 2023 23:16:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgZbF-009KEd-07
	for linux-nvme@lists.infradead.org;
	Sun, 26 Mar 2023 23:16:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D33CE68B05; Mon, 27 Mar 2023 01:16:22 +0200 (CEST)
Date: Mon, 27 Mar 2023 01:16:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma
 devices
Message-ID: <20230326231622.GA19436@lst.de>
References: <20230322123703.485544-1-sagi@grimberg.me> <ZBr6kNVoa5RbNzSa@ziepe.ca> <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me> <ZBsHnq6FlpO0p10A@ziepe.ca> <20230323120515.GE36557@unreal> <ZBxOHZwre3x8DkWN@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxOHZwre3x8DkWN@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_161633_222350_9C924EDC 
X-CRM114-Status: GOOD (  20.56  )
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

On Thu, Mar 23, 2023 at 10:03:25AM -0300, Jason Gunthorpe wrote:
> > > > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > > > the nvme tree?
> > > 
> > > Sure, it is probably fine
> > 
> > I tried to do it two+ years ago:
> > https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org
> 
> Christoph's points make sense, but I think we should still purge this
> code.

Given that we don't keep dead code around in the kernel as policy
we should probably remove it.  That being said, I'm really sad about
this, as I think what the RDMA code does here right now is pretty
broken.

> If we want to do proper managed affinity the right RDMA API is to
> directly ask for the desired CPU binding when creating the CQ, and
> optionally a way to change the CPU binding of the CQ at runtime.

Chanigng the bindings causes a lot of nasty interactions with CPU
hotplug.  The managed affinity and the way blk-mq interacts with it
is designed around the hotunplug notifier quiescing the queues,
and I'm not sure we can get everything right without a strict
binding to a set of CPUs.

> This obfuscated 'comp vector number' thing is nonsensical for a kAPI -
> creating a CQ on a random CPU then trying to backwards figure out what
> CPU it was created on is silly.

Yes.

