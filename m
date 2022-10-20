Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F70C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3bz3RuiVpLvMhqMLP2gjoFmbzt5vePWCpbyZJsptMHU=; b=jh6jCnvJVmXaSkP0TKNTXxNTNO
	a2Wrjw1n+O7OJcNMYB23c9FCo3+wcO3sZVwnIVfjAiPwchZ3ZR+C+MadysfdLhTJYMTXWSVr+UoWt
	ac174BPMYkUKu5jXcsK1eeL3zI2ee6PjXTj34xle6CgGeJdAMpdHfTNIyQFjKC5NJ/tpN1iZkfbV1
	SH3PWeIhceIZaSiwivVaYJvWij+riOVZ1q16PZo4hnMJu0e7V0XQqfb6cHvAcXbwZBfa7TF6ldAzb
	aVHsp3xXo533I4uQLhC5BUJ7Raf/3Qn4eck37jYKGlQZvZzl4cFnoFhYHORYPsD57eQXL/tmFICOA
	ZGJdvEVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olY8l-000Bf6-HB; Thu, 20 Oct 2022 16:11:27 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olY8d-000BaZ-9L
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 16:11:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5523BB82763;
	Thu, 20 Oct 2022 16:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05418C433D7;
	Thu, 20 Oct 2022 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666282273;
	bh=EuPEOKlzmJJEaSMf81G00U2vU/zKyly71DNI92HyRRs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kG5Lhq1SC5/kkzDOkVz+f0Jy8TPMRZpZi40crlEpu3WapIFV3PXdzAEr02JjDzDwL
	 BeluVVfw75lf2Pbrm9McsJRAyJmD75YY9vTsdUXMe3QWGknFRYPnGzLFsRjGE3kwQE
	 TQ/PnxynFlN4cFDK7KSf1ztk5MgQfBnX/Kv3GDu9PIxLJTrcf2AY5iJJoEgMd3GNlI
	 Vkb6jGmdpyJmzFrNWa0cyIPmTAOC6/exgvczeyLVq3ZlApOovUXrjM1gAouNSXR4qD
	 yZ9DZcRy9bZ7DkP5BocxTmPplAqtYyEKNtPnNP0MUIN63lB8IRQK8YKbxm+bb73Cq9
	 rVn1uCEp2mukg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1C125C04D0; Thu, 20 Oct 2022 09:11:12 -0700 (PDT)
Date: Thu, 20 Oct 2022 09:11:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk,
	ming.lei@redhat.com
Subject: Re: [PATCH v3 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221020161112.GO5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221020035348.10163-1-lengchao@huawei.com>
 <20221020035348.10163-2-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020035348.10163-2-lengchao@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_091119_779798_EB163CA1 
X-CRM114-Status: GOOD (  30.61  )
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

On Thu, Oct 20, 2022 at 11:53:47AM +0800, Chao Leng wrote:
> Drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an
> interface to quiesce all the queues on a given tagset. This interface is
> useful because it can speedup the quiesce by doing it in parallel.
> 
> For tagsets that have BLK_MQ_F_BLOCKING set, we first call
> start_poll_synchronize_srcu for all queues of the tagset, and then call
> poll_state_synchronize_srcu such that all of them wait for the same srcu
> elapsed period. For tagsets that don't have BLK_MQ_F_BLOCKING set,
> we simply call a single synchronize_rcu as this is sufficient.
> 
> Because some queues should not need to be quiesced(e.g. nvme connect_q)
> when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to
> tagset quiesce interface to skip the queue.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chao Leng <lengchao@huawei.com>

From an RCU viewpoint:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

As noted in the earlier email thread, using a single srcu_struct for the
whole tag list would require even less memory and would further reduce
the overhead and latency of blk_mq_quiesce_blocking_tagset().

							Thanx, Paul

> ---
>  block/blk-mq.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  2 ++
>  include/linux/blkdev.h |  3 ++
>  3 files changed, 81 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..f064ecda425b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -311,6 +311,82 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>  
> +static void blk_mq_quiesce_blocking_tagset(struct blk_mq_tag_set *set)
> +{
> +	int i, count = 0;
> +	struct request_queue *q;
> +	unsigned long *rcu;
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (blk_queue_skip_tagset_quiesce(q))
> +			continue;
> +
> +		blk_mq_quiesce_queue_nowait(q);
> +		count++;
> +	}
> +
> +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
> +	if (rcu) {
> +		i = 0;
> +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +			if (blk_queue_skip_tagset_quiesce(q))
> +				continue;
> +
> +			rcu[i++] = start_poll_synchronize_srcu(q->srcu);
> +		}
> +
> +		i = 0;
> +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +			if (blk_queue_skip_tagset_quiesce(q))
> +				continue;
> +
> +			if (!poll_state_synchronize_srcu(q->srcu, rcu[i++]))
> +				synchronize_srcu(q->srcu);
> +		}
> +
> +		kvfree(rcu);
> +	} else {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> +			synchronize_srcu(q->srcu);
> +	}
> +}
> +
> +static void blk_mq_quiesce_nonblocking_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (blk_queue_skip_tagset_quiesce(q))
> +			continue;
> +
> +		blk_mq_quiesce_queue_nowait(q);
> +	}
> +	synchronize_rcu();
> +}
> +
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	mutex_lock(&set->tag_list_lock);
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		blk_mq_quiesce_blocking_tagset(set);
> +	else
> +		blk_mq_quiesce_nonblocking_tagset(set);
> +
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
> +
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +		blk_mq_unquiesce_queue(q);
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
> +
>  void blk_mq_wake_waiters(struct request_queue *q)
>  {
>  	struct blk_mq_hw_ctx *hctx;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ba18e9bdb799..1df47606d0a7 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -877,6 +877,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
>  void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
>  void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
>  void blk_mq_quiesce_queue(struct request_queue *q);
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
>  void blk_mq_wait_quiesce_done(struct request_queue *q);
>  void blk_mq_unquiesce_queue(struct request_queue *q);
>  void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50e358a19d98..efa3fa771dce 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -579,6 +579,7 @@ struct request_queue {
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
> +#define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
>  				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
> @@ -619,6 +620,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
>  #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
> +#define blk_queue_skip_tagset_quiesce(q) \
> +	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
>  
>  extern void blk_set_pm_only(struct request_queue *q);
>  extern void blk_clear_pm_only(struct request_queue *q);
> -- 
> 2.16.4
> 

