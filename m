Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41833C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbHUokWJSxGrBBtA6mQiET7L7f2cmm7xXv9DuBY9hes=; b=dEVe2xhJWnJ7I4fxYXiMamX0NW
	Ve6CIeSDZ6pwFwswTwTwdLsrKo7XxhBuoJs/vZwjrVjsrYs7QgVIMMNFANjbaiH2wNg+Aa+fYgcGI
	o9yFGlwxmky10pjbjusC36B4mmMJMAUpURUvpioiEWCRsr0QzmqS26rZhKTaiZgfGPOri2Z410juU
	GOouWypEsRJgYABgVL+eVMTgvoKOtsVOedh42dSJH5DIodt82sJ/+LittwlvWUf5JHPvL5cQXPWc0
	V9KS6yHV3+sLVyKsN5msZ2s4z/tYCx9PnS8UwGUwxGNOZzhBuNOvC/qRhCO6Tua6+3UJB8z9wqa9f
	YuFOH9Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okRvx-00DDjT-81; Mon, 17 Oct 2022 15:21:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okRvu-00DDiu-C1
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 15:21:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0723061186;
	Mon, 17 Oct 2022 15:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682DFC433D6;
	Mon, 17 Oct 2022 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666020096;
	bh=lFuLr2+e1H3YK5ePLPiosHaO8VROEZrfG/m92oz45eQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Eei1SMM8G7OJ8InVn9vtXcNYF0UUqa4ftD9I8QSrwfBHYSeDMc6RULXpUl+QL/qPn
	 ehHqU5u/Jljm82YTZRgO7bVjIt1bCpZDsbnKPkJg08FvSYJ7KDYzaSAH8zpURDfaKb
	 HRxnE+AkhFZ1LBbAImrx0sfOC39VytimAYT/Yy/Vvl5PUdQv94UB+MVQzzJIyCLb9J
	 kiuM1kIpAckF73Kn56h9K1lrCKwfd611bG60L13mDhZ1lzBp67BOLFtdU/RNRja8zj
	 N9c6yan30ip2MkJb/b0qtPGT1Qp24+aNBU6ASAiivjlIVbWgFX+/qGpPAKciuEV4/y
	 f3NWRGTXPanaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0AD0E5C0622; Mon, 17 Oct 2022 08:21:36 -0700 (PDT)
Date: Mon, 17 Oct 2022 08:21:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
	ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
 <20221017133906.GA24492@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017133906.GA24492@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_082138_534329_29E08567 
X-CRM114-Status: GOOD (  23.07  )
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

On Mon, Oct 17, 2022 at 03:39:06PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 13, 2022 at 05:44:49PM +0800, Chao Leng wrote:
> > +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
> > +	if (rcu) {
> > +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > +			if (blk_queue_noquiesced(q))
> > +				continue;
> > +
> > +			init_rcu_head(&rcu[i].head);
> > +			init_completion(&rcu[i].completion);
> > +			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
> > +			i++;
> > +		}
> > +
> > +		for (i = 0; i < count; i++) {
> > +			wait_for_completion(&rcu[i].completion);
> > +			destroy_rcu_head(&rcu[i].head);
> > +		}
> > +		kvfree(rcu);
> > +	} else {
> > +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> > +			synchronize_srcu(q->srcu);
> > +	}
> 
> Having to allocate a struct rcu_synchronize for each of the potentially
> many queues here is a bit sad.
> 
> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
> last week, so I wonder if something like that would also be feasible
> for SRCU, as that would come in really handy here.

There is start_poll_synchronize_srcu() and poll_state_synchronize_srcu(),
but there would need to be an unsigned long for each srcu_struct from
which an SRCU grace period was required.  This would be half the size
of the "rcu" array above, but still maybe larger than you would like.

The resulting code might look something like this, with "rcu" now being
a pointer to unsigned long:

	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
	if (rcu) {
		list_for_each_entry(q, &set->tag_list, tag_set_list) {
			if (blk_queue_noquiesced(q))
				continue;
			rcu[i] = start_poll_synchronize_srcu(q->srcu);
			i++;
		}

		for (i = 0; i < count; i++)
			if (!poll_state_synchronize_srcu(q->srcu))
				synchronize_srcu(q->srcu);
		kvfree(rcu);
	} else {
		list_for_each_entry(q, &set->tag_list, tag_set_list)
			synchronize_srcu(q->srcu);
	}

Or as Christoph suggested, just have a single srcu_struct for the
whole group.

The main reason for having multiple srcu_struct structures is to
prevent the readers from one from holding up the updaters from another.
Except that by waiting for the multiple grace periods, you are losing
that property anyway, correct?  Or is this code waiting on only a small
fraction of the srcu_struct structures associated with blk_queue?

							Thanx, Paul

