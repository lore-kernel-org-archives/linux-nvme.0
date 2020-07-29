Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D80C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:10:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BC420768
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xo6GnrGP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH1QkGNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BC420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vchKM8Fku1gLn5E/gX9FTtYHojBPIHqaPqzGze2ubE4=; b=Xo6GnrGPn5hDyhceoA4gbYzFok
	3KN5z/rlObChutSRLR/AoNW5exFnNLsXsb5vr4EjoLdq+6O5qEa4sr2Vxk3Pjofcf5fk4uoOUHkUz
	h7DwR25FJlmL9L32id/ZMyxc4JYOfk9tk0dO5+Q7c+VfXZVEb0kab1IIqBMF/K7sMc3e8cgf46qPB
	N4/k1q92TeNPzIWQ1Pr5Gf7A4EvJbHhjbc+wLzRpBMKexAyqSHHqp16qO7xM7EbkCPYJIEpbpKkTN
	HbrylrDknybClmRfiVNA/ieB2oerZEzu+1uwJEscroS9BJLa3avrk5VXAxwFmWqL0NlK1RXwW7oy6
	tWF6d+/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0dPr-0006lR-G7; Wed, 29 Jul 2020 04:10:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0dPq-0006ky-2r
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 04:10:06 +0000
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EA2C9206D7;
 Wed, 29 Jul 2020 04:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595995805;
 bh=IKuBNsl4qI263D75wzMMfJxggGK+N6Re79brmEIzMxA=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
 b=OH1QkGNd8OQvbYtYzMt3W9axgOV4KN7144XsAoavF/F84RBlHJJIG75jz/4fq06/Y
 H347LXh6xgmmQ4rxh0sKnPuqwkgbQGfj+7P7BQFfpaFdX76IwSDQlUcNDQmUxelGKk
 UM3Go1sN/Nzwhz6ROLO3/Uy3rpGwcDvhQg/VfWjw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
 id C7F783522621; Tue, 28 Jul 2020 21:10:04 -0700 (PDT)
Date: Tue, 28 Jul 2020 21:10:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200729041004.GV9247@paulmck-ThinkPad-P72>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_001006_246294_C488182D 
X-CRM114-Status: GOOD (  22.29  )
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

On Tue, Jul 28, 2020 at 05:43:02PM -0700, Sagi Grimberg wrote:
> 
> > > Dynamically allocating each one is possible but not very scalable.
> > > 
> > > The question is if there is some way, we can do this with on-stack
> > > or a single on-heap rcu_head or equivalent that can achieve the same
> > > effect.
> > 
> > If the hctx structures are guaranteed to stay put, you could count
> > them and then do a single allocation of an array of rcu_head structures
> > (or some larger structure containing an rcu_head structure, if needed).
> > You could then sequence through this array, consuming one rcu_head per
> > hctx as you processed it.  Once all the callbacks had been invoked,
> > it would be safe to free the array.
> > 
> > Sounds too simple, though.  So what am I missing?
> 
> We don't want higher-order allocations...

OK, I will bite...  Do multiple lower-order allocations (page size is
still lower-order, correct?) and link them together.

Sorry, couldn't resist...

							Thanx, Paul

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
