Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0FCC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 00:59:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE64D207FC
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 00:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SxtYtZCn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH8OIflD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE64D207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f2nmjTjzoFtzhiYVQ51H4Cxa0PPjMk0ZP0C74i0mvYs=; b=SxtYtZCn+MoihjPk3aF9qX7iB
	jRvR0opkaTSvU+4jkTGQ5yRz9jZ8AHJsX56Y1xWwg7qkGOofyX/zwDxAgXkL+WtJW0gJZEsUZi6U0
	NFFa4+hXH31VecwTqOfQncl4ylLmsD7V+1Ov9k3NddsOxfvUE9A7tCA4ynxiyKbAo6mVRA3e3a57E
	n53etamVqiXkpj1n7aO6CYVWjZkJKZ0czTFEofR3G1QXeUZn2s1CZfMFTr7gi/YUSAtEWuSVr8hDW
	uuf1h7sARTtxTR/YbRliFE/ZSt/MWh8lTbT8gYWomxdFcR9sRWlDTCz+UySJEbDqDtkk9Eb8t40Bd
	Pbn4Nfr9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0aRh-0005st-2Y; Wed, 29 Jul 2020 00:59:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0aRe-0005sG-J5
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 00:59:47 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C13E207FC;
 Wed, 29 Jul 2020 00:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595984385;
 bh=inRLNcNir+2HXo5UAjgkF7XPH8Znd3x+ex92gz6b024=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sH8OIflDUuu0bNAyqO0ygXSQHjK6EQ3psTuArUDssDeNX46Y+I7YhZBlYqK4Gm3Bx
 WnvTQ9ivIRjGIozLaJXYseQkoJHtMmx6/CEqDHEjb9zbHEop0UCNtH96hvSKEam7wh
 9f7/qwT1vh+cT1va3kvDucqsCDVbc/Q24OgPVJsE=
Date: Tue, 28 Jul 2020 17:59:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_205946_697675_E95BC57C 
X-CRM114-Status: GOOD (  21.32  )
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
Cc: Jens Axboe <axboe@kernel.dk>, paulmck@kernel.org,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
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

So:

  (1) We don't want to embed the struct in the hctx because we allocate
  so many of them that this is non-negligable to add for something we
  typically never use.

  (2) We don't want to allocate dynamically because it's potentially
  huge.

As long as we're using srcu for blocking hctx's, I think it's "pick your
poison".

Alternatively, Ming's percpu_ref patch(*) may be worth a look.

 * https://www.spinics.net/lists/linux-block/msg56976.html1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
