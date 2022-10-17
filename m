Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49ECC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tGH+dvwO+cBr6xGBDZTVcarqRBH0PDZ8fa2KKBVr48c=; b=gPAfaLt8AvTM7o5qW/KeJW75fc
	3JdPY2t0p/InVo3sNJUmGSAUPB7cCXn271qnIpDYK6L4w17bAdDYiaBZ2Z3YDdhvPQgA4ZEl/e7uI
	+vU9DU72RbxhlBCsSvZ6eHmQCY63+U4R7JmwTv05flfPz0JGWz/LjtymEL4QsfsVUkzOVP5HcCr9k
	g4/Bz0GoijGUVWaaQVMCM7ixV+nGLXq3pg/p4McfSvXBBNmaK3LOCjH5428/WbJRB5h7TZNtzZo1U
	hnlI6QhjVAnsjF6bUUoKnYXnmIyop/+50L0d4tEH11Gn3P0DOLeRSnFTO3pj/u26IA+lqpGO8uhuh
	OQAewtfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQKn-00C9LU-Qk; Mon, 17 Oct 2022 13:39:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQKk-00C9HB-Ti
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 13:39:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE9FF68BFE; Mon, 17 Oct 2022 15:39:06 +0200 (CEST)
Date: Mon, 17 Oct 2022 15:39:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com,
	axboe@kernel.dk, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017133906.GA24492@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013094450.5947-2-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_063911_124095_67F29486 
X-CRM114-Status: GOOD (  14.56  )
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

On Thu, Oct 13, 2022 at 05:44:49PM +0800, Chao Leng wrote:
> +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
> +	if (rcu) {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +			if (blk_queue_noquiesced(q))
> +				continue;
> +
> +			init_rcu_head(&rcu[i].head);
> +			init_completion(&rcu[i].completion);
> +			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
> +			i++;
> +		}
> +
> +		for (i = 0; i < count; i++) {
> +			wait_for_completion(&rcu[i].completion);
> +			destroy_rcu_head(&rcu[i].head);
> +		}
> +		kvfree(rcu);
> +	} else {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> +			synchronize_srcu(q->srcu);
> +	}

Having to allocate a struct rcu_synchronize for each of the potentially
many queues here is a bit sad.

Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
last week, so I wonder if something like that would also be feasible
for SRCU, as that would come in really handy here.

