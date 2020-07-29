Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81BDC433E4
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 00:31:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FB720829
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 00:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WeCoLpgZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLwxLBll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FB720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cF/nzqmO2bW0+ZXE3mPUgKEwYDoaWMzu3nTXbwZGlo=; b=WeCoLpgZobGc596YzYS68tEzJx
	1jrR+dDlPtYfYCdmgOYTy9s2wt7JBUGXWMZr0CVa3nwKvSnal5NLC69eqTn3aW9/BNOJF0FKa5Pjc
	gMX75B7XSa3ZUn7hhX2SUVPPuk+QyQnFPx/AcSpkvHh1flu8MrAq1ZbQ4RifNaYsl3oNHn7/oEq/8
	/AvmK4aHJH8kuuYP54zY6TXXgBoFWUUI/nyTnwXfgQ+HfIbXpwZeIPgWgWA/Yxoo3xbwMI3ZEfymc
	yM//GdvE+9Fl8aLYikiGvZjcXooqBJVDxcmOq6tvUK/CCIoUv9CMfZaTB/E35lBlYfao1UBFKsy0o
	YQU9wheg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0a0H-0002qB-2Y; Wed, 29 Jul 2020 00:31:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0a0E-0002pl-JK
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 00:31:27 +0000
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 043B62078E;
 Wed, 29 Jul 2020 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595982685;
 bh=J1/PzA/n8f+1AOaebBifCr2jzqUxA8tYlqC59WVPIlU=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
 b=BLwxLBll+XLyb7H8aM+sUxIubp4Cg/GvHIWOcGJ+xB0QeM5yl2B9Og2SZlxlkMFO5
 87uqP7Up3Qzhl+ZfZ2kTsRcZpiGMAcyXh6xPmvQGKSUowMI452xs/mM7Z2mPy49lXJ
 3xzTUzERt+KCdEjgJfsu//ansFtvPA0UMqlSpDPI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
 id D5A183521363; Tue, 28 Jul 2020 17:31:24 -0700 (PDT)
Date: Tue, 28 Jul 2020 17:31:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200729003124.GT9247@paulmck-ThinkPad-P72>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_203126_783487_1BA433E8 
X-CRM114-Status: GOOD (  32.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 28, 2020 at 04:46:23PM -0700, Sagi Grimberg wrote:
> Hey Paul,
> 
> > Indeed you cannot.  And if you build with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> > it will yell at you when you try.
> > 
> > You -can- pass on-stack rcu_head structures to call_srcu(), though,
> > if that helps.  You of course must have some way of waiting for the
> > callback to be invoked before exiting that function.  This should be
> > easy for me to package into an API, maybe using one of the existing
> > reference-counting APIs.
> > 
> > So, do you have a separate stack frame for each of the desired call_srcu()
> > invocations?  If not, do you know at build time how many rcu_head
> > structures you need?  If the answer to both of these is "no", then
> > it is likely that there needs to be an rcu_head in each of the relevant
> > data structures, as was noted earlier in this thread.
> > 
> > Yeah, I should go read the code.  But I would need to know where it is
> > and it is still early in the morning over here!  ;-)
> > 
> > I probably should also have read the remainder of the thread before
> > replying, as well.  But what is the fun in that?
> 
> The use-case is to quiesce submissions to queues. This flow is where we
> want to teardown stuff, and we can potentially have 1000's of queues
> that we need to quiesce each one.
> 
> each queue (hctx) has either rcu or srcu depending if it may sleep
> during submission.
> 
> The goal is that the overall quiesce should be fast, so we want
> to wait for all of these queues elapsed period ~once, in parallel,
> instead of synchronizing each serially as done today.
> 
> The guys here are resisting to add a rcu_synchronize to each and
> every hctx because it will take 32 bytes more or less from 1000's
> of hctxs.
> 
> Dynamically allocating each one is possible but not very scalable.
> 
> The question is if there is some way, we can do this with on-stack
> or a single on-heap rcu_head or equivalent that can achieve the same
> effect.

If the hctx structures are guaranteed to stay put, you could count
them and then do a single allocation of an array of rcu_head structures
(or some larger structure containing an rcu_head structure, if needed).
You could then sequence through this array, consuming one rcu_head per
hctx as you processed it.  Once all the callbacks had been invoked,
it would be safe to free the array.

Sounds too simple, though.  So what am I missing?

							Thanx, Paul

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
