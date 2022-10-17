Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49492C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jZxZTQmOXtMjem0okrwKcRoMZ6Yv6+dLStS7A/7WVp4=; b=Oi8BAesET/11423knDQFpjbBf7
	XCr9StBju2FnXWPWiW4HeWXIGpKCviAAfikSQOP26PBsDtAvu54Lm/tHDUt7rP4F2RJc7ba/n0xfs
	p5KWkqc+PnnoZKZv8jtQxgelRMWwctgZjlQQThxS4plxqjYL8qUYMYi7hqe9+UTdYDdRkBmZ9guMX
	q37x0dQGSc+lUjL0Iil46IB3daLfnuzzSvNzcOpXrgp8fZlk3oUaccPVb4ibRioePONjOIbJrInI/
	efjqCY4wmxdGR91K9gvskhdyeU+RJfP7hR2DwxGvvQts3bULvnElNW3bPmrNH1JaVZh1z5MReofFg
	wZQWDKZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okYnO-00FDes-MP; Mon, 17 Oct 2022 22:41:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okYnM-00FDe6-I5
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 22:41:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 244C76121A;
	Mon, 17 Oct 2022 22:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F77C433B5;
	Mon, 17 Oct 2022 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666046475;
	bh=9fDxJXZK1U5womZDJo/c6FscAHDcI1ZEsc4GYARxhcU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NlhwvhXnMEkst0U+X3torWYjiWRmQFE2imEJmLTmGUTEHw3MwqigrAGHwi0X7+WwC
	 o2mU7YTjFZ038Do7gF/b9hhV+sg1qLk0GshZFAN2x0fgMK1fJud1ifPwWvyaGPjZux
	 TaNkCQXaZReqDNUM8M1oYjmQ4PL/NpfAcBnyIgFJdgx8802xlgaIobz0auU0K2bQPn
	 cqlaVYLWLlvm8fLVeac0JNDJaou4DlbimxTeIb8h8Tj0V7gBOdft5NplZ5K1eXAh57
	 CDk8QjvGSyhiZ+kG6g8vnrPk3SKcAz7iPPbzbYuQkb6Owk8QYEAijxMekqj36S+57M
	 akMuagydW2GDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 16EC05C0C34; Mon, 17 Oct 2022 15:41:15 -0700 (PDT)
Date: Mon, 17 Oct 2022 15:41:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
	ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
 <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017153105.GA32509@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_154116_658370_E3710E98 
X-CRM114-Status: GOOD (  26.97  )
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

On Mon, Oct 17, 2022 at 05:31:05PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 17, 2022 at 08:21:36AM -0700, Paul E. McKenney wrote:
> > The main reason for having multiple srcu_struct structures is to
> > prevent the readers from one from holding up the updaters from another.
> > Except that by waiting for the multiple grace periods, you are losing
> > that property anyway, correct?  Or is this code waiting on only a small
> > fraction of the srcu_struct structures associated with blk_queue?
> 
> There are a few places that do this.  SCSI and MMC could probably switch
> to this scheme or at least and open coded version of it (if we move
> to a per_tagsect srcu_struct open coding it might be a better idea
> anyway).
> 
> del_gendisk is one where we have to go one queue at a time, and
> that might actually matter for a device removal.  elevator_switch
> is another one, there is a variant for it that works on the whole
> tagset, but also those that don't.

OK, thank you for the info!

Then the big question is "how long do the SRCU readers run?"

If all of the readers ran for exactly the same duration, there would be
little point in having more than one srcu_struct.

If the kernel knew up front how long the SRCU readers for a given entry
would run, it could provide an srcu_struct structure for each duration.
For a (fanciful) example, you could have one srcu_struct structure for
SSDs, another for rotating rust, a third for LAN-attached storage, and
a fourth for WAN-attached storage.  Maybe a fifth for lunar-based storage.

If it is impossible to know up front which entry has what SRCU read-side
latency characteristics, then the current approach of just giving each
entry its own srcu_struct structure is not at all a bad plan.

Does that help, or am I off in the weeds here?

							Thanx, Paul

