Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2E3D11198
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7LN52m6OYs3n9cSBwBgOV3I1t8/wpF8T8AtrTo8iG70=; b=LKvZib+JZlJkklNm72UOYQ2N7F
	LWbLuW+df2sFYagD4gfjQMeWuOWem65lQvBDfKzmDd0S6vDqP+E8IjFsSoarFqySAv9JM5ary9gdP
	VFr6y3cvrGibXZg8aStkzcM5gM/g+fDTiVwv01gYsA+JDP3mZBMoCUiF3Hq21pdQKkwKARrQ41K+r
	ZyNStgaKcqMYYA1kNqybDX25PPZswSGMTmgh18p0kIS54XsyHOWM4ZUo0ltwZdj+GYDx1OPTi3bXR
	tkjua/uTiBpyZq3nNMuAJ2f6E1PTGDwcSQu5HfmPug7pujpfABxAKYg/Pt4DtMSup9BC6RkfZ7yUM
	JrJe4v+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ksI-0000000CIux-1tDN;
	Mon, 04 Nov 2024 00:23:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ks9-0000000CIta-2bOH
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 00:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730679785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7LN52m6OYs3n9cSBwBgOV3I1t8/wpF8T8AtrTo8iG70=;
	b=DXIvJ9seSa/WCtqLgOXCMbP7+lfXVEV8gql1EaEVe7N2hZkIidyhaLDpVZnvd+ocQCA0Qt
	Y/E7E1Nw1w6IhBaCGjBgDQyyNokvqLusyEZLOqTcUmw9UTwNvFFGgcivCFULIBkUuJwiKs
	W6QZk3vT0dUpQ9hxqMv0vlAuPfvTIS8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-_hoTRRygP6eLpAYfyv33gw-1; Sun,
 03 Nov 2024 19:23:02 -0500
X-MC-Unique: _hoTRRygP6eLpAYfyv33gw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B625219560BA;
	Mon,  4 Nov 2024 00:23:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 035101956052;
	Mon,  4 Nov 2024 00:22:52 +0000 (UTC)
Date: Mon, 4 Nov 2024 08:22:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv3 2/2] nvme-fabrics: fix kernel crash while shutting down
 controller
Message-ID: <ZygT1rurZOAjEq0R@fedora>
References: <20241103181450.933737-1-nilay@linux.ibm.com>
 <20241103181450.933737-3-nilay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20241103181450.933737-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_162309_757056_C636C885 
X-CRM114-Status: GOOD (  29.82  )
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

On Sun, Nov 03, 2024 at 11:44:42PM +0530, Nilay Shroff wrote:
> The nvme keep-alive operation, which executes at a periodic interval,
> could potentially sneak in while shutting down a fabric controller.
> This may lead to a race between the fabric controller admin queue
> destroy code path (invoked while shutting down controller) and hw/hctx
> queue dispatcher called from the nvme keep-alive async request queuing
> operation. This race could lead to the kernel crash shown below:
> 
> Call Trace:
>     autoremove_wake_function+0x0/0xbc (unreliable)
>     __blk_mq_sched_dispatch_requests+0x114/0x24c
>     blk_mq_sched_dispatch_requests+0x44/0x84
>     blk_mq_run_hw_queue+0x140/0x220
>     nvme_keep_alive_work+0xc8/0x19c [nvme_core]
>     process_one_work+0x200/0x4e0
>     worker_thread+0x340/0x504
>     kthread+0x138/0x140
>     start_kernel_thread+0x14/0x18
> 
> While shutting down fabric controller, if nvme keep-alive request sneaks
> in then it would be flushed off. The nvme_keep_alive_end_io function is
> then invoked to handle the end of the keep-alive operation which
> decrements the admin->q_usage_counter and assuming this is the last/only
> request in the admin queue then the admin->q_usage_counter becomes zero.
> If that happens then blk-mq destroy queue operation (blk_mq_destroy_
> queue()) which could be potentially running simultaneously on another
> cpu (as this is the controller shutdown code path) would forward
> progress and deletes the admin queue. So, now from this point onward
> we are not supposed to access the admin queue resources. However the
> issue here's that the nvme keep-alive thread running hw/hctx queue
> dispatch operation hasn't yet finished its work and so it could still
> potentially access the admin queue resource while the admin queue had
> been already deleted and that causes the above crash.
> 
> The above kernel crash is regression caused due to changes implemented
> in commit a54a93d0e359 ("nvme: move stopping keep-alive into
> nvme_uninit_ctrl()"). Ideally we should stop keep-alive before destroyin
> g the admin queue and freeing the admin tagset so that it wouldn't sneak
> in during the shutdown operation. However we removed the keep alive stop
> operation from the beginning of the controller shutdown code path in commit
> a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_ctrl()")
> and added it under nvme_uninit_ctrl() which executes very late in the
> shutdown code path after the admin queue is destroyed and its tagset is
> removed. So this change created the possibility of keep-alive sneaking in
> and interfering with the shutdown operation and causing observed kernel
> crash.
> 
> To fix the observed crash, we decided to move nvme_stop_keep_alive() from
> nvme_uninit_ctrl() to nvme_remove_admin_tag_set(). This change would ensure
> that we don't forward progress and delete the admin queue until the keep-
> alive operation is finished (if it's in-flight) or cancelled and that would
> help contain the race condition explained above and hence avoid the crash.
> 
> Fixes: a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_ctrl()")
> Link: https://lore.kernel.org/all/1a21f37b-0f2a-4745-8c56-4dc8628d3983@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/host/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ddf07df243d3..a55c56123bfe 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4593,6 +4593,11 @@ EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
>  
>  void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
>  {
> +	/*
> +	 * As we're about to destroy the queue and free tagset
> +	 * we can not have keep-alive work running.
> +	 */
> +	nvme_stop_keep_alive(ctrl);
>  	blk_mq_destroy_queue(ctrl->admin_q);
>  	blk_put_queue(ctrl->admin_q);
>  	if (ctrl->ops->flags & NVME_F_FABRICS) {

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


