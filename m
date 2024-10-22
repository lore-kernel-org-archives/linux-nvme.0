Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612CDD1714E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 01:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fuU7Pk5ir/W1+5iFZkdVjz+lD+cUxjKbexv+u9sHBo4=; b=Qj7Ns5w+D7SqQ2Yx4T0Z9yG678
	5zsX1QBdhOgGc29EZbe4+qBfp59NrXqw3RK+D/5LMGpTc//wnXzAldonTLJhVRNP4nxSuemBnHn0o
	uT9uvWuinh5x0Y6rnGrwa6f4MhgcjRTwNC7qAmSbpNLlJtAmg1B+uVvzuJ4VGaXSwExgpQyCipVbl
	jIi6ypTd35C1JUJ3B+aOKXexb6wx2zmmAB3N06hh/jo2chggyX/f0pL+yPMzi2yDgHWgD4AUU9FD4
	kpa7O/AmIk8dMWQz1OWhYBgsBnYMEiLcy7cXlDT73fCxdKwEhkiuZhueHSmAmEuC7bULHctdjhEBi
	uT/kPzdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t33W8-00000009AlM-486N;
	Tue, 22 Oct 2024 01:17:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t33Sp-00000009AEn-3HvF
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 01:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729559614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fuU7Pk5ir/W1+5iFZkdVjz+lD+cUxjKbexv+u9sHBo4=;
	b=JLqDGnvZj/AArSU3mbeaAYh8v65I905FWOL239EMntDAb4pYGabzgPFvJ1QSaJIzutElaI
	p+JIyb6Gm+55cWtZ03UArs5gNQdU11pRt4XN4vyriaFWmBZq6YMZsmMMDy9kiaRDbxhn9o
	yzUQ+u0KUbopGMYnlROut2shzTE3PHs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-1FVvjAtWMyiKfyY_BPofrg-1; Mon,
 21 Oct 2024 21:13:28 -0400
X-MC-Unique: 1FVvjAtWMyiKfyY_BPofrg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 174CF195608C;
	Tue, 22 Oct 2024 01:13:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 289131955F41;
	Tue, 22 Oct 2024 01:13:18 +0000 (UTC)
Date: Tue, 22 Oct 2024 09:13:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
Message-ID: <Zxb8KaoUVstRCxiP@fedora>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora>
 <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora>
 <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
 <ZxZm5HcsGCYoQ6Mv@fedora>
 <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_181335_955481_946FA583 
X-CRM114-Status: GOOD (  39.64  )
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

On Mon, Oct 21, 2024 at 06:27:51PM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 21/10/2024 17:36, Ming Lei wrote:
> > On Mon, Oct 21, 2024 at 02:30:01PM +0300, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 21/10/2024 11:31, Ming Lei wrote:
> > > > On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
> > > > > 
> > > > > On 21/10/2024 4:39, Ming Lei wrote:
> > > > > > On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
> > > > > > > From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
> > > > > > > 
> > > > > > > It is observed that nvme connect to a nvme over fabric target will
> > > > > > > always fail when 'nohz_full' is set.
> > > > > > > 
> > > > > > > In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> > > > > > > isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
> > > > > > > and when nvme connect to a remote target, it may fails on this stack:
> > > > > > > 
> > > > > > >            blk_mq_alloc_request_hctx+1
> > > > > > >            __nvme_submit_sync_cmd+106
> > > > > > >            nvmf_connect_io_queue+181
> > > > > > >            nvme_tcp_start_queue+293
> > > > > > >            nvme_tcp_setup_ctrl+948
> > > > > > >            nvme_tcp_create_ctrl+735
> > > > > > >            nvmf_dev_write+532
> > > > > > >            vfs_write+237
> > > > > > >            ksys_write+107
> > > > > > >            do_syscall_64+128
> > > > > > >            entry_SYSCALL_64_after_hwframe+118
> > > > > > > 
> > > > > > > due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
> > > > > > > blk_mq_ctx on the hw queue.
> > > > > > > 
> > > > > > > This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
> > > > > > > as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
> > > > > > > indicate that block layer can fallback to a  blk_mq_ctx whose cpu
> > > > > > > is not isolated.
> > > > > > blk_mq_alloc_request_hctx()
> > > > > > 	...
> > > > > > 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > > > > > 	...
> > > > > > 
> > > > > > It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
> > > > > > online CPUs, both are same actually from this viewpoint.
> > > > > > 
> > > > > > It is one long-time problem for nvme fc.
> > > > > For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
> > > > > needs a tag from that hctx. the request execution is running where
> > > > > blk_mq_alloc_request_hctx() is running.
> > > > I am afraid that just one tag from the specified hw queue isn't enough.
> > > > 
> > > > The connection request needs to be issued to the hw queue & completed.
> > > > Without any online CPU for this hw queue, the request can't be completed
> > > > in case of managed-irq.
> > > None of the consumers of this API use managed-irqs. the networking stack
> > > takes care of steering irq vectors to online cpus.
> > OK, it looks not necessary to AND with cpu_online_mask in
> > blk_mq_alloc_request_hctx, and the behavior is actually from commit
> > 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU").
> 
> it is a long time ago...
> 
> > 
> > But it is still too tricky as one API, please look at blk_mq_get_tag(), which may
> > allocate tag from other hw queue, instead of the specified one.
> 
> I don't see how it can help here.

Without taking offline cpus into account, every hctx has CPUs mapped
except for cpu isolation, then the failure of 'cpu >= nr_cpu_ids' won't
be triggered.

> 
> > 
> > It is just lucky for connection request because IO isn't started
> > yet at that time, and the allocation always succeeds in the 1st try of
> > __blk_mq_get_tag().
> 
> It's not lucky, we reserve a per-queue tag for exactly this flow (connect)
> so we
> always have one available. And when the connect is running, the driver
> should
> guarantee nothing else is running.

What if there is multiple concurrent allocation(reserve) requests? You still
may run into allocation from other hw queue. In reality, nvme may don't
use in that way, but as one API, it is still not good, or at least the
behavior should be documented.


thanks,
Ming


