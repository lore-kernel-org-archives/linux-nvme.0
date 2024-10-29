Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF50D33994
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfRRQDvjgFEObJ3EGt23LVKbjI5Jv898QZllE6X5gZI=; b=yonfysvu9l6DbGa3jXp4/FExen
	eyRdxdeQj/scpdnvzJNGwPglwdahDZmMQp2eKsBPfJCu7nVPk5jpPAM/AMVAp0qFezeVmhRwriOki
	If7Ak5E2TUX1KoxWuPgnEAbYnOmY4AG28AwGrhslY+rz/URGjGdcBMHnGUUrHsrnn0KlD+6AHQ6Hy
	kPdqVQQWmqJf6sRRTOo4bWcComGXzQBzkU7dxcwbfkCMlhXB4BLuCLMV+xJE/L2A933uMVsaYnkvH
	2IWE2ydzpmuIQNHywFRzSHhOimtk8/tl1AAM9iNal2R6zuJ4zX7fvlCZNOZ5YqAbswulDVnorv+h6
	VmqW3nGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5ghn-0000000DVhc-3vOQ;
	Tue, 29 Oct 2024 07:31:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gaK-0000000DUel-1D5N
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 07:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730186650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfRRQDvjgFEObJ3EGt23LVKbjI5Jv898QZllE6X5gZI=;
	b=ej8poonlPtAcmotHoGcIdE6bbcKNmgygMlG+lGZPBDY8T/5qqOm43lY8BMhBrSIHlb16R5
	60H2mFaSCpw4fcJg0sLSQ5ODxB4DuTbF1l0W9xY0mkOQikKppQTwcD4jw9kI7K2JbGTtNV
	vPUY+zQkWS4edeN8MhZhYL5QBDYpK5Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-6wyWuyS_Ma-ogC9xTfbgwg-1; Tue,
 29 Oct 2024 03:24:08 -0400
X-MC-Unique: 6wyWuyS_Ma-ogC9xTfbgwg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD2D71955DA6;
	Tue, 29 Oct 2024 07:24:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.117])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 453741956054;
	Tue, 29 Oct 2024 07:23:59 +0000 (UTC)
Date: Tue, 29 Oct 2024 15:23:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH 2/3] nvme-fabrics: fix kernel crash while shutting down
 controller
Message-ID: <ZyCNiuYQw7_7IzJb@fedora>
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-3-nilay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20241027170209.440776-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_002412_422057_BED65ECB 
X-CRM114-Status: GOOD (  31.37  )
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

On Sun, Oct 27, 2024 at 10:32:05PM +0530, Nilay Shroff wrote:
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
> nvme_uninit_ctrl()"). Ideally we should stop keep-alive at the very
> beggining of the controller shutdown code path so that it wouldn't
> sneak in during the shutdown operation. However we removed the keep
> alive stop operation from the beginning of the controller shutdown
> code path in commit a54a93d0e359 ("nvme: move stopping keep-alive into
> nvme_uninit_ctrl()") and that now created the possibility of keep-alive
> sneaking in and interfering with the shutdown operation and causing
> observed kernel crash. So to fix this crash, now we're adding back the
> keep-alive stop operation at very beginning of the fabric controller
> shutdown code path so that the actual controller shutdown opeation only
> begins after it's ensured that keep-alive operation is not in-flight and
> also it can't be scheduled in future.
> 
> Fixes: a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_ctrl()")
> Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/#t
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/host/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5016f69e9a15..865c00ea19e3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4648,6 +4648,11 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	nvme_mpath_stop(ctrl);
>  	nvme_auth_stop(ctrl);
> +	/*
> +	 * the transport driver may be terminating the admin tagset a little
> +	 * later on, so we cannot have the keep-alive work running
> +	 */
> +	nvme_stop_keep_alive(ctrl);
>  	nvme_stop_failfast_work(ctrl);
>  	flush_work(&ctrl->async_event_work);
>  	cancel_work_sync(&ctrl->fw_act_work);

The change looks fine.

IMO the `nvme_stop_keep_alive` in nvme_uninit_ctrl() may be moved to
entry of nvme_remove_admin_tag_set(), then this one in nvme_stop_ctrl()
can be saved?


thanks,
Ming


