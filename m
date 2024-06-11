Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030F0C27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8gJSbCFxQb93IxoirGxPS6Kck4/B26Bdd6Fo/yvtYmU=; b=y97jS5e/u6gS7UXuRTMN0/2Zg+
	sY4IVj1guhtUD/HEJZQJgf39NTNQHQLTeL6YMDoontobm398wDowSUPHNNp6KCRzPOoWRV7P8atv7
	yHEBz16vvciGX8DYLzWGHFWHBYlg+P4dC0rlqAucVbV7UzoteYfEFwBF3H3i2+9y8nF0suua5zOdt
	mEGOq/neUTw829n1tNPJ5VdQpOHMSdT5w0uSUz4UJ0oz86VES5KmyFpxsCQDu1Lca9Adn6DLz6hV5
	8rHRzbINeQE4+mLX6Dv7D1k3tLRQHpp3/0ymNDFMtROdSpcWQIlJByvbNhiqSSNIm8VCIiqFVTu4U
	cdDm1RNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5Cu-00000009eaC-2Mon;
	Tue, 11 Jun 2024 17:22:52 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5Cs-00000009eZa-1z4q
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 17:22:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BED8FCE1CB3;
	Tue, 11 Jun 2024 17:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22A2C2BD10;
	Tue, 11 Jun 2024 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718126567;
	bh=0BZ9tFCVBqaCeHphipKneKXZmMFZJlufZ9XAKIAREqk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WGaylCcuEOB1jmZ3hoZHsqxpwuA7eykpk34Yg3STpg6SLm4G61iWdT2lQ25uqvZyz
	 6I5Ae4Wy0tK+pVqjDEWp0EcJ4vDazzIdgKh1GSon4XEyFPW4OQLDUQbxLYskbELd9x
	 pwkgvnrJzbmibnnTOVfsgVe5bHBwfgvKylX6Tkxso3PHHI4GoFv6aqa7eMNWOca7IM
	 EjlaLFxIsFiP2TSOncoBYcnpPyOiZmMwXS+hVXka9sOHzNf+w6F/ikJ3hxEb9Ss6UN
	 9YnvpPXEOx+nnJu9BYvAM9dCJS6RVoGCxWJcKTwaObfGatxk75D1s8wKynEh1MiSVM
	 MGcnS2RJSc8lg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96436CE0991; Tue, 11 Jun 2024 10:22:46 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:22:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, Keith Busch <kbusch@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <02b9e73e-aaea-4885-ab8f-692001ccb756@paulmck-laptop>
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611163955.GA12787@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_102250_719606_EFAA07C6 
X-CRM114-Status: GOOD (  17.65  )
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
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 11, 2024 at 06:39:55PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 08:20:55AM -0700, Keith Busch wrote:
> >  	mutex_lock(&ctrl->namespaces_lock);
> >  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> > -		if (ns->head->ns_id > nsid)
> > -			list_splice_init_rcu(&ns->list, &rm_list,
> > -					     synchronize_rcu);
> > +		if (ns->head->ns_id > nsid) {
> > +			list_del_rcu(&ns->list);
> > +			list_add_tail_rcu(&ns->list, &rm_list);
> > +		}
> 
> Is this actually valid for a (S)RCU protected list?  If the entry gets
> added to the new list before the grace period has completed, we could
> trick a concurrent traversal into following the new list unless I'm
> mistaken (although chances I'm mistaken on RCU corner cases aren't that
> low..).

Just to confirm, yes, if an RCU reader was referencing the object being
deleted from the first list, that reader really could be transported
(free of charge!) to the second list.

One (slow) way to avoid this involuntary transportation is to do something
like this:

		list_del_rcu(&ns->list);
		synchronize_rcu(); // drain all readers from ns.
		list_add_tail_rcu(&ns->list, &rm_list);

You could speed things up using synchronize_rcu_expedited, with the
usual downsides.

There are faster ways of getting this effect, but the ones that I
know of involve putting generation numbers on all objects, duplicating
objects on each change, and having readers chase pointers to find the
desired version.  Usually not worth it, but I don't know enough about
this code to judge.

							Thanx, Paul

