Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC0D15DAB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XdHMHctRtd6RpWu83wzIm149e96GKtvvM481R456WxY=; b=n4WQrf+fzePxbrS57fv3wPOHzg
	we44OBifR1Gij6SxsZ5jHXMYScTjxPLw4AV/kWNgxNVtIQnjNUltmNNtiOvDH1//8mechmVNq0opa
	tHX6RdTmnPwCuypduC3aMbdu+ufqNrbFt9RhLaEqvqeQAPZ8vj2zdqyG210M3GwLKCoaU7WxYOtxm
	ACobuSuETrEtxjdTwy/I2FnRF+seZeoR4wuxGzxEXB1dr4tJFfYTr79UPUQbbnTL3JxkUadhIQINj
	sALIKgWap0VHtBmaUXleCCL4/HDoVg9lK70LAxnML2s4Oqo4bJ775qYkR/5Z3msFWykTlp9uHVp8o
	ylfBI2HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2try-00000007hYP-0B7J;
	Mon, 21 Oct 2024 14:58:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2tWP-00000007dYo-3lFQ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 14:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729521396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdHMHctRtd6RpWu83wzIm149e96GKtvvM481R456WxY=;
	b=cQJ57qAw9DNuIFq7Id+DdcPY3oKj8HXzeSVk6SsaZGtxouV0DXvUZczuaMGCbVJAKqfOIQ
	n0HFWdKgM3xclPzsa/HK81wJcFn+6ExOci52Ys28DUeh9zLAx/kcntOCZoiAEdVw307QOh
	XArMARAbkgPkrJP+E6jYPPR8Zkiy2+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-0pwV072UOfySrmjNGC_Seg-1; Mon,
 21 Oct 2024 10:36:35 -0400
X-MC-Unique: 0pwV072UOfySrmjNGC_Seg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FCB7195608D;
	Mon, 21 Oct 2024 14:36:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFC941956056;
	Mon, 21 Oct 2024 14:36:25 +0000 (UTC)
Date: Mon, 21 Oct 2024 22:36:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
Message-ID: <ZxZm5HcsGCYoQ6Mv@fedora>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora>
 <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora>
 <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_073638_124670_8BFD81AD 
X-CRM114-Status: GOOD (  30.71  )
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

On Mon, Oct 21, 2024 at 02:30:01PM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 21/10/2024 11:31, Ming Lei wrote:
> > On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 21/10/2024 4:39, Ming Lei wrote:
> > > > On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
> > > > > From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
> > > > > 
> > > > > It is observed that nvme connect to a nvme over fabric target will
> > > > > always fail when 'nohz_full' is set.
> > > > > 
> > > > > In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> > > > > isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
> > > > > and when nvme connect to a remote target, it may fails on this stack:
> > > > > 
> > > > >           blk_mq_alloc_request_hctx+1
> > > > >           __nvme_submit_sync_cmd+106
> > > > >           nvmf_connect_io_queue+181
> > > > >           nvme_tcp_start_queue+293
> > > > >           nvme_tcp_setup_ctrl+948
> > > > >           nvme_tcp_create_ctrl+735
> > > > >           nvmf_dev_write+532
> > > > >           vfs_write+237
> > > > >           ksys_write+107
> > > > >           do_syscall_64+128
> > > > >           entry_SYSCALL_64_after_hwframe+118
> > > > > 
> > > > > due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
> > > > > blk_mq_ctx on the hw queue.
> > > > > 
> > > > > This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
> > > > > as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
> > > > > indicate that block layer can fallback to a  blk_mq_ctx whose cpu
> > > > > is not isolated.
> > > > blk_mq_alloc_request_hctx()
> > > > 	...
> > > > 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > > > 	...
> > > > 
> > > > It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
> > > > online CPUs, both are same actually from this viewpoint.
> > > > 
> > > > It is one long-time problem for nvme fc.
> > > For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
> > > needs a tag from that hctx. the request execution is running where
> > > blk_mq_alloc_request_hctx() is running.
> > I am afraid that just one tag from the specified hw queue isn't enough.
> > 
> > The connection request needs to be issued to the hw queue & completed.
> > Without any online CPU for this hw queue, the request can't be completed
> > in case of managed-irq.
> 
> None of the consumers of this API use managed-irqs. the networking stack
> takes care of steering irq vectors to online cpus.

OK, it looks not necessary to AND with cpu_online_mask in
blk_mq_alloc_request_hctx, and the behavior is actually from commit
20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU").

But it is still too tricky as one API, please look at blk_mq_get_tag(), which may
allocate tag from other hw queue, instead of the specified one.

It is just lucky for connection request because IO isn't started
yet at that time, and the allocation always succeeds in the 1st try of
__blk_mq_get_tag().



thanks,
Ming


