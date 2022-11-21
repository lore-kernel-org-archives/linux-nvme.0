Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156CAC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAi/8iT2HKJjgQwS8S9bGGynE+kec9+osMjMqjcR42A=; b=HY5PrMT/xxA6KCSc3LUTWP7L2m
	DlkvBuiFXrqgJgrSUtWdK1wzoSB+LLWshnP52nyQk/ZE/m+XwcApgXefnAIZL1I6UroMNeQKVdqE0
	R1UB7B7Hzm380RYpMYOiurx5fy0yDK3ODs0p7L+kU1pu+p8vAhYeUfwfP0KoNZxL+AuqULPKjT3s/
	AE6BJfceJaDep3QQA7HIGH0uxLLWXBFHobhFOFx8xn4N8+o97OJSU5a6R/rBck3CP9RvVYL6h+HUX
	MN0z4ZK0nC7SHoW5njTyEfKSr4ns5GU3VdX+wSqHgJcI+c7qKogRLij/If8bF1vSSpfZFourPPKLP
	fUUlLuAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox8an-00F6W4-Oo; Mon, 21 Nov 2022 15:20:17 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox8Ex-00EvJm-D6
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 14:57:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 86FF5B81063;
	Mon, 21 Nov 2022 14:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A1C433B5;
	Mon, 21 Nov 2022 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669042660;
	bh=44/1ZYjEBvhsXDz1UwPq/l5It0TQpyKwUC/S/yKkcgs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RaA3L/p8IFNDWue5lH3ucFTsE/n4t4ATEtitg/aIUzu85PnF4wX/QRive7YLhKCSt
	 qySH4AypPJ+Pg1Qs0vbd070d0o3gG5Y2nppQ2hnJJc6scXatHO7pQA63K8IOoUoi9s
	 yLCS12rkl9OWPfG5Rmq4yekb9NnTVciz5qYwT9zP8dd7vfPkNk3uWlyQIHkLYV+llf
	 0zadU/m/4p8RKdNeHnIKHnLAxPRtrfFx22rCse8gKbOUcNuvv7xNcdRXcVMY+gDsK2
	 bW6nuyC2pB2kM0hk/u31+pvp7k4eEoTV0Ijx60YyX9SfBoYfxVxPJHKjOL8KCPYEhI
	 gzhIJ0kyc++sA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5CE45C0292; Mon, 21 Nov 2022 06:57:39 -0800 (PST)
Date: Mon, 21 Nov 2022 06:57:39 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Message-ID: <20221121145739.GG4001@paulmck-ThinkPad-P17-Gen-1>
References: <20221121074039.GA24507@lst.de>
 <a7092b30-39db-a58e-ea65-2cfd12201426@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7092b30-39db-a58e-ea65-2cfd12201426@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_065743_625183_E8D2490F 
X-CRM114-Status: GOOD (  19.04  )
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

On Mon, Nov 21, 2022 at 11:43:33AM +0200, Sagi Grimberg wrote:
> 
> > > >    	sector_t capacity = get_capacity(head->disk);
> > > >    	int node;
> > > > +	int srcu_idx;
> > > >    +	srcu_idx = srcu_read_lock(&head->srcu);
> > > >    	list_for_each_entry_rcu(ns, &head->list, siblings) {
> > > >    		if (capacity != get_capacity(ns->disk))
> > > >    			clear_bit(NVME_NS_READY, &ns->flags);
> > > >    	}
> > > > +	srcu_read_unlock(&head->srcu, srcu_idx);
> > > 
> > > I don't think you need srcu here, rcu_read_lock/unlock is sufficient.
> > 
> > So the code obviously does not sleep.  But I wonder if anything speaks
> > against mixing SRCU and RCU protection for the same list?
> 
> I am not an expert, but the point of (s)rcu_synchronize to fence the
> reader critical section isn't it? so if the reader doesn't sleep, the
> existing rcu_synchronize should be sufficient.

Just in case you need to mix RCU and SRCU readers, so that you need
to wait for both types of readers, but need to avoid the latency of
back-to-back waits, you can overlap the waits like this:

	void call_my_srrcu(struct rcu_head *head, rcu_callback_t func)
	{
		call_srcu(&my_srcu, head, func);
	}

	...

	synchronize_rcu_mult(call_rcu, call_my_srrcu);


							Thanx, Paul

