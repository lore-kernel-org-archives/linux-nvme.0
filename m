Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AB5D5CCA8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pC64u8/LVTnnZpEPy9GKXBpJqP4GiOZcVTifEOuntDM=; b=Ib8yRN+jDflvN4e2uAjuO85jbe
	RdpcT63hnNJvdeWaWl50zhMgK/23j6D9+vVMj4wSMxfh+1Jl9l/sfBTitqQdvTfcouXA8rGEBUWSO
	bysPgPLiC4HErcD0NIjzAiciqKmfMTAGYMKBTd28Ojf1IgYY2+N6PKgI0QVjWDr1H3RS2Ok7RSCFQ
	9VdjahL7FRbLAoLTMgXHdqmHdxR+4srG7aUzDDXmnQzGVEKTi3M0eaohhLZHJSKQS7NyV+i9J4XC+
	MNxTB6PmlEF/Axx/hGzBoz3dHavo3Gj6NznOqYoQCzWhyiID0yqiLV93cmJB5+aRPa6N65Dy94fLJ
	FGdRe9nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t68Dj-00000000Nmn-0TTE;
	Wed, 30 Oct 2024 12:54:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t68BC-00000000NR6-2Zrs
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 12:52:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730292725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pC64u8/LVTnnZpEPy9GKXBpJqP4GiOZcVTifEOuntDM=;
	b=NkDUsASoFCNswzex73bwzgyOloWKiKf+T0tNfrq1N9wgct4BS7MBy/mekb5OpePGtyxO3b
	TVIcYWUJkVzeX0b2rwSyWfRiPuGZteIol6EPIYG4BrBeDf6V3hlQqmCOCJAjIh+y5m9Ml0
	KB2M/ld0oQTcWMfLcVY4pmLLa1tEJ0Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-bVhUqlkfOma_daOHoyo4Cg-1; Wed,
 30 Oct 2024 08:52:02 -0400
X-MC-Unique: bVhUqlkfOma_daOHoyo4Cg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60E6C19560AE;
	Wed, 30 Oct 2024 12:52:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1B321956086;
	Wed, 30 Oct 2024 12:51:53 +0000 (UTC)
Date: Wed, 30 Oct 2024 20:51:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH 2/3] nvme-fabrics: fix kernel crash while shutting down
 controller
Message-ID: <ZyIr47G6PutvB7WW@fedora>
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-3-nilay@linux.ibm.com>
 <ZyCNiuYQw7_7IzJb@fedora>
 <ff8baedc-3aa9-4277-8753-282f3744ae2b@linux.ibm.com>
 <ZyGX8jCZVXwbhI89@fedora>
 <aca10f02-2c64-4ad8-867a-e226d6d61a80@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <aca10f02-2c64-4ad8-867a-e226d6d61a80@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_055206_752068_38A5765E 
X-CRM114-Status: GOOD (  43.06  )
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

On Wed, Oct 30, 2024 at 04:08:16PM +0530, Nilay Shroff wrote:
> 
> 
> On 10/30/24 07:50, Ming Lei wrote:
> > On Tue, Oct 29, 2024 at 06:10:00PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 10/29/24 12:53, Ming Lei wrote:
> >>> On Sun, Oct 27, 2024 at 10:32:05PM +0530, Nilay Shroff wrote:
> >>>> The nvme keep-alive operation, which executes at a periodic interval,
> >>>> could potentially sneak in while shutting down a fabric controller.
> >>>> This may lead to a race between the fabric controller admin queue
> >>>> destroy code path (invoked while shutting down controller) and hw/hctx
> >>>> queue dispatcher called from the nvme keep-alive async request queuing
> >>>> operation. This race could lead to the kernel crash shown below:
> >>>>
> >>>> Call Trace:
> >>>>     autoremove_wake_function+0x0/0xbc (unreliable)
> >>>>     __blk_mq_sched_dispatch_requests+0x114/0x24c
> >>>>     blk_mq_sched_dispatch_requests+0x44/0x84
> >>>>     blk_mq_run_hw_queue+0x140/0x220
> >>>>     nvme_keep_alive_work+0xc8/0x19c [nvme_core]
> >>>>     process_one_work+0x200/0x4e0
> >>>>     worker_thread+0x340/0x504
> >>>>     kthread+0x138/0x140
> >>>>     start_kernel_thread+0x14/0x18
> >>>>
> >>>> While shutting down fabric controller, if nvme keep-alive request sneaks
> >>>> in then it would be flushed off. The nvme_keep_alive_end_io function is
> >>>> then invoked to handle the end of the keep-alive operation which
> >>>> decrements the admin->q_usage_counter and assuming this is the last/only
> >>>> request in the admin queue then the admin->q_usage_counter becomes zero.
> >>>> If that happens then blk-mq destroy queue operation (blk_mq_destroy_
> >>>> queue()) which could be potentially running simultaneously on another
> >>>> cpu (as this is the controller shutdown code path) would forward
> >>>> progress and deletes the admin queue. So, now from this point onward
> >>>> we are not supposed to access the admin queue resources. However the
> >>>> issue here's that the nvme keep-alive thread running hw/hctx queue
> >>>> dispatch operation hasn't yet finished its work and so it could still
> >>>> potentially access the admin queue resource while the admin queue had
> >>>> been already deleted and that causes the above crash.
> >>>>
> >>>> The above kernel crash is regression caused due to changes implemented
> >>>> in commit a54a93d0e359 ("nvme: move stopping keep-alive into
> >>>> nvme_uninit_ctrl()"). Ideally we should stop keep-alive at the very
> >>>> beggining of the controller shutdown code path so that it wouldn't
> >>>> sneak in during the shutdown operation. However we removed the keep
> >>>> alive stop operation from the beginning of the controller shutdown
> >>>> code path in commit a54a93d0e359 ("nvme: move stopping keep-alive into
> >>>> nvme_uninit_ctrl()") and that now created the possibility of keep-alive
> >>>> sneaking in and interfering with the shutdown operation and causing
> >>>> observed kernel crash. So to fix this crash, now we're adding back the
> >>>> keep-alive stop operation at very beginning of the fabric controller
> >>>> shutdown code path so that the actual controller shutdown opeation only
> >>>> begins after it's ensured that keep-alive operation is not in-flight and
> >>>> also it can't be scheduled in future.
> >>>>
> >>>> Fixes: a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_ctrl()")
> >>>> Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/#t
> >>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> >>>> ---
> >>>>  drivers/nvme/host/core.c | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>>> index 5016f69e9a15..865c00ea19e3 100644
> >>>> --- a/drivers/nvme/host/core.c
> >>>> +++ b/drivers/nvme/host/core.c
> >>>> @@ -4648,6 +4648,11 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >>>>  {
> >>>>  	nvme_mpath_stop(ctrl);
> >>>>  	nvme_auth_stop(ctrl);
> >>>> +	/*
> >>>> +	 * the transport driver may be terminating the admin tagset a little
> >>>> +	 * later on, so we cannot have the keep-alive work running
> >>>> +	 */
> >>>> +	nvme_stop_keep_alive(ctrl);
> >>>>  	nvme_stop_failfast_work(ctrl);
> >>>>  	flush_work(&ctrl->async_event_work);
> >>>>  	cancel_work_sync(&ctrl->fw_act_work);
> >>>
> >>> The change looks fine.
> >>>
> >>> IMO the `nvme_stop_keep_alive` in nvme_uninit_ctrl() may be moved to
> >>> entry of nvme_remove_admin_tag_set(), then this one in nvme_stop_ctrl()
> >>> can be saved?
> >>>
> >> Yes that should work however IMO, stopping keep-alive at very beginning of
> >> shutdown operation would make sense because delaying the stopping of keep-alive 
> >> would not be useful anyways once we start the controller shutdown. It may
> >> sneak in unnecessarily while we shutdown controller and later we will have to 
> >> flush it off.
> >>
> >> And yes, as you mentioned, in this case we would save one call site but 
> >> looking at the code we have few other call sites already present where we
> >> call nvme_stop_keep_alive().
> > 
> > If it works, I'd suggest to move nvme_stop_keep_alive() from
> > nvme_uninit_ctrl() into nvme_remove_admin_tag_set() because:
> > 
> > 1) it isn't correct to do it in nvme_uninit_ctrl()
> > 
> > 2) stop keep alive in nvme_remove_admin_tag_set() covers everything
> > 
> > 3) most of nvme_stop_keep_alive() can be removed in failure path
> > 
> 
> Moving nvme_stop_keep_alive() from nvme_uninit_ctrl() to nvme_remove_admin_
> tag_set() works, I tested it with blktest nvme/037. However, I am afraid 
> that we may not be able to remove most of nvme_stop_keep_alive() from the
> failure/recovery code path. The reason being, in most of the failure/recovery
> code path we don't invoke nvme_remove_admin_tag_set(). 
> 
> For instance, in case of nvme_tcp_error_recovery_work(), the nvme_remove_
> admin_tag_set() is not invoked and we explicitly call nvme_stop_keep_alive(). 
> The same is true for error recovery case of nvme rdma.
> 
> Another example when nvme_tcp_setup_ctrl fails, we don't call nvme_remove_
> admin_tag_set() but we explicitly call the nvme_stop_keep_alive(). 
> 
> Third example while resetting tcp/rdam ctrl, we don't call nvme_remove_admin_
> tag_set() but we explicitly call the nvme_stop_keep_alive().

If nvme_remove_admin_tag_set() isn't called, do we really need to call
nvme_stop_keep_alive() in the failure path?

> 
> In your first point above, you mentioned that calling nvme_stop_keep_alive()
> from nvme_uninit_ctrl() isn't correct, would you please explain why is it so, 
> considering fact that we call nvme_start_keep_alive() from nvme_init_ctrl_
> finish()?

nvme_uninit_ctrl() is usually run after nvme_remove_admin_tag_set(), when the
admin queue is destroyed and tagset is freed.


Thanks,
Ming


