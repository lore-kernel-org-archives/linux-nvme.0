Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EF5C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0auTPA4vYidS64dKlGZ2iuWsz92CCvwlVwRB7qaRuYs=; b=x3ppiUTHvYNJ0g7lT6XAGDLF7Y
	U5dQmha/61ypSmAzOZkGI6LSxUCH6xBFms8bT4u9n1t+CX9R/n7rT9NSq/HT6JezMrahKX5FTkIss
	ktHQTMserq6yhtQMKzLFrCW3ew4bnwmO5MjTcY9Wj8EVjT0Mmnxl7uX8+9eTW3W2ac6XhW9BYTDju
	OrxpUi1LmKrHIuZmqy2QtLU6PxPcabeBUiUKhRMZG1X0vY2ZSgcQYsPuLp22Uh/z3ukzPyxXFmQ6q
	Uv8AC654tuAw8d65M3+0pfqLQpkFMkGe/xTNZYgTmbfJ/HiO1j9jQGK0V05HCb0BF9klbRan/B8hi
	Og3l+adQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkmP-00000006HeD-3lMn;
	Mon, 10 Jun 2024 19:34:09 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkmI-00000006Hb3-1pOY
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 19:34:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 49F78CE175F;
	Mon, 10 Jun 2024 19:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A64C2BBFC;
	Mon, 10 Jun 2024 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718048035;
	bh=Qk5Vp5/sI/Gldp06bVN/w//AsSVkw1JHkdQm2GlWS3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRkBnj3qKLzKtc+3T5Oij/zRoN3CPoJC7GS5nVXb/86MZithcRd6sMyUvqmLiuTQq
	 pfdjVpplwIOj0hgPBKTLQwNVOUhWufQo/Nz3EGhkIw2Ap9qq7/2KJiSQtwlmrZav/R
	 Y4Fjx471dGhT/sWZ1ydiRA/gIiheH19aiatm3VQ7oCBB0M1L2INCSzXPTB6ja5tGj1
	 /vpAeA0tVtZw+i9nFLeqRhVi/DxX43c6938Ok5M3vcZPiMG8cGI3+PxKTyXelp9dry
	 MTyJEFng7Av4ucas1DQkJXLVpsQchgXgwgVtzS9X1c5qBRcisVuz5DZ6Lrs75vPqhd
	 TI7lq1JrELaNA==
Date: Mon, 10 Jun 2024 13:33:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Message-ID: <ZmdVIfnqtweVt9ZN@kbusch-mbp.dhcp.thefacebook.com>
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
 <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
 <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
 <bccf1e1f-bc45-4052-9504-d852f9ae4e6c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccf1e1f-bc45-4052-9504-d852f9ae4e6c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_123407_263727_53465A19 
X-CRM114-Status: GOOD (  25.36  )
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

On Mon, Jun 10, 2024 at 10:17:42PM +0300, Sagi Grimberg wrote:
> On 10/06/2024 22:15, Keith Busch wrote:
> > On Mon, Jun 10, 2024 at 10:05:00PM +0300, Sagi Grimberg wrote:
> > > 
> > > On 10/06/2024 21:53, Keith Busch wrote:
> > > > On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
> > > > > Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
> > > > My mistake. The namespace remove list appears to be getting corrupted
> > > > because I'm using the wrong APIs to replace a "list_move_tail". This is
> > > > fixing the issue on my end:
> > > > 
> > > > ---
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index 7c9f91314d366..c667290de5133 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> > > >    	mutex_lock(&ctrl->namespaces_lock);
> > > >    	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> > > > -		if (ns->head->ns_id > nsid)
> > > > -			list_splice_init_rcu(&ns->list, &rm_list,
> > > > -					     synchronize_rcu);
> > > > +		if (ns->head->ns_id > nsid) {
> > > > +			list_del_rcu(&ns->list);
> > > > +			list_add_tail_rcu(&ns->list, &rm_list);
> > > > +		}
> > > >    	}
> > > >    	mutex_unlock(&ctrl->namespaces_lock);
> > > >    	synchronize_srcu(&ctrl->srcu);
> > > > --
> > > Can we add a reproducer for this in blktests? I'm assuming that we can
> > > easily trigger this
> > > with adding/removing nvmet namespaces?
> > I'm testing this with Namespace Manamgent commands, which nvmet doesn't
> > support. You can recreate the issue by detaching the last namespace.
> > 
> 
> I think the same will happen in a test that creates two namespaces and then
> echo 0 > ns/enable.

Looks like nvme/016 tess this. It's reporting as "passed" on my end, but
I don't think it's actually testing the driver as intended. Still
messing with it.

