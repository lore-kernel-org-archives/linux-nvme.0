Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDD4D0E6CC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 08:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZcSc+4L9y38uraoqMApZCtt9pe8JnUSoYfln1jlvOsY=; b=f8bIkkKgIpMxXh7oYcRO4OmOIQ
	+rZ3tMIRXGsiDQmcAJPdQphoI2yzMEW7E2Jx7g790H7P4tcgU+0wsxrgUarL6CjwITbqLSiZ3gfCZ
	kPfKE/DrMXCF++hcxcutkfOOC32xlvesN7R4G420X4YbQElPU40q6aIv/OhzAUxedfvDm3dScfpci
	oNe35uh+6GlW2d+aLMOk+ux/B8mABoI4Kzryoqp13siL15ilcL+TTGxlKEj2P66gGTVaeZtjFCi7H
	MF63m0p20YUSaNNuQDhDX9SBggyF92Kf0MvJu787z41KdWfn+Yc2I1pFdPTAWS/3IdMPB9mmvB8yx
	K3kz7V9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2npy-00000006ZSk-0Thn;
	Mon, 21 Oct 2024 08:32:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2npJ-00000006ZG1-03Rn
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 08:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729499503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcSc+4L9y38uraoqMApZCtt9pe8JnUSoYfln1jlvOsY=;
	b=SJvfjADD2URLODkgPq1RboDzyyFB5zRMeRbE8Pa1yQ7/jGiWqam6XpJcWjBm+Nb6wrIYQY
	F/rXnQhzMZM4gODkMxnXaeehjYuDkOJ9sfCJUxNZhwA4SqbvZaTcSOIAc7K2Q4dm7X99P9
	CBO/Aaa5HHOkbcnnMrssblY5E3IiNR0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-36Rx2BnCNDeuD8EftrT9VQ-1; Mon,
 21 Oct 2024 04:31:40 -0400
X-MC-Unique: 36Rx2BnCNDeuD8EftrT9VQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEEAE1955D80;
	Mon, 21 Oct 2024 08:31:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.104])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D147B1956056;
	Mon, 21 Oct 2024 08:31:31 +0000 (UTC)
Date: Mon, 21 Oct 2024 16:31:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
Message-ID: <ZxYRXvyxzlFP_NPl@fedora>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora>
 <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_013145_380613_F0833050 
X-CRM114-Status: GOOD (  24.81  )
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

On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 21/10/2024 4:39, Ming Lei wrote:
> > On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
> > > From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
> > > 
> > > It is observed that nvme connect to a nvme over fabric target will
> > > always fail when 'nohz_full' is set.
> > > 
> > > In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> > > isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
> > > and when nvme connect to a remote target, it may fails on this stack:
> > > 
> > >          blk_mq_alloc_request_hctx+1
> > >          __nvme_submit_sync_cmd+106
> > >          nvmf_connect_io_queue+181
> > >          nvme_tcp_start_queue+293
> > >          nvme_tcp_setup_ctrl+948
> > >          nvme_tcp_create_ctrl+735
> > >          nvmf_dev_write+532
> > >          vfs_write+237
> > >          ksys_write+107
> > >          do_syscall_64+128
> > >          entry_SYSCALL_64_after_hwframe+118
> > > 
> > > due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
> > > blk_mq_ctx on the hw queue.
> > > 
> > > This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
> > > as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
> > > indicate that block layer can fallback to a  blk_mq_ctx whose cpu
> > > is not isolated.
> > blk_mq_alloc_request_hctx()
> > 	...
> > 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > 	...
> > 
> > It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
> > online CPUs, both are same actually from this viewpoint.
> > 
> > It is one long-time problem for nvme fc.
> 
> For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
> needs a tag from that hctx. the request execution is running where
> blk_mq_alloc_request_hctx() is running.

I am afraid that just one tag from the specified hw queue isn't enough.

The connection request needs to be issued to the hw queue & completed.
Without any online CPU for this hw queue, the request can't be completed
in case of managed-irq.


thanks,
Ming


