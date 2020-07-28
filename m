Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F83C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 13:54:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F7A2074F
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 13:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O0iAaqpN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk40ogl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F7A2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RViO6x/7HxkK2a2Dor+3ufEi0Y2D4Dr6CoJqKcKY0M4=; b=O0iAaqpN+k0umnMpg0WIM7j46j
	W7Oy+SyMtPAnu1jhuPn++GrFBZfvTuCSZ6cetHuUGB65FB67VqqRj0ac39Q+YRaJy3Teledcg4JgJ
	plpcbu+m7kGFX3MxaMicjP5r2xirNynsdYDs5Ynon8YVFqEVe4jrBwUZsWkhIzKn3gJSV/Y2A04KU
	v1dJA2l1YFl+CDe3GxSNdRV+t7KwW6EYjSoG2Ck1BHlpfq0rUC+enNn6Yc5SsmCuRLJcxpnMmqY4a
	+C58ORHLqg3cRYV0+gLJuJC/pomzmcTdTHAyKK89nHlHxkVlDmmcQYf299fHVyY4BTRd//3gM7Db7
	LKyd0V3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Q41-0004bP-2E; Tue, 28 Jul 2020 13:54:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Q3x-0004a3-Vp
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 13:54:38 +0000
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 81933206D4;
 Tue, 28 Jul 2020 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595944476;
 bh=DissLUbAP9Jy5mdAUWXDETYp95SfaSgQ/gBg0BubDx0=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
 b=Vk40ogl5hUJG1yYnh493OVsakM8AF+Qvn+kq8JHam9/fFZsQrWhbsyb9fztTrw8Gc
 VO4zjgh/KhQM1sksHERfx+BNaAM5GeddGr2y+ALfAaEdW+1d16hwsevqxjhJ2zabCd
 E2nAEjkBxlSC3HJAzc1OTHsGpH6Qfxz2Zop9xOZw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
 id 5F3223521361; Tue, 28 Jul 2020 06:54:36 -0700 (PDT)
Date: Tue, 28 Jul 2020 06:54:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728135436.GP9247@paulmck-ThinkPad-P72>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_095438_146003_C6E55094 
X-CRM114-Status: GOOD (  28.05  )
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

On Tue, Jul 28, 2020 at 02:24:38AM -0700, Sagi Grimberg wrote:
> 
> > > I like the tagset based interface.  But the idea of doing a per-hctx
> > > allocation and wait doesn't seem very scalable.
> > > 
> > > Paul, do you have any good idea for an interface that waits on
> > > multiple srcu heads?  As far as I can tell we could just have a single
> > > global completion and counter, and each call_srcu would just just
> > > decrement it and then the final one would do the wakeup.  It would just
> > > be great to figure out a way to keep the struct rcu_synchronize and
> > > counter on stack to avoid an allocation.
> > > 
> > > But if we can't do with an on-stack object I'd much rather just embedd
> > > the rcu_head in the hw_ctx.
> > 
> > I think we can do that, please see the following patch which is against Sagi's V5:
> 
> I don't think you can send a single rcu_head to multiple call_srcu calls.

Indeed you cannot.  And if you build with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
it will yell at you when you try.

You -can- pass on-stack rcu_head structures to call_srcu(), though,
if that helps.  You of course must have some way of waiting for the
callback to be invoked before exiting that function.  This should be
easy for me to package into an API, maybe using one of the existing
reference-counting APIs.

So, do you have a separate stack frame for each of the desired call_srcu()
invocations?  If not, do you know at build time how many rcu_head
structures you need?  If the answer to both of these is "no", then
it is likely that there needs to be an rcu_head in each of the relevant
data structures, as was noted earlier in this thread.

Yeah, I should go read the code.  But I would need to know where it is
and it is still early in the morning over here!  ;-)

I probably should also have read the remainder of the thread before
replying, as well.  But what is the fun in that?

							Thanx, Paul

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
