Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E094FC27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AAKM2OZB8R/fR9k+N8VOAC2KLaopOWKY3hyEGI99zXg=; b=BTyEiIA0hbLkZ0zmWGVLsCChzk
	9b+82YojK1LK33LqJUy8tDF+OpLDWojfrANVwWuI1S9aemHKqb8hyTRLUkKfy8Xr+0RTCABWrc7Gw
	7yAVc7AsvdZ4eCBtlV4iHuCKXTRomfWhXEec07gIUVmsLQyOztj2TUnfIO9XfdSpoYSyqRgaomMzs
	NzYchfTLWUBranI2E0YZYROkJAqBGKJe0Q/Y+MuigNa0lJCiP/J4zx/7r8qRovKIY9TNEQWSZnP3u
	5C9LyncpGLQnODroRN7gQpxeAQIoeCWFtIwu29yMAHr/a4Pqu/Vs6KYUc/LiYNbVlq6FAWO4enM8y
	NSfIMKBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkU6-00000006EFN-2G1n;
	Mon, 10 Jun 2024 19:15:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkU3-00000006EEw-1jrG
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 19:15:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A043460C07;
	Mon, 10 Jun 2024 19:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEA8C2BBFC;
	Mon, 10 Jun 2024 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718046910;
	bh=L7ZozjW/CAUgCkBG7Y7oL8z6so9aqPVMLj+1HaGaLFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aC2wDHIus0HXZO/CjsYD8+ikV+1Z/HZo7oKJy1yjj5PKXzrYk3ti49hNPhRELCyVi
	 4R/BH/sCRX/vfBS/qInp505tZQQhp9P8Dar0hZFrs9pJrmf7Cg/Bzi56EPiqJATsoo
	 qxw1cWZPSUNkQrrZQArXmZLyQLoFWsqGCKaouLP5sQLQBp/OsCUBu/dUD1SfGlCnuM
	 n9vXMRQ8h+NJ34+BZo9427kh5b9WYNTEZ+G5sT7DWlL8w5kQtgpQsYl9vnHVQ+FR0m
	 QlUT8nWVjRwSTT5LA2Bx6SAPqo1s+yDuTz8Y5bld4P3ndS3Y6xh64kblf0362SqK3x
	 dMMLKT0rMXBOQ==
Date: Mon, 10 Jun 2024 13:15:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Message-ID: <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
 <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_121511_524091_6846AFEA 
X-CRM114-Status: GOOD (  18.90  )
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

On Mon, Jun 10, 2024 at 10:05:00PM +0300, Sagi Grimberg wrote:
> 
> 
> On 10/06/2024 21:53, Keith Busch wrote:
> > On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
> > > Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
> > My mistake. The namespace remove list appears to be getting corrupted
> > because I'm using the wrong APIs to replace a "list_move_tail". This is
> > fixing the issue on my end:
> > 
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 7c9f91314d366..c667290de5133 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> >   	mutex_lock(&ctrl->namespaces_lock);
> >   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> > -		if (ns->head->ns_id > nsid)
> > -			list_splice_init_rcu(&ns->list, &rm_list,
> > -					     synchronize_rcu);
> > +		if (ns->head->ns_id > nsid) {
> > +			list_del_rcu(&ns->list);
> > +			list_add_tail_rcu(&ns->list, &rm_list);
> > +		}
> >   	}
> >   	mutex_unlock(&ctrl->namespaces_lock);
> >   	synchronize_srcu(&ctrl->srcu);
> > --
> 
> Can we add a reproducer for this in blktests? I'm assuming that we can
> easily trigger this
> with adding/removing nvmet namespaces?

I'm testing this with Namespace Manamgent commands, which nvmet doesn't
support. You can recreate the issue by detaching the last namespace.

