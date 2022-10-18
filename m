Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168FCC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kIvANCUwXcO+aOKjtLDkotVOCXgASKBpNRetF2baJ/A=; b=BOIsR54f22ALk3R+I6QXovxXPf
	p0GeCpwSbnS6PIGuEoge1w0SvcljFeKpgvJ27P2ORDn/mJbHS2VzysgvltpXX6X7eel8KXKJFie4Y
	/lvpVfviWZklcn3rI/j1xonX4bPlhonOPzqZO8z4S7BqIe5fDrIPDzCzpHBr2sWnIg+poMfparZRm
	VRkLhOY4gxzDXpPHJ2lmgS3p7yRQakzUXd/mRfaaxJerNMDTD+TGuocX3U3oHWS4Ykt4gFel1myuL
	zURLLg4DpCXM+tJRKQ06d9dZKDcwOd9+Ax7c3WPd3PBqJY+d7GDspdTW8G/8XNA2PqR9gh5DaPdM1
	Enj5tXfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oko8e-007QoZ-Dk; Tue, 18 Oct 2022 15:04:16 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oko8X-007Qmj-My
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:04:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B1F4CB81E87;
	Tue, 18 Oct 2022 15:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CB8C433C1;
	Tue, 18 Oct 2022 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666105446;
	bh=6d6sOeYJIaI4xHm9s7ynvdKVVekexAuhfAwjLNjju28=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YQJWYlqwiQIoGy1TSUeZKXL1jebKyta9ND/mYGnj9J0+fyjb9GwQJ9iaE665uMMsj
	 VnjFiMHHZ+hn8Z4gOlBPzG8+2hWmcPf1JxDYJJVOtnk1bIZKfs5CGYFimIon3vZS78
	 P9aPk8AQKfgNXvQmFRetH7VrpSb+sIiRTnZxzeHd9ZUmC7nbPvNz1shufyrxmB7mKe
	 eajzvVJjk5wxjEJCScDT1zebOSGG/MTfVnZl8a7hj5g+Cek0aJOCZ6wRDQ8UDBgDsd
	 VKhu6+HuopQuLDPGpCiWYGWVm8o30Jb/T/ecWjNdz2l95DuwxWy4McKqWDBVAI8Eqg
	 go5NGmMTx9wnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0A5775C0528; Tue, 18 Oct 2022 08:04:06 -0700 (PDT)
Date: Tue, 18 Oct 2022 08:04:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
	ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221018150406.GO5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
 <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <3bb8a547-b2e2-7654-55dc-e943ac9aa06d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb8a547-b2e2-7654-55dc-e943ac9aa06d@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_080410_085417_5EC4A898 
X-CRM114-Status: GOOD (  33.77  )
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

On Tue, Oct 18, 2022 at 05:52:06PM +0800, Chao Leng wrote:
> On 2022/10/17 23:21, Paul E. McKenney wrote:
> > On Mon, Oct 17, 2022 at 03:39:06PM +0200, Christoph Hellwig wrote:
> > > On Thu, Oct 13, 2022 at 05:44:49PM +0800, Chao Leng wrote:
> > > > +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
> > > > +	if (rcu) {
> > > > +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > > > +			if (blk_queue_noquiesced(q))
> > > > +				continue;
> > > > +
> > > > +			init_rcu_head(&rcu[i].head);
> > > > +			init_completion(&rcu[i].completion);
> > > > +			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
> > > > +			i++;
> > > > +		}
> > > > +
> > > > +		for (i = 0; i < count; i++) {
> > > > +			wait_for_completion(&rcu[i].completion);
> > > > +			destroy_rcu_head(&rcu[i].head);
> > > > +		}
> > > > +		kvfree(rcu);
> > > > +	} else {
> > > > +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> > > > +			synchronize_srcu(q->srcu);
> > > > +	}
> > > 
> > > Having to allocate a struct rcu_synchronize for each of the potentially
> > > many queues here is a bit sad.
> > > 
> > > Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
> > > last week, so I wonder if something like that would also be feasible
> > > for SRCU, as that would come in really handy here.
> > 
> > There is start_poll_synchronize_srcu() and poll_state_synchronize_srcu(),
> > but there would need to be an unsigned long for each srcu_struct from
> > which an SRCU grace period was required.  This would be half the size
> > of the "rcu" array above, but still maybe larger than you would like.
> > 
> > The resulting code might look something like this, with "rcu" now being
> > a pointer to unsigned long:
> > 
> > 	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
> > 	if (rcu) {
> > 		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > 			if (blk_queue_noquiesced(q))
> > 				continue;
> > 			rcu[i] = start_poll_synchronize_srcu(q->srcu);
> > 			i++;
> > 		}
> > 
> > 		for (i = 0; i < count; i++)
> > 			if (!poll_state_synchronize_srcu(q->srcu))
> > 				synchronize_srcu(q->srcu);
> synchronize_srcu will restart a new period of grace.

True, but SRCU grace periods normally complete reasonably quickly, so
the synchronize_srcu() might well be faster than the loop, depending on
what the corresponding SRCU readers are doing.

> Maybe it would be better like this:
> 			while (!poll_state_synchronize_srcu(q->srcu, rcu[i]))
> 				schedule_timeout_uninterruptible(1);

Why not try it both ways and see what happens?  Assuming that is, that
the differences matter in this code.

							Thanx, Paul

> > 		kvfree(rcu);
> > 	} else {
> > 		list_for_each_entry(q, &set->tag_list, tag_set_list)
> > 			synchronize_srcu(q->srcu);
> > 	}
> > 
> > Or as Christoph suggested, just have a single srcu_struct for the
> > whole group.
> > 
> > The main reason for having multiple srcu_struct structures is to
> > prevent the readers from one from holding up the updaters from another.
> > Except that by waiting for the multiple grace periods, you are losing
> > that property anyway, correct?  Or is this code waiting on only a small
> > fraction of the srcu_struct structures associated with blk_queue?
> > 
> > 							Thanx, Paul
> > .
> > 

