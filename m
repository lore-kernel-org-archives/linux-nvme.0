Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429FCC25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Es9ibWfXIfbUl6bLX9vOS5XLYyrT3zBlCWooucgrCUo=; b=VC6IgJRJQb9jvvzaVzfOkWD1S4
	sKHsh0BhhDVFFnil4frv/1xieo16bBDIRV0iROZZ9lHyA8kudpzB8YtsD2uwJ49esXLr8snI3eJHF
	S8PRMkRZcmvNmC0D34jCgIuk1UxGDH99SljQQXe4BL5TDFCPnt8Zcm9A24TUQ/JLXYvQP3YHW90Cj
	Wcf2G2k9Q8oj+K786SGYkumm10YrkdMAicuV9YH5xF6N2syBOUuc4QLiHVgN94l96VWxzC/EqgIQz
	ViTr7nvC5aNJBWj9T3sk6Dy6AuVR4gW4idOVf7IpZEAc3ju30yukV0MNVlVMNxsA6aOUCS9e2u9Zv
	q9qk7iVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oqg-00000003XBO-2wbV;
	Wed, 22 May 2024 16:29:54 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oqa-00000003X9g-0G3M
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 16:29:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BA0B5CE12B8;
	Wed, 22 May 2024 16:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3A1C2BBFC;
	Wed, 22 May 2024 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716395384;
	bh=JUtNNJy/nHM4nKkU6sDEme4IkoVcVSX2db5+h1zO+ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qf3wgycv0vGY1lvXnKMRNqMJUZL34+i6jciTl+/h2OitcbI7fSBAfLJ4bsWwxDMyp
	 SxUgE79/uzg3gdbuS1OCa3tK44ftrHsrL8tIsH5KJQUIQHEqR8fpgAgDbDDfTTodIi
	 jQQ6Mk0/T0Wc9EtESMSelBkiW+DnB5zn2nzS7b3jYB3IaYMa4joL+31qGVJXjZ6SIB
	 8u20pzIMLtrO1UxrMD9+Bb4j9JbMgdefFMaI2lDceBrYCBhgjB/e/RJCn5YkmiyyBL
	 9qu+2ZsoTI37O7zfnnOzaHE9hpnmG9/CZd8o5QBrDLS4caN0HNQWyDjpu7/FVt5ENm
	 nxv5xGzprRVjA==
Date: Wed, 22 May 2024 10:29:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zk4ddPmottdOJND1@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
 <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
 <cef5a764-ffab-495c-bea2-e4c6a7c76944@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef5a764-ffab-495c-bea2-e4c6a7c76944@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_092950_078446_D05ECA17 
X-CRM114-Status: GOOD (  25.89  )
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

On Wed, May 22, 2024 at 12:23:51PM -0400, John Meneghini wrote:
> On 5/22/24 11:56, Keith Busch wrote:
> > On Wed, May 22, 2024 at 11:42:12AM -0400, John Meneghini wrote:
> > > +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> > > +{
> > > +	struct nvme_ctrl *ctrl;
> > > +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> > > +
> > > +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> > > +
> > > +	/* iopolicy changes reset the counters and clear the mpath by design */
> > > +	mutex_lock(&nvme_subsystems_lock);
> > > +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > > +		atomic_set(&ctrl->nr_active, 0);
> > 
> > Can you me understand why this is a desirable feature? Unless you
> > quiesce everything at some point, you'll always have more unaccounted
> > requests on whichever path has higher latency. That sounds like it
> > defeats the goals of this io policy.
> 
> This is true. And as a matter of practice I never change the IO policy when IOs are in flight.  I always stop the IO first.
> But we can't stop any user from changing the IO policy again and again.  So I'm not sure what to do.
> 
> If you'd like I add the 'if (old_iopolicy == iopolicy) return;' here, but
> that's not going to solve the problem of inaccurate counters when users
> start flipping io policies around. with IO inflight. There is no
> synchronization between io submission across controllers and changing the
> policy so I expect changing between round-robin and queue-depth with IO
> inflight suffers from the same problem... though not as badly.
> 
> I'd rather take this patch now and figure out how to fix the problem with
> another patch in the future.  Maybe we can check the io stats and refuse to
> change the policy of they are not zero....

The idea of tagging the nvme_req()->flags on submission means the
completion handling the nr_active counter is symmetric with the
submission side: you don't ever need to reset nr_active because
everything is accounted for.

